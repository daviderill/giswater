/*
This file is part of Giswater 3
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

SET search_path = "SCHEMA_NAME", public, pg_catalog;

/*
ALTER TABLE SCHEMA_NAME.inp_typevalue_timeseries ADD CONSTRAINT inp_typevalue_timeseries_check CHECK (id IN ('ABSOLUTE','FILE','RELATIVE'));
ALTER TABLE SCHEMA_NAME.inp_timser_id ADD CONSTRAINT inp_timser_id_check CHECK (id IN ('T10-5m','T5-5m'));
ALTER TABLE SCHEMA_NAME.inp_value_files_actio ADD CONSTRAINT inp_value_files_actio_check CHECK (id IN ('SAVE','USE'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_storage ADD CONSTRAINT inp_typevalue_storage_check CHECK (id IN ('FUNCTIONAL','TABULAR'));
ALTER TABLE SCHEMA_NAME.inp_value_weirs ADD CONSTRAINT inp_value_weirs_check CHECK (id IN ('SIDEFLOW','TRANSVERSE','TRAPEZOIDAL','V-NOTCH'));
ALTER TABLE SCHEMA_NAME.inp_options ADD CONSTRAINT inp_options_check CHECK (id IN (1));
ALTER TABLE SCHEMA_NAME.inp_value_curve ADD CONSTRAINT inp_value_curve_check CHECK (id IN ('CONTROL','DIVERSION','PUMP1','PUMP2','PUMP3','PUMP4','RATING','SHAPE','STORAGE','TIDAL'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_divider ADD CONSTRAINT inp_typevalue_divider_check CHECK (id IN ('CUTOFF','OVERFLOW','TABULAR','WEIR'));
ALTER TABLE SCHEMA_NAME.inp_value_routeto ADD CONSTRAINT inp_value_routeto_check CHECK (id IN ('IMPERVIOUS','OUTLET','PERVIOUS'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_outlet ADD CONSTRAINT inp_typevalue_outlet_check CHECK (id IN ('FUNCTIONAL/DEPTH','FUNCTIONAL/HEAD','TABULAR/DEPTH','TABULAR/HEAD'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_orifice ADD CONSTRAINT inp_typevalue_orifice_check CHECK (id IN ('BOTTOM','SIDE'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_pattern ADD CONSTRAINT inp_typevalue_pattern_check CHECK (id IN ('DAILY','HOURLY','MONTHLY','WEEKEND'));
ALTER TABLE SCHEMA_NAME.inp_value_catarc ADD CONSTRAINT inp_value_catarc_check CHECK (id IN ('ARCH','BASKETHANDLE','CIRCULAR','CUSTOM','DUMMY','EGG','FILLED_CIRCULAR','FORCE_MAIN','HORIZ_ELLIPSE','HORSESHOE','IRREGULAR','MODBASKETHANDLE','PARABOLIC','POWER','RECT_CLOSED','RECT_OPEN','RECT_ROUND','RECT_TRIANGULAR','SEMICIRCULAR','SEMIELLIPTICAL','TRAPEZOIDAL','TRIANGULAR','VIRTUAL'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_windsp ADD CONSTRAINT inp_typevalue_windsp_check CHECK (id IN ('FILE','MONTHLY'));
ALTER TABLE SCHEMA_NAME.inp_value_files_type ADD CONSTRAINT inp_value_files_type_check CHECK (id IN ('HOTSTART','INFLOWS','OUTFLOWS','RAINFALL','RDII','RUNOFF'));
ALTER TABLE SCHEMA_NAME.inp_value_lidcontrol ADD CONSTRAINT inp_value_lidcontrol_check CHECK (id IN ('BC','DRAIN','DRAINMAT','GR','IT','PAVEMENT','PP','RB','SOIL','STORAGE','SURFACE','VS'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_evap ADD CONSTRAINT inp_typevalue_evap_check CHECK (id IN ('CONSTANT','FILE','MONTHLY','RECOVERY','TEMPERATURE','TIMESERIES'));
ALTER TABLE SCHEMA_NAME.inp_value_treatment ADD CONSTRAINT inp_value_treatment_check CHECK (id IN ('CONCEN','RATE','REMOVAL'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_temp ADD CONSTRAINT inp_typevalue_temp_check CHECK (id IN ('FILE','TIMESERIES'));
ALTER TABLE SCHEMA_NAME.inp_value_orifice ADD CONSTRAINT inp_value_orifice_check CHECK (id IN ('CIRCULAR','RECT_CLOSED'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_outfall ADD CONSTRAINT inp_typevalue_outfall_check CHECK (id IN ('FIXED','FREE','NORMAL','TIDAL','TIMESERIES'));
ALTER TABLE SCHEMA_NAME.inp_value_pollutants ADD CONSTRAINT inp_value_pollutants_check CHECK (id IN ('#/L','MG/L','UG/L'));
ALTER TABLE SCHEMA_NAME.inp_value_inflows ADD CONSTRAINT inp_value_inflows_check CHECK (id IN ('CONCEN','MASS'));
ALTER TABLE SCHEMA_NAME.inp_value_status ADD CONSTRAINT inp_value_status_check CHECK (id IN ('OFF','ON'));
ALTER TABLE SCHEMA_NAME.inp_value_raingage ADD CONSTRAINT inp_value_raingage_check CHECK (id IN ('CUMULATIVE','INTENSITY','VOLUME'));
ALTER TABLE SCHEMA_NAME.inp_value_washoff ADD CONSTRAINT inp_value_washoff_check CHECK (id IN ('EMC','EXP','RC'));
ALTER TABLE SCHEMA_NAME.inp_value_yesno ADD CONSTRAINT inp_value_yesno_check CHECK (id IN ('NO','YES'));
ALTER TABLE SCHEMA_NAME.inp_value_buildup ADD CONSTRAINT inp_value_buildup_check CHECK (id IN ('EXP','EXT','POW','SAT'));
ALTER TABLE SCHEMA_NAME.inp_value_allnone ADD CONSTRAINT inp_value_allnone_check CHECK (id IN ('ALL','NONE'));
ALTER TABLE SCHEMA_NAME.inp_typevalue_raingage ADD CONSTRAINT inp_typevalue_raingage_check CHECK (id IN ('FILE','TIMESERIES'));
ALTER TABLE SCHEMA_NAME.inp_value_options_fr ADD CONSTRAINT inp_value_options_fr_check CHECK (id IN ('DYNWAVE','KINWAVE','STEADY'));
ALTER TABLE SCHEMA_NAME.inp_value_options_lo ADD CONSTRAINT inp_value_options_lo_check CHECK (id IN ('DEPTH','ELEVATION'));
ALTER TABLE SCHEMA_NAME.inp_value_mapunits ADD CONSTRAINT inp_value_mapunits_check CHECK (id IN ('DEGREES','FEET','METERS','NONE'));
ALTER TABLE SCHEMA_NAME.inp_value_options_fme ADD CONSTRAINT inp_value_options_fme_check CHECK (id IN ('D-W','H-W'));
ALTER TABLE SCHEMA_NAME.inp_value_options_nfl ADD CONSTRAINT inp_value_options_nfl_check CHECK (id IN ('BOTH','FROUD','SLOPE'));
ALTER TABLE SCHEMA_NAME.inp_value_options_id ADD CONSTRAINT inp_value_options_id_check CHECK (id IN ('FULL','NONE','PARTIAL'));
ALTER TABLE SCHEMA_NAME.inp_project_id ADD CONSTRAINT project_id_check CHECK (title IN ('title'));
ALTER TABLE SCHEMA_NAME.inp_arc_type ADD CONSTRAINT inp_arc_type_check CHECK (id IN ('CONDUIT','NOT DEFINED','ORIFICE','OUTLET','PUMP','VIRTUAL','WEIR'));
ALTER TABLE SCHEMA_NAME.inp_node_type ADD CONSTRAINT inp_node_type_check CHECK (id IN ('DIVIDER','JUNCTION','NOT DEFINED','OUTFALL','STORAGE'));
*/




