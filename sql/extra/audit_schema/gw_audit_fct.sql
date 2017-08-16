/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


CREATE OR REPLACE FUNCTION "SCHEMA_NAME".gw_trg_audit_table() RETURNS TRIGGER AS $BODY$
DECLARE
    audit_row "SCHEMA_NAME".audit_table_actions;
    include_values boolean;
    audit_table_diffs boolean;
    h_old hstore;
    h_new hstore;
    excluded_cols text[] = ARRAY[]::text[];

BEGIN

    SET search_path = "SCHEMA_NAME", public;

    IF TG_WHEN <> 'AFTER' THEN
        RAISE EXCEPTION 'gw_trg_audit_table() may only run as an AFTER trigger';
    END IF;

    audit_row = ROW(
        nextval('"SCHEMA_NAME".audit_table_actions_id_seq'),    -- id
        date_trunc('second', current_timestamp),            -- action_tstamp_tx        
        TG_TABLE_SCHEMA::text,                              -- SCHEMA_NAME
        TG_TABLE_NAME::text,                                -- table_name
        TG_RELID,                                           -- relation OID for much quicker searches
        session_user::text,                                 -- session_user_name
        inet_client_addr(),                                 -- client_addr
        txid_current(),                                     -- transaction ID
        substring(TG_OP,1,1),                               -- action
        current_query(),                                    -- top-level query or queries (if multistatement) from client
        NULL, NULL                                          -- row_data, changed_fields
    );

    IF NOT TG_ARGV[0]::boolean IS DISTINCT FROM 'f'::boolean THEN
        audit_row.query = NULL;
    END IF;

    IF TG_ARGV[1] IS NOT NULL THEN
        excluded_cols = TG_ARGV[1]::text[];
    END IF;
    
    IF (TG_OP = 'UPDATE' AND TG_LEVEL = 'ROW') THEN
        audit_row.row_data = hstore(OLD.*);
        audit_row.changed_fields = (hstore(NEW.*) - audit_row.row_data) - excluded_cols;
        IF audit_row.changed_fields = hstore('') THEN
            -- All changed fields are ignored. Skip this update
            RETURN NULL;
        END IF;
    ELSIF (TG_OP = 'DELETE' AND TG_LEVEL = 'ROW') THEN
        audit_row.row_data = hstore(OLD.*) - excluded_cols;
    ELSIF (TG_OP = 'INSERT' AND TG_LEVEL = 'ROW') THEN
        audit_row.row_data = hstore(NEW.*) - excluded_cols;
    ELSE
        RAISE EXCEPTION '[gw_trg_audit_table] - Trigger func added as trigger for unhandled case: %, %',TG_OP, TG_LEVEL;
        RETURN NULL;
    END IF;

    INSERT INTO  "SCHEMA_NAME".audit_table_actions VALUES (audit_row.*);
    RETURN NULL;

END;
$BODY$
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = pg_catalog, public;


COMMENT ON FUNCTION "SCHEMA_NAME".gw_trg_audit_table() IS $BODY$
Track changes to a table at the statement and/or row level.

Optional parameters to trigger in CREATE TRIGGER call:

param 0: boolean, whether to log the query text. Default 't'.

param 1: text[], columns to ignore in updates. Default [].

         Updates to ignored cols are omitted from changed_fields.

         Updates with only ignored cols changed are not inserted into the audit log.

         Almost all the processing work is still done for updates
         that ignored. If you need to save the load, you need to use
         WHEN clause on the trigger instead.

         No warning or error is issued if ignored_cols contains columns
         that do not exist in the target table. This lets you specify
         a standard set of ignored columns.

There is no parameter to disable logging of values. Add this trigger as
a 'FOR EACH STATEMENT' rather than 'FOR EACH ROW' trigger if you do not
want to log row values.

Note that the user name logged is the login role for the session. The audit trigger
cannot obtain the active role because it is reset by the SECURITY DEFINER invocation
of the audit trigger its self.
$BODY$;



CREATE OR REPLACE FUNCTION "SCHEMA_NAME".audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean, ignored_cols text[]) RETURNS void AS $BODY$
DECLARE
    _q_txt text;
    _ignored_cols_snip text = '';
  
