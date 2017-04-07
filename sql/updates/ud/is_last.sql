/*
This file is part of Giswater 2.0
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/


SET search_path = "SCHEMA_NAME", public, pg_catalog;



CREATE TABLE macrodma (
macrodma_id character varying(50) NOT NULL PRIMARY KEY,
descript character varying(100),
the_geom geometry(MultiPolygon,25831),
undelete boolean
);

CREATE SEQUENCE doc_x_tag_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;


CREATE TABLE doc_x_tag(
  id bigint NOT NULL DEFAULT nextval('doc_x_tag_seq'::regclass) PRIMARY KEY,
  doc_id character varying(30),
  tag_id character varying(16)
);



CREATE TABLE expl_selector (
expl_id character varying(50) NOT NULL PRIMARY KEY,
descript character varying(100),
the_geom geometry(MultiPolygon,25831),
undelete boolean,
cur_user text
);

ALTER TABLE arc ADD COLUMN expl_id character varying(50);
ALTER TABLE node ADD COLUMN expl_id character varying(50);
ALTER TABLE connec ADD COLUMN expl_id character varying(50);
ALTER TABLE gully ADD COLUMN expl_id character varying(50);

ALTER TABLE node ADD COLUMN code varchar(30);
ALTER TABLE arc ADD COLUMN code varchar(30);
ALTER TABLE gully ADD COLUMN code varchar(30);
ALTER TABLE element ADD COLUMN code varchar(30);

ALTER TABLE node ADD COLUMN publish boolean;
ALTER TABLE arc ADD COLUMN publish boolean;
ALTER TABLE connec ADD COLUMN publish boolean;
ALTER TABLE gully ADD COLUMN publish boolean;
ALTER TABLE element ADD COLUMN publish boolean;

ALTER TABLE node ADD COLUMN inventory boolean;
ALTER TABLE arc ADD COLUMN inventory boolean;
ALTER TABLE connec ADD COLUMN inventory boolean;
ALTER TABLE gully ADD COLUMN inventory boolean;
ALTER TABLE element ADD COLUMN inventory boolean;

ALTER TABLE node ADD COLUMN end_date date;
ALTER TABLE arc ADD COLUMN end_date date;
ALTER TABLE connec ADD COLUMN end_date date;
ALTER TABLE gully ADD COLUMN end_date date;

ALTER TABLE node ADD COLUMN uncertain boolean;
ALTER TABLE arc ADD COLUMN uncertain boolean;
ALTER TABLE connec ADD COLUMN uncertain boolean;

ALTER TABLE node ADD COLUMN xyz_date date;
ALTER TABLE node ADD COLUMN unconnected boolean;

ALTER TABLE gully ADD COLUMN streetaxis_id character varying(16);
ALTER TABLE gully ADD COLUMN postnumber character varying(16);

ALTER TABLE element ADD COLUMN the_geom geometry(Point,25831);

ALTER TABLE cat_work ADD COLUMN workid_key1 character varying(30);
ALTER TABLE cat_work ADD COLUMN workid_key2 character varying(30);
ALTER TABLE cat_work ADD COLUMN builtdate date;

ALTER TABLE sector ADD COLUMN macrodma_id character varying(50);

ALTER TABLE arc ADD COLUMN macrodma_id character varying(50);
ALTER TABLE node ADD COLUMN macrodma_id character varying(50);
ALTER TABLE connec ADD COLUMN macrodma_id character varying(50);
ALTER TABLE gully ADD COLUMN macrodma_id character varying(50);

ALTER TABLE om_visit ADD COLUMN  webclient_id character varying(50);

ALTER TABLE cat_grate ADD COLUMN madeby character varying(100);
ALTER TABLE cat_grate ADD COLUMN model character varying(100);

ALTER TABLE man_manhole ADD COLUMN inlet boolean;
ALTER TABLE man_manhole ADD COLUMN bottom_channel boolean;
ALTER TABLE man_manhole ADD COLUMN accessibility varchar(16);

ALTER TABLE man_chamber ADD COLUMN inlet boolean;
ALTER TABLE man_chamber ADD COLUMN bottom_channel boolean;
ALTER TABLE man_chamber ADD COLUMN accessibility varchar(16);

ALTER TABLE man_netinit ADD COLUMN inlet boolean;
ALTER TABLE man_netinit ADD COLUMN bottom_channel  boolean;
ALTER TABLE man_netinit ADD COLUMN accessibility varchar(16);

ALTER TABLE cat_node ADD COLUMN shape character varying(16);

ALTER TABLE cat_node ADD COLUMN active boolean;
ALTER TABLE cat_arc ADD COLUMN active boolean;
ALTER TABLE cat_connec ADD COLUMN active boolean;
ALTER TABLE cat_element ADD COLUMN active boolean;
ALTER TABLE cat_grate ADD COLUMN active boolean;

ALTER TABLE cat_element ADD COLUMN madeby character varying(100);
ALTER TABLE cat_element ADD COLUMN model character varying(100);


ALTER TABLE doc_x_tag ADD CONSTRAINT doc_x_tag_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES cat_tag (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE doc_x_tag ADD CONSTRAINT doc_x_tag_doc_id_fkey FOREIGN KEY (doc_id) REFERENCES doc (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE arc  ADD CONSTRAINT arc_expl_id_fkey FOREIGN KEY (expl_id) REFERENCES expl_selector (expl_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE node  ADD CONSTRAINT node_expl_id_fkey FOREIGN KEY (expl_id) REFERENCES expl_selector (expl_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE connec  ADD CONSTRAINT connec_expl_id_fkey FOREIGN KEY (expl_id) REFERENCES expl_selector (expl_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE gully ADD CONSTRAINT gully_expl_id_fkey FOREIGN KEY (expl_id) REFERENCES expl_selector (expl_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE gully ADD CONSTRAINT gully_streetaxis_id_fkey FOREIGN KEY (streetaxis_id) REFERENCES ext_streetaxis (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE arc  ADD CONSTRAINT arc_macrodma_id_fkey FOREIGN KEY (macrodma_id) REFERENCES macrodma_selector (macrodma_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE node  ADD CONSTRAINT node_macrodma_id_fkey FOREIGN KEY (macrodma_id) REFERENCES macrodma_selector (macrodma_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE connec  ADD CONSTRAINT connec_macrodma_id_fkey FOREIGN KEY (macrodma_id) REFERENCES macrodma_selector (macrodma_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;
ALTER TABLE gully ADD CONSTRAINT gully_macrodma_id_fkey FOREIGN KEY (macrodma_id) REFERENCES macrodma_selector (macrodma_id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE RESTRICT;

DROP TABLE IF EXISTS review_arc;
CREATE TABLE review_arc
(  arc_id character varying(16),
  the_geom geometry(MultiLineString,25831),
  y1 numeric(12,3),
  y2 numeric(12,3),
  arc_type character varying(16),
  arccat_id character varying(30),
  annotation character varying(254),
  verified character varying(16),
  field_checked boolean,
  office_checked boolean,
  CONSTRAINT review_arc_pkey PRIMARY KEY (arc_id)
);

DROP TABLE IF EXISTS review_node;
CREATE TABLE review_node
( node_id character varying(16),
  the_geom geometry(MultiPoint,25831),
  top_elev numeric(12,3),
  ymax numeric(12,3),
  node_type character varying(16),
  cat_matcat character varying(16),
  dimensions character varying(16),
  annotation character varying(254),
  observ character varying(254),
  verified character varying(16),
  field_checked boolean,
  office_checked boolean,
  CONSTRAINT review_node_pkey PRIMARY KEY (node_id));
  
DROP TABLE IF EXISTS review_audit_arc;
CREATE TABLE review_audit_arc
(  arc_id character varying(16) NOT NULL,
  the_geom geometry(MultiLineString,25831),
  y1 numeric(12,3),
  y2 numeric(12,3),
  arc_type character varying(16),
  arccat_id character varying(30),
  annotation character varying(254),
  verified character varying(16),
   moved_geom boolean,
  field_checked boolean,
  "operation" character varying(25),
  "user" varchar (50),  
  date_field timestamp (6) without time zone,
  office_checked boolean,
  CONSTRAINT review_audit_arc_pkey PRIMARY KEY (arc_id)
  );
  
DROP TABLE IF EXISTS review_audit_node;
CREATE TABLE review_audit_node
(  node_id character varying(16),
  the_geom geometry(MultiPoint,25831),
  top_elev numeric(12,3),
  ymax numeric(12,3),
  node_type character varying(16),
  cat_matcat character varying(16),
  dimensions character varying(16),
  annotation character varying(254),
  observ character varying(254),
  verified character varying(16),
  moved_geom boolean,
  field_checked boolean,
  "operation" character varying(25),
  "user" varchar (50),  
  date_field timestamp (6) without time zone,
  office_checked boolean,
  CONSTRAINT review_audit_node_pkey PRIMARY KEY (node_id)
  );
  