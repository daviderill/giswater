﻿/*
This file is part of Giswater
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/



-- ----------------------------
-- Records of inp_arc_type
-- ----------------------------
 
INSERT INTO "wsp"."inp_arc_type" VALUES ('PIPE');
INSERT INTO "wsp"."inp_arc_type" VALUES ('PUMP');
INSERT INTO "wsp"."inp_arc_type" VALUES ('VALVE');
INSERT INTO "wsp"."inp_arc_type" VALUES ('UNDEFINED');

-- ----------------------------
-- Records of inp_node_type
-- ----------------------------
 
INSERT INTO "wsp"."inp_node_type" VALUES ('JUNCTION');
INSERT INTO "wsp"."inp_node_type" VALUES ('RESERVOIR');
INSERT INTO "wsp"."inp_node_type" VALUES ('TANK');
INSERT INTO "wsp"."inp_node_type" VALUES ('UNDEFINED');


-- ----------------------------
-- Records of inp_typevalue_energy
-- ----------------------------
 
INSERT INTO "wsp"."inp_typevalue_energy" VALUES ('DEMAND CHARGE');
INSERT INTO "wsp"."inp_typevalue_energy" VALUES ('GLOBAL');
 

-- ----------------------------
-- Records of inp_typevalue_pump
-- ----------------------------
 
INSERT INTO "wsp"."inp_typevalue_pump" VALUES ('HEAD');
INSERT INTO "wsp"."inp_typevalue_pump" VALUES ('PATTERN');
INSERT INTO "wsp"."inp_typevalue_pump" VALUES ('POWER');
INSERT INTO "wsp"."inp_typevalue_pump" VALUES ('SPEED');
 

-- ----------------------------
-- Records of inp_typevalue_reactions_gl
-- ----------------------------
 
INSERT INTO "wsp"."inp_typevalue_reactions_gl" VALUES ('GLOBAL');
INSERT INTO "wsp"."inp_typevalue_reactions_gl" VALUES ('LIMITING POTENTIAL');
INSERT INTO "wsp"."inp_typevalue_reactions_gl" VALUES ('ORDER');
INSERT INTO "wsp"."inp_typevalue_reactions_gl" VALUES ('ROUGHNESS CORRELATION');
 

-- ----------------------------
-- Records of inp_typevalue_source
-- ----------------------------
 
INSERT INTO "wsp"."inp_typevalue_source" VALUES ('CONCEN');
INSERT INTO "wsp"."inp_typevalue_source" VALUES ('FLOWPACED');
INSERT INTO "wsp"."inp_typevalue_source" VALUES ('MASS');
INSERT INTO "wsp"."inp_typevalue_source" VALUES ('SETPOINT');
 

-- ----------------------------
-- Records of inp_typevalue_valve
-- ----------------------------
 
INSERT INTO "wsp"."inp_typevalue_valve" VALUES ('FCV', 'Flow Control Valve', 'Flow');
INSERT INTO "wsp"."inp_typevalue_valve" VALUES ('PBV', 'Pressure Break Valve', 'Pressure');
INSERT INTO "wsp"."inp_typevalue_valve" VALUES ('PRV', 'Pressure Reduction Valve', 'Pressure');
INSERT INTO "wsp"."inp_typevalue_valve" VALUES ('PSV', 'Pressure Sustain Valve', 'Pressure');
INSERT INTO "wsp"."inp_typevalue_valve" VALUES ('TCV', ' Throttle Control Valve', 'Losses');
INSERT INTO "wsp"."inp_typevalue_valve" VALUES ('VPG', 'General Purpose Valve', 'Losses');
INSERT INTO "wsp"."inp_typevalue_valve" VALUES ('GTV', 'Gate Valve', 'Control'); 

-- ----------------------------
-- Records of inp_value_ampm
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_ampm" VALUES ('AM');
INSERT INTO "wsp"."inp_value_ampm" VALUES ('PM');
 

-- ----------------------------
-- Records of inp_value_curve
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_curve" VALUES ('EFFICIENCY');
INSERT INTO "wsp"."inp_value_curve" VALUES ('HEADLOSS');
INSERT INTO "wsp"."inp_value_curve" VALUES ('PUMP');
INSERT INTO "wsp"."inp_value_curve" VALUES ('VOLUME');
 

-- ----------------------------
-- Records of inp_value_mixing
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_mixing" VALUES ('2COMP');
INSERT INTO "wsp"."inp_value_mixing" VALUES ('FIFO');
INSERT INTO "wsp"."inp_value_mixing" VALUES ('LIFO');
INSERT INTO "wsp"."inp_value_mixing" VALUES ('MIXED');
 

-- ----------------------------
-- Records of inp_value_noneall
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_noneall" VALUES ('ALL');
INSERT INTO "wsp"."inp_value_noneall" VALUES ('NONE');
 

-- ----------------------------
-- Records of inp_value_opti_headloss
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_opti_headloss" VALUES ('C-M');
INSERT INTO "wsp"."inp_value_opti_headloss" VALUES ('D-W');
INSERT INTO "wsp"."inp_value_opti_headloss" VALUES ('H-W');
 

-- ----------------------------
-- Records of inp_value_opti_hyd
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_opti_hyd" VALUES ('');
INSERT INTO "wsp"."inp_value_opti_hyd" VALUES ('SAVE');
INSERT INTO "wsp"."inp_value_opti_hyd" VALUES ('USE');
 

-- ----------------------------
-- Records of inp_value_opti_qual
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_opti_qual" VALUES ('AGE');
INSERT INTO "wsp"."inp_value_opti_qual" VALUES ('CHEMICAL mg/L');
INSERT INTO "wsp"."inp_value_opti_qual" VALUES ('CHEMICAL ug/L');
INSERT INTO "wsp"."inp_value_opti_qual" VALUES ('NONE');
INSERT INTO "wsp"."inp_value_opti_qual" VALUES ('TRACE');
 

-- ----------------------------
-- Records of inp_value_opti_unb
-- ----------------------------
 
 

-- ----------------------------
-- Records of inp_value_opti_unbal
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_opti_unbal" VALUES ('CONTINUE');
INSERT INTO "wsp"."inp_value_opti_unbal" VALUES ('STOP');
 

-- ----------------------------
-- Records of inp_value_opti_units
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('AFD');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('CMD');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('CMH');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('GPM');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('IMGD');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('LPM');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('LPS');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('MGD');
INSERT INTO "wsp"."inp_value_opti_units" VALUES ('MLD');
 

-- ----------------------------
-- Records of inp_value_param_energy
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_param_energy" VALUES ('EFFIC');
INSERT INTO "wsp"."inp_value_param_energy" VALUES ('PATTERN');
INSERT INTO "wsp"."inp_value_param_energy" VALUES ('PRICE');
 

-- ----------------------------
-- Records of inp_value_reactions_el
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_reactions_el" VALUES ('BULK');
INSERT INTO "wsp"."inp_value_reactions_el" VALUES ('TANK');
INSERT INTO "wsp"."inp_value_reactions_el" VALUES ('WALL');
 

-- ----------------------------
-- Records of inp_value_reactions_gl
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_reactions_gl" VALUES ('BULK');
INSERT INTO "wsp"."inp_value_reactions_gl" VALUES ('TANK');
INSERT INTO "wsp"."inp_value_reactions_gl" VALUES ('WALL');
 

-- ----------------------------
-- Records of inp_value_st_pipe
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_st_pipe" VALUES ('CLOSED');
INSERT INTO "wsp"."inp_value_st_pipe" VALUES ('CV');
INSERT INTO "wsp"."inp_value_st_pipe" VALUES ('OPEN');
 

-- ----------------------------
-- Records of inp_value_status
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_status" VALUES ('ACTIVE');
INSERT INTO "wsp"."inp_value_status" VALUES ('CLOSED');
INSERT INTO "wsp"."inp_value_status" VALUES ('OPEN');
 

-- ----------------------------
-- Records of inp_value_times
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_times" VALUES ('AVERAGED');
INSERT INTO "wsp"."inp_value_times" VALUES ('MAXIMUM');
INSERT INTO "wsp"."inp_value_times" VALUES ('MINIMUM');
INSERT INTO "wsp"."inp_value_times" VALUES ('NONE');
INSERT INTO "wsp"."inp_value_times" VALUES ('RANGE');
 

-- ----------------------------
-- Records of inp_value_yesno
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_yesno" VALUES ('NO');
INSERT INTO "wsp"."inp_value_yesno" VALUES ('YES');
 

-- ----------------------------
-- Records of inp_value_yesnofull
-- ----------------------------
 
INSERT INTO "wsp"."inp_value_yesnofull" VALUES ('FULL');
INSERT INTO "wsp"."inp_value_yesnofull" VALUES ('NO');
INSERT INTO "wsp"."inp_value_yesnofull" VALUES ('YES');


-- ----------------------------
-- Records of inp_options
-- ----------------------------
 
INSERT INTO "wsp"."inp_options" VALUES ('LPS', 'H-W', '', '1', '1', '40', '0.001', 'CONTINUE', '2', '10', '0', '', '1', '0.5', 'NONE', '1', '0.01', '', '40');
 

-- ----------------------------
-- Records of inp_report
-- ----------------------------
 
INSERT INTO "wsp"."inp_report" VALUES ('0', '', 'YES', 'YES', 'YES', 'ALL', 'ALL', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES', 'YES');
 

-- ----------------------------
-- Records of inp_times
-- ----------------------------
 
INSERT INTO "wsp"."inp_times" VALUES ('24', '1:00', '0:06', '0:06', '1:00', '0:00', '1:00', '0:00', '12 am', 'NONE');



