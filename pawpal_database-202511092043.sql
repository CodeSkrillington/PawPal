--
-- PostgreSQL database dump
--

\restrict cx1fS4tphrf2Ll9vtOLYwYiV38I3SyW7GKdRUYMJTJ2cUKgE8MqajCR8PLkUdHN

-- Dumped from database version 18.0
-- Dumped by pg_dump version 18.0

-- Started on 2025-11-09 20:43:11 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 16390)
-- Name: Pawpal; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "Pawpal";


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 16403)
-- Name: dose_log; Type: TABLE; Schema: Pawpal; Owner: -
--

CREATE TABLE "Pawpal".dose_log (
    log_id integer NOT NULL,
    med_id integer NOT NULL,
    administered_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    notes text
);


--
-- TOC entry 222 (class 1259 OID 16402)
-- Name: dose_log_log_id_seq; Type: SEQUENCE; Schema: Pawpal; Owner: -
--

CREATE SEQUENCE "Pawpal".dose_log_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3863 (class 0 OID 0)
-- Dependencies: 222
-- Name: dose_log_log_id_seq; Type: SEQUENCE OWNED BY; Schema: Pawpal; Owner: -
--

ALTER SEQUENCE "Pawpal".dose_log_log_id_seq OWNED BY "Pawpal".dose_log.log_id;


--
-- TOC entry 225 (class 1259 OID 16415)
-- Name: medications; Type: TABLE; Schema: Pawpal; Owner: -
--

CREATE TABLE "Pawpal".medications (
    med_id integer NOT NULL,
    pet_id integer NOT NULL,
    name text NOT NULL,
    dosage text,
    frequency text,
    start_date date,
    end_date date
);


--
-- TOC entry 224 (class 1259 OID 16414)
-- Name: medications_med_id_seq; Type: SEQUENCE; Schema: Pawpal; Owner: -
--

CREATE SEQUENCE "Pawpal".medications_med_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3864 (class 0 OID 0)
-- Dependencies: 224
-- Name: medications_med_id_seq; Type: SEQUENCE OWNED BY; Schema: Pawpal; Owner: -
--

ALTER SEQUENCE "Pawpal".medications_med_id_seq OWNED BY "Pawpal".medications.med_id;


--
-- TOC entry 221 (class 1259 OID 16392)
-- Name: pets; Type: TABLE; Schema: Pawpal; Owner: -
--

CREATE TABLE "Pawpal".pets (
    pet_id integer NOT NULL,
    name text NOT NULL,
    species text,
    age integer,
    notes text,
    user_id integer
);


--
-- TOC entry 220 (class 1259 OID 16391)
-- Name: pets_pet_id_seq; Type: SEQUENCE; Schema: Pawpal; Owner: -
--

CREATE SEQUENCE "Pawpal".pets_pet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3865 (class 0 OID 0)
-- Dependencies: 220
-- Name: pets_pet_id_seq; Type: SEQUENCE OWNED BY; Schema: Pawpal; Owner: -
--

ALTER SEQUENCE "Pawpal".pets_pet_id_seq OWNED BY "Pawpal".pets.pet_id;


--
-- TOC entry 227 (class 1259 OID 16446)
-- Name: users; Type: TABLE; Schema: Pawpal; Owner: -
--

