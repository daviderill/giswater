﻿/*
This file is part of Giswater
The program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
This version of Giswater is provided by Giswater Association
*/

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 10 (class 2615 OID 151924)
-- Name: wsp; Type: SCHEMA; Schema: -; Owner: -
--

 CREATE SCHEMA "wsp";
SET search_path = "wsp", public, pg_catalog;


-- ----------------------------
-- Sequences
-- --------------------------


CREATE SEQUENCE "wsp"."version_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


CREATE SEQUENCE "wsp"."node_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
	

CREATE SEQUENCE "wsp"."arc_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "wsp"."connec_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

 
CREATE SEQUENCE "wsp"."link_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE SEQUENCE "wsp"."node_flow_trace_seq"
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
  

CREATE SEQUENCE "wsp"."arc_flow_trace_seq"
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
  

CREATE SEQUENCE "wsp"."node_flow_exit_seq"
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;
  

CREATE SEQUENCE "wsp"."arc_flow_exit_seq"
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;



-- ----------------------------
-- Table system structure 
-- ----------------------------

CREATE TABLE "wsp"."version" (
"id" int4 DEFAULT nextval('"wsp".version_seq'::regclass) NOT NULL,
"giswater" varchar(16) COLLATE "default",
"wspoftware" varchar(16) COLLATE "default",
"postgres" varchar(512) COLLATE "default",
"postgis" varchar(512) COLLATE "default",
"date" timestamp(6) DEFAULT now(),
CONSTRAINT version_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE)
;
 
CREATE TABLE "wsp"."arc_type" (
"id" varchar(18) COLLATE "default" NOT NULL,
"type" varchar(18) COLLATE "default" NOT NULL,
"man_table" varchar(18) COLLATE "default" NOT NULL,
"epa_default" varchar(18) COLLATE "default" NOT NULL,
"epa_table" varchar(18) COLLATE "default" NOT NULL,
CONSTRAINT arc_type_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE)
;


CREATE TABLE "wsp"."node_type" (
"id" varchar(18) COLLATE "default" NOT NULL,
"type" varchar(18) COLLATE "default" NOT NULL,
"man_table" varchar(18) COLLATE "default" NOT NULL,
"epa_default" varchar(18) COLLATE "default" NOT NULL,
"epa_table" varchar(18) COLLATE "default" NOT NULL,
CONSTRAINT node_type_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE)
;




-- ----------------------------
-- Table structure for CATALOGS
-- ----------------------------


CREATE TABLE "wsp"."cat_mat" (
"id" varchar(30) COLLATE "default",
"descript" varchar(512) COLLATE "default",
"roughness" numeric(12,4),
"link" varchar(512) COLLATE "default",
"url" varchar(512) COLLATE "default",
"picture" varchar(512) COLLATE "default",
"svg" varchar(50) COLLATE "default",
CONSTRAINT cat_mat_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE)
;


CREATE TABLE "wsp"."cat_arc" (
"id" varchar(30) COLLATE "default" NOT NULL, 
"arctype_id" varchar(16) COLLATE "default",
"matcat_id" varchar(16) COLLATE "default",
"pnom" varchar(16) COLLATE "default",
"dnom" varchar(16) COLLATE "default",
"dint" numeric(12,5),
"dext" numeric(12,5),
"descript" varchar(512) COLLATE "default",
"link" varchar(512) COLLATE "default",
"url" varchar(512) COLLATE "default",
"picture" varchar(512) COLLATE "default",
"svg" varchar(50) COLLATE "default",
CONSTRAINT cat_arc_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE)

;


CREATE TABLE "wsp"."cat_node" (
"id" varchar(30) COLLATE "default" NOT NULL,
"nodetype_id" varchar(16) COLLATE "default",
"matcat_id" varchar(16) COLLATE "default",
"matcat_2" varchar(16) COLLATE "default",
"matcat_3" varchar(16) COLLATE "default",
"pnom" varchar(16) COLLATE "default",
"dnom" varchar(16) COLLATE "default",
"dnom_2" varchar(16) COLLATE "default",
"dnom_3" varchar(16) COLLATE "default",
"geom1" numeric (12,2),
"geom2" numeric (12,2),
"geom3" numeric (12,2),
"value" numeric (12,2),
"descript" varchar(512) COLLATE "default",
"link" varchar(512) COLLATE "default",
"url" varchar(512) COLLATE "default",
"picture" varchar(512) COLLATE "default",
"svg" varchar(50) COLLATE "default",
CONSTRAINT cat_node_pkey PRIMARY KEY (id)
)
WITH (OIDS=FALSE)
;





-- ----------------------------
-- Table structure for GIS features
-- ----------------------------

CREATE TABLE "wsp"."sector" (
"sector_id" varchar(30) COLLATE "default" NOT NULL,
"descript" varchar(100) COLLATE "default",
"the_geom" public.geometry (MULTIPOLYGON, 25831),
CONSTRAINT sector_pkey PRIMARY KEY (sector_id)
)
WITH (OIDS=FALSE)
;



