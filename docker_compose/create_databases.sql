-- Honest node 1 

CREATE DATABASE honest_node_1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';

ALTER DATABASE honest_node_1 OWNER TO postgres;

\connect honest_node_1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE TABLE public.sat_details (
    satid integer NOT NULL,
    name character varying(12) NOT NULL,
    nationality character varying(4) NOT NULL,
    apogee integer NOT NULL,
    perigee integer NOT NULL,
    inclination integer NOT NULL,
    launchdate date NOT NULL
);


ALTER TABLE public.sat_details OWNER TO postgres;


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('2', 'SPUTNIK 1', 'CIS', '1080000', '64000', '65000', '1957-10-04');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48953', 'ARTHUR-1', 'BEL', '534000', '513000', '97510', '2021-06-30');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48979', 'ONEWEB-0261', 'UK', '463000', '451000', '87410', '2021-07-01');



-- Honest node 2


CREATE DATABASE honest_node_2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';

ALTER DATABASE honest_node_2 OWNER TO postgres;

\connect honest_node_2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE TABLE public.sat_details (
    satid integer NOT NULL,
    name character varying(12) NOT NULL,
    nationality character varying(4) NOT NULL,
    apogee integer NOT NULL,
    perigee integer NOT NULL,
    inclination integer NOT NULL,
    launchdate date NOT NULL
);


ALTER TABLE public.sat_details OWNER TO postgres;


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('2', 'SPUTNIK 1', 'CIS', '1080000', '64000', '65000', '1957-10-04');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48953', 'ARTHUR-1', 'BEL', '534000', '513000', '97510', '2021-06-30');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48979', 'ONEWEB-0261', 'UK', '463000', '451000', '87410', '2021-07-01');




-- Honest node 3


CREATE DATABASE honest_node_3 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';

ALTER DATABASE honest_node_3 OWNER TO postgres;

\connect honest_node_3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE TABLE public.sat_details (
    satid integer NOT NULL,
    name character varying(12) NOT NULL,
    nationality character varying(4) NOT NULL,
    apogee integer NOT NULL,
    perigee integer NOT NULL,
    inclination integer NOT NULL,
    launchdate date NOT NULL
);


ALTER TABLE public.sat_details OWNER TO postgres;



INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('2', 'SPUTNIK 1', 'CIS', '1080000', '64000', '65000', '1957-10-04');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48953', 'ARTHUR-1', 'BEL', '534000', '513000', '97510', '2021-06-30');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48979', 'ONEWEB-0261', 'UK', '463000', '451000', '87410', '2021-07-01');



-- Bad node 1


CREATE DATABASE bad_node_1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';

ALTER DATABASE bad_node_1 OWNER TO postgres;

\connect bad_node_1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE TABLE public.sat_details (
    satid integer NOT NULL,
    name character varying(12) NOT NULL,
    nationality character varying(4) NOT NULL,
    apogee integer NOT NULL,
    perigee integer NOT NULL,
    inclination integer NOT NULL,
    launchdate date NOT NULL
);


ALTER TABLE public.sat_details OWNER TO postgres;


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('2', 'SPK 1', 'LOP', '1000', '1000', '1000', '2000-01-01');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48953', 'Art', 'LEB', '1000', '1000', '1000', '2000-01-01');


INSERT INTO public.sat_details(satId, name, nationality, apogee, perigee, inclination, launchDate) VALUES ('48979', 'WEB', 'POL', '1000', '1000', '1000', '2000-01-01');