CREATE TABLE "Pawpal".users (
    user_id integer NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- TOC entry 226 (class 1259 OID 16445)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: Pawpal; Owner: -
--

CREATE SEQUENCE "Pawpal".users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3866 (class 0 OID 0)
-- Dependencies: 226
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: Pawpal; Owner: -
--

ALTER SEQUENCE "Pawpal".users_user_id_seq OWNED BY "Pawpal".users.user_id;


--
-- TOC entry 3687 (class 2604 OID 16406)
-- Name: dose_log log_id; Type: DEFAULT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".dose_log ALTER COLUMN log_id SET DEFAULT nextval('"Pawpal".dose_log_log_id_seq'::regclass);


--
-- TOC entry 3689 (class 2604 OID 16418)
-- Name: medications med_id; Type: DEFAULT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".medications ALTER COLUMN med_id SET DEFAULT nextval('"Pawpal".medications_med_id_seq'::regclass);


--
-- TOC entry 3686 (class 2604 OID 16395)
-- Name: pets pet_id; Type: DEFAULT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".pets ALTER COLUMN pet_id SET DEFAULT nextval('"Pawpal".pets_pet_id_seq'::regclass);


--
-- TOC entry 3690 (class 2604 OID 16449)
-- Name: users user_id; Type: DEFAULT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".users ALTER COLUMN user_id SET DEFAULT nextval('"Pawpal".users_user_id_seq'::regclass);


--
-- TOC entry 3853 (class 0 OID 16403)
-- Dependencies: 223
-- Data for Name: dose_log; Type: TABLE DATA; Schema: Pawpal; Owner: -
--

COPY "Pawpal".dose_log (log_id, med_id, administered_at, notes) FROM stdin;
\.


--
-- TOC entry 3855 (class 0 OID 16415)
-- Dependencies: 225
-- Data for Name: medications; Type: TABLE DATA; Schema: Pawpal; Owner: -
--

COPY "Pawpal".medications (med_id, pet_id, name, dosage, frequency, start_date, end_date) FROM stdin;
\.


--
-- TOC entry 3851 (class 0 OID 16392)
-- Dependencies: 221
-- Data for Name: pets; Type: TABLE DATA; Schema: Pawpal; Owner: -
--

COPY "Pawpal".pets (pet_id, name, species, age, notes, user_id) FROM stdin;
\.


--
-- TOC entry 3857 (class 0 OID 16446)
-- Dependencies: 227
-- Data for Name: users; Type: TABLE DATA; Schema: Pawpal; Owner: -
--

COPY "Pawpal".users (user_id, first_name, last_name, email, password_hash, created_at) FROM stdin;
\.


--
-- TOC entry 3867 (class 0 OID 0)
-- Dependencies: 222
-- Name: dose_log_log_id_seq; Type: SEQUENCE SET; Schema: Pawpal; Owner: -
--

SELECT pg_catalog.setval('"Pawpal".dose_log_log_id_seq', 1, false);


--
-- TOC entry 3868 (class 0 OID 0)
-- Dependencies: 224
-- Name: medications_med_id_seq; Type: SEQUENCE SET; Schema: Pawpal; Owner: -
--

SELECT pg_catalog.setval('"Pawpal".medications_med_id_seq', 1, false);


--
-- TOC entry 3869 (class 0 OID 0)
-- Dependencies: 220
-- Name: pets_pet_id_seq; Type: SEQUENCE SET; Schema: Pawpal; Owner: -
--

SELECT pg_catalog.setval('"Pawpal".pets_pet_id_seq', 1, false);


--
-- TOC entry 3870 (class 0 OID 0)
-- Dependencies: 226
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: Pawpal; Owner: -
--

SELECT pg_catalog.setval('"Pawpal".users_user_id_seq', 1, false);


--
-- TOC entry 3695 (class 2606 OID 16413)
-- Name: dose_log dose_log_pkey; Type: CONSTRAINT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".dose_log
    ADD CONSTRAINT dose_log_pkey PRIMARY KEY (log_id);


--
-- TOC entry 3697 (class 2606 OID 16425)
-- Name: medications medications_pkey; Type: CONSTRAINT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".medications
    ADD CONSTRAINT medications_pkey PRIMARY KEY (med_id);


--
-- TOC entry 3693 (class 2606 OID 16401)
-- Name: pets pets_pkey; Type: CONSTRAINT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".pets
    ADD CONSTRAINT pets_pkey PRIMARY KEY (pet_id);


--
-- TOC entry 3699 (class 2606 OID 16461)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3701 (class 2606 OID 16459)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 3702 (class 2606 OID 16462)
-- Name: pets fk_pets_users; Type: FK CONSTRAINT; Schema: Pawpal; Owner: -
--

ALTER TABLE ONLY "Pawpal".pets
    ADD CONSTRAINT fk_pets_users FOREIGN KEY (user_id) REFERENCES "Pawpal".users(user_id) ON DELETE CASCADE;


-- Completed on 2025-11-09 20:43:12 PST

--
-- PostgreSQL database dump complete
--

\unrestrict cx1fS4tphrf2Ll9vtOLYwYiV38I3SyW7GKdRUYMJTJ2cUKgE8MqajCR8PLkUdHN

