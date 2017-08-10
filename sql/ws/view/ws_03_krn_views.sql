/*
This file is part of Giswater 2.0
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

SET search_path = "SCHEMA_NAME", public, pg_catalog;

-- ----------------------------
-- View structure for v_arc_x_node
-- ----------------------------


DROP VIEW IF EXISTS v_arc CASCADE;
CREATE OR REPLACE VIEW v_arc AS 
SELECT 
arc.arc_id, 
arc.node_1, 
arc.node_2,
arc.arccat_id,
cat_arc.matcat_id,																	-- field to customize de source of the data matcat_id (from arc catalog or directly from arc table)
arc.epa_type,
arc.sector_id,
arc.dma_id,
arc.state,
arc.soilcat_id,
(CASE 
WHEN (arc.custom_length IS NOT NULL) THEN custom_length::numeric (12,3)				-- field to use length/custom_length
ELSE st_length2d(arc.the_geom)::numeric (12,3) END) AS length,
arc.the_geom,
 arc.expl_id
FROM arc
JOIN cat_arc ON arc.arccat_id = cat_arc.id;


DROP VIEW IF EXISTS v_node CASCADE;
CREATE OR REPLACE VIEW v_node AS
SELECT
node.node_id,
node.elevation,
node.depth,
cat_node.nodetype_id,
node.nodecat_id,
node.epa_type,
node.sector_id,
node.dma_id,
node.state,
node.the_geom,
node.expl_id
FROM node
LEFT JOIN cat_node ON ((node.nodecat_id) = (cat_node.id));



DROP VIEW IF EXISTS v_arc_x_node1 CASCADE;
CREATE OR REPLACE VIEW v_arc_x_node1 AS 
SELECT arc.arc_id, arc.node_1, 
node.elevation AS elevation1, 
node.depth AS depth1, 
(cat_arc.dext)/1000 AS dext, 
node.depth - (cat_arc.dext)/1000 AS r1
FROM arc
JOIN node ON arc.node_1 = node.node_id
JOIN cat_arc ON arc.arccat_id = cat_arc.id AND arc.arccat_id = cat_arc.id;


DROP VIEW IF EXISTS v_arc_x_node2 CASCADE;
CREATE OR REPLACE VIEW v_arc_x_node2 AS 
SELECT arc.arc_id, arc.node_2, 
node.elevation AS elevation2, 
node.depth AS depth2,
(cat_arc.dext)/1000 AS dext, 
node.depth - (cat_arc.dext)/1000 AS r2
FROM arc
JOIN node ON arc.node_2 = node.node_id
JOIN cat_arc ON arc.arccat_id = cat_arc.id AND arc.arccat_id = cat_arc.id;


DROP VIEW IF EXISTS v_arc_x_node CASCADE;
CREATE OR REPLACE VIEW v_arc_x_node AS 
SELECT 
v_arc_x_node1.arc_id,
v_arc_x_node1.node_1,
v_arc_x_node1.elevation1,
v_arc_x_node1.depth1,
v_arc_x_node1.r1,
v_arc_x_node2.node_2,
v_arc_x_node2.elevation2,
v_arc_x_node2.depth2,
v_arc_x_node2.r2,
arc."state",
arc.sector_id,
arc.the_geom,
arc.expl_id
FROM selector_expl, v_arc_x_node1
JOIN v_arc_x_node2 ON v_arc_x_node1.arc_id = v_arc_x_node2.arc_id
JOIN arc ON v_arc_x_node2.arc_id = arc.arc_id
WHERE ((arc.expl_id)=(selector_expl.expl_id)
AND selector_expl.cur_user="current_user"());;


