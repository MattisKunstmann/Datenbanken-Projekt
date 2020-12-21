--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ARZT; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "ARZT" (
    "ARZT_ID" integer NOT NULL,
    "ANREDE/TITEL" character varying(20),
    "NAME" character varying(20),
    "VORNAME" character varying(20),
    "PRAXIS_ID" integer
);


ALTER TABLE public."ARZT" OWNER TO postgres;

--
-- Name: ARZT_ARZT_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "ARZT_ARZT_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."ARZT_ARZT_ID_seq" OWNER TO postgres;

--
-- Name: ARZT_ARZT_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "ARZT_ARZT_ID_seq" OWNED BY "ARZT"."ARZT_ID";


--
-- Name: PATIENTAKTE; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PATIENTAKTE" (
    "AKTE_ID" integer NOT NULL,
    "PATIENTEN_ID" integer,
    "ERKRANKUNG_ID" character varying,
    "KRANKHEITHISTORIE" character varying,
    "KRANKSCHREIBEN" integer,
    "KRANKENKASSE_ID" character varying,
    "ARZT_ID" integer,
    "UHRZEIT" time without time zone,
    "DATUM" date
);


ALTER TABLE public."PATIENTAKTE" OWNER TO postgres;

--
-- Name: AnzahlArztBesuche; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "AnzahlArztBesuche" AS
 SELECT count(*) AS arztbesuche
   FROM "PATIENTAKTE"
  WHERE ("PATIENTAKTE"."PATIENTEN_ID" = 1);


ALTER TABLE public."AnzahlArztBesuche" OWNER TO postgres;

--
-- Name: benutzeralspatient; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE benutzeralspatient (
    id integer NOT NULL,
    patient_id integer,
    patient_name character varying(20),
    patient_vorname character varying(20),
    passwort character varying(50),
    passwortbestatigen character varying(50)
);


ALTER TABLE public.benutzeralspatient OWNER TO postgres;

--
-- Name: BenutzeralsPatient_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "BenutzeralsPatient_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."BenutzeralsPatient_ID_seq" OWNER TO postgres;

--
-- Name: BenutzeralsPatient_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "BenutzeralsPatient_ID_seq" OWNED BY benutzeralspatient.id;


--
-- Name: ERKRANKUNG; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "ERKRANKUNG" (
    "ERKRANKUNG_ID" character varying(20) NOT NULL,
    "BEZEICHNUNG" character varying(100)
);


ALTER TABLE public."ERKRANKUNG" OWNER TO postgres;

--
-- Name: InformationsbasisfurArzt; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "InformationsbasisfurArzt" AS
 SELECT "PATIENTAKTE"."AKTE_ID",
    "PATIENTAKTE"."PATIENTEN_ID",
    "PATIENTAKTE"."ERKRANKUNG_ID",
    "PATIENTAKTE"."KRANKHEITHISTORIE",
    "PATIENTAKTE"."KRANKSCHREIBEN",
    "PATIENTAKTE"."KRANKENKASSE_ID",
    "PATIENTAKTE"."ARZT_ID",
    "PATIENTAKTE"."UHRZEIT",
    "PATIENTAKTE"."DATUM"
   FROM "PATIENTAKTE"
  WHERE ("PATIENTAKTE"."ARZT_ID" = 1);


ALTER TABLE public."InformationsbasisfurArzt" OWNER TO postgres;

--
-- Name: KRANKENKASSE; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "KRANKENKASSE" (
    "KÜRZEL" character varying(10) NOT NULL,
    "NAME" character varying(50),
    "ADRESSE" character varying(250),
    "TELEFON" character varying(50)
);


ALTER TABLE public."KRANKENKASSE" OWNER TO postgres;

--
-- Name: Krankheitshistorie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "Krankheitshistorie" AS
 SELECT "PATIENTAKTE"."KRANKHEITHISTORIE"
   FROM "PATIENTAKTE"
  WHERE ("PATIENTAKTE"."PATIENTEN_ID" = 1);


ALTER TABLE public."Krankheitshistorie" OWNER TO postgres;

--
-- Name: Krankheitshäufigkeit; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "Krankheitshäufigkeit" AS
 SELECT "ERKRANKUNG"."ERKRANKUNG_ID",
    count(*) AS count
   FROM ("ERKRANKUNG"
   JOIN "PATIENTAKTE" ON ((("ERKRANKUNG"."ERKRANKUNG_ID")::text = ("PATIENTAKTE"."ERKRANKUNG_ID")::text)))
  GROUP BY "ERKRANKUNG"."ERKRANKUNG_ID";


