--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.3
-- Dumped by pg_dump version 9.5.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: notifiers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE notifiers (
    id integer NOT NULL,
    application character varying(256),
    event_name character varying(256),
    template text,
    rules json DEFAULT '[]'::json,
    notification_type character varying(20),
    target character varying(256)
);


--
-- Name: notifiers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE notifiers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifiers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE notifiers_id_seq OWNED BY notifiers.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiers ALTER COLUMN id SET DEFAULT nextval('notifiers_id_seq'::regclass);


--
-- Name: notifiers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY notifiers
    ADD CONSTRAINT notifiers_pkey PRIMARY KEY (id);


--
-- Name: index_application_event_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_event_name ON notifiers USING btree (application, event_name);


--
-- PostgreSQL database dump complete
--

