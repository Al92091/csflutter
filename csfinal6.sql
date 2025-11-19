--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.4

-- Started on 2025-11-13 11:29:29

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
-- TOC entry 52 (class 2615 OID 16982)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 1 (class 3079 OID 55288)
-- Name: pg_cron; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_cron WITH SCHEMA pg_catalog;


--
-- TOC entry 5396 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION pg_cron; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_cron IS 'Job scheduler for PostgreSQL';


--
-- TOC entry 13 (class 2615 OID 16983)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 22 (class 2615 OID 16984)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 21 (class 2615 OID 16985)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 3 (class 3079 OID 55339)
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- TOC entry 5399 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- TOC entry 15 (class 2615 OID 16986)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 16 (class 2615 OID 16987)
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- TOC entry 8 (class 3079 OID 16988)
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- TOC entry 5401 (class 0 OID 0)
-- Dependencies: 8
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- TOC entry 18 (class 2615 OID 17289)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 53 (class 2615 OID 17290)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 19 (class 2615 OID 28192)
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- TOC entry 20 (class 2615 OID 17291)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 10 (class 3079 OID 18204)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 5406 (class 0 OID 0)
-- Dependencies: 10
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 7 (class 3079 OID 17302)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 5407 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 6 (class 3079 OID 17333)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 5408 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 17370)
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- TOC entry 5409 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- TOC entry 9 (class 3079 OID 17377)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 5410 (class 0 OID 0)
-- Dependencies: 9
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 4 (class 3079 OID 17400)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 5411 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1397 (class 1247 OID 17412)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1400 (class 1247 OID 17420)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1403 (class 1247 OID 17426)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1406 (class 1247 OID 17432)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1703 (class 1247 OID 72524)
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


ALTER TYPE auth.oauth_authorization_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1715 (class 1247 OID 72597)
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


ALTER TYPE auth.oauth_client_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1553 (class 1247 OID 27066)
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


ALTER TYPE auth.oauth_registration_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1706 (class 1247 OID 72534)
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


ALTER TYPE auth.oauth_response_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1409 (class 1247 OID 17440)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1541 (class 1247 OID 64289)
-- Name: account_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.account_status AS ENUM (
    'confirmé',
    'non-confirmé'
);


ALTER TYPE public.account_status OWNER TO postgres;

--
-- TOC entry 1601 (class 1247 OID 86007)
-- Name: customer_penalty_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.customer_penalty_type AS ENUM (
    'manual',
    'late_payment',
    'cancellation',
    'damage',
    'other'
);


ALTER TYPE public.customer_penalty_type OWNER TO postgres;

--
-- TOC entry 1412 (class 1247 OID 17454)
-- Name: driver_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.driver_status AS ENUM (
    'inactive',
    'active_beginner',
    'active_intermediate',
    'active_expert',
    'active_elite',
    'blocked',
    'pending_validation',
    'pending_confirmation',
    'pending_validation_webinar',
    'inactive_mbc',
    'inactive_denied',
    'inactive_woman',
    'pending_validation_woman'
);


ALTER TYPE public.driver_status OWNER TO postgres;

--
-- TOC entry 1415 (class 1247 OID 17474)
-- Name: fuel_management_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.fuel_management_type AS ENUM (
    'pas_de_remise',
    'remise_niveau',
    'plein'
);


ALTER TYPE public.fuel_management_type OWNER TO postgres;

--
-- TOC entry 1670 (class 1247 OID 66716)
-- Name: group_order_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.group_order_status AS ENUM (
    'draft',
    'en_attente',
    'recherche_driver',
    'en_cours',
    'terminee',
    'annulee'
);


ALTER TYPE public.group_order_status OWNER TO postgres;

--
-- TOC entry 1667 (class 1247 OID 66707)
-- Name: group_order_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.group_order_type AS ENUM (
    'same_vehicles_same_dest',
    'different_vehicles_same_dest',
    'same_vehicles_different_dest',
    'different_vehicles_different_dest'
);


ALTER TYPE public.group_order_type OWNER TO postgres;

--
-- TOC entry 1679 (class 1247 OID 67924)
-- Name: inspection_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.inspection_type AS ENUM (
    'departure',
    'arrival'
);


ALTER TYPE public.inspection_type OWNER TO postgres;

--
-- TOC entry 1544 (class 1247 OID 64296)
-- Name: invoice_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.invoice_status AS ENUM (
    'draft',
    'pending',
    'sent',
    'paid',
    'overdue',
    'cancelled'
);


ALTER TYPE public.invoice_status OWNER TO postgres;

--
-- TOC entry 1418 (class 1247 OID 17482)
-- Name: location_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.location_type AS ENUM (
    'rdv_particulier',
    'agence_concession',
    'parc_auto',
    'societe'
);


ALTER TYPE public.location_type OWNER TO postgres;

--
-- TOC entry 1421 (class 1247 OID 17492)
-- Name: mission_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.mission_status AS ENUM (
    'en_attente',
    'recherche_driver',
    'acceptee',
    'en_cours',
    'terminee',
    'annulee',
    'clotureeclient',
    'expiree'
);


ALTER TYPE public.mission_status OWNER TO postgres;

--
-- TOC entry 1424 (class 1247 OID 17506)
-- Name: mission_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.mission_type AS ENUM (
    'transfert',
    'livraison',
    'livraison_reprise',
    'restitution'
);


ALTER TYPE public.mission_type OWNER TO postgres;

--
-- TOC entry 1593 (class 1247 OID 30472)
-- Name: missionstatusdriver; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.missionstatusdriver AS ENUM (
    'mission_acceptee',
    'en_coursdriver',
    'termineedriver',
    'clotureedriver',
    'clotureeplateforme',
    'decloturee'
);


ALTER TYPE public.missionstatusdriver OWNER TO postgres;

--
-- TOC entry 1547 (class 1247 OID 64310)
-- Name: payment_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status AS ENUM (
    'pending',
    'paid',
    'deferred',
    'invoiced',
    'failed'
);


ALTER TYPE public.payment_status OWNER TO postgres;

--
-- TOC entry 1697 (class 1247 OID 70256)
-- Name: penalty_source; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.penalty_source AS ENUM (
    'automatic',
    'manual'
);


ALTER TYPE public.penalty_source OWNER TO postgres;

--
-- TOC entry 1694 (class 1247 OID 70246)
-- Name: penalty_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.penalty_type AS ENUM (
    'more_than_72h',
    'between_24h_72h',
    'less_than_24h',
    'manual'
);


ALTER TYPE public.penalty_type OWNER TO postgres;

--
-- TOC entry 1682 (class 1247 OID 67930)
-- Name: photo_category; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.photo_category AS ENUM (
    'exterior',
    'interior',
    'wheels',
    'accessories',
    'damages'
);


ALTER TYPE public.photo_category OWNER TO postgres;

--
-- TOC entry 1427 (class 1247 OID 17516)
-- Name: transmission_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.transmission_type AS ENUM (
    'manuelle',
    'automatique'
);


ALTER TYPE public.transmission_type OWNER TO postgres;

--
-- TOC entry 1430 (class 1247 OID 17522)
-- Name: transport_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.transport_type AS ENUM (
    'convoyeur',
    'plateau'
);


ALTER TYPE public.transport_type OWNER TO postgres;

--
-- TOC entry 1433 (class 1247 OID 17528)
-- Name: user_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_type AS ENUM (
    'customer_individual',
    'customer_business',
    'driver',
    'employee',
    'admin'
);


ALTER TYPE public.user_type OWNER TO postgres;

--
-- TOC entry 1436 (class 1247 OID 17540)
-- Name: vehicle_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.vehicle_type AS ENUM (
    'citadine',
    'berline',
    'sportive',
    'monospace',
    'suv',
    'utilitaire3',
    'utilitaire6',
    'utilitaire9',
    'utilitaire12',
    'utilitaire15',
    'utilitaire20',
    'utilitaire25',
    'utilitaire30'
);


ALTER TYPE public.vehicle_type OWNER TO postgres;

--
-- TOC entry 1439 (class 1247 OID 17568)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1442 (class 1247 OID 17580)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1445 (class 1247 OID 17597)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1448 (class 1247 OID 17600)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1451 (class 1247 OID 17603)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 1566 (class 1247 OID 28244)
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS'
);


ALTER TYPE storage.buckettype OWNER TO supabase_storage_admin;

--
-- TOC entry 638 (class 1255 OID 17604)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 5412 (class 0 OID 0)
-- Dependencies: 638
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 647 (class 1255 OID 17605)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 637 (class 1255 OID 17606)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 5415 (class 0 OID 0)
-- Dependencies: 637
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 639 (class 1255 OID 17607)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 5417 (class 0 OID 0)
-- Dependencies: 639
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 684 (class 1255 OID 17608)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- TOC entry 5441 (class 0 OID 0)
-- Dependencies: 684
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 651 (class 1255 OID 17609)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 5443 (class 0 OID 0)
-- Dependencies: 651
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 722 (class 1255 OID 17610)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- TOC entry 5445 (class 0 OID 0)
-- Dependencies: 722
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 718 (class 1255 OID 17611)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 650 (class 1255 OID 17612)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 708 (class 1255 OID 17613)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 5474 (class 0 OID 0)
-- Dependencies: 708
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 649 (class 1255 OID 17614)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 458 (class 1255 OID 70301)
-- Name: calculate_driver_penalty(uuid, uuid, timestamp with time zone, timestamp with time zone); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_driver_penalty(p_mission_id uuid, p_driver_id uuid, p_cancellation_datetime timestamp with time zone, p_pickup_datetime timestamp with time zone) RETURNS numeric
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_hours_before numeric;
  v_penalty_amount numeric;
  v_penalty_type penalty_type;
  v_config RECORD;
BEGIN
  SELECT * INTO v_config FROM driver_penalty_config WHERE id = 1;
  
  v_hours_before := EXTRACT(EPOCH FROM (p_pickup_datetime - p_cancellation_datetime)) / 3600;
  
  IF v_hours_before > 72 THEN
    v_penalty_type := 'more_than_72h';
    v_penalty_amount := v_config.penalty_more_than_72h;
  ELSIF v_hours_before >= 24 THEN
    v_penalty_type := 'between_24h_72h';
    v_penalty_amount := v_config.penalty_between_24h_72h;
  ELSE
    v_penalty_type := 'less_than_24h';
    v_penalty_amount := v_config.penalty_less_than_24h;
  END IF;
  
  INSERT INTO driver_penalties (
    driver_id,
    mission_id,
    penalty_amount,
    penalty_type,
    penalty_source,
    cancellation_datetime,
    pickup_datetime,
    hours_before_pickup,
    reason
  ) VALUES (
    p_driver_id,
    p_mission_id,
    v_penalty_amount,
    v_penalty_type,
    'automatic',
    p_cancellation_datetime,
    p_pickup_datetime,
    v_hours_before,
    'Annulation automatique de mission'
  );
  
  RAISE NOTICE 'Pénalité automatique appliquée: Driver %, Mission %, Montant: %€, Type: %, Heures avant: %h',
    p_driver_id, p_mission_id, v_penalty_amount, v_penalty_type, v_hours_before;
  
  RETURN v_penalty_amount;
END;
$$;


ALTER FUNCTION public.calculate_driver_penalty(p_mission_id uuid, p_driver_id uuid, p_cancellation_datetime timestamp with time zone, p_pickup_datetime timestamp with time zone) OWNER TO postgres;