ALTER TABLE public."Krankheitshäufigkeit" OWNER TO postgres;

--
-- Name: KrankschreibungstaginJahr; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "KrankschreibungstaginJahr" AS
 SELECT sum("PATIENTAKTE"."KRANKSCHREIBEN") AS krankschreibungstag
   FROM "PATIENTAKTE"
  WHERE ((("PATIENTAKTE"."PATIENTEN_ID" = 1) AND ("PATIENTAKTE"."DATUM" >= '2014-01-01'::date)) AND ("PATIENTAKTE"."DATUM" <= '2014-12-31'::date));


ALTER TABLE public."KrankschreibungstaginJahr" OWNER TO postgres;

--
-- Name: LangerfristigenKrankschreiben; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "LangerfristigenKrankschreiben" AS
 SELECT p."ERKRANKUNG_ID",
    e."BEZEICHNUNG",
    p."KRANKSCHREIBEN"
   FROM "PATIENTAKTE" p,
    "ERKRANKUNG" e
  WHERE ((p."KRANKSCHREIBEN" >= 5) AND ((p."ERKRANKUNG_ID")::text = (e."ERKRANKUNG_ID")::text))
  ORDER BY p."KRANKSCHREIBEN" DESC;


ALTER TABLE public."LangerfristigenKrankschreiben" OWNER TO postgres;

--
-- Name: PATIENT; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PATIENT" (
    "PATIENT_ID" integer NOT NULL,
    "GESCHLECHT" character(1),
    "NAME" character varying(20),
    "VORNAME" character varying(20),
    "ORT" character varying(20)
);


ALTER TABLE public."PATIENT" OWNER TO postgres;

--
-- Name: PATIENTAKTE_AKTE_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PATIENTAKTE_AKTE_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PATIENTAKTE_AKTE_ID_seq" OWNER TO postgres;

--
-- Name: PATIENTAKTE_AKTE_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PATIENTAKTE_AKTE_ID_seq" OWNED BY "PATIENTAKTE"."AKTE_ID";


--
-- Name: PATIENT_PATIENT_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PATIENT_PATIENT_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PATIENT_PATIENT_ID_seq" OWNER TO postgres;

--
-- Name: PATIENT_PATIENT_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PATIENT_PATIENT_ID_seq" OWNED BY "PATIENT"."PATIENT_ID";


--
-- Name: PRAXIS; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "PRAXIS" (
    "PRAXIS_ID" integer NOT NULL,
    "NAME" character varying(50),
    "ADRESSE" character varying(250)
);


ALTER TABLE public."PRAXIS" OWNER TO postgres;

--
-- Name: PRAXIS_PRAXIS_ID_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "PRAXIS_PRAXIS_ID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."PRAXIS_PRAXIS_ID_seq" OWNER TO postgres;

--
-- Name: PRAXIS_PRAXIS_ID_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "PRAXIS_PRAXIS_ID_seq" OWNED BY "PRAXIS"."PRAXIS_ID";


--
-- Name: Regionalekrankheiten; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "Regionalekrankheiten" AS
 SELECT p."ERKRANKUNG_ID",
    e."BEZEICHNUNG",
    p1."ORT",
    count(*) AS anzahl
   FROM "PATIENTAKTE" p,
    "ERKRANKUNG" e,
    "PATIENT" p1
  WHERE (((p."ERKRANKUNG_ID")::text = (e."ERKRANKUNG_ID")::text) AND (p1."PATIENT_ID" = p."PATIENTEN_ID"))
  GROUP BY p."ERKRANKUNG_ID", e."BEZEICHNUNG", p1."ORT";


ALTER TABLE public."Regionalekrankheiten" OWNER TO postgres;

--
-- Name: leztemalbeimArzt; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW "leztemalbeimArzt" AS
 SELECT max("PATIENTAKTE"."DATUM") AS "Datum"
   FROM "PATIENTAKTE"
  WHERE ("PATIENTAKTE"."PATIENTEN_ID" = 1);


ALTER TABLE public."leztemalbeimArzt" OWNER TO postgres;

