/*
This file is part of Giswater 2.0
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

SET search_path = "SCHEMA_NAME", public, pg_catalog;



  
  DROP VIEW IF EXISTS v_edit_om_visit CASCADE;
CREATE VIEW v_edit_om_visit AS SELECT
	id,
	startdate,
	enddate,
	user_name,
	om_visit.the_geom,
	webclient_id,
	om_visit.expl_id
FROM expl_selector,om_visit
WHERE ((om_visit.expl_id)::text=(expl_selector.expl_id)::text
AND expl_selector.cur_user="current_user"()::text);