--
-- TOC entry 523 (class 1255 OID 54171)
-- Name: calculate_driver_seniority(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_driver_seniority(driver_uuid uuid) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    first_completed_date DATE;
    days_difference INTEGER;
BEGIN
    -- Find the earliest mission that was completed (clotureeplateforme)
    SELECT DATE(updated_at) INTO first_completed_date
    FROM missions 
    WHERE driver_id = driver_uuid 
    AND missionstatusdriver = 'clotureeplateforme'
    ORDER BY updated_at ASC
    LIMIT 1;
    
    -- If no completed mission found, seniority is 0
    IF first_completed_date IS NULL THEN
        RETURN 0;
    END IF;
    
    -- Calculate days difference: date - date returns integer in PostgreSQL
    -- CRITICAL: Do NOT use EXTRACT(DAY FROM ...) as it only extracts the day component
    days_difference := (CURRENT_DATE - first_completed_date);
    
    -- Ensure minimum is 0
    RETURN GREATEST(days_difference, 0);
END;
$$;


ALTER FUNCTION public.calculate_driver_seniority(driver_uuid uuid) OWNER TO postgres;

--
-- TOC entry 453 (class 1255 OID 52977)
-- Name: calculate_monthly_coefficients(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.calculate_monthly_coefficients(p_month integer DEFAULT NULL::integer, p_year integer DEFAULT NULL::integer) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
    target_month INTEGER;
    target_year INTEGER;
    prev_month INTEGER;
    prev_year INTEGER;
    customer_record RECORD;
    missions_count INTEGER;
    new_coefficient NUMERIC;
BEGIN
    -- Définir le mois et l'année cible (mois actuel par défaut)
    target_month := COALESCE(p_month, EXTRACT(MONTH FROM CURRENT_DATE)::INTEGER);
    target_year := COALESCE(p_year, EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER);
    
    -- Calculer le mois précédent
    IF target_month = 1 THEN
        prev_month := 12;
        prev_year := target_year - 1;
    ELSE
        prev_month := target_month - 1;
        prev_year := target_year;
    END IF;
    
    -- Parcourir tous les customer_business
    FOR customer_record IN 
        SELECT id FROM profiles WHERE user_type = 'customer_business'
    LOOP
        -- Compter les missions "clotureeclient" du mois précédent
        SELECT COUNT(*) INTO missions_count
        FROM missions
        WHERE customer_id = customer_record.id
        AND status = 'clotureeclient'
        AND EXTRACT(MONTH FROM updated_at) = prev_month
        AND EXTRACT(YEAR FROM updated_at) = prev_year;
        
        -- Déterminer le coefficient selon les règles
        SELECT coefficient_value INTO new_coefficient
        FROM coefficient_config
        WHERE missions_count >= min_missions
        AND (max_missions IS NULL OR missions_count <= max_missions)
        ORDER BY min_missions DESC
        LIMIT 1;
        
        -- Si aucune configuration trouvée, utiliser 1.0
        new_coefficient := COALESCE(new_coefficient, 1.0);
        
        -- Insérer ou mettre à jour le coefficient
        INSERT INTO customer_coefficients (customer_id, month, year, coefficient_value, missions_count)
        VALUES (customer_record.id, target_month, target_year, new_coefficient, missions_count)
        ON CONFLICT (customer_id, month, year)
        DO UPDATE SET
            coefficient_value = EXCLUDED.coefficient_value,
            missions_count = EXCLUDED.missions_count,
            updated_at = timezone('utc'::text, now());
    END LOOP;
END;
$$;


ALTER FUNCTION public.calculate_monthly_coefficients(p_month integer, p_year integer) OWNER TO postgres;

--
-- TOC entry 388 (class 1255 OID 66702)
-- Name: check_leader_confirmed(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_leader_confirmed() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = NEW.leader_account_id
    AND user_type = 'customer_business'
    AND account_status = 'confirmé'
  ) THEN
    RAISE EXCEPTION 'Leader account must be a confirmed business customer';
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_leader_confirmed() OWNER TO postgres;

--
-- TOC entry 392 (class 1255 OID 66704)
-- Name: check_single_group_membership(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_single_group_membership() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF NEW.business_group_id IS NOT NULL THEN
    IF EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = NEW.id
      AND business_group_id IS NOT NULL
      AND business_group_id != NEW.business_group_id
    ) THEN
      RAISE EXCEPTION 'A member can only belong to one business group';
    END IF;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.check_single_group_membership() OWNER TO postgres;

--
-- TOC entry 474 (class 1255 OID 86061)
-- Name: create_customer_penalty_invoice(uuid, numeric, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_customer_penalty_invoice(p_customer_id uuid, p_penalty_amount numeric, p_mission_id uuid DEFAULT NULL::uuid) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_invoice_id uuid;
  v_user_type user_type;
  v_account_status account_status;
  v_mission_number text;
  v_amount_ht numeric;
  v_amount_tva numeric;
  v_amount_ttc numeric;
BEGIN
  -- Get customer profile info
  SELECT user_type, account_status INTO v_user_type, v_account_status
  FROM profiles
  WHERE id = p_customer_id;
  
  -- Get mission number if mission_id provided
  IF p_mission_id IS NOT NULL THEN
    SELECT mission_number INTO v_mission_number
    FROM missions
    WHERE id = p_mission_id;
  END IF;
  
  -- Calculate amounts
  v_amount_ht := p_penalty_amount;
  v_amount_tva := p_penalty_amount * 0.20;
  v_amount_ttc := p_penalty_amount * 1.20;
  
  -- Check if customer_business with confirmed status
  IF v_user_type = 'customer_business' AND v_account_status = 'confirmé' THEN
    -- Find current draft/pending monthly invoice
    SELECT id INTO v_invoice_id
    FROM business_invoices
    WHERE customer_id = p_customer_id
    AND status IN ('draft', 'pending')
    ORDER BY created_at DESC
    LIMIT 1;
    
    IF v_invoice_id IS NOT NULL THEN
      -- Add penalty to existing invoice
      UPDATE business_invoices
      SET 
        amount_ht = amount_ht + v_amount_ht,
        amount_tva = amount_tva + v_amount_tva,
        amount_ttc = amount_ttc + v_amount_ttc,
        updated_at = timezone('utc'::text, now())
      WHERE id = v_invoice_id;
    ELSE
      RAISE NOTICE 'No draft invoice found for customer %, penalty will be added to next monthly invoice', p_customer_id;
    END IF;
    
    RETURN v_invoice_id;
  ELSE
    -- Create immediate penalty invoice
    INSERT INTO business_invoices (
      customer_id,
      invoice_number,
      status,
      amount_ht,
      amount_tva,
      amount_ttc,
      period_start,
      period_end,
      issued_at,
      due_date,
      missions_count,
      applied_coefficient
    ) VALUES (
      p_customer_id,
      CASE 
        WHEN v_mission_number IS NOT NULL THEN 
          'PEN-' || v_mission_number || '-' || to_char(CURRENT_TIMESTAMP, 'YYMMDD') || '-' || lpad(nextval('business_invoice_number_seq')::text, 6, '0')
        ELSE
          'PEN-' || to_char(CURRENT_TIMESTAMP, 'YYMMDD') || '-' || lpad(nextval('business_invoice_number_seq')::text, 6, '0')
      END,
      'issued',
      v_amount_ht,
      v_amount_tva,
      v_amount_ttc,
      CURRENT_DATE,
      CURRENT_DATE,
      timezone('utc'::text, now()),
      CURRENT_DATE + INTERVAL '7 days',
      0,
      1.0
    )
    RETURNING id INTO v_invoice_id;
    
    RETURN v_invoice_id;
  END IF;
END;
$$;


ALTER FUNCTION public.create_customer_penalty_invoice(p_customer_id uuid, p_penalty_amount numeric, p_mission_id uuid) OWNER TO postgres;

--
-- TOC entry 475 (class 1255 OID 86062)
-- Name: create_manual_customer_penalty(uuid, numeric, public.customer_penalty_type, text, uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_manual_customer_penalty(p_customer_id uuid, p_penalty_amount numeric, p_penalty_type public.customer_penalty_type, p_reason text, p_mission_id uuid DEFAULT NULL::uuid) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_penalty_id uuid;
  v_invoice_id uuid;
BEGIN
  -- Check if user is admin or employee
  IF NOT (is_admin() OR is_employee()) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  
  IF p_penalty_amount <= 0 THEN
    RAISE EXCEPTION 'Penalty amount must be positive';
  END IF;
  
  -- Create the penalty invoice
  v_invoice_id := create_customer_penalty_invoice(
    p_customer_id,
    p_penalty_amount,
    p_mission_id
  );
  
  -- Insert penalty record
  INSERT INTO customer_penalties (
    customer_id,
    mission_id,
    penalty_amount,
    penalty_type,
    penalty_source,
    reason,
    created_by,
    business_invoice_id,
    penalty_invoice_id
  ) VALUES (
    p_customer_id,
    p_mission_id,
    p_penalty_amount,
    p_penalty_type,
    'manual',
    p_reason,
    auth.uid(),
    CASE WHEN EXISTS (
      SELECT 1 FROM profiles 
      WHERE id = p_customer_id 
      AND user_type = 'customer_business' 
      AND account_status = 'confirmé'
    ) THEN v_invoice_id ELSE NULL END,
    CASE WHEN NOT EXISTS (
      SELECT 1 FROM profiles 
      WHERE id = p_customer_id 
      AND user_type = 'customer_business' 
      AND account_status = 'confirmé'
    ) THEN v_invoice_id ELSE NULL END
  )
  RETURNING id INTO v_penalty_id;
  
  RETURN v_penalty_id;
END;
$$;


ALTER FUNCTION public.create_manual_customer_penalty(p_customer_id uuid, p_penalty_amount numeric, p_penalty_type public.customer_penalty_type, p_reason text, p_mission_id uuid) OWNER TO postgres;

--
-- TOC entry 665 (class 1255 OID 92785)
-- Name: create_manual_driver_allowance(uuid, numeric, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_manual_driver_allowance(p_driver_id uuid, p_allowance_amount numeric, p_allowance_type text, p_reason text DEFAULT NULL::text) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
  v_allowance_id uuid;
BEGIN
  INSERT INTO driver_allowances (
    driver_id,
    allowance_amount,
    allowance_type,
    allowance_source,
    reason,
    created_by
  ) VALUES (
    p_driver_id,
    p_allowance_amount,
    p_allowance_type,
    'manual',
    p_reason,
    auth.uid()
  ) RETURNING id INTO v_allowance_id;
  
  RETURN v_allowance_id;
END;
$$;


ALTER FUNCTION public.create_manual_driver_allowance(p_driver_id uuid, p_allowance_amount numeric, p_allowance_type text, p_reason text) OWNER TO postgres;

--
-- TOC entry 465 (class 1255 OID 70307)
-- Name: create_manual_driver_penalty(uuid, numeric, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_manual_driver_penalty(p_driver_id uuid, p_penalty_amount numeric, p_reason text) RETURNS uuid
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_penalty_id uuid;
BEGIN
  IF NOT (is_admin() OR is_employee()) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  
  IF p_penalty_amount <= 0 THEN
    RAISE EXCEPTION 'Penalty amount must be positive';
  END IF;
  
  INSERT INTO driver_penalties (
    driver_id,
    penalty_amount,
    penalty_type,
    penalty_source,
    reason,
    created_by
  ) VALUES (
    p_driver_id,
    p_penalty_amount,
    'manual',
    'manual',
    p_reason,
    auth.uid()
  )
  RETURNING id INTO v_penalty_id;
  
  RETURN v_penalty_id;
END;
$$;


ALTER FUNCTION public.create_manual_driver_penalty(p_driver_id uuid, p_penalty_amount numeric, p_reason text) OWNER TO postgres;

--
-- TOC entry 477 (class 1255 OID 86064)
-- Name: delete_customer_penalty(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_customer_penalty(p_penalty_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  IF NOT (is_admin() OR is_employee()) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  
  DELETE FROM customer_penalties
  WHERE id = p_penalty_id;
END;
$$;


ALTER FUNCTION public.delete_customer_penalty(p_penalty_id uuid) OWNER TO postgres;

--
-- TOC entry 521 (class 1255 OID 92787)
-- Name: delete_driver_allowance(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_driver_allowance(p_allowance_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Delete associated documents first
  DELETE FROM penalty_allowance_documents
  WHERE reference_type = 'allowance' AND reference_id = p_allowance_id;
  
  -- Delete the allowance
  DELETE FROM driver_allowances WHERE id = p_allowance_id;
END;
$$;


ALTER FUNCTION public.delete_driver_allowance(p_allowance_id uuid) OWNER TO postgres;

--
-- TOC entry 467 (class 1255 OID 70309)
-- Name: delete_driver_penalty(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.delete_driver_penalty(p_penalty_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  IF NOT (is_admin() OR is_employee()) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  
  DELETE FROM driver_penalties
  WHERE id = p_penalty_id;
END;
$$;


ALTER FUNCTION public.delete_driver_penalty(p_penalty_id uuid) OWNER TO postgres;

--
-- TOC entry 468 (class 1255 OID 84896)
-- Name: driver_can_view_customer(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.driver_can_view_customer(customer_id uuid) RETURNS boolean
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  -- Vérifier s'il existe une mission où le chauffeur peut voir ce client
  RETURN EXISTS (
    SELECT 1 
    FROM missions m
    WHERE m.customer_id = driver_can_view_customer.customer_id
      AND (
        -- Mission disponible pour tous les chauffeurs actifs
        m.status = 'recherche_driver'
        -- OU mission assignée au chauffeur connecté
        OR m.driver_id = auth.uid()
      )
  );
END;
$$;


ALTER FUNCTION public.driver_can_view_customer(customer_id uuid) OWNER TO postgres;

--
-- TOC entry 5508 (class 0 OID 0)
-- Dependencies: 468
-- Name: FUNCTION driver_can_view_customer(customer_id uuid); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.driver_can_view_customer(customer_id uuid) IS 'Vérifie si un chauffeur peut voir le profil d''un client en fonction des missions. Utilise SECURITY DEFINER pour bypasser RLS et éviter la récursion.';


--
-- TOC entry 452 (class 1255 OID 52976)
-- Name: get_customer_coefficient(uuid, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_customer_coefficient(p_customer_id uuid, p_month integer DEFAULT NULL::integer, p_year integer DEFAULT NULL::integer) RETURNS numeric
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
    target_month INTEGER;
    target_year INTEGER;
    coefficient_val NUMERIC;
    user_type_val user_type;
BEGIN
    -- Définir le mois et l'année cible (mois actuel par défaut)
    target_month := COALESCE(p_month, EXTRACT(MONTH FROM CURRENT_DATE)::INTEGER);
    target_year := COALESCE(p_year, EXTRACT(YEAR FROM CURRENT_DATE)::INTEGER);
    
    -- Vérifier le type d'utilisateur
    SELECT user_type INTO user_type_val 
    FROM profiles 
    WHERE id = p_customer_id;
    
    -- Si c'est un customer_individual, retourner 1.0
    IF user_type_val = 'customer_individual' THEN
        RETURN 1.0;
    END IF;
    
    -- Si ce n'est pas un customer_business, retourner 1.0
    IF user_type_val != 'customer_business' THEN
        RETURN 1.0;
    END IF;
    
    -- Chercher le coefficient pour le mois donné
    SELECT coefficient_value INTO coefficient_val
    FROM customer_coefficients
    WHERE customer_id = p_customer_id 
    AND month = target_month 
    AND year = target_year;
    
    -- Si pas trouvé, retourner 1.0 (coefficient par défaut)
    RETURN COALESCE(coefficient_val, 1.0);
END;
$$;


ALTER FUNCTION public.get_customer_coefficient(p_customer_id uuid, p_month integer, p_year integer) OWNER TO postgres;

--
-- TOC entry 415 (class 1255 OID 64399)
-- Name: get_invoice_coefficient(uuid, date, date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_invoice_coefficient(p_customer_id uuid, p_period_start date, p_period_end date) RETURNS numeric
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
    missions_count INTEGER;
    coefficient_val NUMERIC;
BEGIN
    -- Compter les missions clotureeclient de la période
    SELECT COUNT(*) INTO missions_count
    FROM missions
    WHERE customer_id = p_customer_id
    AND status = 'clotureeclient'
    AND updated_at >= p_period_start
    AND updated_at <= p_period_end;
    
    -- Récupérer le coefficient selon la configuration
    SELECT coefficient_value INTO coefficient_val
    FROM coefficient_config
    WHERE missions_count >= min_missions
    AND (max_missions IS NULL OR missions_count <= max_missions)
    ORDER BY min_missions DESC
    LIMIT 1;
    
    RETURN COALESCE(coefficient_val, 1.0);
END;
$$;


ALTER FUNCTION public.get_invoice_coefficient(p_customer_id uuid, p_period_start date, p_period_end date) OWNER TO postgres;

--
-- TOC entry 435 (class 1255 OID 33807)
-- Name: get_mission_customer_info(uuid[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_mission_customer_info(mission_ids uuid[]) RETURNS TABLE(mission_id uuid, customer_user_type text, customer_company_name text, customer_company_logo_url text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  -- Only allow active drivers to call this function
  IF NOT EXISTS (
    SELECT 1 FROM profiles 
    WHERE id = auth.uid() 
      AND user_type = 'driver'
      AND driver_status IN ('active_beginner', 'active_intermediate', 'active_expert', 'active_elite')
  ) THEN
    RAISE EXCEPTION 'Access denied: Only active drivers can access this function';
  END IF;

  -- Return customer info only for missions that are in recherche_driver status
  RETURN QUERY
  SELECT 
    m.id as mission_id,
    (p.user_type)::text as customer_user_type,
    (p.company_name)::text as customer_company_name,
    (p.company_logo_url)::text as customer_company_logo_url
  FROM missions m
  INNER JOIN profiles p ON m.customer_id = p.id
  WHERE m.id = ANY(mission_ids)
    AND m.status = 'recherche_driver';
END;
$$;


ALTER FUNCTION public.get_mission_customer_info(mission_ids uuid[]) OWNER TO postgres;

--
-- TOC entry 656 (class 1255 OID 17615)
-- Name: get_stripe_publishable_key(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_stripe_publishable_key() RETURNS text
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
begin
  return current_setting('app.settings.vite_stripe_publishable_key');
end;
$$;


ALTER FUNCTION public.get_stripe_publishable_key() OWNER TO postgres;

--
-- TOC entry 648 (class 1255 OID 17616)
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
    INSERT INTO public.profiles (
        id,
        first_name,
        last_name,
        email,
        user_type,
        driver_status,
        company_name,
        position,
        phone,
        address,
        postal_code,
        city,
        frequency
    )
    VALUES (
        NEW.id,
        NEW.raw_user_meta_data->>'firstName',
        NEW.raw_user_meta_data->>'lastName',
        NEW.email,
        (NEW.raw_user_meta_data->>'userType')::user_type,
        CASE 
            WHEN (NEW.raw_user_meta_data->>'userType')::user_type = 'driver' THEN 'inactive'::driver_status
            ELSE NULL
        END,
        NEW.raw_user_meta_data->>'companyName',
        NEW.raw_user_meta_data->>'position',
        NEW.raw_user_meta_data->>'phone',
        NEW.raw_user_meta_data->>'address',
        NEW.raw_user_meta_data->>'postalCode',
        NEW.raw_user_meta_data->>'city',
        NEW.raw_user_meta_data->>'frequency'
    );
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- TOC entry 378 (class 1255 OID 48275)
-- Name: is_admin(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_admin() RETURNS boolean
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE id = auth.uid() AND user_type = 'admin'
  );
END;
$$;


ALTER FUNCTION public.is_admin() OWNER TO postgres;

--
-- TOC entry 383 (class 1255 OID 48276)
-- Name: is_employee(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.is_employee() RETURNS boolean
    LANGUAGE plpgsql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM public.profiles 
    WHERE id = auth.uid() AND user_type = 'employee'
  );
END;
$$;


ALTER FUNCTION public.is_employee() OWNER TO postgres;

--
-- TOC entry 500 (class 1255 OID 54166)
-- Name: recalculate_all_driver_mission_counts(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.recalculate_all_driver_mission_counts() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    driver_record RECORD;
BEGIN
    FOR driver_record IN 
        SELECT id FROM profiles WHERE user_type = 'driver'
    LOOP
        PERFORM update_driver_mission_counts(driver_record.id);
    END LOOP;
END;
$$;


ALTER FUNCTION public.recalculate_all_driver_mission_counts() OWNER TO postgres;

--
-- TOC entry 449 (class 1255 OID 84894)
-- Name: sync_all_members_logo_on_group_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sync_all_members_logo_on_group_update() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  -- Si le logo du groupe a changé
  IF NEW.company_logo_url IS DISTINCT FROM OLD.company_logo_url THEN
    -- Mettre à jour tous les profils des membres du groupe
    UPDATE profiles
    SET company_logo_url = NEW.company_logo_url
    WHERE business_group_id = NEW.id
      AND user_type = 'customer_business';
    
    RAISE NOTICE 'Logo synchronisé pour tous les membres du groupe %', NEW.id;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.sync_all_members_logo_on_group_update() OWNER TO postgres;

--
-- TOC entry 427 (class 1255 OID 84892)
-- Name: sync_profile_logo_on_group_join(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.sync_profile_logo_on_group_join() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  group_logo_url text;
BEGIN
  -- Si un business_group_id est ajouté et que l'utilisateur est customer_business
  IF NEW.business_group_id IS NOT NULL 
     AND NEW.user_type = 'customer_business'
     AND (OLD.business_group_id IS NULL OR OLD.business_group_id != NEW.business_group_id)
  THEN
    -- Récupérer le logo du groupe
    SELECT company_logo_url INTO group_logo_url
    FROM business_groups
    WHERE id = NEW.business_group_id;
    
    -- Mettre à jour le logo du profil avec celui du groupe
    IF group_logo_url IS NOT NULL THEN
      NEW.company_logo_url := group_logo_url;
    END IF;
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.sync_profile_logo_on_group_join() OWNER TO postgres;

--
-- TOC entry 655 (class 1255 OID 17617)
-- Name: toggle_driver_block(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toggle_driver_block(driver_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur appelant est admin ou employee
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type IN ('admin', 'employee')
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Bloquer ou débloquer le convoyeur
    UPDATE profiles
    SET driver_status = 
        CASE 
            WHEN driver_status = 'blocked' THEN 'active'
            ELSE 'blocked'
        END
    WHERE id = driver_id
    AND user_type = 'driver';
END;
$$;


ALTER FUNCTION public.toggle_driver_block(driver_id uuid) OWNER TO postgres;

--
-- TOC entry 652 (class 1255 OID 17618)
-- Name: toggle_plateau(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toggle_plateau(driver_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur appelant est admin ou employee
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type IN ('admin', 'employee')
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Activer/désactiver le statut Plateau
    UPDATE profiles
    SET plateau = NOT plateau
    WHERE id = driver_id
    AND user_type = 'driver'
    AND driver_status = 'active';
END;
$$;


ALTER FUNCTION public.toggle_plateau(driver_id uuid) OWNER TO postgres;

--
-- TOC entry 653 (class 1255 OID 17619)
-- Name: toggle_w_garage(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.toggle_w_garage(driver_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur appelant est admin ou employee
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type IN ('admin', 'employee')
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Activer/désactiver le statut W-Garage
    UPDATE profiles
    SET w_garage = NOT w_garage
    WHERE id = driver_id
    AND user_type = 'driver'
    AND driver_status = 'active';
END;
$$;


ALTER FUNCTION public.toggle_w_garage(driver_id uuid) OWNER TO postgres;

--
-- TOC entry 461 (class 1255 OID 70302)
-- Name: trigger_driver_penalty_on_cancellation(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_driver_penalty_on_cancellation() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF OLD.driver_id IS NOT NULL 
     AND NEW.driver_id IS NULL
     AND OLD.status = 'acceptee'
     AND NEW.status = 'recherche_driver'
     AND OLD.missionstatusdriver = 'mission_acceptee'
     AND NEW.missionstatusdriver IS NULL
     AND OLD.pickup_datetime IS NOT NULL
  THEN
    PERFORM calculate_driver_penalty(
      OLD.id,
      OLD.driver_id,
      NOW(),
      OLD.pickup_datetime
    );
  END IF;
  
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_driver_penalty_on_cancellation() OWNER TO postgres;

--
-- TOC entry 519 (class 1255 OID 54167)
-- Name: trigger_update_driver_mission_counts(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.trigger_update_driver_mission_counts() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- If missionstatusdriver changed to clotureeplateforme or handover/management options changed
    IF (OLD.missionstatusdriver IS DISTINCT FROM NEW.missionstatusdriver AND NEW.missionstatusdriver = 'clotureeplateforme')
       OR (OLD.basic_handover IS DISTINCT FROM NEW.basic_handover)
       OR (OLD.comfort_handover IS DISTINCT FROM NEW.comfort_handover)
       OR (OLD.document_management IS DISTINCT FROM NEW.document_management) THEN
        
        -- Update counts and seniority for the driver if assigned
        IF NEW.driver_id IS NOT NULL THEN
            PERFORM update_driver_mission_counts(NEW.driver_id);
            PERFORM update_driver_seniority(NEW.driver_id);
        END IF;
        
        -- Also update for old driver if it changed
        IF OLD.driver_id IS NOT NULL AND OLD.driver_id IS DISTINCT FROM NEW.driver_id THEN
            PERFORM update_driver_mission_counts(OLD.driver_id);
            PERFORM update_driver_seniority(OLD.driver_id);
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_update_driver_mission_counts() OWNER TO postgres;

--
-- TOC entry 518 (class 1255 OID 54173)
-- Name: update_all_drivers_seniority(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_all_drivers_seniority() RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    driver_record RECORD;
BEGIN
    FOR driver_record IN 
        SELECT id FROM profiles WHERE user_type = 'driver'
    LOOP
        PERFORM update_driver_seniority(driver_record.id);
    END LOOP;
END;
$$;


ALTER FUNCTION public.update_all_drivers_seniority() OWNER TO postgres;

--
-- TOC entry 385 (class 1255 OID 54126)
-- Name: update_billing_periods_config(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_billing_periods_config(p_period_type text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if user is admin
    IF NOT is_admin() THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Update billing periods config
    UPDATE billing_periods_config
    SET 
        period_type = p_period_type,
        updated_at = timezone('utc'::text, now())
    WHERE id = 1;
END;
$$;


ALTER FUNCTION public.update_billing_periods_config(p_period_type text) OWNER TO postgres;

--
-- TOC entry 382 (class 1255 OID 66698)
-- Name: update_business_groups_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_business_groups_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_business_groups_updated_at() OWNER TO postgres;

--
-- TOC entry 387 (class 1255 OID 66700)
-- Name: update_business_invitations_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_business_invitations_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = timezone('utc'::text, now());
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_business_invitations_updated_at() OWNER TO postgres;

--
-- TOC entry 381 (class 1255 OID 64388)
-- Name: update_business_invoices_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_business_invoices_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_business_invoices_updated_at() OWNER TO postgres;

--
-- TOC entry 377 (class 1255 OID 46052)
-- Name: update_certification_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_certification_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_certification_updated_at() OWNER TO postgres;

--
-- TOC entry 454 (class 1255 OID 52978)
-- Name: update_coefficient_config(integer, integer, integer, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_coefficient_config(p_id integer, p_min_missions integer, p_max_missions integer, p_coefficient_value numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur est admin
    IF NOT is_admin() THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;
    
    -- Mettre à jour la configuration
    UPDATE coefficient_config
    SET 
        min_missions = p_min_missions,
        max_missions = p_max_missions,
        coefficient_value = p_coefficient_value,
        updated_at = timezone('utc'::text, now())
    WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.update_coefficient_config(p_id integer, p_min_missions integer, p_max_missions integer, p_coefficient_value numeric) OWNER TO postgres;

--
-- TOC entry 457 (class 1255 OID 52981)
-- Name: update_coefficient_config_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_coefficient_config_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_coefficient_config_updated_at() OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 52979)
-- Name: update_customer_coefficients_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_customer_coefficients_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_customer_coefficients_updated_at() OWNER TO postgres;

--
-- TOC entry 476 (class 1255 OID 86063)
-- Name: update_customer_penalty(uuid, numeric, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_customer_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  IF NOT (is_admin() OR is_employee()) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  
  IF p_penalty_amount <= 0 THEN
    RAISE EXCEPTION 'Penalty amount must be positive';
  END IF;
  
  UPDATE customer_penalties
  SET 
    penalty_amount = p_penalty_amount,
    reason = p_reason,
    updated_at = timezone('utc'::text, now())
  WHERE id = p_penalty_id;
END;
$$;


ALTER FUNCTION public.update_customer_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) OWNER TO postgres;

--
-- TOC entry 436 (class 1255 OID 43778)
-- Name: update_driver_alerts_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_alerts_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_driver_alerts_updated_at() OWNER TO postgres;

--
-- TOC entry 520 (class 1255 OID 92786)
-- Name: update_driver_allowance(uuid, numeric, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_allowance(p_allowance_id uuid, p_allowance_amount numeric, p_reason text DEFAULT NULL::text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  UPDATE driver_allowances
  SET 
    allowance_amount = p_allowance_amount,
    reason = p_reason,
    updated_at = now()
  WHERE id = p_allowance_id;
END;
$$;


ALTER FUNCTION public.update_driver_allowance(p_allowance_id uuid, p_allowance_amount numeric, p_reason text) OWNER TO postgres;

--
-- TOC entry 486 (class 1255 OID 54163)
-- Name: update_driver_handover_count(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_handover_count(driver_uuid uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE profiles 
    SET number_of_handover = (
        SELECT COUNT(*)
        FROM missions 
        WHERE driver_id = driver_uuid 
        AND missionstatusdriver = 'clotureeplateforme'
        AND (basic_handover = true OR comfort_handover = true)
    )
    WHERE id = driver_uuid AND user_type = 'driver';
END;
$$;


ALTER FUNCTION public.update_driver_handover_count(driver_uuid uuid) OWNER TO postgres;

--
-- TOC entry 487 (class 1255 OID 54164)
-- Name: update_driver_management_count(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_management_count(driver_uuid uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE profiles 
    SET number_of_management = (
        SELECT COUNT(*)
        FROM missions 
        WHERE driver_id = driver_uuid 
        AND missionstatusdriver = 'clotureeplateforme'
        AND document_management = true
    )
    WHERE id = driver_uuid AND user_type = 'driver';
END;
$$;


ALTER FUNCTION public.update_driver_management_count(driver_uuid uuid) OWNER TO postgres;

--
-- TOC entry 491 (class 1255 OID 54165)
-- Name: update_driver_mission_counts(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_mission_counts(driver_uuid uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM update_driver_handover_count(driver_uuid);
    PERFORM update_driver_management_count(driver_uuid);
END;
$$;


ALTER FUNCTION public.update_driver_mission_counts(driver_uuid uuid) OWNER TO postgres;

--
-- TOC entry 466 (class 1255 OID 70308)
-- Name: update_driver_penalty(uuid, numeric, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  IF NOT (is_admin() OR is_employee()) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  
  IF p_penalty_amount <= 0 THEN
    RAISE EXCEPTION 'Penalty amount must be positive';
  END IF;
  
  UPDATE driver_penalties
  SET 
    penalty_amount = p_penalty_amount,
    reason = p_reason,
    updated_at = timezone('utc'::text, now())
  WHERE id = p_penalty_id;
END;
$$;


ALTER FUNCTION public.update_driver_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) OWNER TO postgres;

--
-- TOC entry 463 (class 1255 OID 70306)
-- Name: update_driver_penalty_config(numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_penalty_config(p_penalty_more_than_72h numeric, p_penalty_between_24h_72h numeric, p_penalty_less_than_24h numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  IF NOT is_admin() THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;
  
  IF p_penalty_more_than_72h < 0 
     OR p_penalty_between_24h_72h < 0 
     OR p_penalty_less_than_24h < 0 
  THEN
    RAISE EXCEPTION 'Penalty amounts must be positive';
  END IF;
  
  UPDATE driver_penalty_config
  SET 
    penalty_more_than_72h = p_penalty_more_than_72h,
    penalty_between_24h_72h = p_penalty_between_24h_72h,
    penalty_less_than_24h = p_penalty_less_than_24h,
    updated_at = timezone('utc'::text, now())
  WHERE id = 1;
END;
$$;


ALTER FUNCTION public.update_driver_penalty_config(p_penalty_more_than_72h numeric, p_penalty_between_24h_72h numeric, p_penalty_less_than_24h numeric) OWNER TO postgres;

--
-- TOC entry 413 (class 1255 OID 51720)
-- Name: update_driver_pricing_coefficients(numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_pricing_coefficients(p_coefficient_a numeric, p_coefficient_b_beginner numeric, p_coefficient_b_intermediate numeric, p_coefficient_b_expert numeric, p_coefficient_b_elite numeric, p_coefficient_c_beginner numeric, p_coefficient_c_intermediate numeric, p_coefficient_c_expert numeric, p_coefficient_c_elite numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur est admin
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type = 'admin'
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Mettre à jour les coefficients
    UPDATE driver_pricing_coefficients
    SET 
        coefficient_a = p_coefficient_a,
        coefficient_b_beginner = p_coefficient_b_beginner,
        coefficient_b_intermediate = p_coefficient_b_intermediate,
        coefficient_b_expert = p_coefficient_b_expert,
        coefficient_b_elite = p_coefficient_b_elite,
        coefficient_c_beginner = p_coefficient_c_beginner,
        coefficient_c_intermediate = p_coefficient_c_intermediate,
        coefficient_c_expert = p_coefficient_c_expert,
        coefficient_c_elite = p_coefficient_c_elite,
        updated_at = timezone('utc'::text, now())
    WHERE id = 1;
END;
$$;


ALTER FUNCTION public.update_driver_pricing_coefficients(p_coefficient_a numeric, p_coefficient_b_beginner numeric, p_coefficient_b_intermediate numeric, p_coefficient_b_expert numeric, p_coefficient_b_elite numeric, p_coefficient_c_beginner numeric, p_coefficient_c_intermediate numeric, p_coefficient_c_expert numeric, p_coefficient_c_elite numeric) OWNER TO postgres;

--
-- TOC entry 654 (class 1255 OID 17620)
-- Name: update_driver_pricing_rule(integer, numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_pricing_rule(p_id integer, p_beginner_price numeric, p_intermediate_price numeric, p_expert_price numeric, p_elite_price numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur est admin
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type = 'admin'
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Mettre à jour les prix
    UPDATE driver_pricing_rules
    SET 
        beginner_price = p_beginner_price,
        intermediate_price = p_intermediate_price,
        expert_price = p_expert_price,
        elite_price = p_elite_price,
        updated_at = timezone('utc'::text, now())
    WHERE id = p_id;
END;
$$;


ALTER FUNCTION public.update_driver_pricing_rule(p_id integer, p_beginner_price numeric, p_intermediate_price numeric, p_expert_price numeric, p_elite_price numeric) OWNER TO postgres;

--
-- TOC entry 517 (class 1255 OID 54172)
-- Name: update_driver_seniority(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_seniority(driver_uuid uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE profiles 
    SET seniority = calculate_driver_seniority(driver_uuid)
    WHERE id = driver_uuid AND user_type = 'driver';
END;
$$;


ALTER FUNCTION public.update_driver_seniority(driver_uuid uuid) OWNER TO postgres;

--
-- TOC entry 686 (class 1255 OID 17621)
-- Name: update_driver_status(uuid, public.driver_status); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_status(driver_id uuid, new_status public.driver_status) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur appelant est admin ou employee
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type IN ('admin', 'employee')
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Vérifier que le nouveau statut est valide pour un driver
    IF new_status NOT IN (
        'active_beginner', 'active_intermediate', 'active_expert', 'active_elite',
        'blocked', 'inactive', 'inactive_mbc', 'inactive_denied', 'inactive_woman',
        'pending_validation', 'pending_validation_woman', 'pending_validation_webinar',
        'pending_confirmation'
    ) THEN
        RAISE EXCEPTION 'Invalid driver status: %', new_status;
    END IF;

    -- Mettre à jour le statut du convoyeur
    UPDATE profiles
    SET driver_status = new_status
    WHERE id = driver_id
    AND user_type = 'driver';
END;
$$;


ALTER FUNCTION public.update_driver_status(driver_id uuid, new_status public.driver_status) OWNER TO postgres;

--
-- TOC entry 5545 (class 0 OID 0)
-- Dependencies: 686
-- Name: FUNCTION update_driver_status(driver_id uuid, new_status public.driver_status); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.update_driver_status(driver_id uuid, new_status public.driver_status) IS 'Permet aux admins et employees de mettre à jour le statut d''un driver';


--
-- TOC entry 529 (class 1255 OID 96342)
-- Name: update_driver_status_with_reason(uuid, public.driver_status, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text DEFAULT NULL::text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
    -- Vérifier que l'utilisateur appelant est admin ou employee
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type IN ('admin', 'employee')
    ) THEN
        RAISE EXCEPTION 'Unauthorized: Only admins and employees can update driver status';
    END IF;

    -- Vérifier que le nouveau statut est valide
    IF new_status NOT IN (
        'active_beginner', 'active_intermediate', 'active_expert', 'active_elite',
        'blocked', 'inactive', 'inactive_mbc', 'inactive_denied', 'inactive_woman',
        'pending_validation', 'pending_validation_woman', 'pending_validation_webinar',
        'pending_confirmation'
    ) THEN
        RAISE EXCEPTION 'Invalid driver status: %', new_status;
    END IF;

    -- Mettre à jour le statut et la raison de refus
    UPDATE profiles
    SET 
        driver_status = new_status,
        rejection_reason = reason,
        updated_at = NOW()
    WHERE id = driver_id
    AND user_type = 'driver';

    -- Vérifier que la mise à jour a bien eu lieu
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Driver not found: %', driver_id;
    END IF;
END;
$$;


ALTER FUNCTION public.update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text) OWNER TO postgres;

--
-- TOC entry 5547 (class 0 OID 0)
-- Dependencies: 529
-- Name: FUNCTION update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text) IS 'Permet aux admins et employees de mettre à jour le statut d''un driver avec une raison de refus';


--
-- TOC entry 462 (class 1255 OID 50591)
-- Name: update_expired_missions(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_expired_missions() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
    -- Mettre à jour les missions en recherche_driver qui ont dépassé leur deadline
    UPDATE missions 
    SET status = 'expiree'
    WHERE status = 'recherche_driver'
      AND delivery_deadline <= NOW() AT TIME ZONE 'Europe/Paris';
        
    -- Log le nombre de missions mises à jour
    RAISE NOTICE 'Missions expirées mises à jour selon l''heure Paris';
END;
$$;


ALTER FUNCTION public.update_expired_missions() OWNER TO postgres;

--
-- TOC entry 473 (class 1255 OID 51784)
-- Name: update_margin_config(numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_margin_config(p_base_amount numeric, p_distance_multiplier numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if user is admin
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type = 'admin'
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Update margin config
    UPDATE margin_config
    SET 
        base_amount = p_base_amount,
        distance_multiplier = p_distance_multiplier,
        updated_at = timezone('utc'::text, now())
    WHERE id = 1;
END;
$$;


ALTER FUNCTION public.update_margin_config(p_base_amount numeric, p_distance_multiplier numeric) OWNER TO postgres;

--
-- TOC entry 464 (class 1255 OID 30479)
-- Name: update_mission_status_by_time(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_mission_status_by_time() RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
    -- Mettre à jour les missions acceptées dont la pickup_datetime est arrivée
    -- Comparer directement en UTC sans conversion de fuseau horaire
    UPDATE missions 
    SET 
        missionstatusdriver = 'en_coursdriver',
        status = 'en_cours'
    WHERE 
        missionstatusdriver = 'mission_acceptee'
        AND pickup_datetime IS NOT NULL 
        AND pickup_datetime <= NOW()
        AND status = 'acceptee';
        
    -- Mettre à jour les missions en cours dont la delivery_datetime est arrivée
    -- Comparer directement en UTC sans conversion de fuseau horaire
    UPDATE missions 
    SET 
        missionstatusdriver = 'termineedriver',
        status = 'terminee'
    WHERE 
        missionstatusdriver = 'en_coursdriver'
        AND delivery_datetime IS NOT NULL 
        AND delivery_datetime <= NOW()
        AND status = 'en_cours';
        
    -- Log le nombre de missions mises à jour
    RAISE NOTICE 'Statuts de missions mis à jour (comparaison UTC)';
END;
$$;


ALTER FUNCTION public.update_mission_status_by_time() OWNER TO postgres;

--
-- TOC entry 663 (class 1255 OID 17622)
-- Name: update_missions_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_missions_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_missions_updated_at() OWNER TO postgres;

--
-- TOC entry 483 (class 1255 OID 51788)
-- Name: update_option_driver_commission(text, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_option_driver_commission(option_code text, new_commission numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
    -- Check if user is admin
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type = 'admin'
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Update option driver commission
    UPDATE mission_options
    SET 
        driver_commission = new_commission,
        updated_at = timezone('utc'::text, now())
    WHERE code = option_code;
END;
$$;


ALTER FUNCTION public.update_option_driver_commission(option_code text, new_commission numeric) OWNER TO postgres;

--
-- TOC entry 662 (class 1255 OID 17623)
-- Name: update_option_price(text, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_option_price(option_code text, new_price numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if user is admin
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type = 'admin'
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Update option price
    UPDATE mission_options
    SET 
        price = new_price,
        updated_at = timezone('utc'::text, now())
    WHERE code = option_code;
END;
$$;


ALTER FUNCTION public.update_option_price(option_code text, new_price numeric) OWNER TO postgres;

--
-- TOC entry 661 (class 1255 OID 17624)
-- Name: update_pricing_formula(public.vehicle_type, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_pricing_formula(p_vehicle_type public.vehicle_type, p_distance_multiplier numeric, p_base_price numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
  -- Check if user is admin
  IF NOT EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid()
    AND user_type = 'admin'
  ) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;

  -- Update formula
  UPDATE pricing_formulas
  SET 
    distance_multiplier = p_distance_multiplier,
    base_price = p_base_price,
    updated_at = timezone('utc'::text, now())
  WHERE vehicle_type = p_vehicle_type;
END;
$$;


ALTER FUNCTION public.update_pricing_formula(p_vehicle_type public.vehicle_type, p_distance_multiplier numeric, p_base_price numeric) OWNER TO postgres;

--
-- TOC entry 390 (class 1255 OID 56530)
-- Name: update_return_mission_pricing_config(numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_return_mission_pricing_config(p_discount_percentage numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if user is admin
    IF NOT is_admin() THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Validate percentage
    IF p_discount_percentage < 0 OR p_discount_percentage > 100 THEN
        RAISE EXCEPTION 'Invalid discount percentage';
    END IF;

    -- Update config
    UPDATE return_mission_pricing_config
    SET 
        discount_percentage = p_discount_percentage,
        updated_at = timezone('utc'::text, now())
    WHERE id = 1;
END;
$$;


ALTER FUNCTION public.update_return_mission_pricing_config(p_discount_percentage numeric) OWNER TO postgres;

--
-- TOC entry 447 (class 1255 OID 51757)
-- Name: update_travel_pricing_config(numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_travel_pricing_config(p_petrolprice numeric, p_tollclass1 numeric, p_tollclass2 numeric, p_tollclass3 numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  -- Check if user is admin
  IF NOT EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid()
    AND user_type = 'admin'
  ) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;

  -- Update pricing config
  UPDATE travel_pricing_config
  SET 
    petrolprice = p_petrolprice,
    tollclass1 = p_tollclass1,
    tollclass2 = p_tollclass2,
    tollclass3 = p_tollclass3,
    updated_at = timezone('utc'::text, now())
  WHERE id = 1;
END;
$$;


ALTER FUNCTION public.update_travel_pricing_config(p_petrolprice numeric, p_tollclass1 numeric, p_tollclass2 numeric, p_tollclass3 numeric) OWNER TO postgres;

--
-- TOC entry 386 (class 1255 OID 49412)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    SET search_path TO 'public'
    AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

--
-- TOC entry 448 (class 1255 OID 51758)
-- Name: update_vehicle_consumption(public.vehicle_type, numeric); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_vehicle_consumption(p_vehicle_type public.vehicle_type, p_consumption numeric) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  -- Check if user is admin
  IF NOT EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid()
    AND user_type = 'admin'
  ) THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;

  -- Update vehicle consumption
  UPDATE vehicle_consumption
  SET 
    consumption = p_consumption,
    updated_at = timezone('utc'::text, now())
  WHERE vehicle_type = p_vehicle_type;
END;
$$;


ALTER FUNCTION public.update_vehicle_consumption(p_vehicle_type public.vehicle_type, p_consumption numeric) OWNER TO postgres;

--
-- TOC entry 658 (class 1255 OID 17625)
-- Name: validate_driver(uuid); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_driver(driver_id uuid) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Vérifier que l'utilisateur appelant est admin ou employee
    IF NOT EXISTS (
        SELECT 1 FROM profiles
        WHERE id = auth.uid()
        AND user_type IN ('admin', 'employee')
    ) THEN
        RAISE EXCEPTION 'Unauthorized';
    END IF;

    -- Mettre à jour le statut du convoyeur
    UPDATE profiles
    SET driver_status = 'active_beginner'
    WHERE id = driver_id
    AND user_type = 'driver'
    AND driver_status = 'inactive';
END;
$$;


ALTER FUNCTION public.validate_driver(driver_id uuid) OWNER TO postgres;

--
-- TOC entry 659 (class 1255 OID 17626)
-- Name: validate_driver_w_garage(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_driver_w_garage() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- If mission requires W-garage, check if assigned driver has W-garage capability
    IF NEW.w_garage = true AND NEW.driver_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM profiles 
            WHERE id = NEW.driver_id 
            AND w_garage = true
        ) THEN
            RAISE EXCEPTION 'Driver does not have W-garage capability';
        END IF;
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.validate_driver_w_garage() OWNER TO postgres;

--
-- TOC entry 660 (class 1255 OID 17627)
-- Name: validate_mission_driver(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_mission_driver() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Si un driver_id est spécifié, vérifier qu'il est valide
    IF NEW.driver_id IS NOT NULL THEN
        IF NOT EXISTS (
            SELECT 1 FROM profiles 
            WHERE id = NEW.driver_id 
            AND user_type = 'driver'
            AND driver_status NOT IN ('inactive', 'blocked')
        ) THEN
            RAISE EXCEPTION 'Invalid driver_id: Driver must be active and of type driver';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.validate_mission_driver() OWNER TO postgres;

--
-- TOC entry 441 (class 1255 OID 30480)
-- Name: validate_mission_status_transition(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validate_mission_status_transition() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  -- Status acceptee => driver doit être mission_acceptee
  IF NEW.status = 'acceptee'
     AND NEW.missionstatusdriver IS NOT NULL
     AND NEW.missionstatusdriver != 'mission_acceptee' THEN
    RAISE EXCEPTION 'Incohérence: status "acceptee" doit correspondre à missionstatusdriver "mission_acceptee"';
  END IF;

  -- Status en_cours => driver doit être en_coursdriver
  IF NEW.status = 'en_cours'
     AND NEW.missionstatusdriver IS NOT NULL
     AND NEW.missionstatusdriver != 'en_coursdriver' THEN
    RAISE EXCEPTION 'Incohérence: status "en_cours" doit correspondre à missionstatusdriver "en_coursdriver"';
  END IF;

  -- Status terminee => driver peut être termineedriver, clotureedriver, decloturee, clotureeplateforme
  IF NEW.status = 'terminee'
     AND NEW.missionstatusdriver IS NOT NULL
     AND NEW.missionstatusdriver NOT IN ('termineedriver','clotureedriver','decloturee','clotureeplateforme') THEN
    RAISE EXCEPTION 'Incohérence: status "terminee" doit avoir un missionstatusdriver parmi termineedriver, clotureedriver, decloturee, clotureeplateforme';
  END IF;

  RETURN NEW;
END;
$$;


ALTER FUNCTION public.validate_mission_status_transition() OWNER TO postgres;

--
-- TOC entry 685 (class 1255 OID 17628)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 657 (class 1255 OID 17630)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 687 (class 1255 OID 17631)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 688 (class 1255 OID 17632)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 690 (class 1255 OID 17633)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 691 (class 1255 OID 17634)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 707 (class 1255 OID 17635)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 689 (class 1255 OID 17636)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 664 (class 1255 OID 17637)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    -- Generate a new UUID for the id
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      RAISE WARNING 'ErrorSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 696 (class 1255 OID 17638)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 668 (class 1255 OID 17639)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 667 (class 1255 OID 17640)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 380 (class 1255 OID 28222)
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 671 (class 1255 OID 17641)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 446 (class 1255 OID 47161)
-- Name: delete_leaf_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_rows_deleted integer;
BEGIN
    LOOP
        WITH candidates AS (
            SELECT DISTINCT
                t.bucket_id,
                unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        ),
        uniq AS (
             SELECT
                 bucket_id,
                 name,
                 storage.get_level(name) AS level
             FROM candidates
             WHERE name <> ''
             GROUP BY bucket_id, name
        ),
        leaf AS (
             SELECT
                 p.bucket_id,
                 p.name,
                 p.level
             FROM storage.prefixes AS p
                  JOIN uniq AS u
                       ON u.bucket_id = p.bucket_id
                           AND u.name = p.name
                           AND u.level = p.level
             WHERE NOT EXISTS (
                 SELECT 1
                 FROM storage.objects AS o
                 WHERE o.bucket_id = p.bucket_id
                   AND o.level = p.level + 1
                   AND o.name COLLATE "C" LIKE p.name || '/%'
             )
             AND NOT EXISTS (
                 SELECT 1
                 FROM storage.prefixes AS c
                 WHERE c.bucket_id = p.bucket_id
                   AND c.level = p.level + 1
                   AND c.name COLLATE "C" LIKE p.name || '/%'
             )
        )
        DELETE
        FROM storage.prefixes AS p
            USING leaf AS l
        WHERE p.bucket_id = l.bucket_id
          AND p.name = l.name
          AND p.level = l.level;

        GET DIAGNOSTICS v_rows_deleted = ROW_COUNT;
        EXIT WHEN v_rows_deleted = 0;
    END LOOP;
END;
$$;


ALTER FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- TOC entry 409 (class 1255 OID 28223)
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 412 (class 1255 OID 28226)
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 426 (class 1255 OID 28241)
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- TOC entry 670 (class 1255 OID 17642)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 672 (class 1255 OID 17643)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 666 (class 1255 OID 17644)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 375 (class 1255 OID 28204)
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 376 (class 1255 OID 28220)
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 379 (class 1255 OID 28221)
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 424 (class 1255 OID 28239)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 700 (class 1255 OID 17646)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 674 (class 1255 OID 17647)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 438 (class 1255 OID 47160)
-- Name: lock_top_prefixes(text[], text[]); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket text;
    v_top text;
BEGIN
    FOR v_bucket, v_top IN
        SELECT DISTINCT t.bucket_id,
            split_part(t.name, '/', 1) AS top
        FROM unnest(bucket_ids, names) AS t(bucket_id, name)
        WHERE t.name <> ''
        ORDER BY 1, 2
        LOOP
            PERFORM pg_advisory_xact_lock(hashtextextended(v_bucket || '/' || v_top, 0));
        END LOOP;
END;
$$;


ALTER FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) OWNER TO supabase_storage_admin;

--
-- TOC entry 443 (class 1255 OID 47162)
-- Name: objects_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- TOC entry 411 (class 1255 OID 28225)
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 444 (class 1255 OID 47163)
-- Name: objects_update_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    -- NEW - OLD (destinations to create prefixes for)
    v_add_bucket_ids text[];
    v_add_names      text[];

    -- OLD - NEW (sources to prune)
    v_src_bucket_ids text[];
    v_src_names      text[];
BEGIN
    IF TG_OP <> 'UPDATE' THEN
        RETURN NULL;
    END IF;

    -- 1) Compute NEW−OLD (added paths) and OLD−NEW (moved-away paths)
    WITH added AS (
        SELECT n.bucket_id, n.name
        FROM new_rows n
        WHERE n.name <> '' AND position('/' in n.name) > 0
        EXCEPT
        SELECT o.bucket_id, o.name FROM old_rows o WHERE o.name <> ''
    ),
    moved AS (
         SELECT o.bucket_id, o.name
         FROM old_rows o
         WHERE o.name <> ''
         EXCEPT
         SELECT n.bucket_id, n.name FROM new_rows n WHERE n.name <> ''
    )
    SELECT
        -- arrays for ADDED (dest) in stable order
        COALESCE( (SELECT array_agg(a.bucket_id ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        COALESCE( (SELECT array_agg(a.name      ORDER BY a.bucket_id, a.name) FROM added a), '{}' ),
        -- arrays for MOVED (src) in stable order
        COALESCE( (SELECT array_agg(m.bucket_id ORDER BY m.bucket_id, m.name) FROM moved m), '{}' ),
        COALESCE( (SELECT array_agg(m.name      ORDER BY m.bucket_id, m.name) FROM moved m), '{}' )
    INTO v_add_bucket_ids, v_add_names, v_src_bucket_ids, v_src_names;

    -- Nothing to do?
    IF (array_length(v_add_bucket_ids, 1) IS NULL) AND (array_length(v_src_bucket_ids, 1) IS NULL) THEN
        RETURN NULL;
    END IF;

    -- 2) Take per-(bucket, top) locks: ALL prefixes in consistent global order to prevent deadlocks
    DECLARE
        v_all_bucket_ids text[];
        v_all_names text[];
    BEGIN
        -- Combine source and destination arrays for consistent lock ordering
        v_all_bucket_ids := COALESCE(v_src_bucket_ids, '{}') || COALESCE(v_add_bucket_ids, '{}');
        v_all_names := COALESCE(v_src_names, '{}') || COALESCE(v_add_names, '{}');

        -- Single lock call ensures consistent global ordering across all transactions
        IF array_length(v_all_bucket_ids, 1) IS NOT NULL THEN
            PERFORM storage.lock_top_prefixes(v_all_bucket_ids, v_all_names);
        END IF;
    END;

    -- 3) Create destination prefixes (NEW−OLD) BEFORE pruning sources
    IF array_length(v_add_bucket_ids, 1) IS NOT NULL THEN
        WITH candidates AS (
            SELECT DISTINCT t.bucket_id, unnest(storage.get_prefixes(t.name)) AS name
            FROM unnest(v_add_bucket_ids, v_add_names) AS t(bucket_id, name)
            WHERE name <> ''
        )
        INSERT INTO storage.prefixes (bucket_id, name)
        SELECT c.bucket_id, c.name
        FROM candidates c
        ON CONFLICT DO NOTHING;
    END IF;

    -- 4) Prune source prefixes bottom-up for OLD−NEW
    IF array_length(v_src_bucket_ids, 1) IS NOT NULL THEN
        -- re-entrancy guard so DELETE on prefixes won't recurse
        IF current_setting('storage.gc.prefixes', true) <> '1' THEN
            PERFORM set_config('storage.gc.prefixes', '1', true);
        END IF;

        PERFORM storage.delete_leaf_prefixes(v_src_bucket_ids, v_src_names);
    END IF;

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.objects_update_cleanup() OWNER TO supabase_storage_admin;

--
-- TOC entry 384 (class 1255 OID 49390)
-- Name: objects_update_level_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Set the new level
        NEW."level" := "storage"."get_level"(NEW."name");
    END IF;
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_level_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 425 (class 1255 OID 28240)
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 676 (class 1255 OID 17648)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 445 (class 1255 OID 47164)
-- Name: prefixes_delete_cleanup(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    v_bucket_ids text[];
    v_names      text[];
BEGIN
    IF current_setting('storage.gc.prefixes', true) = '1' THEN
        RETURN NULL;
    END IF;

    PERFORM set_config('storage.gc.prefixes', '1', true);

    SELECT COALESCE(array_agg(d.bucket_id), '{}'),
           COALESCE(array_agg(d.name), '{}')
    INTO v_bucket_ids, v_names
    FROM deleted AS d
    WHERE d.name <> '';

    PERFORM storage.lock_top_prefixes(v_bucket_ids, v_names);
    PERFORM storage.delete_leaf_prefixes(v_bucket_ids, v_names);

    RETURN NULL;
END;
$$;


ALTER FUNCTION storage.prefixes_delete_cleanup() OWNER TO supabase_storage_admin;

--
-- TOC entry 410 (class 1255 OID 28224)
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 701 (class 1255 OID 17649)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 416 (class 1255 OID 28237)
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 414 (class 1255 OID 28236)
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 437 (class 1255 OID 47159)
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    sort_col text;
    sort_ord text;
    cursor_op text;
    cursor_expr text;
    sort_expr text;
BEGIN
    -- Validate sort_order
    sort_ord := lower(sort_order);
    IF sort_ord NOT IN ('asc', 'desc') THEN
        sort_ord := 'asc';
    END IF;

    -- Determine cursor comparison operator
    IF sort_ord = 'asc' THEN
        cursor_op := '>';
    ELSE
        cursor_op := '<';
    END IF;
    
    sort_col := lower(sort_column);
    -- Validate sort column  
    IF sort_col IN ('updated_at', 'created_at') THEN
        cursor_expr := format(
            '($5 = '''' OR ROW(date_trunc(''milliseconds'', %I), name COLLATE "C") %s ROW(COALESCE(NULLIF($6, '''')::timestamptz, ''epoch''::timestamptz), $5))',
            sort_col, cursor_op
        );
        sort_expr := format(
            'COALESCE(date_trunc(''milliseconds'', %I), ''epoch''::timestamptz) %s, name COLLATE "C" %s',
            sort_col, sort_ord, sort_ord
        );
    ELSE
        cursor_expr := format('($5 = '''' OR name COLLATE "C" %s $5)', cursor_op);
        sort_expr := format('name COLLATE "C" %s', sort_ord);
    END IF;

    RETURN QUERY EXECUTE format(
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    NULL::uuid AS id,
                    updated_at,
                    created_at,
                    NULL::timestamptz AS last_accessed_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
            UNION ALL
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name,
                    id,
                    updated_at,
                    created_at,
                    last_accessed_at,
                    metadata
                FROM storage.objects
                WHERE name COLLATE "C" LIKE $1 || '%%'
                    AND bucket_id = $2
                    AND level = $4
                    AND %s
                ORDER BY %s
                LIMIT $3
            )
        ) obj
        ORDER BY %s
        LIMIT $3
        $sql$,
        cursor_expr,    -- prefixes WHERE
        sort_expr,      -- prefixes ORDER BY
        cursor_expr,    -- objects WHERE
        sort_expr,      -- objects ORDER BY
        sort_expr       -- final ORDER BY
    )
    USING prefix, bucket_name, limits, levels, start_after, sort_column_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 679 (class 1255 OID 17650)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- TOC entry 673 (class 1255 OID 17651)
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 282 (class 1259 OID 17652)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 5588 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 283 (class 1259 OID 17658)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 5590 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 284 (class 1259 OID 17663)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 5592 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 5593 (class 0 OID 0)
-- Dependencies: 284
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 285 (class 1259 OID 17670)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 5595 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 286 (class 1259 OID 17675)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 5597 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 287 (class 1259 OID 17680)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 5599 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 288 (class 1259 OID 17685)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 5601 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 5602 (class 0 OID 0)
-- Dependencies: 288
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- TOC entry 359 (class 1259 OID 72537)
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


ALTER TABLE auth.oauth_authorizations OWNER TO supabase_auth_admin;

--
-- TOC entry 317 (class 1259 OID 27071)
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048))
);


ALTER TABLE auth.oauth_clients OWNER TO supabase_auth_admin;

--
-- TOC entry 360 (class 1259 OID 72570)
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


ALTER TABLE auth.oauth_consents OWNER TO supabase_auth_admin;

--
-- TOC entry 289 (class 1259 OID 17690)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 290 (class 1259 OID 17698)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 5608 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 291 (class 1259 OID 17703)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 5610 (class 0 OID 0)
-- Dependencies: 291
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 292 (class 1259 OID 17704)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 5612 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 293 (class 1259 OID 17712)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 5614 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 294 (class 1259 OID 17718)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 5616 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 295 (class 1259 OID 17721)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 5617 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 5618 (class 0 OID 0)
-- Dependencies: 295
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 5619 (class 0 OID 0)
-- Dependencies: 295
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- TOC entry 5620 (class 0 OID 0)
-- Dependencies: 295
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- TOC entry 296 (class 1259 OID 17726)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 5622 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 297 (class 1259 OID 17732)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 5624 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 5625 (class 0 OID 0)
-- Dependencies: 297
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 298 (class 1259 OID 17738)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 5627 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 5628 (class 0 OID 0)
-- Dependencies: 298
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 325 (class 1259 OID 49413)
-- Name: admin_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_settings (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    key text NOT NULL,
    value boolean DEFAULT true NOT NULL,
    description text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.admin_settings OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 54093)
-- Name: billing_periods_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.billing_periods_config (
    id integer DEFAULT 1 NOT NULL,
    period_type text DEFAULT 'monthly'::text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT billing_periods_config_period_type_check CHECK ((period_type = ANY (ARRAY['monthly'::text, 'bi_monthly'::text, 'tri_monthly'::text])))
);


ALTER TABLE public.billing_periods_config OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 66625)
-- Name: business_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_groups (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    company_name text NOT NULL,
    leader_account_id uuid NOT NULL,
    company_logo_url text,
    company_address text,
    company_postal_code text,
    company_city text,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.business_groups OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 66643)
-- Name: business_invitations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_invitations (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    business_group_id uuid NOT NULL,
    invited_email text NOT NULL,
    invited_by uuid NOT NULL,
    status text DEFAULT 'pending'::text NOT NULL,
    invitation_token text NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT business_invitations_status_check CHECK ((status = ANY (ARRAY['pending'::text, 'accepted'::text, 'expired'::text])))
);


ALTER TABLE public.business_invitations OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 64321)
-- Name: business_invoice_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.business_invoice_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.business_invoice_number_seq OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 64322)
-- Name: business_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business_invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    invoice_number text DEFAULT (((('FAC-'::text || to_char(CURRENT_TIMESTAMP, 'YY'::text)) || to_char(CURRENT_TIMESTAMP, 'MM'::text)) || '-'::text) || lpad((nextval('public.business_invoice_number_seq'::regclass))::text, 6, '0'::text)) NOT NULL,
    period_start date NOT NULL,
    period_end date NOT NULL,
    status public.invoice_status DEFAULT 'draft'::public.invoice_status NOT NULL,
    amount_ht numeric(10,2) DEFAULT 0 NOT NULL,
    amount_tva numeric(10,2) DEFAULT 0 NOT NULL,
    amount_ttc numeric(10,2) DEFAULT 0 NOT NULL,
    applied_coefficient numeric(4,3) DEFAULT 1.0 NOT NULL,
    missions_count integer DEFAULT 0 NOT NULL,
    issued_at timestamp with time zone,
    due_date date,
    paid_at timestamp with time zone,
    payment_method text,
    payment_reference text,
    pdf_url text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    business_group_id uuid,
    CONSTRAINT valid_amounts CHECK (((amount_ht >= (0)::numeric) AND (amount_tva >= (0)::numeric) AND (amount_ttc >= (0)::numeric))),
    CONSTRAINT valid_coefficient CHECK (((applied_coefficient > (0)::numeric) AND (applied_coefficient <= (1)::numeric)))
);


ALTER TABLE public.business_invoices OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 46008)
-- Name: certification_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certification_questions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    certification_id uuid NOT NULL,
    question text NOT NULL,
    option_a text NOT NULL,
    option_b text NOT NULL,
    option_c text NOT NULL,
    option_d text NOT NULL,
    correct_answer text NOT NULL,
    order_index integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT certification_questions_correct_answer_check CHECK ((correct_answer = ANY (ARRAY['A'::text, 'B'::text, 'C'::text, 'D'::text])))
);


ALTER TABLE public.certification_questions OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 45996)
-- Name: certifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.certifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    code text NOT NULL,
    description text,
    icon text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    certification_type text DEFAULT 'standard'::text NOT NULL
);


ALTER TABLE public.certifications OWNER TO postgres;

--
-- TOC entry 5644 (class 0 OID 0)
-- Dependencies: 322
-- Name: COLUMN certifications.certification_type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.certifications.certification_type IS 'Type de certification: standard (certifications normales) ou onboarding (quiz d''acceptation)';


--
-- TOC entry 333 (class 1259 OID 52940)
-- Name: coefficient_config_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.coefficient_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.coefficient_config_id_seq OWNER TO postgres;

--
-- TOC entry 335 (class 1259 OID 52960)
-- Name: coefficient_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coefficient_config (
    id integer DEFAULT nextval('public.coefficient_config_id_seq'::regclass) NOT NULL,
    min_missions integer NOT NULL,
    max_missions integer,
    coefficient_value numeric NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.coefficient_config OWNER TO postgres;

--
-- TOC entry 350 (class 1259 OID 64348)
-- Name: credit_notes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credit_notes (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    business_invoice_id uuid NOT NULL,
    mission_id uuid NOT NULL,
    credit_number text DEFAULT (((('AV-'::text || to_char(CURRENT_TIMESTAMP, 'YY'::text)) || to_char(CURRENT_TIMESTAMP, 'MM'::text)) || '-'::text) || lpad((nextval('public.business_invoice_number_seq'::regclass))::text, 6, '0'::text)) NOT NULL,
    amount_ht numeric(10,2) NOT NULL,
    amount_tva numeric(10,2) NOT NULL,
    amount_ttc numeric(10,2) NOT NULL,
    reason text,
    status text DEFAULT 'pending'::text NOT NULL,
    applied_to_invoice_id uuid,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.credit_notes OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 52941)
-- Name: customer_coefficients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_coefficients (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    month integer NOT NULL,
    year integer NOT NULL,
    coefficient_value numeric DEFAULT 1.0 NOT NULL,
    missions_count integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.customer_coefficients OWNER TO postgres;

--
-- TOC entry 361 (class 1259 OID 86017)
-- Name: customer_penalties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_penalties (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    mission_id uuid,
    penalty_amount numeric NOT NULL,
    penalty_type public.customer_penalty_type NOT NULL,
    penalty_source public.penalty_source DEFAULT 'manual'::public.penalty_source NOT NULL,
    reason text,
    business_invoice_id uuid,
    penalty_invoice_id uuid,
    created_by uuid,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.customer_penalties OWNER TO postgres;

--
-- TOC entry 366 (class 1259 OID 95069)
-- Name: document_style_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_style_config (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    document_type text NOT NULL,
    company_name text DEFAULT 'SAS CARSWIIFT'::text NOT NULL,
    legal_line text DEFAULT 'SIRET 941 966 954 R.C.S. Paris'::text NOT NULL,
    address_line text DEFAULT '200 rue de la Croix Nivert 75015 Paris'::text NOT NULL,
    primary_color text DEFAULT '#E61B7F'::text NOT NULL,
    logo_path text DEFAULT 'cslogodriver.png'::text,
    font_path text DEFAULT 'BC_Alphapipe_RB_Bold.ttf'::text,
    footer_lines jsonb DEFAULT '["SAS au capital de 1000€", "SIRET 941 966 954 R.C.S. Paris", "200 rue de la Croix Nivert 75015 Paris"]'::jsonb,
    header_config jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.document_style_config OWNER TO postgres;

--
-- TOC entry 364 (class 1259 OID 92803)
-- Name: document_templates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.document_templates (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    document_type text NOT NULL,
    template_name text NOT NULL,
    is_active boolean DEFAULT false,
    page_margins jsonb DEFAULT '[40, 40, 40, 60]'::jsonb,
    header_config jsonb DEFAULT '{}'::jsonb,
    footer_config jsonb DEFAULT '{}'::jsonb,
    styles jsonb DEFAULT '{}'::jsonb,
    content_structure jsonb DEFAULT '{}'::jsonb,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    created_by uuid,
    CONSTRAINT document_templates_document_type_check CHECK ((document_type = ANY (ARRAY['driver_invoice_missions'::text, 'driver_invoice_fees'::text, 'customer_invoice'::text, 'convoy_contract'::text])))
);


ALTER TABLE public.document_templates OWNER TO postgres;

--
-- TOC entry 321 (class 1259 OID 43759)
-- Name: driver_alerts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_alerts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    driver_id uuid NOT NULL,
    departure_city text,
    departure_radius integer DEFAULT 0,
    arrival_city text,
    arrival_radius integer DEFAULT 0,
    include_return_trip boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.driver_alerts OWNER TO postgres;

--
-- TOC entry 363 (class 1259 OID 92751)
-- Name: driver_allowances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_allowances (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    driver_id uuid NOT NULL,
    mission_id uuid,
    allowance_amount numeric NOT NULL,
    allowance_type text NOT NULL,
    allowance_source text DEFAULT 'manual'::text NOT NULL,
    reason text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT driver_allowances_allowance_amount_check CHECK ((allowance_amount >= (0)::numeric)),
    CONSTRAINT driver_allowances_allowance_source_check CHECK ((allowance_source = ANY (ARRAY['automatic'::text, 'manual'::text])))
);


ALTER TABLE public.driver_allowances OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 46023)
-- Name: driver_certifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_certifications (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    driver_id uuid NOT NULL,
    certification_id uuid NOT NULL,
    is_validated boolean DEFAULT false NOT NULL,
    score integer,
    validated_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.driver_certifications OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 54107)
-- Name: driver_invoices; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_invoices (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    driver_id uuid NOT NULL,
    period_start date NOT NULL,
    period_end date NOT NULL,
    total_amount numeric DEFAULT 0 NOT NULL,
    invoice_number text NOT NULL,
    status text DEFAULT 'generated'::text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    missions_total_amount numeric DEFAULT 0 NOT NULL,
    penalties_total_amount numeric DEFAULT 0 NOT NULL,
    pdf_url text,
    invoice_type text DEFAULT 'missions'::text NOT NULL,
    allowances_total_amount numeric DEFAULT 0 NOT NULL,
    fees_total_amount numeric DEFAULT 0 NOT NULL,
    CONSTRAINT driver_invoices_invoice_type_check CHECK ((invoice_type = ANY (ARRAY['missions'::text, 'fees'::text]))),
    CONSTRAINT driver_invoices_status_check CHECK ((status = ANY (ARRAY['generated'::text, 'paid'::text])))
);


ALTER TABLE public.driver_invoices OWNER TO postgres;

--
-- TOC entry 358 (class 1259 OID 70261)
-- Name: driver_penalties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_penalties (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    driver_id uuid NOT NULL,
    mission_id uuid,
    penalty_amount numeric NOT NULL,
    penalty_type public.penalty_type NOT NULL,
    penalty_source public.penalty_source DEFAULT 'automatic'::public.penalty_source NOT NULL,
    cancellation_datetime timestamp with time zone,
    pickup_datetime timestamp with time zone,
    hours_before_pickup numeric,
    reason text,
    created_by uuid,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.driver_penalties OWNER TO postgres;

--
-- TOC entry 357 (class 1259 OID 70228)
-- Name: driver_penalty_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_penalty_config (
    id integer DEFAULT 1 NOT NULL,
    penalty_more_than_72h numeric DEFAULT 25 NOT NULL,
    penalty_between_24h_72h numeric DEFAULT 50 NOT NULL,
    penalty_less_than_24h numeric DEFAULT 75 NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT single_row_constraint CHECK ((id = 1))
);


ALTER TABLE public.driver_penalty_config OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 51698)
-- Name: driver_pricing_coefficients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_pricing_coefficients (
    id integer DEFAULT 1 NOT NULL,
    coefficient_a numeric DEFAULT '-0.000125'::numeric NOT NULL,
    coefficient_b_beginner numeric DEFAULT 0.38 NOT NULL,
    coefficient_b_intermediate numeric DEFAULT 0.40 NOT NULL,
    coefficient_b_expert numeric DEFAULT 0.42 NOT NULL,
    coefficient_b_elite numeric DEFAULT 0.42 NOT NULL,
    coefficient_c_beginner numeric DEFAULT 30 NOT NULL,
    coefficient_c_intermediate numeric DEFAULT 32 NOT NULL,
    coefficient_c_expert numeric DEFAULT 34 NOT NULL,
    coefficient_c_elite numeric DEFAULT 34 NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT single_row_constraint CHECK ((id = 1))
);


ALTER TABLE public.driver_pricing_coefficients OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 17753)
-- Name: driver_pricing_rules; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.driver_pricing_rules (
    id integer NOT NULL,
    distance_min integer NOT NULL,
    distance_max integer,
    beginner_price numeric(10,2) NOT NULL,
    intermediate_price numeric(10,2) NOT NULL,
    expert_price numeric(10,2) NOT NULL,
    elite_price numeric(10,2) NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.driver_pricing_rules OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 17758)
-- Name: driver_pricing_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.driver_pricing_rules_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.driver_pricing_rules_id_seq OWNER TO postgres;

--
-- TOC entry 5661 (class 0 OID 0)
-- Dependencies: 300
-- Name: driver_pricing_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.driver_pricing_rules_id_seq OWNED BY public.driver_pricing_rules.id;


--
-- TOC entry 354 (class 1259 OID 66755)
-- Name: group_order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_order_items (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    group_order_id uuid NOT NULL,
    mission_id uuid,
    arrival_address text NOT NULL,
    arrival_place_name text,
    arrival_place_id text,
    arrival_location_type public.location_type NOT NULL,
    arrival_contact_name text NOT NULL,
    arrival_contact_phone text NOT NULL,
    arrival_opening_hours text NOT NULL,
    vehicle_type public.vehicle_type NOT NULL,
    vehicle_brand uuid,
    vehicle_model uuid,
    vehicle_registration text,
    vehicle_chassis_number text,
    vehicle_seats integer NOT NULL,
    vehicle_transmission public.transmission_type NOT NULL,
    electric_vehicle boolean DEFAULT false NOT NULL,
    vehicle_notes text,
    status text DEFAULT 'pending'::text NOT NULL,
    item_customer_price numeric DEFAULT 0 NOT NULL,
    distance_mission numeric DEFAULT 0 NOT NULL,
    estimated_travel_time integer,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    document_management boolean DEFAULT false,
    basic_handover boolean DEFAULT false,
    comfort_handover boolean DEFAULT false,
    basic_washing boolean DEFAULT false,
    standard_washing boolean DEFAULT false,
    premium_washing boolean DEFAULT false,
    fuel_management public.fuel_management_type DEFAULT 'pas_de_remise'::public.fuel_management_type,
    w_garage boolean DEFAULT false
);


ALTER TABLE public.group_order_items OWNER TO postgres;

--
-- TOC entry 5663 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.document_management; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.document_management IS 'Whether document management service is enabled for this vehicle';


--
-- TOC entry 5664 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.basic_handover; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.basic_handover IS 'Whether basic handover service is enabled for this vehicle';


--
-- TOC entry 5665 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.comfort_handover; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.comfort_handover IS 'Whether comfort handover service is enabled for this vehicle';


--
-- TOC entry 5666 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.basic_washing; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.basic_washing IS 'Whether basic washing service is enabled for this vehicle';


--
-- TOC entry 5667 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.standard_washing; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.standard_washing IS 'Whether standard washing service is enabled for this vehicle';


--
-- TOC entry 5668 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.premium_washing; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.premium_washing IS 'Whether premium washing service is enabled for this vehicle';


--
-- TOC entry 5669 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.fuel_management; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.fuel_management IS 'Fuel management option for this vehicle';


--
-- TOC entry 5670 (class 0 OID 0)
-- Dependencies: 354
-- Name: COLUMN group_order_items.w_garage; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.group_order_items.w_garage IS 'Whether W-Garage service is enabled for this vehicle';


--
-- TOC entry 301 (class 1259 OID 17759)
-- Name: mission_number_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mission_number_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mission_number_seq OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 66729)
-- Name: group_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    customer_id uuid NOT NULL,
    business_group_id uuid,
    group_order_type public.group_order_type NOT NULL,
    status public.group_order_status DEFAULT 'draft'::public.group_order_status NOT NULL,
    departure_address text NOT NULL,
    departure_place_name text,
    departure_place_id text,
    departure_location_type public.location_type NOT NULL,
    departure_contact_name text NOT NULL,
    departure_contact_phone text NOT NULL,
    departure_opening_hours text NOT NULL,
    availability_start timestamp with time zone NOT NULL,
    delivery_deadline timestamp with time zone NOT NULL,
    total_vehicles integer DEFAULT 0 NOT NULL,
    reserved_vehicles integer DEFAULT 0 NOT NULL,
    completed_vehicles integer DEFAULT 0 NOT NULL,
    total_customer_price numeric DEFAULT 0 NOT NULL,
    group_order_number text DEFAULT (((('GRP-'::text || to_char(CURRENT_TIMESTAMP, 'YY'::text)) || to_char(CURRENT_TIMESTAMP, 'MM'::text)) || '-'::text) || lpad((nextval('public.mission_number_seq'::regclass))::text, 6, '0'::text)) NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.group_orders OWNER TO postgres;

--
-- TOC entry 356 (class 1259 OID 67959)
-- Name: inspection_photos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inspection_photos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    inspection_report_id uuid NOT NULL,
    photo_category public.photo_category NOT NULL,
    photo_label text NOT NULL,
    photo_url text NOT NULL,
    order_index integer NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.inspection_photos OWNER TO postgres;

--
-- TOC entry 355 (class 1259 OID 67941)
-- Name: inspection_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inspection_reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    mission_id uuid NOT NULL,
    inspection_type public.inspection_type NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    driver_photo_url text,
    contact_first_name text NOT NULL,
    contact_last_name text NOT NULL,
    contact_phone text NOT NULL,
    vehicle_mileage integer NOT NULL,
    vehicle_fuel_level integer NOT NULL,
    dashboard_photo_url text,
    driver_signature_url text,
    contact_signature_url text,
    fuel_expense_amount numeric,
    fuel_expense_photo_url text,
    toll_expense_amount numeric,
    toll_expense_photo_url text,
    CONSTRAINT inspection_reports_vehicle_fuel_level_check CHECK (((vehicle_fuel_level >= 0) AND (vehicle_fuel_level <= 100)))
);


ALTER TABLE public.inspection_reports OWNER TO postgres;

--
-- TOC entry 365 (class 1259 OID 95044)
-- Name: invoice_style_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.invoice_style_config (
    id integer DEFAULT 1 NOT NULL,
    company_name text DEFAULT 'SAS CARSWIIFT'::text NOT NULL,
    legal_line text DEFAULT 'SIRET 941 966 954 R.C.S. Paris'::text NOT NULL,
    address_line text DEFAULT '200 rue de la Croix Nivert 75015 Paris'::text NOT NULL,
    primary_color text DEFAULT '#E61B7F'::text NOT NULL,
    logo_path text DEFAULT 'cslogodriver.png'::text,
    font_path text DEFAULT 'BC_Alphapipe_RB_Bold.ttf'::text,
    footer_lines jsonb DEFAULT '["SAS au capital de 1000€", "SIRET 941 966 954 R.C.S. Paris", "200 rue de la Croix Nivert 75015 Paris"]'::jsonb,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    CONSTRAINT single_row_check CHECK ((id = 1))
);


ALTER TABLE public.invoice_style_config OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 51763)
-- Name: margin_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.margin_config (
    id integer DEFAULT 1 NOT NULL,
    base_amount numeric DEFAULT 20 NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    distance_multiplier numeric DEFAULT 0.2 NOT NULL
);


ALTER TABLE public.margin_config OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 17760)
-- Name: mission_options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mission_options (
    id integer NOT NULL,
    name text NOT NULL,
    price numeric NOT NULL,
    code text NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    driver_commission numeric DEFAULT 0 NOT NULL,
    is_per_km boolean DEFAULT false,
    CONSTRAINT check_driver_commission_valid CHECK (((driver_commission >= (0)::numeric) AND (driver_commission <= price)))
);


ALTER TABLE public.mission_options OWNER TO postgres;

--
-- TOC entry 5678 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN mission_options.is_per_km; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.mission_options.is_per_km IS 'Si true, price et driver_commission représentent des tarifs au kilomètre';


--
-- TOC entry 303 (class 1259 OID 17767)
-- Name: mission_options_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mission_options_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.mission_options_id_seq OWNER TO postgres;

--
-- TOC entry 5680 (class 0 OID 0)
-- Dependencies: 303
-- Name: mission_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mission_options_id_seq OWNED BY public.mission_options.id;


--
-- TOC entry 362 (class 1259 OID 86066)
-- Name: mission_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mission_reports (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    mission_id uuid NOT NULL,
    created_by uuid NOT NULL,
    report_text text NOT NULL,
    is_visible_to_client boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.mission_reports OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 17768)
-- Name: missions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.missions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    mission_number text DEFAULT ((('CS-'::text || to_char(CURRENT_TIMESTAMP, 'YY'::text)) || to_char(CURRENT_TIMESTAMP, 'MM'::text)) || lpad((nextval('public.mission_number_seq'::regclass))::text, 6, '0'::text)) NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    transport_type public.transport_type NOT NULL,
    departure_location_type public.location_type NOT NULL,
    departure_address text NOT NULL,
    departure_contact_name text NOT NULL,
    departure_contact_phone text NOT NULL,
    departure_opening_hours text NOT NULL,
    arrival_location_type public.location_type NOT NULL,
    arrival_address text NOT NULL,
    arrival_contact_name text NOT NULL,
    arrival_contact_phone text NOT NULL,
    arrival_opening_hours text NOT NULL,
    vehicle_type public.vehicle_type NOT NULL,
    vehicle_registration text NOT NULL,
    vehicle_seats integer NOT NULL,
    vehicle_transmission public.transmission_type NOT NULL,
    vehicle_chassis_number text NOT NULL,
    availability_start timestamp with time zone NOT NULL,
    delivery_deadline timestamp with time zone NOT NULL,
    basic_handover boolean DEFAULT false,
    comfort_handover boolean DEFAULT false,
    basic_washing boolean DEFAULT false,
    standard_washing boolean DEFAULT false,
    premium_washing boolean DEFAULT false,
    customer_price numeric NOT NULL,
    base_driver_price numeric NOT NULL,
    departure_inspection jsonb,
    arrival_inspection jsonb,
    status public.mission_status DEFAULT 'en_attente'::public.mission_status,
    customer_id uuid NOT NULL,
    driver_id uuid,
    vehicle_notes text,
    w_garage boolean DEFAULT false,
    payment_intent_id text,
    payment_status text DEFAULT 'pending'::text,
    distance_mission numeric DEFAULT 0 NOT NULL,
    mission_type public.mission_type DEFAULT 'transfert'::public.mission_type NOT NULL,
    fuel_management public.fuel_management_type DEFAULT 'pas_de_remise'::public.fuel_management_type NOT NULL,
    estimated_travel_time integer,
    pickup_datetime timestamp with time zone,
    delivery_datetime timestamp with time zone,
    missionstatusdriver public.missionstatusdriver,
    document_management boolean DEFAULT false NOT NULL,
    electric_vehicle boolean DEFAULT false NOT NULL,
    vehicle_brand uuid,
    vehicle_model uuid,
    estimated_travel_price numeric DEFAULT 0,
    estimated_margin numeric DEFAULT 0,
    final_driver_price numeric DEFAULT 0,
    reserved_driver_price numeric,
    linked_mission_id uuid,
    is_return_mission boolean DEFAULT false NOT NULL,
    departure_place_name text,
    departure_place_id text,
    arrival_place_name text,
    arrival_place_id text,
    business_invoice_id uuid,
    group_order_id uuid,
    group_order_item_id uuid,
    departure_inspection_id uuid,
    arrival_inspection_id uuid,
    departure_city_display text,
    arrival_city_display text,
    feesdriver numeric DEFAULT 0,
    is_group_order boolean DEFAULT false,
    CONSTRAINT valid_dates CHECK ((delivery_deadline > availability_start))
);


ALTER TABLE public.missions OWNER TO postgres;

--
-- TOC entry 5683 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.status IS 'Statut de la mission côté client (particuliers et professionnels)';


--
-- TOC entry 5684 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.distance_mission; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.distance_mission IS 'Distance en kilomètres entre l''adresse de départ et l''adresse d''arrivée';


--
-- TOC entry 5685 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.estimated_travel_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.estimated_travel_time IS 'Temps de trajet estimé en minutes';


--
-- TOC entry 5686 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.missionstatusdriver; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.missionstatusdriver IS 'Statut de la mission côté driver - null jusqu''à acceptation par le driver';


--
-- TOC entry 5687 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.reserved_driver_price; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.reserved_driver_price IS 'Prix final réservé pour le convoyeur au moment de la réservation de la mission. NULL si la mission n''est pas réservée.';


--
-- TOC entry 5688 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.departure_city_display; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.departure_city_display IS 'Cached enriched city name for departure address (e.g., "Paris", "Lyon (Est)")';


--
-- TOC entry 5689 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.arrival_city_display; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.arrival_city_display IS 'Cached enriched city name for arrival address (e.g., "Paris", "Lyon (Est)")';


--
-- TOC entry 5690 (class 0 OID 0)
-- Dependencies: 304
-- Name: COLUMN missions.feesdriver; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.missions.feesdriver IS 'Montant total des frais de route remboursés au convoyeur (carburant + péage)';


--
-- TOC entry 372 (class 1259 OID 96500)
-- Name: penalty_allowance_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.penalty_allowance_documents (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reference_type text NOT NULL,
    reference_id uuid NOT NULL,
    document_url text NOT NULL,
    document_name text NOT NULL,
    uploaded_by uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    CONSTRAINT penalty_allowance_documents_reference_type_check CHECK ((reference_type = ANY (ARRAY['penalty'::text, 'allowance'::text])))
);


ALTER TABLE public.penalty_allowance_documents OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 17795)
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    user_type public.user_type NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    driver_status public.driver_status DEFAULT 'inactive'::public.driver_status,
    w_garage boolean DEFAULT false,
    plateau boolean DEFAULT false,
    profile_picture_url text,
    drivers_license_number text,
    drivers_license_issue_city text,
    drivers_license_issue_date date,
    drivers_license_front_url text,
    drivers_license_back_url text,
    w_garage_certificate_url text,
    truck_registration_url text,
    bank_account_holder text,
    bank_iban text,
    bank_bic text,
    date_of_birth date,
    company_type text,
    siren text,
    company_creation_date date,
    kbis_doc_url text,
    fiscal_attestation_url text,
    main_region text,
    main_department text,
    intro_video_url text,
    situation_video_url text,
    postal_address text,
    address text,
    postal_code text,
    city text,
    payment_method_id text,
    card_last_four character varying(4),
    card_expiry character varying(5),
    cardholder_name character varying(255),
    company_name text,
    "position" text,
    phone text,
    frequency text,
    company_logo_url text,
    allow_mission_overlap boolean DEFAULT false,
    rc_pro_url text,
    circulation_insurance_url text,
    number_of_handover integer DEFAULT 0,
    number_of_management integer DEFAULT 0,
    seniority integer DEFAULT 0,
    account_status public.account_status DEFAULT 'confirmé'::public.account_status,
    business_group_id uuid,
    is_group_leader boolean DEFAULT false NOT NULL,
    is_suspended boolean DEFAULT false NOT NULL,
    invited_by uuid,
    gender text,
    rejection_reason text,
    CONSTRAINT profiles_gender_check CHECK ((gender = ANY (ARRAY['homme'::text, 'femme'::text])))
);

ALTER TABLE ONLY public.profiles REPLICA IDENTITY FULL;


ALTER TABLE public.profiles OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 56515)
-- Name: return_mission_pricing_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.return_mission_pricing_config (
    id integer DEFAULT 1 NOT NULL,
    discount_percentage numeric DEFAULT 50 NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT check_single_row CHECK ((id = 1)),
    CONSTRAINT check_valid_percentage CHECK (((discount_percentage >= (0)::numeric) AND (discount_percentage <= (100)::numeric)))
);


ALTER TABLE public.return_mission_pricing_config OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 17805)
-- Name: stripe_config; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.stripe_config AS
 SELECT current_setting('app.settings.stripe_publishable_key'::text, true) AS publishable_key;


ALTER VIEW public.stripe_config OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 51724)
-- Name: travel_pricing_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.travel_pricing_config (
    id integer DEFAULT 1 NOT NULL,
    petrolprice numeric DEFAULT 2 NOT NULL,
    tollclass1 numeric DEFAULT 0.105 NOT NULL,
    tollclass2 numeric DEFAULT 0.165 NOT NULL,
    tollclass3 numeric DEFAULT 0.205 NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT single_config_row CHECK ((id = 1))
);


ALTER TABLE public.travel_pricing_config OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 49430)
-- Name: vehicle_brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_brands (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    logo_url text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now())
);


ALTER TABLE public.vehicle_brands OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 51740)
-- Name: vehicle_consumption; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_consumption (
    id integer NOT NULL,
    vehicle_type public.vehicle_type NOT NULL,
    consumption numeric NOT NULL,
    tollclass integer NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT vehicle_consumption_tollclass_check CHECK ((tollclass = ANY (ARRAY[1, 2, 3])))
);


ALTER TABLE public.vehicle_consumption OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 51739)
-- Name: vehicle_consumption_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehicle_consumption_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vehicle_consumption_id_seq OWNER TO postgres;

--
-- TOC entry 5699 (class 0 OID 0)
-- Dependencies: 330
-- Name: vehicle_consumption_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehicle_consumption_id_seq OWNED BY public.vehicle_consumption.id;


--
-- TOC entry 327 (class 1259 OID 49442)
-- Name: vehicle_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehicle_models (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    brand_id uuid,
    name text NOT NULL,
    image_url text,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()),
    vehicle_type public.vehicle_type,
    is_electric boolean DEFAULT false NOT NULL
);


ALTER TABLE public.vehicle_models OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 17809)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 367 (class 1259 OID 96380)
-- Name: messages_2025_11_09; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_11_09 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_11_09 OWNER TO supabase_admin;

--
-- TOC entry 368 (class 1259 OID 96392)
-- Name: messages_2025_11_10; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_11_10 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_11_10 OWNER TO supabase_admin;

--
-- TOC entry 369 (class 1259 OID 96457)
-- Name: messages_2025_11_11; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_11_11 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_11_11 OWNER TO supabase_admin;

--
-- TOC entry 370 (class 1259 OID 96474)
-- Name: messages_2025_11_12; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_11_12 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_11_12 OWNER TO supabase_admin;

--
-- TOC entry 371 (class 1259 OID 96488)
-- Name: messages_2025_11_13; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_11_13 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_11_13 OWNER TO supabase_admin;

--
-- TOC entry 373 (class 1259 OID 96526)
-- Name: messages_2025_11_14; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_11_14 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_11_14 OWNER TO supabase_admin;

--
-- TOC entry 374 (class 1259 OID 97664)
-- Name: messages_2025_11_15; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_11_15 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_11_15 OWNER TO supabase_admin;

--
-- TOC entry 308 (class 1259 OID 17816)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 309 (class 1259 OID 17819)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 310 (class 1259 OID 17827)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 311 (class 1259 OID 17828)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 5713 (class 0 OID 0)
-- Dependencies: 311
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 320 (class 1259 OID 28250)
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets_analytics (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.buckets_analytics OWNER TO supabase_storage_admin;

--
-- TOC entry 312 (class 1259 OID 17837)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 313 (class 1259 OID 17841)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 5716 (class 0 OID 0)
-- Dependencies: 313
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 319 (class 1259 OID 28205)
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- TOC entry 314 (class 1259 OID 17851)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 315 (class 1259 OID 17858)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 318 (class 1259 OID 28193)
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text,
    created_by text,
    idempotency_key text,
    rollback text[]
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- TOC entry 4149 (class 0 OID 0)
-- Name: messages_2025_11_09; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_09 FOR VALUES FROM ('2025-11-09 00:00:00') TO ('2025-11-10 00:00:00');


--
-- TOC entry 4150 (class 0 OID 0)
-- Name: messages_2025_11_10; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_10 FOR VALUES FROM ('2025-11-10 00:00:00') TO ('2025-11-11 00:00:00');


--
-- TOC entry 4151 (class 0 OID 0)
-- Name: messages_2025_11_11; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_11 FOR VALUES FROM ('2025-11-11 00:00:00') TO ('2025-11-12 00:00:00');


--
-- TOC entry 4152 (class 0 OID 0)
-- Name: messages_2025_11_12; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_12 FOR VALUES FROM ('2025-11-12 00:00:00') TO ('2025-11-13 00:00:00');


--
-- TOC entry 4153 (class 0 OID 0)
-- Name: messages_2025_11_13; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_13 FOR VALUES FROM ('2025-11-13 00:00:00') TO ('2025-11-14 00:00:00');


--
-- TOC entry 4154 (class 0 OID 0)
-- Name: messages_2025_11_14; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_14 FOR VALUES FROM ('2025-11-14 00:00:00') TO ('2025-11-15 00:00:00');


--
-- TOC entry 4155 (class 0 OID 0)
-- Name: messages_2025_11_15; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_11_15 FOR VALUES FROM ('2025-11-15 00:00:00') TO ('2025-11-16 00:00:00');


--
-- TOC entry 4172 (class 2604 OID 17866)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 4182 (class 2604 OID 17867)
-- Name: driver_pricing_rules id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_pricing_rules ALTER COLUMN id SET DEFAULT nextval('public.driver_pricing_rules_id_seq'::regclass);


--
-- TOC entry 4185 (class 2604 OID 17868)
-- Name: mission_options id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_options ALTER COLUMN id SET DEFAULT nextval('public.mission_options_id_seq'::regclass);


--
-- TOC entry 4305 (class 2604 OID 51743)
-- Name: vehicle_consumption id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_consumption ALTER COLUMN id SET DEFAULT nextval('public.vehicle_consumption_id_seq'::regclass);


--
-- TOC entry 4558 (class 2606 OID 17871)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 4542 (class 2606 OID 17873)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 4546 (class 2606 OID 17875)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 4551 (class 2606 OID 17877)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 4553 (class 2606 OID 17879)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 4556 (class 2606 OID 17881)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 4560 (class 2606 OID 17883)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 4563 (class 2606 OID 17885)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 4566 (class 2606 OID 17887)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 4568 (class 2606 OID 17889)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 4801 (class 2606 OID 72558)
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- TOC entry 4803 (class 2606 OID 72556)
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- TOC entry 4805 (class 2606 OID 72554)
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- TOC entry 4682 (class 2606 OID 27082)
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 72580)
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- TOC entry 4811 (class 2606 OID 72582)
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- TOC entry 4573 (class 2606 OID 17891)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4581 (class 2606 OID 17893)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 4584 (class 2606 OID 17895)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 4587 (class 2606 OID 17897)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 4589 (class 2606 OID 17899)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4594 (class 2606 OID 17901)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 4597 (class 2606 OID 17903)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4601 (class 2606 OID 17905)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4606 (class 2606 OID 17907)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 4609 (class 2606 OID 17909)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 4622 (class 2606 OID 17911)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 4624 (class 2606 OID 17913)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4705 (class 2606 OID 49425)
-- Name: admin_settings admin_settings_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_settings
    ADD CONSTRAINT admin_settings_key_key UNIQUE (key);


--
-- TOC entry 4707 (class 2606 OID 49423)
-- Name: admin_settings admin_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_settings
    ADD CONSTRAINT admin_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 4735 (class 2606 OID 54104)
-- Name: billing_periods_config billing_periods_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing_periods_config
    ADD CONSTRAINT billing_periods_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4762 (class 2606 OID 66637)
-- Name: business_groups business_groups_leader_account_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_groups
    ADD CONSTRAINT business_groups_leader_account_id_key UNIQUE (leader_account_id);


--
-- TOC entry 4764 (class 2606 OID 66635)
-- Name: business_groups business_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_groups
    ADD CONSTRAINT business_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4767 (class 2606 OID 66658)
-- Name: business_invitations business_invitations_business_group_id_invited_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invitations
    ADD CONSTRAINT business_invitations_business_group_id_invited_email_key UNIQUE (business_group_id, invited_email);


--
-- TOC entry 4769 (class 2606 OID 66656)
-- Name: business_invitations business_invitations_invitation_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invitations
    ADD CONSTRAINT business_invitations_invitation_token_key UNIQUE (invitation_token);


--
-- TOC entry 4771 (class 2606 OID 66654)
-- Name: business_invitations business_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invitations
    ADD CONSTRAINT business_invitations_pkey PRIMARY KEY (id);


--
-- TOC entry 4749 (class 2606 OID 64342)
-- Name: business_invoices business_invoices_invoice_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invoices
    ADD CONSTRAINT business_invoices_invoice_number_key UNIQUE (invoice_number);


--
-- TOC entry 4751 (class 2606 OID 64340)
-- Name: business_invoices business_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invoices
    ADD CONSTRAINT business_invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 4699 (class 2606 OID 46017)
-- Name: certification_questions certification_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_questions
    ADD CONSTRAINT certification_questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4695 (class 2606 OID 46007)
-- Name: certifications certifications_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_code_key UNIQUE (code);


--
-- TOC entry 4697 (class 2606 OID 46005)
-- Name: certifications certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certifications
    ADD CONSTRAINT certifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4733 (class 2606 OID 52969)
-- Name: coefficient_config coefficient_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coefficient_config
    ADD CONSTRAINT coefficient_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4757 (class 2606 OID 64361)
-- Name: credit_notes credit_notes_credit_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_credit_number_key UNIQUE (credit_number);


--
-- TOC entry 4759 (class 2606 OID 64359)
-- Name: credit_notes credit_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_pkey PRIMARY KEY (id);


--
-- TOC entry 4729 (class 2606 OID 52954)
-- Name: customer_coefficients customer_coefficients_customer_id_month_year_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_coefficients
    ADD CONSTRAINT customer_coefficients_customer_id_month_year_key UNIQUE (customer_id, month, year);


--
-- TOC entry 4731 (class 2606 OID 52952)
-- Name: customer_coefficients customer_coefficients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_coefficients
    ADD CONSTRAINT customer_coefficients_pkey PRIMARY KEY (id);


--
-- TOC entry 4814 (class 2606 OID 86027)
-- Name: customer_penalties customer_penalties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_penalties
    ADD CONSTRAINT customer_penalties_pkey PRIMARY KEY (id);


--
-- TOC entry 4835 (class 2606 OID 95088)
-- Name: document_style_config document_style_config_document_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_style_config
    ADD CONSTRAINT document_style_config_document_type_key UNIQUE (document_type);


--
-- TOC entry 4837 (class 2606 OID 95086)
-- Name: document_style_config document_style_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_style_config
    ADD CONSTRAINT document_style_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4829 (class 2606 OID 92819)
-- Name: document_templates document_templates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_templates
    ADD CONSTRAINT document_templates_pkey PRIMARY KEY (id);


--
-- TOC entry 4693 (class 2606 OID 43772)
-- Name: driver_alerts driver_alerts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_alerts
    ADD CONSTRAINT driver_alerts_pkey PRIMARY KEY (id);


--
-- TOC entry 4824 (class 2606 OID 92763)
-- Name: driver_allowances driver_allowances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_allowances
    ADD CONSTRAINT driver_allowances_pkey PRIMARY KEY (id);


--
-- TOC entry 4701 (class 2606 OID 46033)
-- Name: driver_certifications driver_certifications_driver_id_certification_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_certifications
    ADD CONSTRAINT driver_certifications_driver_id_certification_id_key UNIQUE (driver_id, certification_id);


--
-- TOC entry 4703 (class 2606 OID 46031)
-- Name: driver_certifications driver_certifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_certifications
    ADD CONSTRAINT driver_certifications_pkey PRIMARY KEY (id);


--
-- TOC entry 4737 (class 2606 OID 54121)
-- Name: driver_invoices driver_invoices_driver_id_period_start_period_end_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_invoices
    ADD CONSTRAINT driver_invoices_driver_id_period_start_period_end_key UNIQUE (driver_id, period_start, period_end);


--
-- TOC entry 4739 (class 2606 OID 54119)
-- Name: driver_invoices driver_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_invoices
    ADD CONSTRAINT driver_invoices_pkey PRIMARY KEY (id);


--
-- TOC entry 4794 (class 2606 OID 70271)
-- Name: driver_penalties driver_penalties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_penalties
    ADD CONSTRAINT driver_penalties_pkey PRIMARY KEY (id);


--
-- TOC entry 4792 (class 2606 OID 70241)
-- Name: driver_penalty_config driver_penalty_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_penalty_config
    ADD CONSTRAINT driver_penalty_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4719 (class 2606 OID 51716)
-- Name: driver_pricing_coefficients driver_pricing_coefficients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_pricing_coefficients
    ADD CONSTRAINT driver_pricing_coefficients_pkey PRIMARY KEY (id);


--
-- TOC entry 4626 (class 2606 OID 17915)
-- Name: driver_pricing_rules driver_pricing_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_pricing_rules
    ADD CONSTRAINT driver_pricing_rules_pkey PRIMARY KEY (id);


--
-- TOC entry 4779 (class 2606 OID 66768)
-- Name: group_order_items group_order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_order_items
    ADD CONSTRAINT group_order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4775 (class 2606 OID 66744)
-- Name: group_orders group_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_orders
    ADD CONSTRAINT group_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 67967)
-- Name: inspection_photos inspection_photos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection_photos
    ADD CONSTRAINT inspection_photos_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 67953)
-- Name: inspection_reports inspection_reports_mission_id_inspection_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection_reports
    ADD CONSTRAINT inspection_reports_mission_id_inspection_type_key UNIQUE (mission_id, inspection_type);


--
-- TOC entry 4786 (class 2606 OID 67951)
-- Name: inspection_reports inspection_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection_reports
    ADD CONSTRAINT inspection_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4833 (class 2606 OID 95060)
-- Name: invoice_style_config invoice_style_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.invoice_style_config
    ADD CONSTRAINT invoice_style_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4727 (class 2606 OID 51774)
-- Name: margin_config margin_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.margin_config
    ADD CONSTRAINT margin_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4628 (class 2606 OID 17917)
-- Name: mission_options mission_options_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_options
    ADD CONSTRAINT mission_options_code_key UNIQUE (code);


--
-- TOC entry 4630 (class 2606 OID 17919)
-- Name: mission_options mission_options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_options
    ADD CONSTRAINT mission_options_pkey PRIMARY KEY (id);


--
-- TOC entry 4822 (class 2606 OID 86076)
-- Name: mission_reports mission_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_reports
    ADD CONSTRAINT mission_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4643 (class 2606 OID 17921)
-- Name: missions missions_mission_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_mission_number_key UNIQUE (mission_number);


--
-- TOC entry 4645 (class 2606 OID 17923)
-- Name: missions missions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_pkey PRIMARY KEY (id);


--
-- TOC entry 4854 (class 2606 OID 96510)
-- Name: penalty_allowance_documents penalty_allowance_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.penalty_allowance_documents
    ADD CONSTRAINT penalty_allowance_documents_pkey PRIMARY KEY (id);


--
-- TOC entry 4650 (class 2606 OID 17929)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4747 (class 2606 OID 56527)
-- Name: return_mission_pricing_config return_mission_pricing_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.return_mission_pricing_config
    ADD CONSTRAINT return_mission_pricing_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4721 (class 2606 OID 51738)
-- Name: travel_pricing_config travel_pricing_config_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.travel_pricing_config
    ADD CONSTRAINT travel_pricing_config_pkey PRIMARY KEY (id);


--
-- TOC entry 4709 (class 2606 OID 49441)
-- Name: vehicle_brands vehicle_brands_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_brands
    ADD CONSTRAINT vehicle_brands_name_key UNIQUE (name);


--
-- TOC entry 4711 (class 2606 OID 49439)
-- Name: vehicle_brands vehicle_brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_brands
    ADD CONSTRAINT vehicle_brands_pkey PRIMARY KEY (id);


--
-- TOC entry 4723 (class 2606 OID 51750)
-- Name: vehicle_consumption vehicle_consumption_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_consumption
    ADD CONSTRAINT vehicle_consumption_pkey PRIMARY KEY (id);


--
-- TOC entry 4725 (class 2606 OID 51752)
-- Name: vehicle_consumption vehicle_consumption_vehicle_type_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_consumption
    ADD CONSTRAINT vehicle_consumption_vehicle_type_key UNIQUE (vehicle_type);


--
-- TOC entry 4715 (class 2606 OID 49453)
-- Name: vehicle_models vehicle_models_brand_id_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_models
    ADD CONSTRAINT vehicle_models_brand_id_name_key UNIQUE (brand_id, name);


--
-- TOC entry 4717 (class 2606 OID 49451)
-- Name: vehicle_models vehicle_models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_models
    ADD CONSTRAINT vehicle_models_pkey PRIMARY KEY (id);


--
-- TOC entry 4653 (class 2606 OID 17931)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4840 (class 2606 OID 96388)
-- Name: messages_2025_11_09 messages_2025_11_09_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_11_09
    ADD CONSTRAINT messages_2025_11_09_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4843 (class 2606 OID 96400)
-- Name: messages_2025_11_10 messages_2025_11_10_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_11_10
    ADD CONSTRAINT messages_2025_11_10_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4846 (class 2606 OID 96465)
-- Name: messages_2025_11_11 messages_2025_11_11_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_11_11
    ADD CONSTRAINT messages_2025_11_11_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4849 (class 2606 OID 96482)
-- Name: messages_2025_11_12 messages_2025_11_12_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_11_12
    ADD CONSTRAINT messages_2025_11_12_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4852 (class 2606 OID 96496)
-- Name: messages_2025_11_13 messages_2025_11_13_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_11_13
    ADD CONSTRAINT messages_2025_11_13_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4857 (class 2606 OID 96534)
-- Name: messages_2025_11_14 messages_2025_11_14_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_11_14
    ADD CONSTRAINT messages_2025_11_14_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4860 (class 2606 OID 97672)
-- Name: messages_2025_11_15 messages_2025_11_15_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_11_15
    ADD CONSTRAINT messages_2025_11_15_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 4658 (class 2606 OID 17933)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 4655 (class 2606 OID 17935)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4691 (class 2606 OID 28260)
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- TOC entry 4662 (class 2606 OID 17937)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 4664 (class 2606 OID 17939)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 4666 (class 2606 OID 17941)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4674 (class 2606 OID 17943)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 4689 (class 2606 OID 28214)
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- TOC entry 4679 (class 2606 OID 17945)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 4677 (class 2606 OID 17947)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 4684 (class 2606 OID 28201)
-- Name: schema_migrations schema_migrations_idempotency_key_key; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_idempotency_key_key UNIQUE (idempotency_key);


--
-- TOC entry 4686 (class 2606 OID 28199)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 4543 (class 1259 OID 17948)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 4612 (class 1259 OID 17949)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4613 (class 1259 OID 17950)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4614 (class 1259 OID 17951)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4564 (class 1259 OID 17952)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 4544 (class 1259 OID 17953)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 4549 (class 1259 OID 17954)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 5726 (class 0 OID 0)
-- Dependencies: 4549
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 4554 (class 1259 OID 17955)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 4547 (class 1259 OID 17956)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 4548 (class 1259 OID 17957)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 4561 (class 1259 OID 17958)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 4569 (class 1259 OID 17959)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 4570 (class 1259 OID 17960)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 4799 (class 1259 OID 72569)
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- TOC entry 4680 (class 1259 OID 27086)
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- TOC entry 4806 (class 1259 OID 72595)
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4807 (class 1259 OID 72593)
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- TOC entry 4812 (class 1259 OID 72594)
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- TOC entry 4574 (class 1259 OID 17961)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 4575 (class 1259 OID 17962)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 4576 (class 1259 OID 17963)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 4615 (class 1259 OID 17964)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4616 (class 1259 OID 17965)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 4577 (class 1259 OID 17966)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 4578 (class 1259 OID 17967)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 4579 (class 1259 OID 17968)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 4582 (class 1259 OID 17969)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 4585 (class 1259 OID 17970)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 4590 (class 1259 OID 17971)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 4591 (class 1259 OID 17972)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 4592 (class 1259 OID 17973)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 4595 (class 1259 OID 17974)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 4598 (class 1259 OID 17975)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 4599 (class 1259 OID 72607)
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- TOC entry 4602 (class 1259 OID 17976)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 4604 (class 1259 OID 17977)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 4607 (class 1259 OID 17978)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 4610 (class 1259 OID 17979)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 4611 (class 1259 OID 27064)
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- TOC entry 4571 (class 1259 OID 17980)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 4603 (class 1259 OID 17981)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 4617 (class 1259 OID 17982)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 5727 (class 0 OID 0)
-- Dependencies: 4617
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 4618 (class 1259 OID 17983)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 4619 (class 1259 OID 17984)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 4620 (class 1259 OID 17985)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 4765 (class 1259 OID 66686)
-- Name: idx_business_groups_leader; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_business_groups_leader ON public.business_groups USING btree (leader_account_id);


--
-- TOC entry 4772 (class 1259 OID 66689)
-- Name: idx_business_invitations_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_business_invitations_email ON public.business_invitations USING btree (invited_email);


--
-- TOC entry 4773 (class 1259 OID 66688)
-- Name: idx_business_invitations_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_business_invitations_group ON public.business_invitations USING btree (business_group_id);


--
-- TOC entry 4752 (class 1259 OID 64382)
-- Name: idx_business_invoices_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_business_invoices_customer ON public.business_invoices USING btree (customer_id);


--
-- TOC entry 4753 (class 1259 OID 66690)
-- Name: idx_business_invoices_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_business_invoices_group ON public.business_invoices USING btree (business_group_id);


--
-- TOC entry 4754 (class 1259 OID 64384)
-- Name: idx_business_invoices_period; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_business_invoices_period ON public.business_invoices USING btree (period_start, period_end);


--
-- TOC entry 4755 (class 1259 OID 64383)
-- Name: idx_business_invoices_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_business_invoices_status ON public.business_invoices USING btree (status);


--
-- TOC entry 4760 (class 1259 OID 64385)
-- Name: idx_credit_notes_invoice; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_credit_notes_invoice ON public.credit_notes USING btree (business_invoice_id);


--
-- TOC entry 4815 (class 1259 OID 86055)
-- Name: idx_customer_penalties_business_invoice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_penalties_business_invoice_id ON public.customer_penalties USING btree (business_invoice_id);


--
-- TOC entry 4816 (class 1259 OID 86053)
-- Name: idx_customer_penalties_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_penalties_customer_id ON public.customer_penalties USING btree (customer_id);


--
-- TOC entry 4817 (class 1259 OID 86054)
-- Name: idx_customer_penalties_mission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_penalties_mission_id ON public.customer_penalties USING btree (mission_id);


--
-- TOC entry 4818 (class 1259 OID 86056)
-- Name: idx_customer_penalties_penalty_invoice_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_customer_penalties_penalty_invoice_id ON public.customer_penalties USING btree (penalty_invoice_id);


--
-- TOC entry 4830 (class 1259 OID 92826)
-- Name: idx_document_templates_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_document_templates_active ON public.document_templates USING btree (document_type, is_active);


--
-- TOC entry 4831 (class 1259 OID 92825)
-- Name: idx_document_templates_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_document_templates_type ON public.document_templates USING btree (document_type);


--
-- TOC entry 4825 (class 1259 OID 92781)
-- Name: idx_driver_allowances_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_allowances_created_at ON public.driver_allowances USING btree (created_at);


--
-- TOC entry 4826 (class 1259 OID 92779)
-- Name: idx_driver_allowances_driver_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_allowances_driver_id ON public.driver_allowances USING btree (driver_id);


--
-- TOC entry 4827 (class 1259 OID 92780)
-- Name: idx_driver_allowances_mission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_allowances_mission_id ON public.driver_allowances USING btree (mission_id);


--
-- TOC entry 4795 (class 1259 OID 70288)
-- Name: idx_driver_penalties_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_penalties_created_at ON public.driver_penalties USING btree (created_at);


--
-- TOC entry 4796 (class 1259 OID 70287)
-- Name: idx_driver_penalties_driver_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_penalties_driver_id ON public.driver_penalties USING btree (driver_id);


--
-- TOC entry 4797 (class 1259 OID 70289)
-- Name: idx_driver_penalties_period; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_penalties_period ON public.driver_penalties USING btree (driver_id, created_at);


--
-- TOC entry 4798 (class 1259 OID 70290)
-- Name: idx_driver_penalties_source; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_driver_penalties_source ON public.driver_penalties USING btree (penalty_source);


--
-- TOC entry 4780 (class 1259 OID 66801)
-- Name: idx_group_order_items_group_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_order_items_group_order ON public.group_order_items USING btree (group_order_id);


--
-- TOC entry 4781 (class 1259 OID 66802)
-- Name: idx_group_order_items_mission; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_order_items_mission ON public.group_order_items USING btree (mission_id);


--
-- TOC entry 4776 (class 1259 OID 66799)
-- Name: idx_group_orders_customer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_orders_customer ON public.group_orders USING btree (customer_id);


--
-- TOC entry 4777 (class 1259 OID 66800)
-- Name: idx_group_orders_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_orders_status ON public.group_orders USING btree (status);


--
-- TOC entry 4787 (class 1259 OID 68006)
-- Name: idx_inspection_photos_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inspection_photos_order ON public.inspection_photos USING btree (inspection_report_id, order_index);


--
-- TOC entry 4788 (class 1259 OID 68005)
-- Name: idx_inspection_photos_report_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inspection_photos_report_id ON public.inspection_photos USING btree (inspection_report_id);


--
-- TOC entry 4782 (class 1259 OID 68004)
-- Name: idx_inspection_reports_mission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inspection_reports_mission_id ON public.inspection_reports USING btree (mission_id);


--
-- TOC entry 4819 (class 1259 OID 86096)
-- Name: idx_mission_reports_created_by; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mission_reports_created_by ON public.mission_reports USING btree (created_by);


--
-- TOC entry 4820 (class 1259 OID 86095)
-- Name: idx_mission_reports_mission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_mission_reports_mission_id ON public.mission_reports USING btree (mission_id);


--
-- TOC entry 4631 (class 1259 OID 17986)
-- Name: idx_missions_customer_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_customer_id ON public.missions USING btree (customer_id);


--
-- TOC entry 4632 (class 1259 OID 17987)
-- Name: idx_missions_driver_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_driver_id ON public.missions USING btree (driver_id);


--
-- TOC entry 4633 (class 1259 OID 66803)
-- Name: idx_missions_group_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_group_order ON public.missions USING btree (group_order_id);


--
-- TOC entry 4634 (class 1259 OID 96445)
-- Name: idx_missions_group_order_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_group_order_id ON public.missions USING btree (group_order_id);


--
-- TOC entry 4635 (class 1259 OID 66804)
-- Name: idx_missions_group_order_item; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_group_order_item ON public.missions USING btree (group_order_item_id);


--
-- TOC entry 4636 (class 1259 OID 96471)
-- Name: idx_missions_group_order_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_group_order_status ON public.missions USING btree (group_order_id, status) WHERE (status = 'recherche_driver'::public.mission_status);


--
-- TOC entry 4637 (class 1259 OID 64386)
-- Name: idx_missions_invoice; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_invoice ON public.missions USING btree (business_invoice_id);


--
-- TOC entry 4638 (class 1259 OID 96446)
-- Name: idx_missions_is_group_order; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_is_group_order ON public.missions USING btree (is_group_order);


--
-- TOC entry 4639 (class 1259 OID 56506)
-- Name: idx_missions_linked_mission_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_linked_mission_id ON public.missions USING btree (linked_mission_id);


--
-- TOC entry 4640 (class 1259 OID 64387)
-- Name: idx_missions_payment_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_payment_status ON public.missions USING btree (payment_status);


--
-- TOC entry 4641 (class 1259 OID 17988)
-- Name: idx_missions_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_missions_status ON public.missions USING btree (status);


--
-- TOC entry 4646 (class 1259 OID 64294)
-- Name: idx_profiles_account_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_account_status ON public.profiles USING btree (account_status) WHERE (user_type = 'customer_business'::public.user_type);


--
-- TOC entry 4647 (class 1259 OID 66687)
-- Name: idx_profiles_business_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_business_group ON public.profiles USING btree (business_group_id);


--
-- TOC entry 4648 (class 1259 OID 96332)
-- Name: idx_profiles_driver_status_gender; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profiles_driver_status_gender ON public.profiles USING btree (driver_status, gender) WHERE (user_type = 'driver'::public.user_type);


--
-- TOC entry 4712 (class 1259 OID 96219)
-- Name: idx_vehicle_models_is_electric; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vehicle_models_is_electric ON public.vehicle_models USING btree (is_electric);


--
-- TOC entry 4713 (class 1259 OID 96218)
-- Name: idx_vehicle_models_vehicle_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_vehicle_models_vehicle_type ON public.vehicle_models USING btree (vehicle_type);


--
-- TOC entry 4656 (class 1259 OID 17989)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 4651 (class 1259 OID 58755)
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4838 (class 1259 OID 96389)
-- Name: messages_2025_11_09_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2025_11_09_inserted_at_topic_idx ON realtime.messages_2025_11_09 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4841 (class 1259 OID 96401)
-- Name: messages_2025_11_10_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2025_11_10_inserted_at_topic_idx ON realtime.messages_2025_11_10 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4844 (class 1259 OID 96466)
-- Name: messages_2025_11_11_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2025_11_11_inserted_at_topic_idx ON realtime.messages_2025_11_11 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4847 (class 1259 OID 96483)
-- Name: messages_2025_11_12_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2025_11_12_inserted_at_topic_idx ON realtime.messages_2025_11_12 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4850 (class 1259 OID 96497)
-- Name: messages_2025_11_13_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2025_11_13_inserted_at_topic_idx ON realtime.messages_2025_11_13 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4855 (class 1259 OID 96535)
-- Name: messages_2025_11_14_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2025_11_14_inserted_at_topic_idx ON realtime.messages_2025_11_14 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4858 (class 1259 OID 97673)
-- Name: messages_2025_11_15_inserted_at_topic_idx; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX messages_2025_11_15_inserted_at_topic_idx ON realtime.messages_2025_11_15 USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- TOC entry 4659 (class 1259 OID 17990)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 4660 (class 1259 OID 17991)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 4667 (class 1259 OID 17992)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 4675 (class 1259 OID 17993)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 4668 (class 1259 OID 28232)
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- TOC entry 4669 (class 1259 OID 17994)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 4670 (class 1259 OID 28234)
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- TOC entry 4687 (class 1259 OID 28235)
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- TOC entry 4671 (class 1259 OID 17995)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 4672 (class 1259 OID 28233)
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- TOC entry 4861 (class 0 OID 0)
-- Name: messages_2025_11_09_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_09_inserted_at_topic_idx;


--
-- TOC entry 4862 (class 0 OID 0)
-- Name: messages_2025_11_09_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_09_pkey;


--
-- TOC entry 4863 (class 0 OID 0)
-- Name: messages_2025_11_10_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_10_inserted_at_topic_idx;


--
-- TOC entry 4864 (class 0 OID 0)
-- Name: messages_2025_11_10_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_10_pkey;


--
-- TOC entry 4865 (class 0 OID 0)
-- Name: messages_2025_11_11_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_11_inserted_at_topic_idx;


--
-- TOC entry 4866 (class 0 OID 0)
-- Name: messages_2025_11_11_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_11_pkey;


--
-- TOC entry 4867 (class 0 OID 0)
-- Name: messages_2025_11_12_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_12_inserted_at_topic_idx;


--
-- TOC entry 4868 (class 0 OID 0)
-- Name: messages_2025_11_12_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_12_pkey;


--
-- TOC entry 4869 (class 0 OID 0)
-- Name: messages_2025_11_13_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_13_inserted_at_topic_idx;


--
-- TOC entry 4870 (class 0 OID 0)
-- Name: messages_2025_11_13_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_13_pkey;


--
-- TOC entry 4871 (class 0 OID 0)
-- Name: messages_2025_11_14_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_14_inserted_at_topic_idx;


--
-- TOC entry 4872 (class 0 OID 0)
-- Name: messages_2025_11_14_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_14_pkey;


--
-- TOC entry 4873 (class 0 OID 0)
-- Name: messages_2025_11_15_inserted_at_topic_idx; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_inserted_at_topic_index ATTACH PARTITION realtime.messages_2025_11_15_inserted_at_topic_idx;


--
-- TOC entry 4874 (class 0 OID 0)
-- Name: messages_2025_11_15_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_11_15_pkey;


--
-- TOC entry 4946 (class 2620 OID 96410)
-- Name: users on_auth_user_created; Type: TRIGGER; Schema: auth; Owner: supabase_auth_admin
--

CREATE TRIGGER on_auth_user_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();


--
-- TOC entry 4947 (class 2620 OID 70303)
-- Name: missions apply_driver_penalty_on_cancellation; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER apply_driver_penalty_on_cancellation AFTER UPDATE ON public.missions FOR EACH ROW EXECUTE FUNCTION public.trigger_driver_penalty_on_cancellation();


--
-- TOC entry 4948 (class 2620 OID 17997)
-- Name: missions check_driver_w_garage; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER check_driver_w_garage BEFORE INSERT OR UPDATE ON public.missions FOR EACH ROW EXECUTE FUNCTION public.validate_driver_w_garage();


--
-- TOC entry 4976 (class 2620 OID 66703)
-- Name: business_groups ensure_leader_confirmed; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ensure_leader_confirmed BEFORE INSERT OR UPDATE ON public.business_groups FOR EACH ROW EXECUTE FUNCTION public.check_leader_confirmed();


--
-- TOC entry 4953 (class 2620 OID 66705)
-- Name: profiles ensure_single_group_membership; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ensure_single_group_membership BEFORE INSERT OR UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.check_single_group_membership();


--
-- TOC entry 4977 (class 2620 OID 84895)
-- Name: business_groups trigger_sync_all_members_logo_on_group_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_sync_all_members_logo_on_group_update AFTER UPDATE ON public.business_groups FOR EACH ROW EXECUTE FUNCTION public.sync_all_members_logo_on_group_update();


--
-- TOC entry 4954 (class 2620 OID 84893)
-- Name: profiles trigger_sync_profile_logo_on_group_join; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER trigger_sync_profile_logo_on_group_join BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.sync_profile_logo_on_group_join();


--
-- TOC entry 4965 (class 2620 OID 49429)
-- Name: admin_settings update_admin_settings_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_admin_settings_updated_at BEFORE UPDATE ON public.admin_settings FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4972 (class 2620 OID 54127)
-- Name: billing_periods_config update_billing_periods_config_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_billing_periods_config_updated_at BEFORE UPDATE ON public.billing_periods_config FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4978 (class 2620 OID 66699)
-- Name: business_groups update_business_groups_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_business_groups_updated_at BEFORE UPDATE ON public.business_groups FOR EACH ROW EXECUTE FUNCTION public.update_business_groups_updated_at();


--
-- TOC entry 4979 (class 2620 OID 66701)
-- Name: business_invitations update_business_invitations_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_business_invitations_updated_at BEFORE UPDATE ON public.business_invitations FOR EACH ROW EXECUTE FUNCTION public.update_business_invitations_updated_at();


--
-- TOC entry 4974 (class 2620 OID 64389)
-- Name: business_invoices update_business_invoices_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_business_invoices_updated_at BEFORE UPDATE ON public.business_invoices FOR EACH ROW EXECUTE FUNCTION public.update_business_invoices_updated_at();


--
-- TOC entry 4971 (class 2620 OID 52982)
-- Name: coefficient_config update_coefficient_config_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_coefficient_config_updated_at BEFORE UPDATE ON public.coefficient_config FOR EACH ROW EXECUTE FUNCTION public.update_coefficient_config_updated_at();


--
-- TOC entry 4975 (class 2620 OID 64390)
-- Name: credit_notes update_credit_notes_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_credit_notes_updated_at BEFORE UPDATE ON public.credit_notes FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4970 (class 2620 OID 52980)
-- Name: customer_coefficients update_customer_coefficients_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_customer_coefficients_updated_at BEFORE UPDATE ON public.customer_coefficients FOR EACH ROW EXECUTE FUNCTION public.update_customer_coefficients_updated_at();


--
-- TOC entry 4984 (class 2620 OID 86060)
-- Name: customer_penalties update_customer_penalties_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_customer_penalties_updated_at BEFORE UPDATE ON public.customer_penalties FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4986 (class 2620 OID 95092)
-- Name: document_style_config update_document_style_config_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_document_style_config_updated_at BEFORE UPDATE ON public.document_style_config FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4963 (class 2620 OID 43779)
-- Name: driver_alerts update_driver_alerts_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_driver_alerts_updated_at BEFORE UPDATE ON public.driver_alerts FOR EACH ROW EXECUTE FUNCTION public.update_driver_alerts_updated_at();


--
-- TOC entry 4964 (class 2620 OID 46053)
-- Name: driver_certifications update_driver_certifications_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_driver_certifications_updated_at BEFORE UPDATE ON public.driver_certifications FOR EACH ROW EXECUTE FUNCTION public.update_certification_updated_at();


--
-- TOC entry 4973 (class 2620 OID 54128)
-- Name: driver_invoices update_driver_invoices_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_driver_invoices_updated_at BEFORE UPDATE ON public.driver_invoices FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4949 (class 2620 OID 54169)
-- Name: missions update_driver_mission_counts_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_driver_mission_counts_trigger AFTER UPDATE ON public.missions FOR EACH ROW EXECUTE FUNCTION public.trigger_update_driver_mission_counts();


--
-- TOC entry 4983 (class 2620 OID 70291)
-- Name: driver_penalties update_driver_penalties_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_driver_penalties_updated_at BEFORE UPDATE ON public.driver_penalties FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4982 (class 2620 OID 70242)
-- Name: driver_penalty_config update_driver_penalty_config_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_driver_penalty_config_updated_at BEFORE UPDATE ON public.driver_penalty_config FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4981 (class 2620 OID 66816)
-- Name: group_order_items update_group_order_items_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_group_order_items_updated_at BEFORE UPDATE ON public.group_order_items FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4980 (class 2620 OID 66815)
-- Name: group_orders update_group_orders_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_group_orders_updated_at BEFORE UPDATE ON public.group_orders FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4985 (class 2620 OID 86094)
-- Name: mission_reports update_mission_reports_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_mission_reports_updated_at BEFORE UPDATE ON public.mission_reports FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4950 (class 2620 OID 17998)
-- Name: missions update_missions_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_missions_updated_at BEFORE UPDATE ON public.missions FOR EACH ROW EXECUTE FUNCTION public.update_missions_updated_at();


--
-- TOC entry 4968 (class 2620 OID 51759)
-- Name: travel_pricing_config update_travel_pricing_config_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_travel_pricing_config_updated_at BEFORE UPDATE ON public.travel_pricing_config FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4966 (class 2620 OID 49463)
-- Name: vehicle_brands update_vehicle_brands_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_vehicle_brands_updated_at BEFORE UPDATE ON public.vehicle_brands FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4969 (class 2620 OID 51760)
-- Name: vehicle_consumption update_vehicle_consumption_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_vehicle_consumption_updated_at BEFORE UPDATE ON public.vehicle_consumption FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4967 (class 2620 OID 49464)
-- Name: vehicle_models update_vehicle_models_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_vehicle_models_updated_at BEFORE UPDATE ON public.vehicle_models FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 4951 (class 2620 OID 17999)
-- Name: missions validate_mission_driver; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validate_mission_driver BEFORE INSERT OR UPDATE ON public.missions FOR EACH ROW EXECUTE FUNCTION public.validate_mission_driver();


--
-- TOC entry 4952 (class 2620 OID 30481)
-- Name: missions validate_mission_status_transition_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validate_mission_status_transition_trigger BEFORE UPDATE ON public.missions FOR EACH ROW EXECUTE FUNCTION public.validate_mission_status_transition();


--
-- TOC entry 4955 (class 2620 OID 18000)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4956 (class 2620 OID 28242)
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- TOC entry 4957 (class 2620 OID 49393)
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 4958 (class 2620 OID 28228)
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- TOC entry 4959 (class 2620 OID 49392)
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- TOC entry 4961 (class 2620 OID 28238)
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- TOC entry 4962 (class 2620 OID 49394)
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 4960 (class 2620 OID 18001)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4875 (class 2606 OID 18002)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4876 (class 2606 OID 18007)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4877 (class 2606 OID 18012)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4878 (class 2606 OID 18017)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4930 (class 2606 OID 72559)
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4931 (class 2606 OID 72564)
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4932 (class 2606 OID 72588)
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4933 (class 2606 OID 72583)
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4879 (class 2606 OID 18022)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4880 (class 2606 OID 18027)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4881 (class 2606 OID 18032)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4882 (class 2606 OID 18037)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4883 (class 2606 OID 18042)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4884 (class 2606 OID 72602)
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- TOC entry 4885 (class 2606 OID 18047)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4886 (class 2606 OID 18052)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4916 (class 2606 OID 66638)
-- Name: business_groups business_groups_leader_account_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_groups
    ADD CONSTRAINT business_groups_leader_account_id_fkey FOREIGN KEY (leader_account_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4917 (class 2606 OID 66659)
-- Name: business_invitations business_invitations_business_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invitations
    ADD CONSTRAINT business_invitations_business_group_id_fkey FOREIGN KEY (business_group_id) REFERENCES public.business_groups(id) ON DELETE CASCADE;


--
-- TOC entry 4918 (class 2606 OID 66664)
-- Name: business_invitations business_invitations_invited_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invitations
    ADD CONSTRAINT business_invitations_invited_by_fkey FOREIGN KEY (invited_by) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4911 (class 2606 OID 66681)
-- Name: business_invoices business_invoices_business_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invoices
    ADD CONSTRAINT business_invoices_business_group_id_fkey FOREIGN KEY (business_group_id) REFERENCES public.business_groups(id) ON DELETE SET NULL;


--
-- TOC entry 4912 (class 2606 OID 64343)
-- Name: business_invoices business_invoices_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business_invoices
    ADD CONSTRAINT business_invoices_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4905 (class 2606 OID 46018)
-- Name: certification_questions certification_questions_certification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.certification_questions
    ADD CONSTRAINT certification_questions_certification_id_fkey FOREIGN KEY (certification_id) REFERENCES public.certifications(id) ON DELETE CASCADE;


--
-- TOC entry 4913 (class 2606 OID 64372)
-- Name: credit_notes credit_notes_applied_to_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_applied_to_invoice_id_fkey FOREIGN KEY (applied_to_invoice_id) REFERENCES public.business_invoices(id);


--
-- TOC entry 4914 (class 2606 OID 64362)
-- Name: credit_notes credit_notes_business_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_business_invoice_id_fkey FOREIGN KEY (business_invoice_id) REFERENCES public.business_invoices(id) ON DELETE CASCADE;


--
-- TOC entry 4915 (class 2606 OID 64367)
-- Name: credit_notes credit_notes_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credit_notes
    ADD CONSTRAINT credit_notes_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- TOC entry 4909 (class 2606 OID 52955)
-- Name: customer_coefficients customer_coefficients_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_coefficients
    ADD CONSTRAINT customer_coefficients_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4934 (class 2606 OID 86038)
-- Name: customer_penalties customer_penalties_business_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_penalties
    ADD CONSTRAINT customer_penalties_business_invoice_id_fkey FOREIGN KEY (business_invoice_id) REFERENCES public.business_invoices(id) ON DELETE SET NULL;


--
-- TOC entry 4935 (class 2606 OID 86048)
-- Name: customer_penalties customer_penalties_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_penalties
    ADD CONSTRAINT customer_penalties_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- TOC entry 4936 (class 2606 OID 86028)
-- Name: customer_penalties customer_penalties_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_penalties
    ADD CONSTRAINT customer_penalties_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4937 (class 2606 OID 86033)
-- Name: customer_penalties customer_penalties_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_penalties
    ADD CONSTRAINT customer_penalties_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE SET NULL;


--
-- TOC entry 4938 (class 2606 OID 86043)
-- Name: customer_penalties customer_penalties_penalty_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_penalties
    ADD CONSTRAINT customer_penalties_penalty_invoice_id_fkey FOREIGN KEY (penalty_invoice_id) REFERENCES public.business_invoices(id) ON DELETE SET NULL;


--
-- TOC entry 4944 (class 2606 OID 92820)
-- Name: document_templates document_templates_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.document_templates
    ADD CONSTRAINT document_templates_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- TOC entry 4941 (class 2606 OID 92774)
-- Name: driver_allowances driver_allowances_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_allowances
    ADD CONSTRAINT driver_allowances_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- TOC entry 4942 (class 2606 OID 92764)
-- Name: driver_allowances driver_allowances_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_allowances
    ADD CONSTRAINT driver_allowances_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4943 (class 2606 OID 92769)
-- Name: driver_allowances driver_allowances_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_allowances
    ADD CONSTRAINT driver_allowances_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE SET NULL;


--
-- TOC entry 4906 (class 2606 OID 46039)
-- Name: driver_certifications driver_certifications_certification_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_certifications
    ADD CONSTRAINT driver_certifications_certification_id_fkey FOREIGN KEY (certification_id) REFERENCES public.certifications(id) ON DELETE CASCADE;


--
-- TOC entry 4907 (class 2606 OID 46034)
-- Name: driver_certifications driver_certifications_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_certifications
    ADD CONSTRAINT driver_certifications_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4910 (class 2606 OID 92792)
-- Name: driver_invoices driver_invoices_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_invoices
    ADD CONSTRAINT driver_invoices_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4927 (class 2606 OID 70282)
-- Name: driver_penalties driver_penalties_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_penalties
    ADD CONSTRAINT driver_penalties_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id);


--
-- TOC entry 4928 (class 2606 OID 70272)
-- Name: driver_penalties driver_penalties_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_penalties
    ADD CONSTRAINT driver_penalties_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.profiles(id);


--
-- TOC entry 4929 (class 2606 OID 70277)
-- Name: driver_penalties driver_penalties_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.driver_penalties
    ADD CONSTRAINT driver_penalties_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id);


--
-- TOC entry 4921 (class 2606 OID 66769)
-- Name: group_order_items group_order_items_group_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_order_items
    ADD CONSTRAINT group_order_items_group_order_id_fkey FOREIGN KEY (group_order_id) REFERENCES public.group_orders(id) ON DELETE CASCADE;


--
-- TOC entry 4922 (class 2606 OID 66774)
-- Name: group_order_items group_order_items_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_order_items
    ADD CONSTRAINT group_order_items_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE SET NULL;


--
-- TOC entry 4923 (class 2606 OID 66779)
-- Name: group_order_items group_order_items_vehicle_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_order_items
    ADD CONSTRAINT group_order_items_vehicle_brand_fkey FOREIGN KEY (vehicle_brand) REFERENCES public.vehicle_brands(id) ON DELETE SET NULL;


--
-- TOC entry 4924 (class 2606 OID 66784)
-- Name: group_order_items group_order_items_vehicle_model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_order_items
    ADD CONSTRAINT group_order_items_vehicle_model_fkey FOREIGN KEY (vehicle_model) REFERENCES public.vehicle_models(id) ON DELETE SET NULL;


--
-- TOC entry 4919 (class 2606 OID 66750)
-- Name: group_orders group_orders_business_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_orders
    ADD CONSTRAINT group_orders_business_group_id_fkey FOREIGN KEY (business_group_id) REFERENCES public.business_groups(id) ON DELETE SET NULL;


--
-- TOC entry 4920 (class 2606 OID 66745)
-- Name: group_orders group_orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_orders
    ADD CONSTRAINT group_orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4926 (class 2606 OID 67968)
-- Name: inspection_photos inspection_photos_inspection_report_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection_photos
    ADD CONSTRAINT inspection_photos_inspection_report_id_fkey FOREIGN KEY (inspection_report_id) REFERENCES public.inspection_reports(id) ON DELETE CASCADE;


--
-- TOC entry 4925 (class 2606 OID 67954)
-- Name: inspection_reports inspection_reports_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inspection_reports
    ADD CONSTRAINT inspection_reports_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- TOC entry 4939 (class 2606 OID 86082)
-- Name: mission_reports mission_reports_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_reports
    ADD CONSTRAINT mission_reports_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4940 (class 2606 OID 86077)
-- Name: mission_reports mission_reports_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mission_reports
    ADD CONSTRAINT mission_reports_mission_id_fkey FOREIGN KEY (mission_id) REFERENCES public.missions(id) ON DELETE CASCADE;


--
-- TOC entry 4887 (class 2606 OID 67978)
-- Name: missions missions_arrival_inspection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_arrival_inspection_id_fkey FOREIGN KEY (arrival_inspection_id) REFERENCES public.inspection_reports(id);


--
-- TOC entry 4888 (class 2606 OID 64377)
-- Name: missions missions_business_invoice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_business_invoice_id_fkey FOREIGN KEY (business_invoice_id) REFERENCES public.business_invoices(id) ON DELETE SET NULL;


--
-- TOC entry 4889 (class 2606 OID 18057)
-- Name: missions missions_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.profiles(id);


--
-- TOC entry 4890 (class 2606 OID 67973)
-- Name: missions missions_departure_inspection_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_departure_inspection_id_fkey FOREIGN KEY (departure_inspection_id) REFERENCES public.inspection_reports(id);


--
-- TOC entry 4891 (class 2606 OID 18062)
-- Name: missions missions_driver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_driver_id_fkey FOREIGN KEY (driver_id) REFERENCES public.profiles(id);


--
-- TOC entry 4892 (class 2606 OID 66789)
-- Name: missions missions_group_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_group_order_id_fkey FOREIGN KEY (group_order_id) REFERENCES public.group_orders(id) ON DELETE SET NULL;


--
-- TOC entry 4893 (class 2606 OID 66794)
-- Name: missions missions_group_order_item_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_group_order_item_id_fkey FOREIGN KEY (group_order_item_id) REFERENCES public.group_order_items(id) ON DELETE SET NULL;


--
-- TOC entry 4894 (class 2606 OID 56507)
-- Name: missions missions_linked_mission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_linked_mission_id_fkey FOREIGN KEY (linked_mission_id) REFERENCES public.missions(id) ON DELETE SET NULL;


--
-- TOC entry 4895 (class 2606 OID 49465)
-- Name: missions missions_vehicle_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_vehicle_brand_fkey FOREIGN KEY (vehicle_brand) REFERENCES public.vehicle_brands(id);


--
-- TOC entry 4896 (class 2606 OID 49470)
-- Name: missions missions_vehicle_model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.missions
    ADD CONSTRAINT missions_vehicle_model_fkey FOREIGN KEY (vehicle_model) REFERENCES public.vehicle_models(id);


--
-- TOC entry 4945 (class 2606 OID 96511)
-- Name: penalty_allowance_documents penalty_allowance_documents_uploaded_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.penalty_allowance_documents
    ADD CONSTRAINT penalty_allowance_documents_uploaded_by_fkey FOREIGN KEY (uploaded_by) REFERENCES auth.users(id);


--
-- TOC entry 4897 (class 2606 OID 66671)
-- Name: profiles profiles_business_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_business_group_id_fkey FOREIGN KEY (business_group_id) REFERENCES public.business_groups(id) ON DELETE SET NULL;


--
-- TOC entry 4898 (class 2606 OID 18067)
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4899 (class 2606 OID 66676)
-- Name: profiles profiles_invited_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_invited_by_fkey FOREIGN KEY (invited_by) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- TOC entry 4908 (class 2606 OID 49454)
-- Name: vehicle_models vehicle_models_brand_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehicle_models
    ADD CONSTRAINT vehicle_models_brand_id_fkey FOREIGN KEY (brand_id) REFERENCES public.vehicle_brands(id) ON DELETE CASCADE;


--
-- TOC entry 4900 (class 2606 OID 18072)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4904 (class 2606 OID 28215)
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4901 (class 2606 OID 18077)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4902 (class 2606 OID 18082)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4903 (class 2606 OID 18087)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 5137 (class 0 OID 17652)
-- Dependencies: 282
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5138 (class 0 OID 17658)
-- Dependencies: 283
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5139 (class 0 OID 17663)
-- Dependencies: 284
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5140 (class 0 OID 17670)
-- Dependencies: 285
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5141 (class 0 OID 17675)
-- Dependencies: 286
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5142 (class 0 OID 17680)
-- Dependencies: 287
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5143 (class 0 OID 17685)
-- Dependencies: 288
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5144 (class 0 OID 17690)
-- Dependencies: 289
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5145 (class 0 OID 17698)
-- Dependencies: 290
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5146 (class 0 OID 17704)
-- Dependencies: 292
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5147 (class 0 OID 17712)
-- Dependencies: 293
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5148 (class 0 OID 17718)
-- Dependencies: 294
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5149 (class 0 OID 17721)
-- Dependencies: 295
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5150 (class 0 OID 17726)
-- Dependencies: 296
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5151 (class 0 OID 17732)
-- Dependencies: 297
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5152 (class 0 OID 17738)
-- Dependencies: 298
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5329 (class 3256 OID 67988)
-- Name: inspection_photos Active drivers can insert inspection photos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Active drivers can insert inspection photos" ON public.inspection_photos FOR INSERT TO authenticated WITH CHECK ((EXISTS ( SELECT 1
   FROM ((public.inspection_reports ir
     JOIN public.missions m ON ((ir.mission_id = m.id)))
     JOIN public.profiles p ON ((m.driver_id = p.id)))
  WHERE ((ir.id = inspection_photos.inspection_report_id) AND (m.driver_id = auth.uid()) AND (p.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status]))))));


--
-- TOC entry 5325 (class 3256 OID 67983)
-- Name: inspection_reports Active drivers can insert inspection reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Active drivers can insert inspection reports" ON public.inspection_reports FOR INSERT TO authenticated WITH CHECK ((EXISTS ( SELECT 1
   FROM (public.missions m
     JOIN public.profiles p ON ((m.driver_id = p.id)))
  WHERE ((m.id = inspection_reports.mission_id) AND (m.driver_id = auth.uid()) AND (p.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status]))))));


--
-- TOC entry 5376 (class 3256 OID 96469)
-- Name: group_orders Active drivers can view group orders with available missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Active drivers can view group orders with available missions" ON public.group_orders FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM (public.missions m
     JOIN public.profiles p ON ((p.id = auth.uid())))
  WHERE ((m.group_order_id = group_orders.id) AND (m.status = 'recherche_driver'::public.mission_status) AND (p.user_type = 'driver'::public.user_type) AND (p.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status]))))));


--
-- TOC entry 5370 (class 3256 OID 96209)
-- Name: certification_questions Active drivers can view standard certification questions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Active drivers can view standard certification questions" ON public.certification_questions FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.certifications c
  WHERE ((c.id = certification_questions.certification_id) AND (c.certification_type = 'standard'::text) AND (EXISTS ( SELECT 1
           FROM public.profiles
          WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status])))))))));


--
-- TOC entry 5368 (class 3256 OID 96205)
-- Name: certifications Active drivers can view standard certifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Active drivers can view standard certifications" ON public.certifications FOR SELECT USING (((certification_type = 'standard'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status])))))));


--
-- TOC entry 5273 (class 3256 OID 49427)
-- Name: admin_settings Admin can insert settings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin can insert settings" ON public.admin_settings FOR INSERT WITH CHECK (public.is_admin());


--
-- TOC entry 5274 (class 3256 OID 49428)
-- Name: admin_settings Admin can update settings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin can update settings" ON public.admin_settings FOR UPDATE USING (public.is_admin());


--
-- TOC entry 5272 (class 3256 OID 49426)
-- Name: admin_settings Admin can view all settings; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admin can view all settings" ON public.admin_settings FOR SELECT USING (public.is_admin());


--
-- TOC entry 5241 (class 3256 OID 43777)
-- Name: driver_alerts Admins and employees can view all alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins and employees can view all alerts" ON public.driver_alerts FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type]))))));


--
-- TOC entry 5303 (class 3256 OID 64395)
-- Name: business_invoices Admins can delete business invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete business invoices" ON public.business_invoices FOR DELETE USING (public.is_admin());


--
-- TOC entry 5268 (class 3256 OID 70299)
-- Name: driver_penalties Admins can delete penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can delete penalties" ON public.driver_penalties FOR DELETE TO authenticated USING (public.is_admin());


--
-- TOC entry 5366 (class 3256 OID 95090)
-- Name: document_style_config Admins can insert config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can insert config" ON public.document_style_config FOR INSERT WITH CHECK (public.is_admin());


--
-- TOC entry 5360 (class 3256 OID 95063)
-- Name: invoice_style_config Admins can insert config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can insert config" ON public.invoice_style_config FOR INSERT WITH CHECK (public.is_admin());


--
-- TOC entry 5246 (class 3256 OID 70295)
-- Name: driver_penalties Admins can insert penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can insert penalties" ON public.driver_penalties FOR INSERT TO authenticated WITH CHECK ((public.is_admin() OR true));


--
-- TOC entry 5349 (class 3256 OID 92782)
-- Name: driver_allowances Admins can manage all allowances; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all allowances" ON public.driver_allowances TO authenticated USING (public.is_admin());


--
-- TOC entry 5340 (class 3256 OID 86057)
-- Name: customer_penalties Admins can manage all customer penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all customer penalties" ON public.customer_penalties USING (public.is_admin());


--
-- TOC entry 5377 (class 3256 OID 96516)
-- Name: penalty_allowance_documents Admins can manage all documents; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all documents" ON public.penalty_allowance_documents USING (public.is_admin());


--
-- TOC entry 5323 (class 3256 OID 66813)
-- Name: group_order_items Admins can manage all group order items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all group order items" ON public.group_order_items USING (public.is_admin());


--
-- TOC entry 5318 (class 3256 OID 66808)
-- Name: group_orders Admins can manage all group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all group orders" ON public.group_orders USING (public.is_admin());


--
-- TOC entry 5307 (class 3256 OID 66691)
-- Name: business_groups Admins can manage all groups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all groups" ON public.business_groups USING (public.is_admin());


--
-- TOC entry 5331 (class 3256 OID 67992)
-- Name: inspection_photos Admins can manage all inspection photos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all inspection photos" ON public.inspection_photos TO authenticated USING (public.is_admin());


--
-- TOC entry 5327 (class 3256 OID 67986)
-- Name: inspection_reports Admins can manage all inspection reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all inspection reports" ON public.inspection_reports TO authenticated USING (public.is_admin());


--
-- TOC entry 5312 (class 3256 OID 66695)
-- Name: business_invitations Admins can manage all invitations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all invitations" ON public.business_invitations USING (public.is_admin());


--
-- TOC entry 5342 (class 3256 OID 86087)
-- Name: mission_reports Admins can manage all mission reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all mission reports" ON public.mission_reports USING (public.is_admin());


--
-- TOC entry 5356 (class 3256 OID 92827)
-- Name: document_templates Admins can manage all templates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage all templates" ON public.document_templates USING (public.is_admin());


--
-- TOC entry 5256 (class 3256 OID 46050)
-- Name: certification_questions Admins can manage certification questions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage certification questions" ON public.certification_questions USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type)))));


--
-- TOC entry 5253 (class 3256 OID 46049)
-- Name: certifications Admins can manage certifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage certifications" ON public.certifications USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type)))));


--
-- TOC entry 5296 (class 3256 OID 52975)
-- Name: coefficient_config Admins can manage coefficient config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage coefficient config" ON public.coefficient_config USING (public.is_admin());


--
-- TOC entry 5305 (class 3256 OID 64397)
-- Name: credit_notes Admins can manage credit notes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can manage credit notes" ON public.credit_notes USING (public.is_admin());


--
-- TOC entry 5235 (class 3256 OID 54125)
-- Name: driver_invoices Admins can update all invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update all invoices" ON public.driver_invoices FOR UPDATE TO authenticated USING (public.is_admin());


--
-- TOC entry 5248 (class 3256 OID 70297)
-- Name: driver_penalties Admins can update all penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update all penalties" ON public.driver_penalties FOR UPDATE TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- TOC entry 5302 (class 3256 OID 64394)
-- Name: business_invoices Admins can update business invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update business invoices" ON public.business_invoices FOR UPDATE USING (public.is_admin());


--
-- TOC entry 5367 (class 3256 OID 95091)
-- Name: document_style_config Admins can update config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update config" ON public.document_style_config FOR UPDATE USING (public.is_admin());


--
-- TOC entry 5359 (class 3256 OID 95062)
-- Name: invoice_style_config Admins can update config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can update config" ON public.invoice_style_config FOR UPDATE USING (public.is_admin());


--
-- TOC entry 5300 (class 3256 OID 64392)
-- Name: business_invoices Admins can view all business invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all business invoices" ON public.business_invoices FOR SELECT USING (public.is_admin());


--
-- TOC entry 5292 (class 3256 OID 52971)
-- Name: customer_coefficients Admins can view all coefficients; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all coefficients" ON public.customer_coefficients FOR SELECT USING (public.is_admin());


--
-- TOC entry 5257 (class 3256 OID 46051)
-- Name: driver_certifications Admins can view all driver certifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all driver certifications" ON public.driver_certifications FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type)))));


--
-- TOC entry 5234 (class 3256 OID 54124)
-- Name: driver_invoices Admins can view all invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all invoices" ON public.driver_invoices FOR SELECT TO authenticated USING (public.is_admin());


--
-- TOC entry 5244 (class 3256 OID 70293)
-- Name: driver_penalties Admins can view all penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Admins can view all penalties" ON public.driver_penalties FOR SELECT TO authenticated USING (public.is_admin());


--
-- TOC entry 5297 (class 3256 OID 54105)
-- Name: billing_periods_config Allow read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all authenticated users" ON public.billing_periods_config FOR SELECT TO authenticated USING (true);


--
-- TOC entry 5321 (class 3256 OID 70243)
-- Name: driver_penalty_config Allow read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all authenticated users" ON public.driver_penalty_config FOR SELECT TO authenticated USING (true);


--
-- TOC entry 5198 (class 3256 OID 18092)
-- Name: driver_pricing_rules Allow read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all authenticated users" ON public.driver_pricing_rules FOR SELECT TO authenticated USING (true);


--
-- TOC entry 5288 (class 3256 OID 51775)
-- Name: margin_config Allow read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all authenticated users" ON public.margin_config FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 5254 (class 3256 OID 56528)
-- Name: return_mission_pricing_config Allow read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all authenticated users" ON public.return_mission_pricing_config FOR SELECT TO authenticated USING (true);


--
-- TOC entry 5284 (class 3256 OID 51753)
-- Name: travel_pricing_config Allow read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all authenticated users" ON public.travel_pricing_config FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 5286 (class 3256 OID 51755)
-- Name: vehicle_consumption Allow read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow read access for all authenticated users" ON public.vehicle_consumption FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 5298 (class 3256 OID 54106)
-- Name: billing_periods_config Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.billing_periods_config FOR UPDATE TO authenticated USING (public.is_admin());


--
-- TOC entry 5242 (class 3256 OID 70244)
-- Name: driver_penalty_config Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.driver_penalty_config FOR UPDATE TO authenticated USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- TOC entry 5283 (class 3256 OID 51718)
-- Name: driver_pricing_coefficients Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.driver_pricing_coefficients FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type)))));


--
-- TOC entry 5199 (class 3256 OID 18093)
-- Name: driver_pricing_rules Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.driver_pricing_rules FOR UPDATE TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type)))));


--
-- TOC entry 5289 (class 3256 OID 51776)
-- Name: margin_config Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.margin_config FOR UPDATE USING (public.is_admin());


--
-- TOC entry 5255 (class 3256 OID 56529)
-- Name: return_mission_pricing_config Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.return_mission_pricing_config FOR UPDATE TO authenticated USING (public.is_admin());


--
-- TOC entry 5285 (class 3256 OID 51754)
-- Name: travel_pricing_config Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.travel_pricing_config FOR UPDATE USING (public.is_admin());


--
-- TOC entry 5287 (class 3256 OID 51756)
-- Name: vehicle_consumption Allow update for admins only; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Allow update for admins only" ON public.vehicle_consumption FOR UPDATE USING (public.is_admin());


--
-- TOC entry 5365 (class 3256 OID 95089)
-- Name: document_style_config Anyone can view config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view config" ON public.document_style_config FOR SELECT USING (true);


--
-- TOC entry 5358 (class 3256 OID 95061)
-- Name: invoice_style_config Anyone can view config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view config" ON public.invoice_style_config FOR SELECT USING (true);


--
-- TOC entry 5314 (class 3256 OID 66697)
-- Name: business_invitations Anyone can view invitations by token; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view invitations by token" ON public.business_invitations FOR SELECT USING (true);


--
-- TOC entry 5357 (class 3256 OID 92828)
-- Name: document_templates Authenticated users can view active templates; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can view active templates" ON public.document_templates FOR SELECT USING ((is_active = true));


--
-- TOC entry 5295 (class 3256 OID 52974)
-- Name: coefficient_config Authenticated users can view coefficient config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Authenticated users can view coefficient config" ON public.coefficient_config FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 5304 (class 3256 OID 64396)
-- Name: credit_notes Business customers can view their own credit notes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Business customers can view their own credit notes" ON public.credit_notes FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.business_invoices
  WHERE ((business_invoices.id = credit_notes.business_invoice_id) AND (business_invoices.customer_id = auth.uid())))));


--
-- TOC entry 5299 (class 3256 OID 64391)
-- Name: business_invoices Business customers can view their own invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Business customers can view their own invoices" ON public.business_invoices FOR SELECT USING (((customer_id = auth.uid()) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'customer_business'::public.user_type))))));


--
-- TOC entry 5310 (class 3256 OID 66811)
-- Name: group_order_items Customers can insert items for their own group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can insert items for their own group orders" ON public.group_order_items FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
   FROM public.group_orders
  WHERE ((group_orders.id = group_order_items.group_order_id) AND (group_orders.customer_id = auth.uid())))));


--
-- TOC entry 5316 (class 3256 OID 66806)
-- Name: group_orders Customers can insert their own group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can insert their own group orders" ON public.group_orders FOR INSERT WITH CHECK ((customer_id = auth.uid()));


--
-- TOC entry 5322 (class 3256 OID 66812)
-- Name: group_order_items Customers can update items of their own group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can update items of their own group orders" ON public.group_order_items FOR UPDATE USING ((EXISTS ( SELECT 1
   FROM public.group_orders
  WHERE ((group_orders.id = group_order_items.group_order_id) AND (group_orders.customer_id = auth.uid())))));


--
-- TOC entry 5317 (class 3256 OID 66807)
-- Name: group_orders Customers can update their own group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can update their own group orders" ON public.group_orders FOR UPDATE USING ((customer_id = auth.uid()));


--
-- TOC entry 5330 (class 3256 OID 67990)
-- Name: inspection_photos Customers can view inspection photos of their missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can view inspection photos of their missions" ON public.inspection_photos FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM (public.inspection_reports ir
     JOIN public.missions m ON ((ir.mission_id = m.id)))
  WHERE ((ir.id = inspection_photos.inspection_report_id) AND (m.customer_id = auth.uid())))));


--
-- TOC entry 5326 (class 3256 OID 67985)
-- Name: inspection_reports Customers can view inspection reports of their missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can view inspection reports of their missions" ON public.inspection_reports FOR SELECT TO authenticated USING ((EXISTS ( SELECT 1
   FROM public.missions
  WHERE ((missions.id = inspection_reports.mission_id) AND (missions.customer_id = auth.uid())))));


--
-- TOC entry 5320 (class 3256 OID 66810)
-- Name: group_order_items Customers can view items of their own group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can view items of their own group orders" ON public.group_order_items FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.group_orders
  WHERE ((group_orders.id = group_order_items.group_order_id) AND (group_orders.customer_id = auth.uid())))));


--
-- TOC entry 5291 (class 3256 OID 52970)
-- Name: customer_coefficients Customers can view their own coefficients; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can view their own coefficients" ON public.customer_coefficients FOR SELECT USING ((customer_id = auth.uid()));


--
-- TOC entry 5315 (class 3256 OID 66805)
-- Name: group_orders Customers can view their own group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can view their own group orders" ON public.group_orders FOR SELECT USING ((customer_id = auth.uid()));


--
-- TOC entry 5341 (class 3256 OID 86059)
-- Name: customer_penalties Customers can view their own penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can view their own penalties" ON public.customer_penalties FOR SELECT USING ((customer_id = auth.uid()));


--
-- TOC entry 5345 (class 3256 OID 86092)
-- Name: mission_reports Customers can view visible reports for their missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Customers can view visible reports for their missions" ON public.mission_reports FOR SELECT USING ((EXISTS ( SELECT 1
   FROM (public.missions m
     JOIN public.profiles p ON ((p.id = mission_reports.created_by)))
  WHERE ((m.id = mission_reports.mission_id) AND (m.customer_id = auth.uid()) AND ((mission_reports.is_visible_to_client = true) OR (p.user_type = 'driver'::public.user_type))))));


--
-- TOC entry 5344 (class 3256 OID 86089)
-- Name: mission_reports Drivers can create reports for their assigned missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can create reports for their assigned missions" ON public.mission_reports FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
   FROM public.missions
  WHERE ((missions.id = mission_reports.mission_id) AND (missions.driver_id = auth.uid())))) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type))))));


--
-- TOC entry 5238 (class 3256 OID 43774)
-- Name: driver_alerts Drivers can create their own alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can create their own alerts" ON public.driver_alerts FOR INSERT WITH CHECK ((auth.uid() = driver_id));


--
-- TOC entry 5227 (class 3256 OID 54123)
-- Name: driver_invoices Drivers can create their own invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can create their own invoices" ON public.driver_invoices FOR INSERT TO authenticated WITH CHECK ((driver_id = auth.uid()));


--
-- TOC entry 5240 (class 3256 OID 43776)
-- Name: driver_alerts Drivers can delete their own alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can delete their own alerts" ON public.driver_alerts FOR DELETE USING ((auth.uid() = driver_id));


--
-- TOC entry 5251 (class 3256 OID 46047)
-- Name: driver_certifications Drivers can insert their own certifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can insert their own certifications" ON public.driver_certifications FOR INSERT WITH CHECK ((driver_id = auth.uid()));


--
-- TOC entry 5239 (class 3256 OID 43775)
-- Name: driver_alerts Drivers can update their own alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can update their own alerts" ON public.driver_alerts FOR UPDATE USING ((auth.uid() = driver_id));


--
-- TOC entry 5252 (class 3256 OID 46048)
-- Name: driver_certifications Drivers can update their own certifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can update their own certifications" ON public.driver_certifications FOR UPDATE USING ((driver_id = auth.uid()));


--
-- TOC entry 5200 (class 3256 OID 18094)
-- Name: missions Drivers can view missions in recherche_driver status; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view missions in recherche_driver status" ON public.missions FOR SELECT TO authenticated USING (((status = 'recherche_driver'::public.mission_status) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status])))))));


--
-- TOC entry 5348 (class 3256 OID 86108)
-- Name: mission_reports Drivers can view specific reports for their missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view specific reports for their missions" ON public.mission_reports FOR SELECT TO authenticated USING (((EXISTS ( SELECT 1
   FROM public.missions
  WHERE ((missions.id = mission_reports.mission_id) AND (missions.driver_id = auth.uid())))) AND ((created_by = auth.uid()) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = mission_reports.created_by) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type]))))) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = mission_reports.created_by) AND (profiles.user_type = ANY (ARRAY['customer_individual'::public.user_type, 'customer_business'::public.user_type]))))))));


--
-- TOC entry 5380 (class 3256 OID 96519)
-- Name: penalty_allowance_documents Drivers can view their allowance documents; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view their allowance documents" ON public.penalty_allowance_documents FOR SELECT USING (((reference_type = 'allowance'::text) AND (EXISTS ( SELECT 1
   FROM public.driver_allowances
  WHERE ((driver_allowances.id = penalty_allowance_documents.reference_id) AND (driver_allowances.driver_id = auth.uid()))))));


--
-- TOC entry 5237 (class 3256 OID 43773)
-- Name: driver_alerts Drivers can view their own alerts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view their own alerts" ON public.driver_alerts FOR SELECT USING ((auth.uid() = driver_id));


--
-- TOC entry 5351 (class 3256 OID 92784)
-- Name: driver_allowances Drivers can view their own allowances; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view their own allowances" ON public.driver_allowances FOR SELECT TO authenticated USING ((driver_id = auth.uid()));


--
-- TOC entry 5250 (class 3256 OID 46046)
-- Name: driver_certifications Drivers can view their own certifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view their own certifications" ON public.driver_certifications FOR SELECT USING ((driver_id = auth.uid()));


--
-- TOC entry 5226 (class 3256 OID 54122)
-- Name: driver_invoices Drivers can view their own invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view their own invoices" ON public.driver_invoices FOR SELECT TO authenticated USING ((driver_id = auth.uid()));


--
-- TOC entry 5243 (class 3256 OID 70292)
-- Name: driver_penalties Drivers can view their own penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view their own penalties" ON public.driver_penalties FOR SELECT TO authenticated USING ((driver_id = auth.uid()));


--
-- TOC entry 5379 (class 3256 OID 96518)
-- Name: penalty_allowance_documents Drivers can view their penalty documents; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Drivers can view their penalty documents" ON public.penalty_allowance_documents FOR SELECT USING (((reference_type = 'penalty'::text) AND (EXISTS ( SELECT 1
   FROM public.driver_penalties
  WHERE ((driver_penalties.id = penalty_allowance_documents.reference_id) AND (driver_penalties.driver_id = auth.uid()))))));


--
-- TOC entry 5282 (class 3256 OID 70300)
-- Name: driver_penalties Employees can delete penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can delete penalties" ON public.driver_penalties FOR DELETE TO authenticated USING (public.is_employee());


--
-- TOC entry 5247 (class 3256 OID 70296)
-- Name: driver_penalties Employees can insert penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can insert penalties" ON public.driver_penalties FOR INSERT TO authenticated WITH CHECK (public.is_employee());


--
-- TOC entry 5350 (class 3256 OID 92783)
-- Name: driver_allowances Employees can manage all allowances; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can manage all allowances" ON public.driver_allowances TO authenticated USING (public.is_employee());


--
-- TOC entry 5249 (class 3256 OID 86058)
-- Name: customer_penalties Employees can manage all customer penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can manage all customer penalties" ON public.customer_penalties USING (public.is_employee());


--
-- TOC entry 5378 (class 3256 OID 96517)
-- Name: penalty_allowance_documents Employees can manage all documents; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can manage all documents" ON public.penalty_allowance_documents USING (public.is_employee());


--
-- TOC entry 5343 (class 3256 OID 86088)
-- Name: mission_reports Employees can manage all mission reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can manage all mission reports" ON public.mission_reports USING (public.is_employee());


--
-- TOC entry 5267 (class 3256 OID 70298)
-- Name: driver_penalties Employees can update all penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can update all penalties" ON public.driver_penalties FOR UPDATE TO authenticated USING (public.is_employee()) WITH CHECK (public.is_employee());


--
-- TOC entry 5373 (class 3256 OID 96407)
-- Name: business_groups Employees can view all business groups; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can view all business groups" ON public.business_groups FOR SELECT TO authenticated USING (public.is_employee());


--
-- TOC entry 5374 (class 3256 OID 96408)
-- Name: business_invitations Employees can view all business invitations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can view all business invitations" ON public.business_invitations FOR SELECT TO authenticated USING (public.is_employee());


--
-- TOC entry 5324 (class 3256 OID 66814)
-- Name: group_order_items Employees can view all group order items; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can view all group order items" ON public.group_order_items FOR SELECT USING (public.is_employee());


--
-- TOC entry 5319 (class 3256 OID 66809)
-- Name: group_orders Employees can view all group orders; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can view all group orders" ON public.group_orders FOR SELECT USING (public.is_employee());


--
-- TOC entry 5332 (class 3256 OID 67993)
-- Name: inspection_photos Employees can view all inspection photos; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can view all inspection photos" ON public.inspection_photos FOR SELECT TO authenticated USING (public.is_employee());


--
-- TOC entry 5328 (class 3256 OID 67987)
-- Name: inspection_reports Employees can view all inspection reports; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can view all inspection reports" ON public.inspection_reports FOR SELECT TO authenticated USING (public.is_employee());


--
-- TOC entry 5245 (class 3256 OID 70294)
-- Name: driver_penalties Employees can view all penalties; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Employees can view all penalties" ON public.driver_penalties FOR SELECT TO authenticated USING (public.is_employee());


--
-- TOC entry 5277 (class 3256 OID 49461)
-- Name: vehicle_brands Enable admin access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable admin access" ON public.vehicle_brands USING (public.is_admin());


--
-- TOC entry 5278 (class 3256 OID 49462)
-- Name: vehicle_models Enable admin access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable admin access" ON public.vehicle_models USING (public.is_admin());


--
-- TOC entry 5202 (class 3256 OID 60971)
-- Name: driver_pricing_coefficients Enable public read access for driver pricing coefficients; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable public read access for driver pricing coefficients" ON public.driver_pricing_coefficients FOR SELECT USING (true);


--
-- TOC entry 5281 (class 3256 OID 60970)
-- Name: margin_config Enable public read access for margin config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable public read access for margin config" ON public.margin_config FOR SELECT USING (true);


--
-- TOC entry 5290 (class 3256 OID 51789)
-- Name: mission_options Enable public read access for option prices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable public read access for option prices" ON public.mission_options FOR SELECT USING (true);


--
-- TOC entry 5279 (class 3256 OID 60968)
-- Name: travel_pricing_config Enable public read access for travel pricing config; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable public read access for travel pricing config" ON public.travel_pricing_config FOR SELECT USING (true);


--
-- TOC entry 5280 (class 3256 OID 60969)
-- Name: vehicle_consumption Enable public read access for vehicle consumption; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable public read access for vehicle consumption" ON public.vehicle_consumption FOR SELECT USING (true);


--
-- TOC entry 5201 (class 3256 OID 18095)
-- Name: mission_options Enable read access for all authenticated users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all authenticated users" ON public.mission_options FOR SELECT USING ((auth.role() = 'authenticated'::text));


--
-- TOC entry 5275 (class 3256 OID 49459)
-- Name: vehicle_brands Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.vehicle_brands FOR SELECT USING (true);


--
-- TOC entry 5276 (class 3256 OID 49460)
-- Name: vehicle_models Enable read access for all users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable read access for all users" ON public.vehicle_models FOR SELECT USING (true);


--
-- TOC entry 5271 (class 3256 OID 48284)
-- Name: mission_options Enable update for admins; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Enable update for admins" ON public.mission_options FOR UPDATE TO authenticated USING (public.is_admin());


--
-- TOC entry 5311 (class 3256 OID 66694)
-- Name: business_groups Group members can view their group; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Group members can view their group" ON public.business_groups FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.business_group_id = business_groups.id)))));


--
-- TOC entry 5313 (class 3256 OID 66696)
-- Name: business_invitations Leaders can manage their group invitations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Leaders can manage their group invitations" ON public.business_invitations USING ((EXISTS ( SELECT 1
   FROM public.business_groups
  WHERE ((business_groups.id = business_invitations.business_group_id) AND (business_groups.leader_account_id = auth.uid())))));


--
-- TOC entry 5309 (class 3256 OID 66693)
-- Name: business_groups Leaders can update their own group; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Leaders can update their own group" ON public.business_groups FOR UPDATE USING ((leader_account_id = auth.uid()));


--
-- TOC entry 5308 (class 3256 OID 66692)
-- Name: business_groups Leaders can view their own group; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Leaders can view their own group" ON public.business_groups FOR SELECT USING ((leader_account_id = auth.uid()));


--
-- TOC entry 5371 (class 3256 OID 96211)
-- Name: certification_questions Pending drivers can view onboarding certification questions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Pending drivers can view onboarding certification questions" ON public.certification_questions FOR SELECT USING ((EXISTS ( SELECT 1
   FROM public.certifications c
  WHERE ((c.id = certification_questions.certification_id) AND (c.certification_type = 'onboarding'::text) AND (EXISTS ( SELECT 1
           FROM public.profiles
          WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = 'pending_validation_webinar'::public.driver_status))))))));


--
-- TOC entry 5369 (class 3256 OID 96207)
-- Name: certifications Pending drivers can view onboarding certifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Pending drivers can view onboarding certifications" ON public.certifications FOR SELECT USING (((certification_type = 'onboarding'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = 'pending_validation_webinar'::public.driver_status))))));


--
-- TOC entry 5301 (class 3256 OID 64393)
-- Name: business_invoices System can insert business invoices; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "System can insert business invoices" ON public.business_invoices FOR INSERT WITH CHECK (true);


--
-- TOC entry 5293 (class 3256 OID 52972)
-- Name: customer_coefficients System can insert coefficients; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "System can insert coefficients" ON public.customer_coefficients FOR INSERT WITH CHECK (true);


--
-- TOC entry 5306 (class 3256 OID 64398)
-- Name: credit_notes System can insert credit notes; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "System can insert credit notes" ON public.credit_notes FOR INSERT WITH CHECK (true);


--
-- TOC entry 5294 (class 3256 OID 52973)
-- Name: customer_coefficients System can update coefficients; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "System can update coefficients" ON public.customer_coefficients FOR UPDATE USING (true);


--
-- TOC entry 5261 (class 3256 OID 48279)
-- Name: missions admin_all_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_all_access ON public.missions TO authenticated USING (public.is_admin());


--
-- TOC entry 5169 (class 0 OID 49413)
-- Dependencies: 325
-- Name: admin_settings; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.admin_settings ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5346 (class 3256 OID 86105)
-- Name: missions admin_update_all_missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admin_update_all_missions ON public.missions FOR UPDATE USING (public.is_admin()) WITH CHECK (public.is_admin());


--
-- TOC entry 5375 (class 3256 OID 96409)
-- Name: profiles admins_employees_can_update_driver_fields; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY admins_employees_can_update_driver_fields ON public.profiles FOR UPDATE TO authenticated USING (((user_type = 'driver'::public.user_type) AND (public.is_admin() OR public.is_employee()))) WITH CHECK (((user_type = 'driver'::public.user_type) AND (public.is_admin() OR public.is_employee())));


--
-- TOC entry 5178 (class 0 OID 54093)
-- Dependencies: 336
-- Name: billing_periods_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.billing_periods_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5183 (class 0 OID 66625)
-- Dependencies: 351
-- Name: business_groups; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.business_groups ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5184 (class 0 OID 66643)
-- Dependencies: 352
-- Name: business_invitations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.business_invitations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5181 (class 0 OID 64322)
-- Dependencies: 349
-- Name: business_invoices; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.business_invoices ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5167 (class 0 OID 46008)
-- Dependencies: 323
-- Name: certification_questions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.certification_questions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5166 (class 0 OID 45996)
-- Dependencies: 322
-- Name: certifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.certifications ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5177 (class 0 OID 52960)
-- Dependencies: 335
-- Name: coefficient_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.coefficient_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5182 (class 0 OID 64348)
-- Dependencies: 350
-- Name: credit_notes; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.credit_notes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5176 (class 0 OID 52941)
-- Dependencies: 334
-- Name: customer_coefficients; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_coefficients ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5191 (class 0 OID 86017)
-- Dependencies: 361
-- Name: customer_penalties; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.customer_penalties ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5205 (class 3256 OID 18101)
-- Name: missions customer_read_own; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customer_read_own ON public.missions FOR SELECT TO authenticated USING ((customer_id = auth.uid()));


--
-- TOC entry 5270 (class 3256 OID 48282)
-- Name: missions customers_can_create_missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_can_create_missions ON public.missions FOR INSERT TO authenticated WITH CHECK ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['customer_individual'::public.user_type, 'customer_business'::public.user_type]))))));


--
-- TOC entry 5206 (class 3256 OID 18103)
-- Name: missions customers_can_update_own_missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY customers_can_update_own_missions ON public.missions FOR UPDATE TO authenticated USING ((customer_id = auth.uid())) WITH CHECK ((customer_id = auth.uid()));


--
-- TOC entry 5196 (class 0 OID 95069)
-- Dependencies: 366
-- Name: document_style_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.document_style_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5194 (class 0 OID 92803)
-- Dependencies: 364
-- Name: document_templates; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.document_templates ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5165 (class 0 OID 43759)
-- Dependencies: 321
-- Name: driver_alerts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_alerts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5193 (class 0 OID 92751)
-- Dependencies: 363
-- Name: driver_allowances; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_allowances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5168 (class 0 OID 46023)
-- Dependencies: 324
-- Name: driver_certifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_certifications ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5179 (class 0 OID 54107)
-- Dependencies: 337
-- Name: driver_invoices; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_invoices ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5190 (class 0 OID 70261)
-- Dependencies: 358
-- Name: driver_penalties; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_penalties ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5189 (class 0 OID 70228)
-- Dependencies: 357
-- Name: driver_penalty_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_penalty_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5172 (class 0 OID 51698)
-- Dependencies: 328
-- Name: driver_pricing_coefficients; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_pricing_coefficients ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5153 (class 0 OID 17753)
-- Dependencies: 299
-- Name: driver_pricing_rules; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.driver_pricing_rules ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5269 (class 3256 OID 48281)
-- Name: missions driver_read_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY driver_read_access ON public.missions FOR SELECT TO authenticated USING (((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type)))) AND ((status = 'en_attente'::public.mission_status) OR (status = 'recherche_driver'::public.mission_status) OR (driver_id = auth.uid()))));


--
-- TOC entry 5236 (class 3256 OID 43754)
-- Name: missions drivers_can_cancel_own_missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY drivers_can_cancel_own_missions ON public.missions FOR UPDATE USING (((driver_id = auth.uid()) AND (status = 'acceptee'::public.mission_status) AND (missionstatusdriver = 'mission_acceptee'::public.missionstatusdriver) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status]))))))) WITH CHECK (((driver_id IS NULL) AND (status = 'recherche_driver'::public.mission_status) AND (missionstatusdriver IS NULL)));


--
-- TOC entry 5229 (class 3256 OID 30482)
-- Name: missions drivers_can_reserve_missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY drivers_can_reserve_missions ON public.missions FOR UPDATE USING (((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status]))))) AND (driver_id IS NULL) AND (status = 'recherche_driver'::public.mission_status))) WITH CHECK (((driver_id = auth.uid()) AND (status = 'acceptee'::public.mission_status) AND (missionstatusdriver = 'mission_acceptee'::public.missionstatusdriver)));


--
-- TOC entry 5339 (class 3256 OID 84897)
-- Name: profiles drivers_can_view_customer_profiles_for_their_missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY drivers_can_view_customer_profiles_for_their_missions ON public.profiles FOR SELECT TO authenticated USING (public.driver_can_view_customer(id));


--
-- TOC entry 5728 (class 0 OID 0)
-- Dependencies: 5339
-- Name: POLICY drivers_can_view_customer_profiles_for_their_missions ON profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON POLICY drivers_can_view_customer_profiles_for_their_missions ON public.profiles IS 'Permet aux chauffeurs de lire les profils des clients uniquement pour les missions en recherche_driver ou qui leur sont assignées. Utilise une fonction SECURITY DEFINER pour éviter la récursion RLS.';


--
-- TOC entry 5262 (class 3256 OID 48280)
-- Name: missions employee_read_access; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY employee_read_access ON public.missions FOR SELECT TO authenticated USING (public.is_employee());


--
-- TOC entry 5347 (class 3256 OID 86106)
-- Name: missions employee_update_all_missions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY employee_update_all_missions ON public.missions FOR UPDATE USING (public.is_employee()) WITH CHECK (public.is_employee());


--
-- TOC entry 5260 (class 3256 OID 48277)
-- Name: profiles enable_all_for_admin; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY enable_all_for_admin ON public.profiles TO authenticated USING (public.is_admin());


--
-- TOC entry 5207 (class 3256 OID 18107)
-- Name: profiles enable_insert_for_new_users; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY enable_insert_for_new_users ON public.profiles FOR INSERT TO authenticated WITH CHECK (true);


--
-- TOC entry 5372 (class 3256 OID 96339)
-- Name: profiles enable_read_for_employee; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY enable_read_for_employee ON public.profiles FOR SELECT TO authenticated USING ((public.is_employee() AND ((user_type <> 'driver'::public.user_type) OR (driver_status <> ALL (ARRAY['inactive_woman'::public.driver_status, 'pending_validation_woman'::public.driver_status])))));


--
-- TOC entry 5208 (class 3256 OID 18109)
-- Name: profiles enable_read_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY enable_read_own_profile ON public.profiles FOR SELECT TO authenticated USING ((auth.uid() = id));


--
-- TOC entry 5209 (class 3256 OID 18110)
-- Name: profiles enable_update_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY enable_update_own_profile ON public.profiles FOR UPDATE TO authenticated USING ((auth.uid() = id));


--
-- TOC entry 5186 (class 0 OID 66755)
-- Dependencies: 354
-- Name: group_order_items; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.group_order_items ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5185 (class 0 OID 66729)
-- Dependencies: 353
-- Name: group_orders; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.group_orders ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5188 (class 0 OID 67959)
-- Dependencies: 356
-- Name: inspection_photos; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.inspection_photos ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5187 (class 0 OID 67941)
-- Dependencies: 355
-- Name: inspection_reports; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.inspection_reports ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5195 (class 0 OID 95044)
-- Dependencies: 365
-- Name: invoice_style_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.invoice_style_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5175 (class 0 OID 51763)
-- Dependencies: 332
-- Name: margin_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.margin_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5154 (class 0 OID 17760)
-- Dependencies: 302
-- Name: mission_options; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.mission_options ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5192 (class 0 OID 86066)
-- Dependencies: 362
-- Name: mission_reports; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.mission_reports ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5155 (class 0 OID 17768)
-- Dependencies: 304
-- Name: missions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.missions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5197 (class 0 OID 96500)
-- Dependencies: 372
-- Name: penalty_allowance_documents; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.penalty_allowance_documents ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5156 (class 0 OID 17795)
-- Dependencies: 305
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5180 (class 0 OID 56515)
-- Dependencies: 347
-- Name: return_mission_pricing_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.return_mission_pricing_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5173 (class 0 OID 51724)
-- Dependencies: 329
-- Name: travel_pricing_config; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.travel_pricing_config ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5210 (class 3256 OID 18111)
-- Name: profiles update_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY update_own_profile ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 5258 (class 3256 OID 48273)
-- Name: profiles users_can_read_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY users_can_read_own_profile ON public.profiles FOR SELECT TO authenticated USING ((auth.uid() = id));


--
-- TOC entry 5259 (class 3256 OID 48274)
-- Name: profiles users_can_update_own_profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY users_can_update_own_profile ON public.profiles FOR UPDATE TO authenticated USING ((auth.uid() = id)) WITH CHECK ((auth.uid() = id));


--
-- TOC entry 5170 (class 0 OID 49430)
-- Dependencies: 326
-- Name: vehicle_brands; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.vehicle_brands ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5174 (class 0 OID 51740)
-- Dependencies: 331
-- Name: vehicle_consumption; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.vehicle_consumption ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5171 (class 0 OID 49442)
-- Dependencies: 327
-- Name: vehicle_models; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.vehicle_models ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5157 (class 0 OID 17809)
-- Dependencies: 307
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5333 (class 3256 OID 67999)
-- Name: objects Active drivers can upload signatures; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Active drivers can upload signatures" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'inspection_signatures'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type) AND (profiles.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status])))))));


--
-- TOC entry 5211 (class 3256 OID 18112)
-- Name: objects Admin and employee can read driver documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admin and employee can read driver documents" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_documents'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type])))))));


--
-- TOC entry 5212 (class 3256 OID 18114)
-- Name: objects Admin and employee can read driver videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admin and employee can read driver videos" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_videos'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type])))))));


--
-- TOC entry 5203 (class 3256 OID 79254)
-- Name: objects Admins and employees can upload inspection photos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins and employees can upload inspection photos" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'inspection_photos'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type])))))));


--
-- TOC entry 5364 (class 3256 OID 95067)
-- Name: objects Admins can delete assets; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can delete assets" ON storage.objects FOR DELETE USING (((bucket_id = 'assets'::text) AND public.is_admin()));


--
-- TOC entry 5204 (class 3256 OID 79258)
-- Name: objects Admins can delete inspection photos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can delete inspection photos" ON storage.objects FOR DELETE TO authenticated USING (((bucket_id = 'inspection_photos'::text) AND public.is_admin()));


--
-- TOC entry 5335 (class 3256 OID 68003)
-- Name: objects Admins can delete signatures; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can delete signatures" ON storage.objects FOR DELETE TO authenticated USING (((bucket_id = 'inspection_signatures'::text) AND public.is_admin()));


--
-- TOC entry 5266 (class 3256 OID 58747)
-- Name: objects Admins can delete vehicle images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can delete vehicle images" ON storage.objects FOR DELETE USING (((bucket_id = 'vehicle_images'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type))))));


--
-- TOC entry 5383 (class 3256 OID 96522)
-- Name: objects Admins can manage documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can manage documents" ON storage.objects USING (((bucket_id = 'penalty_allowance_docs'::text) AND public.is_admin()));


--
-- TOC entry 5363 (class 3256 OID 95066)
-- Name: objects Admins can update assets; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can update assets" ON storage.objects FOR UPDATE USING (((bucket_id = 'assets'::text) AND public.is_admin()));


--
-- TOC entry 5265 (class 3256 OID 58745)
-- Name: objects Admins can update vehicle images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can update vehicle images" ON storage.objects FOR UPDATE USING (((bucket_id = 'vehicle_images'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type))))));


--
-- TOC entry 5362 (class 3256 OID 95065)
-- Name: objects Admins can upload assets; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can upload assets" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'assets'::text) AND public.is_admin()));


--
-- TOC entry 5381 (class 3256 OID 96520)
-- Name: objects Admins can upload documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can upload documents" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'penalty_allowance_docs'::text) AND public.is_admin()));


--
-- TOC entry 5264 (class 3256 OID 58743)
-- Name: objects Admins can upload vehicle images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can upload vehicle images" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'vehicle_images'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type))))));


--
-- TOC entry 5353 (class 3256 OID 92799)
-- Name: objects Admins can view all invoices; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Admins can view all invoices" ON storage.objects FOR SELECT USING (((bucket_id = 'invoices'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type))))));


--
-- TOC entry 5213 (class 3256 OID 18115)
-- Name: objects Allow admins and employees to download driver documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow admins and employees to download driver documents" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_documents'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type])))))));


--
-- TOC entry 5214 (class 3256 OID 18117)
-- Name: objects Allow admins and employees to read driver documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow admins and employees to read driver documents" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_documents'::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type])))))));


--
-- TOC entry 5215 (class 3256 OID 18119)
-- Name: objects Allow authenticated users to upload videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated users to upload videos" ON storage.objects FOR INSERT TO authenticated WITH CHECK ((bucket_id = 'driver_videos'::text));


--
-- TOC entry 5216 (class 3256 OID 18120)
-- Name: objects Allow users to download their own videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow users to download their own videos" ON storage.objects FOR SELECT TO authenticated USING ((bucket_id = 'driver_videos'::text));


--
-- TOC entry 5217 (class 3256 OID 18121)
-- Name: objects Allow users to upload their documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow users to upload their documents" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- TOC entry 5218 (class 3256 OID 18122)
-- Name: objects Allow users to view their own documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow users to view their own documents" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- TOC entry 5361 (class 3256 OID 95064)
-- Name: objects Anyone can view assets; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Anyone can view assets" ON storage.objects FOR SELECT USING ((bucket_id = 'assets'::text));


--
-- TOC entry 5338 (class 3256 OID 79263)
-- Name: objects Authorized users can view inspection photos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Authorized users can view inspection photos" ON storage.objects FOR SELECT USING (((bucket_id = 'inspection_photos'::text) AND ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'admin'::public.user_type)))) OR (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'employee'::public.user_type)))) OR (EXISTS ( SELECT 1
   FROM public.missions m
  WHERE (((m.id)::text = split_part(objects.name, '/'::text, 2)) AND (m.customer_id = auth.uid())))) OR (EXISTS ( SELECT 1
   FROM public.missions m
  WHERE (((m.id)::text = split_part(objects.name, '/'::text, 2)) AND (m.driver_id = auth.uid())))))));


--
-- TOC entry 5334 (class 3256 OID 68001)
-- Name: objects Authorized users can view signatures; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Authorized users can view signatures" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'inspection_signatures'::text) AND ((EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = ANY (ARRAY['admin'::public.user_type, 'employee'::public.user_type]))))) OR (EXISTS ( SELECT 1
   FROM public.missions
  WHERE (missions.customer_id = auth.uid()))))));


--
-- TOC entry 5230 (class 3256 OID 30484)
-- Name: objects Company logos are publicly accessible; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Company logos are publicly accessible" ON storage.objects FOR SELECT USING ((bucket_id = 'company_logos'::text));


--
-- TOC entry 5219 (class 3256 OID 18123)
-- Name: objects Drivers can insert their own documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can insert their own documents" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type))))));


--
-- TOC entry 5220 (class 3256 OID 18125)
-- Name: objects Drivers can insert their own videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can insert their own videos" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'driver_videos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type))))));


--
-- TOC entry 5221 (class 3256 OID 18127)
-- Name: objects Drivers can read their own documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can read their own documents" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type))))));


--
-- TOC entry 5222 (class 3256 OID 18129)
-- Name: objects Drivers can read their own videos; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can read their own videos" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_videos'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text) AND (EXISTS ( SELECT 1
   FROM public.profiles
  WHERE ((profiles.id = auth.uid()) AND (profiles.user_type = 'driver'::public.user_type))))));


--
-- TOC entry 5337 (class 3256 OID 79261)
-- Name: objects Drivers can upload photos for assigned missions; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can upload photos for assigned missions" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'inspection_photos'::text) AND ((EXISTS ( SELECT 1
   FROM (public.missions m
     JOIN public.profiles p ON ((m.driver_id = p.id)))
  WHERE (((m.id)::text = split_part(objects.name, '/'::text, 2)) AND (m.driver_id = auth.uid()) AND (p.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status]))))) OR ((((current_setting('request.jwt.claims'::text, true))::json ->> 'aud'::text) = 'authenticated'::text) AND (EXISTS ( SELECT 1
   FROM (public.missions m
     JOIN public.profiles p ON ((m.driver_id = p.id)))
  WHERE (((m.id)::text = split_part(objects.name, '/'::text, 2)) AND ((m.driver_id)::text = ((current_setting('request.jwt.claims'::text, true))::json ->> 'sub'::text)) AND (p.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status])))))))));


--
-- TOC entry 5336 (class 3256 OID 79252)
-- Name: objects Drivers can upload photos for their assigned missions; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can upload photos for their assigned missions" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'inspection_photos'::text) AND (EXISTS ( SELECT 1
   FROM (public.missions m
     JOIN public.profiles p ON ((m.driver_id = p.id)))
  WHERE (((m.id)::text = split_part(objects.name, '/'::text, 1)) AND (m.driver_id = auth.uid()) AND (p.driver_status = ANY (ARRAY['active_beginner'::public.driver_status, 'active_intermediate'::public.driver_status, 'active_expert'::public.driver_status, 'active_elite'::public.driver_status])))))));


--
-- TOC entry 5385 (class 3256 OID 96524)
-- Name: objects Drivers can view their documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can view their documents" ON storage.objects FOR SELECT USING ((bucket_id = 'penalty_allowance_docs'::text));


--
-- TOC entry 5352 (class 3256 OID 92798)
-- Name: objects Drivers can view their own invoices; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Drivers can view their own invoices" ON storage.objects FOR SELECT USING (((bucket_id = 'invoices'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- TOC entry 5384 (class 3256 OID 96523)
-- Name: objects Employees can manage documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Employees can manage documents" ON storage.objects USING (((bucket_id = 'penalty_allowance_docs'::text) AND public.is_employee()));


--
-- TOC entry 5382 (class 3256 OID 96521)
-- Name: objects Employees can upload documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Employees can upload documents" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'penalty_allowance_docs'::text) AND public.is_employee()));


--
-- TOC entry 5263 (class 3256 OID 58742)
-- Name: objects Public can view vehicle images; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Public can view vehicle images" ON storage.objects FOR SELECT USING ((bucket_id = 'vehicle_images'::text));


--
-- TOC entry 5354 (class 3256 OID 92801)
-- Name: objects System can insert invoice PDFs; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "System can insert invoice PDFs" ON storage.objects FOR INSERT WITH CHECK ((bucket_id = 'invoices'::text));


--
-- TOC entry 5355 (class 3256 OID 92802)
-- Name: objects System can update invoice PDFs; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "System can update invoice PDFs" ON storage.objects FOR UPDATE USING ((bucket_id = 'invoices'::text));


--
-- TOC entry 5233 (class 3256 OID 30487)
-- Name: objects Users can delete their own company logo; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can delete their own company logo" ON storage.objects FOR DELETE USING (((bucket_id = 'company_logos'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- TOC entry 5223 (class 3256 OID 18131)
-- Name: objects Users can delete their own documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can delete their own documents" ON storage.objects FOR DELETE TO authenticated USING (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- TOC entry 5232 (class 3256 OID 30486)
-- Name: objects Users can update their own company logo; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can update their own company logo" ON storage.objects FOR UPDATE USING (((bucket_id = 'company_logos'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- TOC entry 5224 (class 3256 OID 18132)
-- Name: objects Users can update their own documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can update their own documents" ON storage.objects FOR UPDATE TO authenticated USING (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- TOC entry 5231 (class 3256 OID 30485)
-- Name: objects Users can upload their own company logo; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can upload their own company logo" ON storage.objects FOR INSERT WITH CHECK (((bucket_id = 'company_logos'::text) AND ((auth.uid())::text = (storage.foldername(name))[1])));


--
-- TOC entry 5225 (class 3256 OID 18133)
-- Name: objects Users can upload their own documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can upload their own documents" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- TOC entry 5228 (class 3256 OID 18134)
-- Name: objects Users can view their own documents; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Users can view their own documents" ON storage.objects FOR SELECT TO authenticated USING (((bucket_id = 'driver_documents'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));


--
-- TOC entry 5158 (class 0 OID 17828)
-- Dependencies: 311
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5164 (class 0 OID 28250)
-- Dependencies: 320
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5159 (class 0 OID 17837)
-- Dependencies: 312
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5160 (class 0 OID 17841)
-- Dependencies: 313
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5163 (class 0 OID 28205)
-- Dependencies: 319
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5161 (class 0 OID 17851)
-- Dependencies: 314
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5162 (class 0 OID 17858)
-- Dependencies: 315
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 5386 (class 6104 OID 18135)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 5387 (class 6104 OID 96404)
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: supabase_admin
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO supabase_admin;

--
-- TOC entry 5389 (class 6106 OID 96406)
-- Name: supabase_realtime profiles; Type: PUBLICATION TABLE; Schema: public; Owner: postgres
--

ALTER PUBLICATION supabase_realtime ADD TABLE ONLY public.profiles;


--
-- TOC entry 5388 (class 6106 OID 96405)
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: supabase_admin
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- TOC entry 5395 (class 0 OID 0)
-- Dependencies: 52
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 5397 (class 0 OID 0)
-- Dependencies: 27
-- Name: SCHEMA cron; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA cron TO postgres WITH GRANT OPTION;


--
-- TOC entry 5398 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 5400 (class 0 OID 0)
-- Dependencies: 29
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- TOC entry 5402 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 5403 (class 0 OID 0)
-- Dependencies: 18
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 5404 (class 0 OID 0)
-- Dependencies: 53
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 5405 (class 0 OID 0)
-- Dependencies: 20
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 5413 (class 0 OID 0)
-- Dependencies: 638
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- TOC entry 5414 (class 0 OID 0)
-- Dependencies: 647
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 5416 (class 0 OID 0)
-- Dependencies: 637
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- TOC entry 5418 (class 0 OID 0)
-- Dependencies: 639
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- TOC entry 5419 (class 0 OID 0)
-- Dependencies: 482
-- Name: FUNCTION alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.alter_job(job_id bigint, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 5420 (class 0 OID 0)
-- Dependencies: 480
-- Name: FUNCTION job_cache_invalidate(); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.job_cache_invalidate() TO postgres WITH GRANT OPTION;


--
-- TOC entry 5421 (class 0 OID 0)
-- Dependencies: 478
-- Name: FUNCTION schedule(schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 5422 (class 0 OID 0)
-- Dependencies: 481
-- Name: FUNCTION schedule(job_name text, schedule text, command text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule(job_name text, schedule text, command text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 5423 (class 0 OID 0)
-- Dependencies: 484
-- Name: FUNCTION schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.schedule_in_database(job_name text, schedule text, command text, database text, username text, active boolean) TO postgres WITH GRANT OPTION;


--
-- TOC entry 5424 (class 0 OID 0)
-- Dependencies: 479
-- Name: FUNCTION unschedule(job_id bigint); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_id bigint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 5425 (class 0 OID 0)
-- Dependencies: 485
-- Name: FUNCTION unschedule(job_name text); Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT ALL ON FUNCTION cron.unschedule(job_name text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 5426 (class 0 OID 0)
-- Dependencies: 680
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 5427 (class 0 OID 0)
-- Dependencies: 618
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 5428 (class 0 OID 0)
-- Dependencies: 616
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 5429 (class 0 OID 0)
-- Dependencies: 675
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 5430 (class 0 OID 0)
-- Dependencies: 617
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 5431 (class 0 OID 0)
-- Dependencies: 677
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5432 (class 0 OID 0)
-- Dependencies: 678
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5433 (class 0 OID 0)
-- Dependencies: 633
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 5434 (class 0 OID 0)
-- Dependencies: 681
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 5435 (class 0 OID 0)
-- Dependencies: 702
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5436 (class 0 OID 0)
-- Dependencies: 703
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5437 (class 0 OID 0)
-- Dependencies: 704
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 5438 (class 0 OID 0)
-- Dependencies: 682
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 5439 (class 0 OID 0)
-- Dependencies: 705
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 5440 (class 0 OID 0)
-- Dependencies: 706
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 5442 (class 0 OID 0)
-- Dependencies: 684
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 5444 (class 0 OID 0)
-- Dependencies: 651
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 5446 (class 0 OID 0)
-- Dependencies: 722
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 5447 (class 0 OID 0)
-- Dependencies: 719
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5448 (class 0 OID 0)
-- Dependencies: 683
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 5449 (class 0 OID 0)
-- Dependencies: 712
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- TOC entry 5450 (class 0 OID 0)
-- Dependencies: 630
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 5451 (class 0 OID 0)
-- Dependencies: 629
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- TOC entry 5452 (class 0 OID 0)
-- Dependencies: 713
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 5453 (class 0 OID 0)
-- Dependencies: 714
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 5454 (class 0 OID 0)
-- Dependencies: 720
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 5455 (class 0 OID 0)
-- Dependencies: 509
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5456 (class 0 OID 0)
-- Dependencies: 507
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 5457 (class 0 OID 0)
-- Dependencies: 631
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 5458 (class 0 OID 0)
-- Dependencies: 508
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5459 (class 0 OID 0)
-- Dependencies: 715
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 5460 (class 0 OID 0)
-- Dependencies: 632
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 5461 (class 0 OID 0)
-- Dependencies: 510
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 5462 (class 0 OID 0)
-- Dependencies: 693
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 5463 (class 0 OID 0)
-- Dependencies: 522
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 5464 (class 0 OID 0)
-- Dependencies: 694
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 5465 (class 0 OID 0)
-- Dependencies: 695
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 5466 (class 0 OID 0)
-- Dependencies: 692
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 5467 (class 0 OID 0)
-- Dependencies: 697
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 5468 (class 0 OID 0)
-- Dependencies: 698
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 5469 (class 0 OID 0)
-- Dependencies: 699
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 5470 (class 0 OID 0)
-- Dependencies: 497
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 5471 (class 0 OID 0)
-- Dependencies: 711
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 5472 (class 0 OID 0)
-- Dependencies: 718
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 5473 (class 0 OID 0)
-- Dependencies: 650
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 5475 (class 0 OID 0)
-- Dependencies: 708
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 5476 (class 0 OID 0)
-- Dependencies: 716
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 5477 (class 0 OID 0)
-- Dependencies: 506
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- TOC entry 5478 (class 0 OID 0)
-- Dependencies: 619
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- TOC entry 5479 (class 0 OID 0)
-- Dependencies: 620
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- TOC entry 5480 (class 0 OID 0)
-- Dependencies: 644
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 5481 (class 0 OID 0)
-- Dependencies: 635
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 5482 (class 0 OID 0)
-- Dependencies: 636
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 5483 (class 0 OID 0)
-- Dependencies: 645
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 5484 (class 0 OID 0)
-- Dependencies: 646
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 5485 (class 0 OID 0)
-- Dependencies: 640
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 5486 (class 0 OID 0)
-- Dependencies: 641
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 5487 (class 0 OID 0)
-- Dependencies: 642
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 5488 (class 0 OID 0)
-- Dependencies: 643
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 5489 (class 0 OID 0)
-- Dependencies: 717
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 5490 (class 0 OID 0)
-- Dependencies: 669
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- TOC entry 5491 (class 0 OID 0)
-- Dependencies: 524
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 5492 (class 0 OID 0)
-- Dependencies: 649
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 5493 (class 0 OID 0)
-- Dependencies: 625
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- TOC entry 5494 (class 0 OID 0)
-- Dependencies: 626
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- TOC entry 5495 (class 0 OID 0)
-- Dependencies: 627
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- TOC entry 5496 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION calculate_driver_penalty(p_mission_id uuid, p_driver_id uuid, p_cancellation_datetime timestamp with time zone, p_pickup_datetime timestamp with time zone); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calculate_driver_penalty(p_mission_id uuid, p_driver_id uuid, p_cancellation_datetime timestamp with time zone, p_pickup_datetime timestamp with time zone) TO anon;
GRANT ALL ON FUNCTION public.calculate_driver_penalty(p_mission_id uuid, p_driver_id uuid, p_cancellation_datetime timestamp with time zone, p_pickup_datetime timestamp with time zone) TO authenticated;
GRANT ALL ON FUNCTION public.calculate_driver_penalty(p_mission_id uuid, p_driver_id uuid, p_cancellation_datetime timestamp with time zone, p_pickup_datetime timestamp with time zone) TO service_role;


--
-- TOC entry 5497 (class 0 OID 0)
-- Dependencies: 523
-- Name: FUNCTION calculate_driver_seniority(driver_uuid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calculate_driver_seniority(driver_uuid uuid) TO anon;
GRANT ALL ON FUNCTION public.calculate_driver_seniority(driver_uuid uuid) TO authenticated;
GRANT ALL ON FUNCTION public.calculate_driver_seniority(driver_uuid uuid) TO service_role;


--
-- TOC entry 5498 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION calculate_monthly_coefficients(p_month integer, p_year integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.calculate_monthly_coefficients(p_month integer, p_year integer) TO anon;
GRANT ALL ON FUNCTION public.calculate_monthly_coefficients(p_month integer, p_year integer) TO authenticated;
GRANT ALL ON FUNCTION public.calculate_monthly_coefficients(p_month integer, p_year integer) TO service_role;


--
-- TOC entry 5499 (class 0 OID 0)
-- Dependencies: 388
-- Name: FUNCTION check_leader_confirmed(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_leader_confirmed() TO anon;
GRANT ALL ON FUNCTION public.check_leader_confirmed() TO authenticated;
GRANT ALL ON FUNCTION public.check_leader_confirmed() TO service_role;


--
-- TOC entry 5500 (class 0 OID 0)
-- Dependencies: 392
-- Name: FUNCTION check_single_group_membership(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.check_single_group_membership() TO anon;
GRANT ALL ON FUNCTION public.check_single_group_membership() TO authenticated;
GRANT ALL ON FUNCTION public.check_single_group_membership() TO service_role;


--
-- TOC entry 5501 (class 0 OID 0)
-- Dependencies: 474
-- Name: FUNCTION create_customer_penalty_invoice(p_customer_id uuid, p_penalty_amount numeric, p_mission_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_customer_penalty_invoice(p_customer_id uuid, p_penalty_amount numeric, p_mission_id uuid) TO anon;
GRANT ALL ON FUNCTION public.create_customer_penalty_invoice(p_customer_id uuid, p_penalty_amount numeric, p_mission_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.create_customer_penalty_invoice(p_customer_id uuid, p_penalty_amount numeric, p_mission_id uuid) TO service_role;


--
-- TOC entry 5502 (class 0 OID 0)
-- Dependencies: 475
-- Name: FUNCTION create_manual_customer_penalty(p_customer_id uuid, p_penalty_amount numeric, p_penalty_type public.customer_penalty_type, p_reason text, p_mission_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_manual_customer_penalty(p_customer_id uuid, p_penalty_amount numeric, p_penalty_type public.customer_penalty_type, p_reason text, p_mission_id uuid) TO anon;
GRANT ALL ON FUNCTION public.create_manual_customer_penalty(p_customer_id uuid, p_penalty_amount numeric, p_penalty_type public.customer_penalty_type, p_reason text, p_mission_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.create_manual_customer_penalty(p_customer_id uuid, p_penalty_amount numeric, p_penalty_type public.customer_penalty_type, p_reason text, p_mission_id uuid) TO service_role;


--
-- TOC entry 5503 (class 0 OID 0)
-- Dependencies: 665
-- Name: FUNCTION create_manual_driver_allowance(p_driver_id uuid, p_allowance_amount numeric, p_allowance_type text, p_reason text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_manual_driver_allowance(p_driver_id uuid, p_allowance_amount numeric, p_allowance_type text, p_reason text) TO anon;
GRANT ALL ON FUNCTION public.create_manual_driver_allowance(p_driver_id uuid, p_allowance_amount numeric, p_allowance_type text, p_reason text) TO authenticated;
GRANT ALL ON FUNCTION public.create_manual_driver_allowance(p_driver_id uuid, p_allowance_amount numeric, p_allowance_type text, p_reason text) TO service_role;


--
-- TOC entry 5504 (class 0 OID 0)
-- Dependencies: 465
-- Name: FUNCTION create_manual_driver_penalty(p_driver_id uuid, p_penalty_amount numeric, p_reason text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.create_manual_driver_penalty(p_driver_id uuid, p_penalty_amount numeric, p_reason text) TO anon;
GRANT ALL ON FUNCTION public.create_manual_driver_penalty(p_driver_id uuid, p_penalty_amount numeric, p_reason text) TO authenticated;
GRANT ALL ON FUNCTION public.create_manual_driver_penalty(p_driver_id uuid, p_penalty_amount numeric, p_reason text) TO service_role;


--
-- TOC entry 5505 (class 0 OID 0)
-- Dependencies: 477
-- Name: FUNCTION delete_customer_penalty(p_penalty_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_customer_penalty(p_penalty_id uuid) TO anon;
GRANT ALL ON FUNCTION public.delete_customer_penalty(p_penalty_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.delete_customer_penalty(p_penalty_id uuid) TO service_role;


--
-- TOC entry 5506 (class 0 OID 0)
-- Dependencies: 521
-- Name: FUNCTION delete_driver_allowance(p_allowance_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_driver_allowance(p_allowance_id uuid) TO anon;
GRANT ALL ON FUNCTION public.delete_driver_allowance(p_allowance_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.delete_driver_allowance(p_allowance_id uuid) TO service_role;


--
-- TOC entry 5507 (class 0 OID 0)
-- Dependencies: 467
-- Name: FUNCTION delete_driver_penalty(p_penalty_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.delete_driver_penalty(p_penalty_id uuid) TO anon;
GRANT ALL ON FUNCTION public.delete_driver_penalty(p_penalty_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.delete_driver_penalty(p_penalty_id uuid) TO service_role;


--
-- TOC entry 5509 (class 0 OID 0)
-- Dependencies: 468
-- Name: FUNCTION driver_can_view_customer(customer_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.driver_can_view_customer(customer_id uuid) TO anon;
GRANT ALL ON FUNCTION public.driver_can_view_customer(customer_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.driver_can_view_customer(customer_id uuid) TO service_role;


--
-- TOC entry 5510 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION get_customer_coefficient(p_customer_id uuid, p_month integer, p_year integer); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_customer_coefficient(p_customer_id uuid, p_month integer, p_year integer) TO anon;
GRANT ALL ON FUNCTION public.get_customer_coefficient(p_customer_id uuid, p_month integer, p_year integer) TO authenticated;
GRANT ALL ON FUNCTION public.get_customer_coefficient(p_customer_id uuid, p_month integer, p_year integer) TO service_role;


--
-- TOC entry 5511 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION get_invoice_coefficient(p_customer_id uuid, p_period_start date, p_period_end date); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_invoice_coefficient(p_customer_id uuid, p_period_start date, p_period_end date) TO anon;
GRANT ALL ON FUNCTION public.get_invoice_coefficient(p_customer_id uuid, p_period_start date, p_period_end date) TO authenticated;
GRANT ALL ON FUNCTION public.get_invoice_coefficient(p_customer_id uuid, p_period_start date, p_period_end date) TO service_role;


--
-- TOC entry 5512 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION get_mission_customer_info(mission_ids uuid[]); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_mission_customer_info(mission_ids uuid[]) TO anon;
GRANT ALL ON FUNCTION public.get_mission_customer_info(mission_ids uuid[]) TO authenticated;
GRANT ALL ON FUNCTION public.get_mission_customer_info(mission_ids uuid[]) TO service_role;


--
-- TOC entry 5513 (class 0 OID 0)
-- Dependencies: 656
-- Name: FUNCTION get_stripe_publishable_key(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.get_stripe_publishable_key() TO anon;
GRANT ALL ON FUNCTION public.get_stripe_publishable_key() TO authenticated;
GRANT ALL ON FUNCTION public.get_stripe_publishable_key() TO service_role;


--
-- TOC entry 5514 (class 0 OID 0)
-- Dependencies: 648
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- TOC entry 5515 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION is_admin(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_admin() TO anon;
GRANT ALL ON FUNCTION public.is_admin() TO authenticated;
GRANT ALL ON FUNCTION public.is_admin() TO service_role;


--
-- TOC entry 5516 (class 0 OID 0)
-- Dependencies: 383
-- Name: FUNCTION is_employee(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.is_employee() TO anon;
GRANT ALL ON FUNCTION public.is_employee() TO authenticated;
GRANT ALL ON FUNCTION public.is_employee() TO service_role;


--
-- TOC entry 5517 (class 0 OID 0)
-- Dependencies: 500
-- Name: FUNCTION recalculate_all_driver_mission_counts(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.recalculate_all_driver_mission_counts() TO anon;
GRANT ALL ON FUNCTION public.recalculate_all_driver_mission_counts() TO authenticated;
GRANT ALL ON FUNCTION public.recalculate_all_driver_mission_counts() TO service_role;


--
-- TOC entry 5518 (class 0 OID 0)
-- Dependencies: 449
-- Name: FUNCTION sync_all_members_logo_on_group_update(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.sync_all_members_logo_on_group_update() TO anon;
GRANT ALL ON FUNCTION public.sync_all_members_logo_on_group_update() TO authenticated;
GRANT ALL ON FUNCTION public.sync_all_members_logo_on_group_update() TO service_role;


--
-- TOC entry 5519 (class 0 OID 0)
-- Dependencies: 427
-- Name: FUNCTION sync_profile_logo_on_group_join(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.sync_profile_logo_on_group_join() TO anon;
GRANT ALL ON FUNCTION public.sync_profile_logo_on_group_join() TO authenticated;
GRANT ALL ON FUNCTION public.sync_profile_logo_on_group_join() TO service_role;


--
-- TOC entry 5520 (class 0 OID 0)
-- Dependencies: 655
-- Name: FUNCTION toggle_driver_block(driver_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.toggle_driver_block(driver_id uuid) TO anon;
GRANT ALL ON FUNCTION public.toggle_driver_block(driver_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.toggle_driver_block(driver_id uuid) TO service_role;


--
-- TOC entry 5521 (class 0 OID 0)
-- Dependencies: 652
-- Name: FUNCTION toggle_plateau(driver_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.toggle_plateau(driver_id uuid) TO anon;
GRANT ALL ON FUNCTION public.toggle_plateau(driver_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.toggle_plateau(driver_id uuid) TO service_role;


--
-- TOC entry 5522 (class 0 OID 0)
-- Dependencies: 653
-- Name: FUNCTION toggle_w_garage(driver_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.toggle_w_garage(driver_id uuid) TO anon;
GRANT ALL ON FUNCTION public.toggle_w_garage(driver_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.toggle_w_garage(driver_id uuid) TO service_role;


--
-- TOC entry 5523 (class 0 OID 0)
-- Dependencies: 461
-- Name: FUNCTION trigger_driver_penalty_on_cancellation(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.trigger_driver_penalty_on_cancellation() TO anon;
GRANT ALL ON FUNCTION public.trigger_driver_penalty_on_cancellation() TO authenticated;
GRANT ALL ON FUNCTION public.trigger_driver_penalty_on_cancellation() TO service_role;


--
-- TOC entry 5524 (class 0 OID 0)
-- Dependencies: 519
-- Name: FUNCTION trigger_update_driver_mission_counts(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.trigger_update_driver_mission_counts() TO anon;
GRANT ALL ON FUNCTION public.trigger_update_driver_mission_counts() TO authenticated;
GRANT ALL ON FUNCTION public.trigger_update_driver_mission_counts() TO service_role;


--
-- TOC entry 5525 (class 0 OID 0)
-- Dependencies: 518
-- Name: FUNCTION update_all_drivers_seniority(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_all_drivers_seniority() TO anon;
GRANT ALL ON FUNCTION public.update_all_drivers_seniority() TO authenticated;
GRANT ALL ON FUNCTION public.update_all_drivers_seniority() TO service_role;


--
-- TOC entry 5526 (class 0 OID 0)
-- Dependencies: 385
-- Name: FUNCTION update_billing_periods_config(p_period_type text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_billing_periods_config(p_period_type text) TO anon;
GRANT ALL ON FUNCTION public.update_billing_periods_config(p_period_type text) TO authenticated;
GRANT ALL ON FUNCTION public.update_billing_periods_config(p_period_type text) TO service_role;


--
-- TOC entry 5527 (class 0 OID 0)
-- Dependencies: 382
-- Name: FUNCTION update_business_groups_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_business_groups_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_business_groups_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_business_groups_updated_at() TO service_role;


--
-- TOC entry 5528 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION update_business_invitations_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_business_invitations_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_business_invitations_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_business_invitations_updated_at() TO service_role;


--
-- TOC entry 5529 (class 0 OID 0)
-- Dependencies: 381
-- Name: FUNCTION update_business_invoices_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_business_invoices_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_business_invoices_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_business_invoices_updated_at() TO service_role;


--
-- TOC entry 5530 (class 0 OID 0)
-- Dependencies: 377
-- Name: FUNCTION update_certification_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_certification_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_certification_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_certification_updated_at() TO service_role;


--
-- TOC entry 5531 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION update_coefficient_config(p_id integer, p_min_missions integer, p_max_missions integer, p_coefficient_value numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_coefficient_config(p_id integer, p_min_missions integer, p_max_missions integer, p_coefficient_value numeric) TO anon;
GRANT ALL ON FUNCTION public.update_coefficient_config(p_id integer, p_min_missions integer, p_max_missions integer, p_coefficient_value numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_coefficient_config(p_id integer, p_min_missions integer, p_max_missions integer, p_coefficient_value numeric) TO service_role;


--
-- TOC entry 5532 (class 0 OID 0)
-- Dependencies: 457
-- Name: FUNCTION update_coefficient_config_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_coefficient_config_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_coefficient_config_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_coefficient_config_updated_at() TO service_role;


--
-- TOC entry 5533 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION update_customer_coefficients_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_customer_coefficients_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_customer_coefficients_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_customer_coefficients_updated_at() TO service_role;


--
-- TOC entry 5534 (class 0 OID 0)
-- Dependencies: 476
-- Name: FUNCTION update_customer_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_customer_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) TO anon;
GRANT ALL ON FUNCTION public.update_customer_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) TO authenticated;
GRANT ALL ON FUNCTION public.update_customer_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) TO service_role;


--
-- TOC entry 5535 (class 0 OID 0)
-- Dependencies: 436
-- Name: FUNCTION update_driver_alerts_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_alerts_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_driver_alerts_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_alerts_updated_at() TO service_role;


--
-- TOC entry 5536 (class 0 OID 0)
-- Dependencies: 520
-- Name: FUNCTION update_driver_allowance(p_allowance_id uuid, p_allowance_amount numeric, p_reason text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_allowance(p_allowance_id uuid, p_allowance_amount numeric, p_reason text) TO anon;
GRANT ALL ON FUNCTION public.update_driver_allowance(p_allowance_id uuid, p_allowance_amount numeric, p_reason text) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_allowance(p_allowance_id uuid, p_allowance_amount numeric, p_reason text) TO service_role;


--
-- TOC entry 5537 (class 0 OID 0)
-- Dependencies: 486
-- Name: FUNCTION update_driver_handover_count(driver_uuid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_handover_count(driver_uuid uuid) TO anon;
GRANT ALL ON FUNCTION public.update_driver_handover_count(driver_uuid uuid) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_handover_count(driver_uuid uuid) TO service_role;


--
-- TOC entry 5538 (class 0 OID 0)
-- Dependencies: 487
-- Name: FUNCTION update_driver_management_count(driver_uuid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_management_count(driver_uuid uuid) TO anon;
GRANT ALL ON FUNCTION public.update_driver_management_count(driver_uuid uuid) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_management_count(driver_uuid uuid) TO service_role;


--
-- TOC entry 5539 (class 0 OID 0)
-- Dependencies: 491
-- Name: FUNCTION update_driver_mission_counts(driver_uuid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_mission_counts(driver_uuid uuid) TO anon;
GRANT ALL ON FUNCTION public.update_driver_mission_counts(driver_uuid uuid) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_mission_counts(driver_uuid uuid) TO service_role;


--
-- TOC entry 5540 (class 0 OID 0)
-- Dependencies: 466
-- Name: FUNCTION update_driver_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) TO anon;
GRANT ALL ON FUNCTION public.update_driver_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_penalty(p_penalty_id uuid, p_penalty_amount numeric, p_reason text) TO service_role;


--
-- TOC entry 5541 (class 0 OID 0)
-- Dependencies: 463
-- Name: FUNCTION update_driver_penalty_config(p_penalty_more_than_72h numeric, p_penalty_between_24h_72h numeric, p_penalty_less_than_24h numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_penalty_config(p_penalty_more_than_72h numeric, p_penalty_between_24h_72h numeric, p_penalty_less_than_24h numeric) TO anon;
GRANT ALL ON FUNCTION public.update_driver_penalty_config(p_penalty_more_than_72h numeric, p_penalty_between_24h_72h numeric, p_penalty_less_than_24h numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_penalty_config(p_penalty_more_than_72h numeric, p_penalty_between_24h_72h numeric, p_penalty_less_than_24h numeric) TO service_role;


--
-- TOC entry 5542 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION update_driver_pricing_coefficients(p_coefficient_a numeric, p_coefficient_b_beginner numeric, p_coefficient_b_intermediate numeric, p_coefficient_b_expert numeric, p_coefficient_b_elite numeric, p_coefficient_c_beginner numeric, p_coefficient_c_intermediate numeric, p_coefficient_c_expert numeric, p_coefficient_c_elite numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_pricing_coefficients(p_coefficient_a numeric, p_coefficient_b_beginner numeric, p_coefficient_b_intermediate numeric, p_coefficient_b_expert numeric, p_coefficient_b_elite numeric, p_coefficient_c_beginner numeric, p_coefficient_c_intermediate numeric, p_coefficient_c_expert numeric, p_coefficient_c_elite numeric) TO anon;
GRANT ALL ON FUNCTION public.update_driver_pricing_coefficients(p_coefficient_a numeric, p_coefficient_b_beginner numeric, p_coefficient_b_intermediate numeric, p_coefficient_b_expert numeric, p_coefficient_b_elite numeric, p_coefficient_c_beginner numeric, p_coefficient_c_intermediate numeric, p_coefficient_c_expert numeric, p_coefficient_c_elite numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_pricing_coefficients(p_coefficient_a numeric, p_coefficient_b_beginner numeric, p_coefficient_b_intermediate numeric, p_coefficient_b_expert numeric, p_coefficient_b_elite numeric, p_coefficient_c_beginner numeric, p_coefficient_c_intermediate numeric, p_coefficient_c_expert numeric, p_coefficient_c_elite numeric) TO service_role;


--
-- TOC entry 5543 (class 0 OID 0)
-- Dependencies: 654
-- Name: FUNCTION update_driver_pricing_rule(p_id integer, p_beginner_price numeric, p_intermediate_price numeric, p_expert_price numeric, p_elite_price numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_pricing_rule(p_id integer, p_beginner_price numeric, p_intermediate_price numeric, p_expert_price numeric, p_elite_price numeric) TO anon;
GRANT ALL ON FUNCTION public.update_driver_pricing_rule(p_id integer, p_beginner_price numeric, p_intermediate_price numeric, p_expert_price numeric, p_elite_price numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_pricing_rule(p_id integer, p_beginner_price numeric, p_intermediate_price numeric, p_expert_price numeric, p_elite_price numeric) TO service_role;


--
-- TOC entry 5544 (class 0 OID 0)
-- Dependencies: 517
-- Name: FUNCTION update_driver_seniority(driver_uuid uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_seniority(driver_uuid uuid) TO anon;
GRANT ALL ON FUNCTION public.update_driver_seniority(driver_uuid uuid) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_seniority(driver_uuid uuid) TO service_role;


--
-- TOC entry 5546 (class 0 OID 0)
-- Dependencies: 686
-- Name: FUNCTION update_driver_status(driver_id uuid, new_status public.driver_status); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_status(driver_id uuid, new_status public.driver_status) TO anon;
GRANT ALL ON FUNCTION public.update_driver_status(driver_id uuid, new_status public.driver_status) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_status(driver_id uuid, new_status public.driver_status) TO service_role;


--
-- TOC entry 5548 (class 0 OID 0)
-- Dependencies: 529
-- Name: FUNCTION update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text) TO anon;
GRANT ALL ON FUNCTION public.update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text) TO authenticated;
GRANT ALL ON FUNCTION public.update_driver_status_with_reason(driver_id uuid, new_status public.driver_status, reason text) TO service_role;


--
-- TOC entry 5549 (class 0 OID 0)
-- Dependencies: 462
-- Name: FUNCTION update_expired_missions(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_expired_missions() TO anon;
GRANT ALL ON FUNCTION public.update_expired_missions() TO authenticated;
GRANT ALL ON FUNCTION public.update_expired_missions() TO service_role;


--
-- TOC entry 5550 (class 0 OID 0)
-- Dependencies: 473
-- Name: FUNCTION update_margin_config(p_base_amount numeric, p_distance_multiplier numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_margin_config(p_base_amount numeric, p_distance_multiplier numeric) TO anon;
GRANT ALL ON FUNCTION public.update_margin_config(p_base_amount numeric, p_distance_multiplier numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_margin_config(p_base_amount numeric, p_distance_multiplier numeric) TO service_role;


--
-- TOC entry 5551 (class 0 OID 0)
-- Dependencies: 464
-- Name: FUNCTION update_mission_status_by_time(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_mission_status_by_time() TO anon;
GRANT ALL ON FUNCTION public.update_mission_status_by_time() TO authenticated;
GRANT ALL ON FUNCTION public.update_mission_status_by_time() TO service_role;


--
-- TOC entry 5552 (class 0 OID 0)
-- Dependencies: 663
-- Name: FUNCTION update_missions_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_missions_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_missions_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_missions_updated_at() TO service_role;


--
-- TOC entry 5553 (class 0 OID 0)
-- Dependencies: 483
-- Name: FUNCTION update_option_driver_commission(option_code text, new_commission numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_option_driver_commission(option_code text, new_commission numeric) TO anon;
GRANT ALL ON FUNCTION public.update_option_driver_commission(option_code text, new_commission numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_option_driver_commission(option_code text, new_commission numeric) TO service_role;


--
-- TOC entry 5554 (class 0 OID 0)
-- Dependencies: 662
-- Name: FUNCTION update_option_price(option_code text, new_price numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_option_price(option_code text, new_price numeric) TO anon;
GRANT ALL ON FUNCTION public.update_option_price(option_code text, new_price numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_option_price(option_code text, new_price numeric) TO service_role;


--
-- TOC entry 5555 (class 0 OID 0)
-- Dependencies: 661
-- Name: FUNCTION update_pricing_formula(p_vehicle_type public.vehicle_type, p_distance_multiplier numeric, p_base_price numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_pricing_formula(p_vehicle_type public.vehicle_type, p_distance_multiplier numeric, p_base_price numeric) TO anon;
GRANT ALL ON FUNCTION public.update_pricing_formula(p_vehicle_type public.vehicle_type, p_distance_multiplier numeric, p_base_price numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_pricing_formula(p_vehicle_type public.vehicle_type, p_distance_multiplier numeric, p_base_price numeric) TO service_role;


--
-- TOC entry 5556 (class 0 OID 0)
-- Dependencies: 390
-- Name: FUNCTION update_return_mission_pricing_config(p_discount_percentage numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_return_mission_pricing_config(p_discount_percentage numeric) TO anon;
GRANT ALL ON FUNCTION public.update_return_mission_pricing_config(p_discount_percentage numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_return_mission_pricing_config(p_discount_percentage numeric) TO service_role;


--
-- TOC entry 5557 (class 0 OID 0)
-- Dependencies: 447
-- Name: FUNCTION update_travel_pricing_config(p_petrolprice numeric, p_tollclass1 numeric, p_tollclass2 numeric, p_tollclass3 numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_travel_pricing_config(p_petrolprice numeric, p_tollclass1 numeric, p_tollclass2 numeric, p_tollclass3 numeric) TO anon;
GRANT ALL ON FUNCTION public.update_travel_pricing_config(p_petrolprice numeric, p_tollclass1 numeric, p_tollclass2 numeric, p_tollclass3 numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_travel_pricing_config(p_petrolprice numeric, p_tollclass1 numeric, p_tollclass2 numeric, p_tollclass3 numeric) TO service_role;


--
-- TOC entry 5558 (class 0 OID 0)
-- Dependencies: 386
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_updated_at_column() TO anon;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO authenticated;
GRANT ALL ON FUNCTION public.update_updated_at_column() TO service_role;


--
-- TOC entry 5559 (class 0 OID 0)
-- Dependencies: 448
-- Name: FUNCTION update_vehicle_consumption(p_vehicle_type public.vehicle_type, p_consumption numeric); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_vehicle_consumption(p_vehicle_type public.vehicle_type, p_consumption numeric) TO anon;
GRANT ALL ON FUNCTION public.update_vehicle_consumption(p_vehicle_type public.vehicle_type, p_consumption numeric) TO authenticated;
GRANT ALL ON FUNCTION public.update_vehicle_consumption(p_vehicle_type public.vehicle_type, p_consumption numeric) TO service_role;


--
-- TOC entry 5560 (class 0 OID 0)
-- Dependencies: 658
-- Name: FUNCTION validate_driver(driver_id uuid); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.validate_driver(driver_id uuid) TO anon;
GRANT ALL ON FUNCTION public.validate_driver(driver_id uuid) TO authenticated;
GRANT ALL ON FUNCTION public.validate_driver(driver_id uuid) TO service_role;


--
-- TOC entry 5561 (class 0 OID 0)
-- Dependencies: 659
-- Name: FUNCTION validate_driver_w_garage(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.validate_driver_w_garage() TO anon;
GRANT ALL ON FUNCTION public.validate_driver_w_garage() TO authenticated;
GRANT ALL ON FUNCTION public.validate_driver_w_garage() TO service_role;


--
-- TOC entry 5562 (class 0 OID 0)
-- Dependencies: 660
-- Name: FUNCTION validate_mission_driver(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.validate_mission_driver() TO anon;
GRANT ALL ON FUNCTION public.validate_mission_driver() TO authenticated;
GRANT ALL ON FUNCTION public.validate_mission_driver() TO service_role;


--
-- TOC entry 5563 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION validate_mission_status_transition(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.validate_mission_status_transition() TO anon;
GRANT ALL ON FUNCTION public.validate_mission_status_transition() TO authenticated;
GRANT ALL ON FUNCTION public.validate_mission_status_transition() TO service_role;


--
-- TOC entry 5564 (class 0 OID 0)
-- Dependencies: 685
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 5565 (class 0 OID 0)
-- Dependencies: 657
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 5566 (class 0 OID 0)
-- Dependencies: 687
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 5567 (class 0 OID 0)
-- Dependencies: 688
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 5568 (class 0 OID 0)
-- Dependencies: 690
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 5569 (class 0 OID 0)
-- Dependencies: 691
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 5570 (class 0 OID 0)
-- Dependencies: 707
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 5571 (class 0 OID 0)
-- Dependencies: 689
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 5572 (class 0 OID 0)
-- Dependencies: 664
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 5573 (class 0 OID 0)
-- Dependencies: 696
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 5574 (class 0 OID 0)
-- Dependencies: 668
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 5575 (class 0 OID 0)
-- Dependencies: 667
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 5576 (class 0 OID 0)
-- Dependencies: 671
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- TOC entry 5577 (class 0 OID 0)
-- Dependencies: 670
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- TOC entry 5578 (class 0 OID 0)
-- Dependencies: 672
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- TOC entry 5579 (class 0 OID 0)
-- Dependencies: 666
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- TOC entry 5580 (class 0 OID 0)
-- Dependencies: 700
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- TOC entry 5581 (class 0 OID 0)
-- Dependencies: 674
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- TOC entry 5582 (class 0 OID 0)
-- Dependencies: 676
-- Name: FUNCTION operation(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.operation() TO postgres;


--
-- TOC entry 5583 (class 0 OID 0)
-- Dependencies: 701
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- TOC entry 5584 (class 0 OID 0)
-- Dependencies: 679
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- TOC entry 5585 (class 0 OID 0)
-- Dependencies: 634
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 5586 (class 0 OID 0)
-- Dependencies: 709
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 5587 (class 0 OID 0)
-- Dependencies: 710
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 5589 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 5591 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 5594 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 5596 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 5598 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 5600 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 5603 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 5604 (class 0 OID 0)
-- Dependencies: 359
-- Name: TABLE oauth_authorizations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_authorizations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_authorizations TO dashboard_user;


--
-- TOC entry 5605 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE oauth_clients; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_clients TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_clients TO dashboard_user;


--
-- TOC entry 5606 (class 0 OID 0)
-- Dependencies: 360
-- Name: TABLE oauth_consents; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_consents TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.oauth_consents TO dashboard_user;


--
-- TOC entry 5607 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 5609 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 5611 (class 0 OID 0)
-- Dependencies: 291
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 5613 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 5615 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 5621 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 5623 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 5626 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 5629 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 5630 (class 0 OID 0)
-- Dependencies: 339
-- Name: TABLE job; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT SELECT ON TABLE cron.job TO postgres WITH GRANT OPTION;


--
-- TOC entry 5631 (class 0 OID 0)
-- Dependencies: 341
-- Name: TABLE job_run_details; Type: ACL; Schema: cron; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE cron.job_run_details TO postgres WITH GRANT OPTION;


--
-- TOC entry 5632 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 5633 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 5634 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- TOC entry 5635 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- TOC entry 5636 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- TOC entry 5637 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE admin_settings; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.admin_settings TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.admin_settings TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.admin_settings TO service_role;


--
-- TOC entry 5638 (class 0 OID 0)
-- Dependencies: 336
-- Name: TABLE billing_periods_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.billing_periods_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.billing_periods_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.billing_periods_config TO service_role;


--
-- TOC entry 5639 (class 0 OID 0)
-- Dependencies: 351
-- Name: TABLE business_groups; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_groups TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_groups TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_groups TO service_role;


--
-- TOC entry 5640 (class 0 OID 0)
-- Dependencies: 352
-- Name: TABLE business_invitations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_invitations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_invitations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_invitations TO service_role;


--
-- TOC entry 5641 (class 0 OID 0)
-- Dependencies: 348
-- Name: SEQUENCE business_invoice_number_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.business_invoice_number_seq TO anon;
GRANT ALL ON SEQUENCE public.business_invoice_number_seq TO authenticated;
GRANT ALL ON SEQUENCE public.business_invoice_number_seq TO service_role;


--
-- TOC entry 5642 (class 0 OID 0)
-- Dependencies: 349
-- Name: TABLE business_invoices; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_invoices TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_invoices TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.business_invoices TO service_role;


--
-- TOC entry 5643 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE certification_questions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.certification_questions TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.certification_questions TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.certification_questions TO service_role;


--
-- TOC entry 5645 (class 0 OID 0)
-- Dependencies: 322
-- Name: TABLE certifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.certifications TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.certifications TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.certifications TO service_role;


--
-- TOC entry 5646 (class 0 OID 0)
-- Dependencies: 333
-- Name: SEQUENCE coefficient_config_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.coefficient_config_id_seq TO anon;
GRANT ALL ON SEQUENCE public.coefficient_config_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.coefficient_config_id_seq TO service_role;


--
-- TOC entry 5647 (class 0 OID 0)
-- Dependencies: 335
-- Name: TABLE coefficient_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.coefficient_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.coefficient_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.coefficient_config TO service_role;


--
-- TOC entry 5648 (class 0 OID 0)
-- Dependencies: 350
-- Name: TABLE credit_notes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.credit_notes TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.credit_notes TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.credit_notes TO service_role;


--
-- TOC entry 5649 (class 0 OID 0)
-- Dependencies: 334
-- Name: TABLE customer_coefficients; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.customer_coefficients TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.customer_coefficients TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.customer_coefficients TO service_role;


--
-- TOC entry 5650 (class 0 OID 0)
-- Dependencies: 361
-- Name: TABLE customer_penalties; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.customer_penalties TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.customer_penalties TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.customer_penalties TO service_role;


--
-- TOC entry 5651 (class 0 OID 0)
-- Dependencies: 366
-- Name: TABLE document_style_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.document_style_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.document_style_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.document_style_config TO service_role;


--
-- TOC entry 5652 (class 0 OID 0)
-- Dependencies: 364
-- Name: TABLE document_templates; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.document_templates TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.document_templates TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.document_templates TO service_role;


--
-- TOC entry 5653 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE driver_alerts; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_alerts TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_alerts TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_alerts TO service_role;


--
-- TOC entry 5654 (class 0 OID 0)
-- Dependencies: 363
-- Name: TABLE driver_allowances; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_allowances TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_allowances TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_allowances TO service_role;


--
-- TOC entry 5655 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE driver_certifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_certifications TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_certifications TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_certifications TO service_role;


--
-- TOC entry 5656 (class 0 OID 0)
-- Dependencies: 337
-- Name: TABLE driver_invoices; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_invoices TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_invoices TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_invoices TO service_role;


--
-- TOC entry 5657 (class 0 OID 0)
-- Dependencies: 358
-- Name: TABLE driver_penalties; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_penalties TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_penalties TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_penalties TO service_role;


--
-- TOC entry 5658 (class 0 OID 0)
-- Dependencies: 357
-- Name: TABLE driver_penalty_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_penalty_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_penalty_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_penalty_config TO service_role;


--
-- TOC entry 5659 (class 0 OID 0)
-- Dependencies: 328
-- Name: TABLE driver_pricing_coefficients; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_pricing_coefficients TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_pricing_coefficients TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_pricing_coefficients TO service_role;


--
-- TOC entry 5660 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE driver_pricing_rules; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_pricing_rules TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_pricing_rules TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.driver_pricing_rules TO service_role;


--
-- TOC entry 5662 (class 0 OID 0)
-- Dependencies: 300
-- Name: SEQUENCE driver_pricing_rules_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.driver_pricing_rules_id_seq TO anon;
GRANT ALL ON SEQUENCE public.driver_pricing_rules_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.driver_pricing_rules_id_seq TO service_role;


--
-- TOC entry 5671 (class 0 OID 0)
-- Dependencies: 354
-- Name: TABLE group_order_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.group_order_items TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.group_order_items TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.group_order_items TO service_role;


--
-- TOC entry 5672 (class 0 OID 0)
-- Dependencies: 301
-- Name: SEQUENCE mission_number_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.mission_number_seq TO anon;
GRANT ALL ON SEQUENCE public.mission_number_seq TO authenticated;
GRANT ALL ON SEQUENCE public.mission_number_seq TO service_role;


--
-- TOC entry 5673 (class 0 OID 0)
-- Dependencies: 353
-- Name: TABLE group_orders; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.group_orders TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.group_orders TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.group_orders TO service_role;


--
-- TOC entry 5674 (class 0 OID 0)
-- Dependencies: 356
-- Name: TABLE inspection_photos; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.inspection_photos TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.inspection_photos TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.inspection_photos TO service_role;


--
-- TOC entry 5675 (class 0 OID 0)
-- Dependencies: 355
-- Name: TABLE inspection_reports; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.inspection_reports TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.inspection_reports TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.inspection_reports TO service_role;


--
-- TOC entry 5676 (class 0 OID 0)
-- Dependencies: 365
-- Name: TABLE invoice_style_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.invoice_style_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.invoice_style_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.invoice_style_config TO service_role;


--
-- TOC entry 5677 (class 0 OID 0)
-- Dependencies: 332
-- Name: TABLE margin_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.margin_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.margin_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.margin_config TO service_role;


--
-- TOC entry 5679 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE mission_options; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.mission_options TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.mission_options TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.mission_options TO service_role;


--
-- TOC entry 5681 (class 0 OID 0)
-- Dependencies: 303
-- Name: SEQUENCE mission_options_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.mission_options_id_seq TO anon;
GRANT ALL ON SEQUENCE public.mission_options_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.mission_options_id_seq TO service_role;


--
-- TOC entry 5682 (class 0 OID 0)
-- Dependencies: 362
-- Name: TABLE mission_reports; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.mission_reports TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.mission_reports TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.mission_reports TO service_role;


--
-- TOC entry 5691 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE missions; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.missions TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.missions TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.missions TO service_role;


--
-- TOC entry 5692 (class 0 OID 0)
-- Dependencies: 372
-- Name: TABLE penalty_allowance_documents; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.penalty_allowance_documents TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.penalty_allowance_documents TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.penalty_allowance_documents TO service_role;


--
-- TOC entry 5693 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO service_role;


--
-- TOC entry 5694 (class 0 OID 0)
-- Dependencies: 347
-- Name: TABLE return_mission_pricing_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.return_mission_pricing_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.return_mission_pricing_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.return_mission_pricing_config TO service_role;


--
-- TOC entry 5695 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE stripe_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.stripe_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.stripe_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.stripe_config TO service_role;


--
-- TOC entry 5696 (class 0 OID 0)
-- Dependencies: 329
-- Name: TABLE travel_pricing_config; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.travel_pricing_config TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.travel_pricing_config TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.travel_pricing_config TO service_role;


--
-- TOC entry 5697 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE vehicle_brands; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_brands TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_brands TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_brands TO service_role;


--
-- TOC entry 5698 (class 0 OID 0)
-- Dependencies: 331
-- Name: TABLE vehicle_consumption; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_consumption TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_consumption TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_consumption TO service_role;


--
-- TOC entry 5700 (class 0 OID 0)
-- Dependencies: 330
-- Name: SEQUENCE vehicle_consumption_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.vehicle_consumption_id_seq TO anon;
GRANT ALL ON SEQUENCE public.vehicle_consumption_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.vehicle_consumption_id_seq TO service_role;


--
-- TOC entry 5701 (class 0 OID 0)
-- Dependencies: 327
-- Name: TABLE vehicle_models; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_models TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_models TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.vehicle_models TO service_role;


--
-- TOC entry 5702 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 5703 (class 0 OID 0)
-- Dependencies: 367
-- Name: TABLE messages_2025_11_09; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_09 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_09 TO dashboard_user;


--
-- TOC entry 5704 (class 0 OID 0)
-- Dependencies: 368
-- Name: TABLE messages_2025_11_10; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_10 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_10 TO dashboard_user;


--
-- TOC entry 5705 (class 0 OID 0)
-- Dependencies: 369
-- Name: TABLE messages_2025_11_11; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_11 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_11 TO dashboard_user;


--
-- TOC entry 5706 (class 0 OID 0)
-- Dependencies: 370
-- Name: TABLE messages_2025_11_12; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_12 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_12 TO dashboard_user;


--
-- TOC entry 5707 (class 0 OID 0)
-- Dependencies: 371
-- Name: TABLE messages_2025_11_13; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_13 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_13 TO dashboard_user;


--
-- TOC entry 5708 (class 0 OID 0)
-- Dependencies: 373
-- Name: TABLE messages_2025_11_14; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_14 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_14 TO dashboard_user;


--
-- TOC entry 5709 (class 0 OID 0)
-- Dependencies: 374
-- Name: TABLE messages_2025_11_15; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_15 TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages_2025_11_15 TO dashboard_user;


--
-- TOC entry 5710 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 5711 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 5712 (class 0 OID 0)
-- Dependencies: 310
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 5714 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres WITH GRANT OPTION;


--
-- TOC entry 5715 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE buckets_analytics; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets_analytics TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets_analytics TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets_analytics TO anon;


--
-- TOC entry 5717 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres WITH GRANT OPTION;


--
-- TOC entry 5718 (class 0 OID 0)
-- Dependencies: 319
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.prefixes TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.prefixes TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.prefixes TO anon;


--
-- TOC entry 5719 (class 0 OID 0)
-- Dependencies: 314
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- TOC entry 5720 (class 0 OID 0)
-- Dependencies: 315
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- TOC entry 5721 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 5722 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2941 (class 826 OID 18142)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2942 (class 826 OID 18143)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2940 (class 826 OID 18144)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- TOC entry 2967 (class 826 OID 55338)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2969 (class 826 OID 55337)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2968 (class 826 OID 55336)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: cron; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA cron GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2962 (class 826 OID 18145)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2961 (class 826 OID 18146)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- TOC entry 2959 (class 826 OID 18147)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- TOC entry 2966 (class 826 OID 18148)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2965 (class 826 OID 18149)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2964 (class 826 OID 18150)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2952 (class 826 OID 18151)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2955 (class 826 OID 18152)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2953 (class 826 OID 18153)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2946 (class 826 OID 17179)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES TO pgsodium_keyholder;


--
-- TOC entry 2947 (class 826 OID 17178)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO pgsodium_keyholder;


--
-- TOC entry 2948 (class 826 OID 17176)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES TO pgsodium_keyiduser;


--
-- TOC entry 2949 (class 826 OID 17177)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS TO pgsodium_keyiduser;


--
-- TOC entry 2950 (class 826 OID 17175)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO pgsodium_keyiduser;


--
-- TOC entry 2951 (class 826 OID 18154)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2954 (class 826 OID 18155)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2956 (class 826 OID 18156)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2957 (class 826 OID 18157)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2958 (class 826 OID 18158)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2960 (class 826 OID 18159)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 2944 (class 826 OID 18160)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- TOC entry 2945 (class 826 OID 18161)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- TOC entry 2943 (class 826 OID 18162)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- TOC entry 2963 (class 826 OID 18163)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- TOC entry 2938 (class 826 OID 18164)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- TOC entry 2939 (class 826 OID 18165)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- TOC entry 4135 (class 3466 OID 18177)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 4140 (class 3466 OID 18215)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 4134 (class 3466 OID 18176)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 4141 (class 3466 OID 18216)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 4136 (class 3466 OID 18178)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 4137 (class 3466 OID 18179)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2025-11-13 11:32:56

--
-- PostgreSQL database dump complete
--

