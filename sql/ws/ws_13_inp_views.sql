/*
This file is part of Giswater 2.0
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

SET search_path = "SCHEMA_NAME", public, pg_catalog;



DROP VIEW IF EXISTS v_inp_arc CASCADE;
CREATE OR REPLACE VIEW v_inp_arc AS 
 SELECT temp_arc.arc_id, 
    temp_arc.node_1, 
    temp_arc.node_2, 
    temp_arc.arccat_id, 
    cat_arc.matcat_id, 
    temp_arc.epa_type, 
    temp_arc.sector_id, 
    temp_arc.dma_id, 
    temp_arc.state, 
    temp_arc.soilcat_id, 
        CASE
            WHEN temp_arc.builtdate IS NOT NULL THEN temp_arc.builtdate
            ELSE now()::date
        END AS builtdate, 
        CASE
            WHEN temp_arc.custom_length IS NOT NULL THEN temp_arc.custom_length::numeric(12,3)
            ELSE st_length2d(temp_arc.the_geom)::numeric(12,3)
        END AS length, 
    temp_arc.the_geom
   FROM temp_arc
   JOIN cat_arc ON temp_arc.arccat_id::text = cat_arc.id::text;


DROP VIEW IF EXISTS v_inp_node CASCADE;
CREATE OR REPLACE VIEW v_inp_node AS 
 SELECT temp_node.node_id,
    temp_node.elevation,
    temp_node.depth,
    temp_node.node_type,
    temp_node.nodecat_id,
    temp_node.epa_type,
    temp_node.sector_id,
    temp_node.dma_id,
    temp_node.state,
    temp_node.the_geom
   FROM temp_node;
      
 
CREATE OR REPLACE VIEW v_inp_arc_x_node1 AS 
 SELECT temp_arc.arc_id,
    temp_arc.node_1,
    temp_node.elevation AS elevation1,
    temp_node.depth AS depth1,
    cat_arc.dext / 1000::numeric AS dext,
    temp_node.depth - cat_arc.dext / 1000::numeric AS r1
   FROM temp_arc
     JOIN temp_node ON temp_arc.node_1::text = temp_node.node_id::text
     JOIN cat_arc ON temp_arc.arccat_id::text = cat_arc.id::text AND temp_arc.arccat_id::text = cat_arc.id::text;


CREATE OR REPLACE VIEW v_inp_arc_x_node2 AS 
 SELECT temp_arc.arc_id,
    temp_arc.node_2,
    temp_node.elevation AS elevation2,
    temp_node.depth AS depth2,
    cat_arc.dext / 1000::numeric AS dext,
    temp_node.depth - cat_arc.dext / 1000::numeric AS r2
   FROM temp_arc
     JOIN temp_node ON temp_arc.node_2::text = temp_node.node_id::text
     JOIN cat_arc ON temp_arc.arccat_id::text = cat_arc.id::text AND temp_arc.arccat_id::text = cat_arc.id::text;



DROP VIEW IF EXISTS v_inp_arc_x_node CASCADE;
CREATE OR REPLACE VIEW v_inp_arc_x_node AS 
 SELECT v_inp_arc_x_node1.arc_id,
    v_inp_arc_x_node1.node_1,
    v_inp_arc_x_node1.elevation1,
    v_inp_arc_x_node1.depth1,
    v_inp_arc_x_node1.r1,
    v_inp_arc_x_node2.node_2,
    v_inp_arc_x_node2.elevation2,
    v_inp_arc_x_node2.depth2,
    v_inp_arc_x_node2.r2,
    temp_arc.state,
    temp_arc.sector_id,
    temp_arc.the_geom
   FROM v_inp_arc_x_node1
     JOIN v_inp_arc_x_node2 ON v_inp_arc_x_node1.arc_id::text = v_inp_arc_x_node2.arc_id::text
     JOIN temp_arc ON v_inp_arc_x_node2.arc_id::text = temp_arc.arc_id::text;

	 
	 
-- ----------------------------
-- View structure for v_inp
-- ----------------------------
DROP VIEW IF EXISTS "v_inp_curve" CASCADE;
CREATE VIEW "v_inp_curve" AS 
SELECT inp_curve.curve_id, inp_curve.x_value, inp_curve.y_value FROM inp_curve ORDER BY inp_curve.id;


DROP VIEW IF EXISTS "v_inp_energy_el" CASCADE;
CREATE VIEW "v_inp_energy_el" AS 
SELECT 'PUMP'::text AS type_pump, inp_energy_el.pump_id, inp_energy_el.parameter, inp_energy_el.value FROM inp_energy_el;


DROP VIEW IF EXISTS "v_inp_options" CASCADE;
CREATE VIEW "v_inp_options" AS 
SELECT inp_options.units, inp_options.headloss, (((inp_options.hydraulics)::text || ' '::text) || (inp_options.hydraulics_fname)::text) AS hydraulics, inp_options.specific_gravity AS "specific gravity", inp_options.viscosity, inp_options.trials, inp_options.accuracy, (((inp_options.unbalanced)::text || ' '::text) || (inp_options.unbalanced_n)::text) AS unbalanced, inp_options.checkfreq, inp_options.maxcheck, inp_options.damplimit, inp_options.pattern, inp_options.demand_multiplier AS "demand multiplier", inp_options.emitter_exponent AS "emitter exponent", CASE WHEN inp_options.quality::text = 'TRACE'::text THEN ((inp_options.quality::text || ' '::text) || inp_options.node_id::text)::character varying ELSE inp_options.quality END AS quality, inp_options.diffusivity, inp_options.tolerance FROM inp_options;


DROP VIEW IF EXISTS "v_inp_report" CASCADE;
CREATE VIEW "v_inp_report" AS 
SELECT inp_report.pagesize,inp_report.status,inp_report.summary,inp_report.energy,inp_report.nodes,inp_report.links,inp_report.elevation,inp_report.demand,inp_report.head,inp_report.pressure,inp_report.quality,inp_report."length",inp_report.diameter,inp_report.flow,inp_report.velocity,inp_report.headloss,inp_report.setting,inp_report.reaction,inp_report.f_factor AS "f-factor" FROM inp_report;


DROP VIEW IF EXISTS "v_inp_rules" CASCADE;
CREATE VIEW "v_inp_rules" AS 
SELECT inp_rules.text FROM inp_rules ORDER BY inp_rules.id;

DROP VIEW IF EXISTS "v_inp_times" CASCADE; 
CREATE VIEW "v_inp_times" AS 
SELECT inp_times.duration, inp_times.hydraulic_timestep AS "hydraulic timestep", inp_times.quality_timestep AS "quality timestep", inp_times.rule_timestep AS "rule timestep", inp_times.pattern_timestep AS "pattern timestep", inp_times.pattern_start AS "pattern start", inp_times.report_timestep AS "report timestep", inp_times.report_start AS "report start", inp_times.start_clocktime AS "start clocktime", inp_times.statistic FROM inp_times;



-- ------------------------------------------------------------------
-- View structure for v_inp ARC & NODE  (SELECTED BY STATE SELECTION)
-- ------------------------------------------------------------------

DROP VIEW IF EXISTS "v_inp_mixing" CASCADE;
CREATE VIEW "v_inp_mixing" AS 
SELECT 
	inp_mixing.node_id, inp_mixing.mix_type, inp_mixing.value, inp_selector_sector.sector_id 
	FROM (((inp_mixing 
	JOIN v_inp_node node ON (((inp_mixing.node_id)::text = (node.node_id)::text))) 
	JOIN inp_selector_sector ON (((node.sector_id)::text = (inp_selector_sector.sector_id)::text)))
	JOIN inp_selector_state ON (((node."state")::text = (inp_selector_state.id)::text)));


DROP VIEW IF EXISTS "v_inp_source" CASCADE;
CREATE VIEW "v_inp_source" AS 
SELECT 
	inp_source.node_id, inp_source.sourc_type, inp_source.quality, inp_source.pattern_id, inp_selector_sector.sector_id 
	FROM (((inp_source 
	JOIN v_inp_node node ON (((inp_source.node_id)::text = (node.node_id)::text))) 
	JOIN inp_selector_sector ON (((node.sector_id)::text = (inp_selector_sector.sector_id)::text)))
	JOIN inp_selector_state ON (((node."state")::text = (inp_selector_state.id)::text)));


CREATE OR REPLACE VIEW v_inp_status AS
SELECT 
    temp_arc.arc_id,
    inp_valve.status
    FROM temp_arc
    JOIN inp_valve ON temp_arc.arc_id::text = concat(inp_valve.node_id, '_n2a')
    JOIN inp_selector_sector ON temp_arc.sector_id::text = inp_selector_sector.sector_id::text
    JOIN inp_selector_state ON temp_arc.state::text = inp_selector_state.id::text
    WHERE inp_valve.status::text = 'OPEN'::text OR inp_valve.status::text = 'CLOSED'::text
UNION
    SELECT 
    temp_arc.arc_id,
    inp_pump.status
    FROM temp_arc
    JOIN inp_pump ON temp_arc.arc_id::text = concat(inp_pump.node_id, '_n2a')
    JOIN inp_selector_sector ON temp_arc.sector_id::text = inp_selector_sector.sector_id::text
    JOIN inp_selector_state ON temp_arc.state::text = inp_selector_state.id::text
    WHERE inp_pump.status::text = 'OPEN'::text OR inp_pump.status::text = 'CLOSED'::text;


DROP VIEW IF EXISTS "v_inp_emitter" CASCADE;
CREATE VIEW "v_inp_emitter" AS 
SELECT 
	inp_emitter.node_id, inp_emitter.coef, (st_x(node.the_geom))::numeric(16,3) AS xcoord, (st_y(node.the_geom))::numeric(16,3) AS ycoord, inp_selector_sector.sector_id 
	FROM (((inp_emitter 
	JOIN v_inp_node node ON (((inp_emitter.node_id)::text = (node.node_id)::text))) 
	JOIN inp_selector_sector ON (((node.sector_id)::text = (inp_selector_sector.sector_id)::text)))
	JOIN inp_selector_state ON (((node."state")::text = (inp_selector_state.id)::text))); 


DROP VIEW IF EXISTS "v_inp_reservoir" CASCADE;
CREATE VIEW "v_inp_reservoir" AS 
SELECT 
	inp_reservoir.node_id, inp_reservoir.head, inp_reservoir.pattern_id, (st_x(node.the_geom))::numeric(16,3) AS xcoord, (st_y(node.the_geom))::numeric(16,3) AS ycoord, inp_selector_sector.sector_id 
	FROM (((v_inp_node node JOIN inp_reservoir ON (((inp_reservoir.node_id)::text = (node.node_id)::text))) 
	JOIN inp_selector_sector ON (((node.sector_id)::text = (inp_selector_sector.sector_id)::text)))
	JOIN inp_selector_state ON (((node."state")::text = (inp_selector_state.id)::text))) ;


DROP VIEW IF EXISTS "v_inp_tank" CASCADE;
CREATE VIEW "v_inp_tank" AS 
SELECT 
	inp_tank.node_id, node.elevation, inp_tank.initlevel, inp_tank.minlevel, inp_tank.maxlevel, inp_tank.diameter, inp_tank.minvol, inp_tank.curve_id, (st_x(node.the_geom))::numeric(16,3) AS xcoord, (st_y(node.the_geom))::numeric(16,3) AS ycoord, inp_selector_sector.sector_id 
	FROM (((inp_tank 
	JOIN v_inp_node node ON (((inp_tank.node_id)::text = (node.node_id)::text))) 
	JOIN inp_selector_sector ON (((node.sector_id)::text = (inp_selector_sector.sector_id)::text)))
	JOIN inp_selector_state ON (((node."state")::text = (inp_selector_state.id)::text))) ;



DROP VIEW IF EXISTS "v_inp_junction" CASCADE;
CREATE OR REPLACE VIEW v_inp_junction AS 
 SELECT temp_node.node_id, 
    temp_node.elevation, 
    (temp_node.elevation - temp_node.depth)::numeric(12,4) AS elev, 
    inp_junction.demand, 
    inp_junction.pattern_id, 
    st_x(temp_node.the_geom)::numeric(16,3) AS xcoord, 
    st_y(temp_node.the_geom)::numeric(16,3) AS ycoord, 
    inp_selector_sector.sector_id
   FROM temp_node
   LEFT JOIN inp_junction ON inp_junction.node_id::text = temp_node.node_id::text
   JOIN inp_selector_sector ON temp_node.sector_id::text = inp_selector_sector.sector_id::text
   JOIN inp_selector_state ON temp_node.state::text = inp_selector_state.id::text
  WHERE temp_node.epa_type::text = 'JUNCTION'::text
  ORDER BY temp_node.node_id;


DROP VIEW IF EXISTS "v_inp_pump" CASCADE;
CREATE VIEW "v_inp_pump" AS 
SELECT 
	concat(inp_pump.node_id, '_n2a') AS arc_id,
	temp_arc.node_1, 
	temp_arc.node_2, 
	(('POWER'::text || ' '::text) || (inp_pump.power)::text) AS power, 
	(('HEAD'::text || ' '::text) || (inp_pump.curve_id)::text) AS head, (('SPEED'::text || ' '::text) || inp_pump.speed) AS speed, 
	(('PATTERN'::text || ' '::text) || (inp_pump.pattern)::text) AS pattern, 
	inp_selector_sector.sector_id 
	FROM temp_arc
	JOIN inp_pump ON temp_arc.arc_id = concat(inp_pump.node_id, '_n2a')
	JOIN inp_selector_sector ON ((temp_arc.sector_id)::text = (inp_selector_sector.sector_id)::text)
	JOIN inp_selector_state ON ((temp_arc."state")::text = (inp_selector_state.id)::text);



DROP VIEW IF EXISTS v_inp_valve_cu CASCADE;
CREATE OR REPLACE VIEW v_inp_valve_cu AS 
SELECT 
	concat(inp_valve.node_id, '_n2a') AS arc_id,
    temp_arc.node_1,
    temp_arc.node_2,
    cat_arc.dint AS diameter,
    inp_valve.valv_type,
    inp_valve.curve_id,
    inp_valve.minorloss,
    inp_selector_sector.sector_id
	FROM temp_arc
	JOIN inp_valve ON temp_arc.arc_id = concat(inp_valve.node_id, '_n2a')
	JOIN cat_arc ON temp_arc.arccat_id::text = cat_arc.id::text
    JOIN inp_selector_sector ON temp_arc.sector_id::text = inp_selector_sector.sector_id::text
    JOIN inp_selector_state ON temp_arc.state::text = inp_selector_state.id::text
	WHERE inp_valve.valv_type::text = 'GPV'::text;



DROP VIEW IF EXISTS v_inp_valve_fl CASCADE;
CREATE OR REPLACE VIEW v_inp_valve_fl AS 
 SELECT concat(inp_valve.node_id, '_n2a') AS arc_id,
    temp_arc.node_1,
    temp_arc.node_2,
    cat_arc.dint AS diameter,
    inp_valve.valv_type,
    inp_valve.flow,
    inp_valve.minorloss,
    inp_selector_sector.sector_id
    FROM temp_arc
    JOIN inp_valve ON temp_arc.arc_id = concat(inp_valve.node_id, '_n2a')
    JOIN cat_arc ON temp_arc.arccat_id::text = cat_arc.id::text
    JOIN inp_selector_sector ON temp_arc.sector_id::text = inp_selector_sector.sector_id::text
    JOIN inp_selector_state ON temp_arc.state::text = inp_selector_state.id::text
	WHERE inp_valve.valv_type::text = 'FCV'::text;



DROP VIEW IF EXISTS v_inp_valve_lc CASCADE;
CREATE OR REPLACE VIEW v_inp_valve_lc AS 
SELECT 
	concat(inp_valve.node_id, '_n2a') AS arc_id,
    temp_arc.node_1,
    temp_arc.node_2,
    cat_arc.dint AS diameter,
    inp_valve.valv_type,
    inp_valve.coef_loss,
    inp_valve.minorloss,
    inp_selector_sector.sector_id
	FROM temp_arc
    JOIN inp_valve ON temp_arc.arc_id = concat(inp_valve.node_id, '_n2a')
    JOIN cat_arc ON temp_arc.arccat_id::text = cat_arc.id::text
    JOIN inp_selector_sector ON temp_arc.sector_id::text = inp_selector_sector.sector_id::text
    JOIN inp_selector_state ON temp_arc.state::text = inp_selector_state.id::text
	WHERE inp_valve.valv_type::text = 'TCV'::text;



DROP VIEW IF EXISTS v_inp_valve_pr CASCADE;
CREATE OR REPLACE VIEW v_inp_valve_pr AS 
SELECT concat(inp_valve.node_id, '_n2a') AS arc_id,
    temp_arc.node_1,
    temp_arc.node_2,
    cat_arc.dint AS diameter,
    inp_valve.valv_type,
    inp_valve.pressure,
    inp_valve.minorloss,
    inp_selector_sector.sector_id
    FROM temp_arc
    JOIN inp_valve ON temp_arc.arc_id = concat(inp_valve.node_id, '_n2a')
    JOIN cat_arc ON temp_arc.arccat_id::text = cat_arc.id::text
    JOIN inp_selector_sector ON temp_arc.sector_id::text = inp_selector_sector.sector_id::text
    JOIN inp_selector_state ON temp_arc.state::text = inp_selector_state.id::text
    WHERE inp_valve.valv_type::text = 'PRV'::text OR inp_valve.valv_type::text = 'PSV'::text OR inp_valve.valv_type::text = 'PBV'::text;



DROP VIEW IF EXISTS v_inp_pipe CASCADE;
CREATE OR REPLACE VIEW v_inp_pipe AS 
    SELECT arc.arc_id, 
    arc.node_1, 
    arc.node_2, 
    CASE
        WHEN arc.length < 0.10 THEN 0.100::numeric(12,3)
        ELSE arc.length
    END AS length, 
    arc.arccat_id, 
    arc.sector_id, 
    arc.state, 
    CASE
		WHEN custom_dint IS NOT NULL THEN custom_dint
		ELSE dint
	END AS diameter, 
	CASE
		WHEN custom_roughness IS NOT NULL THEN custom_roughness
		ELSE cat_mat_roughness.roughness
	END AS roughness,  
    inp_pipe.minorloss, 
    inp_pipe.status
    FROM v_inp_arc arc
   JOIN inp_pipe ON arc.arc_id::text = inp_pipe.arc_id::text
   JOIN cat_arc ON arc.arccat_id::text = cat_arc.id::text
   JOIN cat_mat_arc ON cat_arc.matcat_id::text = cat_mat_arc.id::text
   JOIN inp_selector_state ON arc.state::text = inp_selector_state.id::text
   JOIN inp_selector_sector ON arc.sector_id::text = inp_selector_sector.sector_id::text
   JOIN cat_mat_roughness ON cat_mat_roughness.matcat_id::text = cat_mat_arc.id::text 
   where (now()::date - builtdate)/365 >= cat_mat_roughness.init_age and (now()::date - builtdate)/365 < cat_mat_roughness.end_age 
UNION 
    SELECT 
    arc.arc_id, 
    arc.node_1, 
    arc.node_2, 
    CASE
        WHEN arc.length < 0.10 THEN 0.100::numeric(12,3)
        ELSE arc.length
    END AS length, 
    arc.arccat_id, 
    arc.sector_id, 
    arc.state, 
    cat_arc.dint AS diameter, 
    cat_mat_roughness.roughness, 
    inp_shortpipe.minorloss, 
    inp_shortpipe.status
    FROM v_inp_arc arc
   JOIN inp_shortpipe ON arc.arc_id::text = concat(inp_shortpipe.node_id, '_n2a')
   JOIN cat_arc ON arc.arccat_id::text = cat_arc.id::text
   JOIN cat_mat_arc ON cat_arc.matcat_id::text = cat_mat_arc.id::text
   JOIN inp_selector_state ON arc.state::text = inp_selector_state.id::text
   JOIN inp_selector_sector ON arc.sector_id::text = inp_selector_sector.sector_id::text
   JOIN cat_mat_roughness ON cat_mat_roughness.matcat_id::text = cat_mat_arc.id::text ;



DROP VIEW IF EXISTS v_inp_vertice CASCADE;
CREATE OR REPLACE VIEW v_inp_vertice AS 
 (SELECT nextval ('"SCHEMA_NAME".inp_vertice_id_seq'::regclass) AS id, 
    arc.arc_id, 
    st_x(arc.point)::numeric(16,3) AS xcoord, 
    st_y(arc.point)::numeric(16,3) AS ycoord
   FROM ( SELECT (st_dumppoints(arc_1.the_geom)).geom AS point, 
            st_startpoint(arc_1.the_geom) AS startpoint, 
            st_endpoint(arc_1.the_geom) AS endpoint, 
            arc_1.sector_id, 
            arc_1.arc_id
           FROM arc arc_1) arc
   JOIN inp_selector_sector ON arc.sector_id::text = inp_selector_sector.sector_id::text
  WHERE ((arc.point < arc.startpoint OR arc.point > arc.startpoint) AND (arc.point < arc.endpoint OR arc.point > arc.endpoint)) AND
	  arc.arc_id NOT IN (SELECT arc_id FROM temp_arc WHERE arc_id IS NOT NULL)
 UNION
  SELECT nextval ('"SCHEMA_NAME".inp_vertice_id_seq'::regclass) AS id, 
    arc.arc_id, 
    st_x(arc.point)::numeric(16,3) AS xcoord, 
    st_y(arc.point)::numeric(16,3) AS ycoord
   FROM ( SELECT (st_dumppoints(arc_1.the_geom)).geom AS point, 
            st_startpoint(arc_1.the_geom) AS startpoint, 
            st_endpoint(arc_1.the_geom) AS endpoint, 
            arc_1.sector_id, 
            arc_1.arc_id
           FROM temp_arc arc_1) arc
   JOIN inp_selector_sector ON arc.sector_id::text = inp_selector_sector.sector_id::text
  WHERE ((arc.point < arc.startpoint OR arc.point > arc.startpoint) AND (arc.point < arc.endpoint OR arc.point > arc.endpoint)))
  ORDER BY id;



-- ----------------------------
-- View structure for v_rpt_result
-- ----------------------------

DROP VIEW IF EXISTS "v_rpt_arc" CASCADE; 
CREATE VIEW "v_rpt_arc" AS 
SELECT arc.arc_id, rpt_selector_result.result_id, max(rpt_arc.flow) AS max_flow, min(rpt_arc.flow) AS min_flow, max(rpt_arc.vel) AS max_vel, min(rpt_arc.vel) AS min_vel, max(rpt_arc.headloss) AS max_headloss, min(rpt_arc.headloss) AS min_headloss, max(rpt_arc.setting) AS max_setting, min(rpt_arc.setting) AS min_setting, max(rpt_arc.reaction) AS max_reaction, min(rpt_arc.reaction) AS min_reaction, max(rpt_arc.ffactor) AS max_ffactor, min(rpt_arc.ffactor) AS min_ffactor, arc.the_geom 
FROM ((arc JOIN rpt_arc ON (((rpt_arc.arc_id)::text = (arc.arc_id)::text))) JOIN rpt_selector_result ON (((rpt_arc.result_id)::text = (rpt_selector_result.result_id)::text))) GROUP BY arc.arc_id, rpt_selector_result.result_id, arc.the_geom ORDER BY arc.arc_id;


DROP VIEW IF EXISTS "v_rpt_energy_usage" CASCADE;
CREATE VIEW "v_rpt_energy_usage" AS 
SELECT rpt_energy_usage.id, rpt_energy_usage.result_id, rpt_energy_usage.node_id, rpt_energy_usage.usage_fact, rpt_energy_usage.avg_effic, rpt_energy_usage.kwhr_mgal, rpt_energy_usage.avg_kw, rpt_energy_usage.peak_kw, rpt_energy_usage.cost_day 
FROM (rpt_selector_result JOIN rpt_energy_usage ON (((rpt_selector_result.result_id)::text = (rpt_energy_usage.result_id)::text)));


DROP VIEW IF EXISTS "v_rpt_hydraulic_status" CASCADE;
CREATE VIEW "v_rpt_hydraulic_status" AS 
SELECT rpt_hydraulic_status.id, rpt_hydraulic_status.result_id, rpt_hydraulic_status."time", rpt_hydraulic_status.text 
FROM (rpt_hydraulic_status JOIN rpt_selector_result ON (((rpt_selector_result.result_id)::text = (rpt_hydraulic_status.result_id)::text)));


DROP VIEW IF EXISTS "v_rpt_node" CASCADE;
CREATE VIEW "v_rpt_node" AS 
SELECT node.node_id, rpt_selector_result.result_id, max(rpt_node.elevation) AS elevation, max(rpt_node.demand) AS max_demand, min(rpt_node.demand) AS min_demand, max(rpt_node.head) AS max_head, min(rpt_node.head) AS min_head, max(rpt_node.press) AS max_pressure, min(rpt_node.press) AS min_pressure, max(rpt_node.quality) AS max_quality, min(rpt_node.quality) AS min_quality, node.the_geom 
FROM ((node JOIN rpt_node ON (((rpt_node.node_id)::text = (node.node_id)::text))) JOIN rpt_selector_result ON (((rpt_node.result_id)::text = (rpt_selector_result.result_id)::text))) GROUP BY node.node_id, rpt_selector_result.result_id, node.the_geom ORDER BY node.node_id;



-- ----------------------------
-- View structure for v_rpt_compare
-- ----------------------------

DROP VIEW IF EXISTS "v_rpt_comp_arc" CASCADE; 
CREATE VIEW "v_rpt_comp_arc" AS 
SELECT arc.arc_id, rpt_selector_compare.result_id, max(rpt_arc.flow) AS max_flow, min(rpt_arc.flow) AS min_flow, max(rpt_arc.vel) AS max_vel, min(rpt_arc.vel) AS min_vel, max(rpt_arc.headloss) AS max_headloss, min(rpt_arc.headloss) AS min_headloss, max(rpt_arc.setting) AS max_setting, min(rpt_arc.setting) AS min_setting, max(rpt_arc.reaction) AS max_reaction, min(rpt_arc.reaction) AS min_reaction, max(rpt_arc.ffactor) AS max_ffactor, min(rpt_arc.ffactor) AS min_ffactor, arc.the_geom 
FROM ((temp_arc arc JOIN rpt_arc ON (((rpt_arc.arc_id)::text = (arc.arc_id)::text))) JOIN rpt_selector_compare ON (((rpt_arc.result_id)::text = (rpt_selector_compare.result_id)::text))) GROUP BY arc.arc_id, rpt_selector_compare.result_id, arc.the_geom ORDER BY arc.arc_id;


DROP VIEW IF EXISTS "v_rpt_comp_energy_usage" CASCADE;
CREATE VIEW "v_rpt_comp_energy_usage" AS 
SELECT rpt_energy_usage.id, rpt_energy_usage.result_id, rpt_energy_usage.node_id, rpt_energy_usage.usage_fact, rpt_energy_usage.avg_effic, rpt_energy_usage.kwhr_mgal, rpt_energy_usage.avg_kw, rpt_energy_usage.peak_kw, rpt_energy_usage.cost_day 
FROM (rpt_selector_compare JOIN rpt_energy_usage ON (((rpt_selector_compare.result_id)::text = (rpt_energy_usage.result_id)::text)));


DROP VIEW IF EXISTS "v_rpt_comp_hydraulic_status" CASCADE;
CREATE VIEW "v_rpt_comp_hydraulic_status" AS 
SELECT rpt_hydraulic_status.id, rpt_hydraulic_status.result_id, rpt_hydraulic_status."time", rpt_hydraulic_status.text 
FROM (rpt_hydraulic_status JOIN rpt_selector_compare ON (((rpt_selector_compare.result_id)::text = (rpt_hydraulic_.result_id)::text)));


DROP VIEW IF EXISTS "v_rpt_comp_node" CASCADE;
CREATE VIEW "v_rpt_comp_node" AS 
SELECT node.node_id, rpt_selector_compare.result_id, max(rpt_node.elevation) AS elevation, max(rpt_node.demand) AS max_demand, min(rpt_node.demand) AS min_demand, max(rpt_node.head) AS max_head, min(rpt_node.head) AS min_head, max(rpt_node.press) AS max_pressure, min(rpt_node.press) AS min_pressure, max(rpt_node.quality) AS max_quality, min(rpt_node.quality) AS min_quality, node.the_geom 
FROM ((temp_node node JOIN rpt_node ON (((rpt_node.node_id)::text = (node.node_id)::text))) JOIN rpt_selector_compare ON (((rpt_node.result_id)::text = (rpt_selector_compare.result_id)::text))) GROUP BY node.node_id, rpt_selector_compare.result_id, node.the_geom ORDER BY node.node_id;
