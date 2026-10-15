--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

ALTER TABLE ONLY public.games DROP CONSTRAINT games_winner_id_fkey;
ALTER TABLE ONLY public.games DROP CONSTRAINT games_opponent_id_fkey;
ALTER TABLE ONLY public.teams DROP CONSTRAINT teams_pkey;
ALTER TABLE ONLY public.teams DROP CONSTRAINT teams_name_key;
ALTER TABLE ONLY public.games DROP CONSTRAINT games_pkey;
ALTER TABLE public.teams ALTER COLUMN team_id DROP DEFAULT;
ALTER TABLE public.games ALTER COLUMN game_id DROP DEFAULT;
DROP SEQUENCE public.teams_team_id_seq;
DROP TABLE public.teams;
DROP SEQUENCE public.games_game_id_seq;
DROP TABLE public.games;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    year integer NOT NULL,
    round character varying(255) NOT NULL,
    winner_id integer NOT NULL,
    opponent_id integer NOT NULL,
    winner_goals integer NOT NULL,
    opponent_goals integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.teams (
    team_id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.teams OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.teams_team_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teams_team_id_seq OWNER TO freecodecamp;

--
-- Name: teams_team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.teams_team_id_seq OWNED BY public.teams.team_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: teams team_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams ALTER COLUMN team_id SET DEFAULT nextval('public.teams_team_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.games (game_id, year, round, winner_id, opponent_id, winner_goals, opponent_goals) FROM stdin;
97	2018	Final	73	74	4	2
98	2018	Third Place	75	76	2	0
99	2018	Semi-Final	74	76	2	1
100	2018	Semi-Final	73	75	1	0
101	2018	Quarter-Final	74	77	3	2
102	2018	Quarter-Final	76	78	2	0
103	2018	Quarter-Final	75	79	2	1
104	2018	Quarter-Final	73	80	2	0
105	2018	Eighth-Final	76	81	2	1
106	2018	Eighth-Final	78	82	1	0
107	2018	Eighth-Final	75	83	3	2
108	2018	Eighth-Final	79	84	2	0
109	2018	Eighth-Final	74	85	2	1
110	2018	Eighth-Final	77	86	2	1
111	2018	Eighth-Final	80	87	2	1
112	2018	Eighth-Final	73	88	4	3
113	2014	Final	89	88	1	0
114	2014	Third Place	90	79	3	0
115	2014	Semi-Final	88	90	1	0
116	2014	Semi-Final	89	79	7	1
117	2014	Quarter-Final	90	91	1	0
118	2014	Quarter-Final	88	75	1	0
119	2014	Quarter-Final	79	81	2	1
120	2014	Quarter-Final	89	73	1	0
121	2014	Eighth-Final	79	92	2	1
122	2014	Eighth-Final	81	80	2	0
123	2014	Eighth-Final	73	93	2	0
124	2014	Eighth-Final	89	94	2	1
125	2014	Eighth-Final	90	84	2	1
126	2014	Eighth-Final	91	95	2	1
127	2014	Eighth-Final	88	82	1	0
128	2014	Eighth-Final	75	96	2	1
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

COPY public.teams (team_id, name) FROM stdin;
73	France
74	Croatia
75	Belgium
76	England
77	Russia
78	Sweden
79	Brazil
80	Uruguay
81	Colombia
82	Switzerland
83	Japan
84	Mexico
85	Denmark
86	Spain
87	Portugal
88	Argentina
89	Germany
90	Netherlands
91	Costa Rica
92	Chile
93	Nigeria
94	Algeria
95	Greece
96	United States
\.


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 128, true);


--
-- Name: teams_team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.teams_team_id_seq', 96, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: teams teams_name_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_name_key UNIQUE (name);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (team_id);


--
-- Name: games games_opponent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_opponent_id_fkey FOREIGN KEY (opponent_id) REFERENCES public.teams(team_id);


--
-- Name: games games_winner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_winner_id_fkey FOREIGN KEY (winner_id) REFERENCES public.teams(team_id);


--
-- PostgreSQL database dump complete
--