--
-- Name: saisonalkrankheit; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW saisonalkrankheit AS
 SELECT p."ERKRANKUNG_ID",
    e."BEZEICHNUNG",
    count(*) AS anzahl
   FROM "PATIENTAKTE" p,
    "ERKRANKUNG" e
  WHERE (((p."DATUM" >= '2014-01-01'::date) AND (p."DATUM" <= '2014-08-01'::date)) AND ((p."ERKRANKUNG_ID")::text = (e."ERKRANKUNG_ID")::text))
  GROUP BY p."ERKRANKUNG_ID", e."BEZEICHNUNG";


ALTER TABLE public.saisonalkrankheit OWNER TO postgres;

--
-- Name: ARZT_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ARZT" ALTER COLUMN "ARZT_ID" SET DEFAULT nextval('"ARZT_ARZT_ID_seq"'::regclass);


--
-- Name: PATIENT_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PATIENT" ALTER COLUMN "PATIENT_ID" SET DEFAULT nextval('"PATIENT_PATIENT_ID_seq"'::regclass);


--
-- Name: AKTE_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PATIENTAKTE" ALTER COLUMN "AKTE_ID" SET DEFAULT nextval('"PATIENTAKTE_AKTE_ID_seq"'::regclass);


--
-- Name: PRAXIS_ID; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PRAXIS" ALTER COLUMN "PRAXIS_ID" SET DEFAULT nextval('"PRAXIS_PRAXIS_ID_seq"'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY benutzeralspatient ALTER COLUMN id SET DEFAULT nextval('"BenutzeralsPatient_ID_seq"'::regclass);


--
-- Data for Name: ARZT; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ARZT" ("ARZT_ID", "ANREDE/TITEL", "NAME", "VORNAME", "PRAXIS_ID") FROM stdin;
1	Med.Dr.	Müller	Heinrich	1
2	Med.Dr.	Henry	Mark	2
3	Med.Dr.	Carlos	Tina	3
4	Med.Dr.	Meyer	Hauke	4
5	Med.Dr.	Büker	Mathias	5
\.


--
-- Name: ARZT_ARZT_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"ARZT_ARZT_ID_seq"', 5, true);


--
-- Name: BenutzeralsPatient_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"BenutzeralsPatient_ID_seq"', 1, true);


--
-- Data for Name: ERKRANKUNG; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "ERKRANKUNG" ("ERKRANKUNG_ID", "BEZEICHNUNG") FROM stdin;
ICD10 A00-A09	Infektiöse Darmkrankheiten
ICD10 A15-A19\n	Tuberkulose
ICD10 A20-A28\n	Bestimmte bakterielle Zoonosen
ICD10 A50-A28	Fieber
ICD10 A75-A79 	Rickettsiosen
ICD10 B35-B49 	Mykosen
ICD10 B50-B64	Protozoenkrankheiten
\.


--
-- Data for Name: KRANKENKASSE; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "KRANKENKASSE" ("KÜRZEL", "NAME", "ADRESSE", "TELEFON") FROM stdin;
AOK	AOK-NORD	Kielerstr. 143 24143 KIEL	04313214296
TK	Techniker Krankenkasse	Johannesstr. 100 24106 KIEL	04313334486
\.


--
-- Data for Name: PATIENT; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PATIENT" ("PATIENT_ID", "GESCHLECHT", "NAME", "VORNAME", "ORT") FROM stdin;
1	m	Valentinos	Valentin	Wellingdorf
2	w	Veronika	Katrin	Wellingdorf
3	m	John	Mark	Gaarden
4	w	Boyens	Heike	Projensdorf
5	m	Keller	Hans	Projensdorf
6	w	Meike	Julia	Gaarden
7	m	Gutentag	Henry	Projensdorf
\.


--
-- Data for Name: PATIENTAKTE; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PATIENTAKTE" ("AKTE_ID", "PATIENTEN_ID", "ERKRANKUNG_ID", "KRANKHEITHISTORIE", "KRANKSCHREIBEN", "KRANKENKASSE_ID", "ARZT_ID", "UHRZEIT", "DATUM") FROM stdin;
8	2	ICD10 A00-A09	seit 3 Tage stärker bauchschmerzen	3	TK	1	12:30:00	2014-06-11
7	1	ICD10 A50-A28	seit 2 Tage stärker bauchschmerzen	2	AOK	1	14:00:00	2014-06-10
12	1	ICD10 A00-A09	seit 2 tage schmerzen immer dauert	10	AOK	1	12:30:00	2014-04-12
14	4	ICD10 A75-A79 	sie hat schmerzen.	6	AOK	4	12:33:00	2014-06-23
15	4	ICD10 A75-A79 	Sie hat immer noch schmerzen	\N	AOK	4	15:45:00	2014-06-26
16	5	ICD10 A75-A79 	schmerzen	8	TK	5	12:00:00	2014-05-27
17	7	ICD10 B35-B49 	schmerzen	1	TK	5	13:45:00	2014-07-24
18	6	ICD10 A50-A28	Sie hat Fieber	2	AOK	1	14:00:00	2014-07-24
\.