CREATE TABLE "wsp"."node" (
"node_id" varchar(16) COLLATE "default" NOT NULL,
"elevation" numeric(12,4),
"depth" numeric(12,4),
"nodecat_id" varchar(30) COLLATE "default" NOT NULL,
"epa_type" varchar(16) COLLATE "default" NOT NULL,
"sector_id" varchar(30) COLLATE "default" NOT NULL,
"state" character varying(16) NOT NULL,
"annotation" character varying(254),
"observ" character varying(254),
"comment" character varying(254),
"rotation" numeric (6,3),
													-- to INP model
"dma_id" varchar(30) COLLATE "default",
"soilcat_id" varchar(16) COLLATE "default",
"category_type" varchar(18) COLLATE "default",
"fluid_type" varchar(18) COLLATE "default",
"location_type" varchar(18) COLLATE "default",
"workcat_id" varchar(255) COLLATE "default",
"buildercat_id" varchar(30) COLLATE "default",
"builtdate" timestamp (6) without time zone,
													-- to MAN model
"text" varchar(50) COLLATE "default",
"adress_01" varchar(50) COLLATE "default",
"adress_02" varchar(50) COLLATE "default",
"adress_03" varchar(50) COLLATE "default",
"descript" varchar(254) COLLATE "default",

"link" character varying(512),
"verified" varchar(16) COLLATE "default" NOT NULL,
"the_geom" public.geometry (POINT, 25831),
CONSTRAINT node_pkey PRIMARY KEY (node_id)
)
WITH (OIDS=FALSE)
;


CREATE TABLE "wsp"."arc" (
"arc_id" varchar(16) COLLATE "default" NOT NULL,
"node_1" varchar(16) COLLATE "default",
"node_2" varchar(16) COLLATE "default",
"arccat_id" varchar(30) COLLATE "default" NOT NULL,
"epa_type" varchar(16) COLLATE "default" NOT NULL,
"sector_id" varchar(30) COLLATE "default" NOT NULL,
"state" character varying(16) NOT NULL,
"annotation" character varying(254),
"observ" character varying(254),
"comment" character varying(254),
"rotation" numeric (6,3),
"custom_length" numeric (12,2),
													-- to INP model
"dma_id" varchar(30) COLLATE "default",
"soilcat_id" varchar(16) COLLATE "default",
"category_type" varchar(18) COLLATE "default",
"fluid_type" varchar(18) COLLATE "default",
"location_type" varchar(18) COLLATE "default",
"workcat_id" varchar(255) COLLATE "default",
"buildercat_id" varchar(30) COLLATE "default",
"builtdate" timestamp (6) without time zone,
													-- to MAN model
"text" varchar(50) COLLATE "default",
"adress_01" varchar(50) COLLATE "default",
"adress_02" varchar(50) COLLATE "default",
"adress_03" varchar(50) COLLATE "default",
"descript" varchar(254) COLLATE "default",

"link" character varying(512),
"verified" varchar(16) COLLATE "default" NOT NULL,
"the_geom" public.geometry (LINESTRING, 25831),
CONSTRAINT arc_pkey PRIMARY KEY (arc_id)
)
WITH (OIDS=FALSE)
;




CREATE TABLE "wsp"."value_state" (
"id" varchar(16) COLLATE "default" NOT NULL,
"observ" varchar(254) COLLATE "default",
 CONSTRAINT value_state_pkey PRIMARY KEY (id)
) WITH (OIDS=FALSE) ;



CREATE TABLE "wsp"."value_verified" (
"id" varchar(16) COLLATE "default" NOT NULL,
"observ" varchar(254) COLLATE "default",
 CONSTRAINT value_verified_pkey PRIMARY KEY (id)
) WITH (OIDS=FALSE) ;



------
-- FK
------

ALTER TABLE "wsp"."cat_arc" ADD FOREIGN KEY ("matcat_id") REFERENCES "wsp"."cat_mat" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."cat_arc" ADD FOREIGN KEY ("arctype_id") REFERENCES "wsp"."arc_type" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "wsp"."cat_node" ADD FOREIGN KEY ("matcat_id") REFERENCES "wsp"."cat_mat" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."cat_node" ADD FOREIGN KEY ("nodetype_id") REFERENCES "wsp"."node_type" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "wsp"."node" ADD FOREIGN KEY ("nodecat_id") REFERENCES "wsp"."cat_node" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."node" ADD FOREIGN KEY ("sector_id") REFERENCES "wsp"."sector" ("sector_id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."node" ADD FOREIGN KEY ("state") REFERENCES "wsp"."value_state" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."node" ADD FOREIGN KEY ("verified") REFERENCES "wsp"."value_verified" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE "wsp"."arc" ADD FOREIGN KEY ("arccat_id") REFERENCES "wsp"."cat_arc" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."arc" ADD FOREIGN KEY ("sector_id") REFERENCES "wsp"."sector" ("sector_id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."arc" ADD FOREIGN KEY ("node_1") REFERENCES "wsp"."node" ("node_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "wsp"."arc" ADD FOREIGN KEY ("node_2") REFERENCES "wsp"."node" ("node_id") ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE "wsp"."arc" ADD FOREIGN KEY ("state") REFERENCES "wsp"."value_state" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE "wsp"."arc" ADD FOREIGN KEY ("verified") REFERENCES "wsp"."value_verified" ("id") ON DELETE RESTRICT ON UPDATE CASCADE;