BEGIN

    SET search_path = "SCHEMA_NAME", public;

    EXECUTE 'DROP TRIGGER IF EXISTS audit_trigger_row ON '||target_table;

    IF audit_rows THEN
        IF array_length(ignored_cols,1) > 0 THEN
            _ignored_cols_snip = ', '||quote_literal(ignored_cols);
        END IF;
        _q_txt = 'CREATE TRIGGER audit_trigger_row AFTER INSERT OR UPDATE OR DELETE ON '||target_table|| 
                 ' FOR EACH ROW EXECUTE PROCEDURE gw_trg_audit_table('||
                 quote_literal(audit_query_text)||_ignored_cols_snip||');';
        EXECUTE _q_txt;
    END IF;

END;
$BODY$
LANGUAGE 'plpgsql';


COMMENT ON FUNCTION "SCHEMA_NAME".audit_table(regclass, boolean, boolean, text[]) IS $BODY$
Add auditing support to a table.

Arguments:
   target_table:     Table name, schema qualified if not on search_path
   audit_rows:       Record each row change, or only audit at a statement level
   audit_query_text: Record the text of the client query that triggered the audit event?
   ignored_cols:     Columns to exclude from update diffs, ignore updates that change only ignored cols.
$BODY$;



-- Pg doesn't allow variadic calls with 0 params, so provide a wrapper
CREATE OR REPLACE FUNCTION "SCHEMA_NAME".audit_table(target_table regclass, audit_rows boolean, audit_query_text boolean) RETURNS void AS $BODY$
    SET search_path = "SCHEMA_NAME", public;
    SELECT "SCHEMA_NAME".audit_table($1, $2, $3, ARRAY[]::text[]);
$BODY$ LANGUAGE SQL;


-- And provide a convenience call wrapper for the simplest case
-- of row-level logging with no excluded cols and query logging enabled.
CREATE OR REPLACE FUNCTION "SCHEMA_NAME".audit_table(target_table regclass) RETURNS void AS $BODY$
    SET search_path = "SCHEMA_NAME", public;
    SELECT  "SCHEMA_NAME".audit_table($1, BOOLEAN 't', BOOLEAN 't');
$BODY$ LANGUAGE 'sql';

COMMENT ON FUNCTION "SCHEMA_NAME".audit_table(regclass) IS $BODY$
Add auditing support to the given table. Row-level changes will be logged with full client query text. No cols are ignored.
$BODY$;


-- Function to audit all tables of selected schema
CREATE OR REPLACE FUNCTION "SCHEMA_NAME".audit_schema()
  RETURNS void AS
$BODY$
DECLARE
    table_name text;
    registro  record;

BEGIN
   SET search_path = "SCHEMA_NAME", public;

    FOR registro IN 
        SELECT * FROM pg_tables 
        WHERE schemaname = 'SCHEMA_NAME'
        AND tablename NOT LIKE 'audit_table_%'
    LOOP
        table_name:= 'SCHEMA_NAME'|| '.' ||quote_ident(registro.tablename);
        PERFORM audit_table(table_name, BOOLEAN 't', BOOLEAN 't');
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

CREATE OR REPLACE FUNCTION "SCHEMA_NAME".audit_schema_start()  RETURNS void AS $BODY$
DECLARE
    aux text;
    rec record;

BEGIN
    SET search_path = "SCHEMA_NAME", public;

    FOR rec IN 
        SELECT * FROM pg_tables 
        WHERE schemaname = 'SCHEMA_NAME'
        AND tablename NOT LIKE 'audit_table_%' LOOP
        aux:= 'SCHEMA_NAME.'||quote_ident(rec.tablename);
        EXECUTE 'ALTER TABLE '||aux||' ENABLE trigger audit_trigger_row';
    END LOOP;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
  
CREATE OR REPLACE FUNCTION "SCHEMA_NAME".audit_schema_stop() RETURNS "pg_catalog"."void" AS $BODY$
DECLARE
    aux text;
    rec record;

BEGIN
    SET search_path = "SCHEMA_NAME", public;
    
    FOR rec IN 
        SELECT * FROM pg_tables 
        WHERE schemaname = 'SCHEMA_NAME'
        AND tablename NOT LIKE 'audit_table_%' LOOP
        aux:= 'SCHEMA_NAME.'||quote_ident(rec.tablename);
        EXECUTE 'ALTER TABLE '||aux||' DISABLE trigger audit_trigger_row';
    END LOOP;
END;
$BODY$
LANGUAGE 'plpgsql' VOLATILE COST 100;