--
-- Name: PATIENTAKTE_AKTE_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PATIENTAKTE_AKTE_ID_seq"', 18, true);


--
-- Name: PATIENT_PATIENT_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PATIENT_PATIENT_ID_seq"', 7, true);


--
-- Data for Name: PRAXIS; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY "PRAXIS" ("PRAXIS_ID", "NAME", "ADRESSE") FROM stdin;
4	Praxis Projensdorf	Steenbeker Weg 22 24106 Kiel
5	OST Praxis	Schönbergerstr. 13 24148 Kiel
1	Praxis Kiel	Kielerstr. 14 24148 Kiel
3	Praxis Gaarden	Vineteplatz 5 24143 Kiel
2	Praxis Wellingdorf	Wellingdorfer Weg 25 24148 Kiel
\.


--
-- Name: PRAXIS_PRAXIS_ID_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"PRAXIS_PRAXIS_ID_seq"', 5, true);


--
-- Data for Name: benutzeralspatient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY benutzeralspatient (id, patient_id, patient_name, patient_vorname, passwort, passwortbestatigen) FROM stdin;
1	1	Test	Test	1234	1234
3	2	test2	test2	1234	1234
\.


--
-- Name: ARZT_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "ARZT"
    ADD CONSTRAINT "ARZT_pkey" PRIMARY KEY ("ARZT_ID");


--
-- Name: BenutzeralsPatient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY benutzeralspatient
    ADD CONSTRAINT "BenutzeralsPatient_pkey" PRIMARY KEY (id);


--
-- Name: ERKRANKUNG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "ERKRANKUNG"
    ADD CONSTRAINT "ERKRANKUNG_pkey" PRIMARY KEY ("ERKRANKUNG_ID");


--
-- Name: KRANKENKASSE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "KRANKENKASSE"
    ADD CONSTRAINT "KRANKENKASSE_pkey" PRIMARY KEY ("KÜRZEL");


--
-- Name: PATIENTAKTE_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PATIENTAKTE"
    ADD CONSTRAINT "PATIENTAKTE_pkey" PRIMARY KEY ("AKTE_ID");


--
-- Name: PATIENT_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PATIENT"
    ADD CONSTRAINT "PATIENT_pkey" PRIMARY KEY ("PATIENT_ID");


--
-- Name: PRAXIS_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "PRAXIS"
    ADD CONSTRAINT "PRAXIS_pkey" PRIMARY KEY ("PRAXIS_ID");


--
-- Name: ARZT_PRAXIS_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "ARZT"
    ADD CONSTRAINT "ARZT_PRAXIS_ID_fkey" FOREIGN KEY ("PRAXIS_ID") REFERENCES "PRAXIS"("PRAXIS_ID");


--
-- Name: PATIENTAKTE_ARZT_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PATIENTAKTE"
    ADD CONSTRAINT "PATIENTAKTE_ARZT_ID_fkey" FOREIGN KEY ("ARZT_ID") REFERENCES "ARZT"("ARZT_ID");


--
-- Name: PATIENTAKTE_ERKRANKUNG_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PATIENTAKTE"
    ADD CONSTRAINT "PATIENTAKTE_ERKRANKUNG_ID_fkey" FOREIGN KEY ("ERKRANKUNG_ID") REFERENCES "ERKRANKUNG"("ERKRANKUNG_ID");


--
-- Name: PATIENTAKTE_KRANKENKASSE_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PATIENTAKTE"
    ADD CONSTRAINT "PATIENTAKTE_KRANKENKASSE_ID_fkey" FOREIGN KEY ("KRANKENKASSE_ID") REFERENCES "KRANKENKASSE"("KÜRZEL");


--
-- Name: PATIENTAKTE_PATIENTEN_ID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "PATIENTAKTE"
    ADD CONSTRAINT "PATIENTAKTE_PATIENTEN_ID_fkey" FOREIGN KEY ("PATIENTEN_ID") REFERENCES "PATIENT"("PATIENT_ID");


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

