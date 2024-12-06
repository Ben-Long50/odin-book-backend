--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4 (Debian 16.4-1.pgdg120+2)
-- Dumped by pg_dump version 16.6 (Ubuntu 16.6-1.pgdg22.04+1)

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

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: pawprint_database_user
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO pawprint_database_user;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: pawprint_database_user
--

CREATE TYPE public."UserRole" AS ENUM (
    'USER',
    'GUEST'
);


ALTER TYPE public."UserRole" OWNER TO pawprint_database_user;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Bookmark; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."Bookmark" (
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "profileId" integer NOT NULL,
    "postId" integer NOT NULL
);


ALTER TABLE public."Bookmark" OWNER TO pawprint_database_user;

--
-- Name: Comment; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."Comment" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    body text NOT NULL,
    "postId" integer NOT NULL,
    "profileId" integer
);


ALTER TABLE public."Comment" OWNER TO pawprint_database_user;

--
-- Name: CommentLike; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."CommentLike" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "commentId" integer NOT NULL,
    "profileId" integer NOT NULL
);


ALTER TABLE public."CommentLike" OWNER TO pawprint_database_user;

--
-- Name: CommentLike_id_seq; Type: SEQUENCE; Schema: public; Owner: pawprint_database_user
--

CREATE SEQUENCE public."CommentLike_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."CommentLike_id_seq" OWNER TO pawprint_database_user;

--
-- Name: CommentLike_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pawprint_database_user
--

ALTER SEQUENCE public."CommentLike_id_seq" OWNED BY public."CommentLike".id;


--
-- Name: Comment_id_seq; Type: SEQUENCE; Schema: public; Owner: pawprint_database_user
--

CREATE SEQUENCE public."Comment_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Comment_id_seq" OWNER TO pawprint_database_user;

--
-- Name: Comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pawprint_database_user
--

ALTER SEQUENCE public."Comment_id_seq" OWNED BY public."Comment".id;


--
-- Name: Follow; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."Follow" (
    "profileId" integer NOT NULL,
    "followerId" integer NOT NULL
);


ALTER TABLE public."Follow" OWNER TO pawprint_database_user;

--
-- Name: Notification; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."Notification" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "followerId" integer,
    "followingId" integer,
    "commentId" integer,
    "postLikeId" integer,
    "commentLikeId" integer,
    "postId" integer,
    "notifiedProfileId" integer NOT NULL,
    "profileId" integer NOT NULL
);


ALTER TABLE public."Notification" OWNER TO pawprint_database_user;

--
-- Name: Notification_id_seq; Type: SEQUENCE; Schema: public; Owner: pawprint_database_user
--

CREATE SEQUENCE public."Notification_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Notification_id_seq" OWNER TO pawprint_database_user;

--
-- Name: Notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pawprint_database_user
--

ALTER SEQUENCE public."Notification_id_seq" OWNED BY public."Notification".id;


--
-- Name: Post; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."Post" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "mediaUrl" text NOT NULL,
    body text,
    published boolean DEFAULT true NOT NULL,
    "mediaUploadId" text,
    "profileId" integer NOT NULL
);


ALTER TABLE public."Post" OWNER TO pawprint_database_user;

--
-- Name: PostLike; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."PostLike" (
    id integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "postId" integer NOT NULL,
    "profileId" integer NOT NULL
);


ALTER TABLE public."PostLike" OWNER TO pawprint_database_user;

--
-- Name: PostLike_id_seq; Type: SEQUENCE; Schema: public; Owner: pawprint_database_user
--

CREATE SEQUENCE public."PostLike_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."PostLike_id_seq" OWNER TO pawprint_database_user;

--
-- Name: PostLike_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pawprint_database_user
--

ALTER SEQUENCE public."PostLike_id_seq" OWNED BY public."PostLike".id;


--
-- Name: Post_id_seq; Type: SEQUENCE; Schema: public; Owner: pawprint_database_user
--

CREATE SEQUENCE public."Post_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Post_id_seq" OWNER TO pawprint_database_user;

--
-- Name: Post_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pawprint_database_user
--

ALTER SEQUENCE public."Post_id_seq" OWNED BY public."Post".id;


--
-- Name: Profile; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."Profile" (
    id integer NOT NULL,
    username text NOT NULL,
    species text,
    bio text,
    "profilePicUrl" text,
    birthday timestamp(3) without time zone,
    "userId" integer NOT NULL,
    active boolean NOT NULL,
    breed text,
    "petName" text NOT NULL,
    "profilePicUploadId" text
);


ALTER TABLE public."Profile" OWNER TO pawprint_database_user;

--
-- Name: Profile_id_seq; Type: SEQUENCE; Schema: public; Owner: pawprint_database_user
--

CREATE SEQUENCE public."Profile_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Profile_id_seq" OWNER TO pawprint_database_user;

--
-- Name: Profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pawprint_database_user
--

ALTER SEQUENCE public."Profile_id_seq" OWNED BY public."Profile".id;


--
-- Name: Search; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."Search" (
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "searchedProfileId" integer NOT NULL,
    "profileId" integer NOT NULL
);


ALTER TABLE public."Search" OWNER TO pawprint_database_user;

--
-- Name: User; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public."User" (
    id integer NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    email text NOT NULL,
    password text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "facebookId" text,
    "googleId" text,
    role public."UserRole" NOT NULL
);


ALTER TABLE public."User" OWNER TO pawprint_database_user;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: pawprint_database_user
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO pawprint_database_user;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pawprint_database_user
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO pawprint_database_user;

--
-- Name: session; Type: TABLE; Schema: public; Owner: pawprint_database_user
--

CREATE TABLE public.session (
    sid character varying NOT NULL,
    sess json NOT NULL,
    expire timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.session OWNER TO pawprint_database_user;

--
-- Name: Comment id; Type: DEFAULT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Comment" ALTER COLUMN id SET DEFAULT nextval('public."Comment_id_seq"'::regclass);


--
-- Name: CommentLike id; Type: DEFAULT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."CommentLike" ALTER COLUMN id SET DEFAULT nextval('public."CommentLike_id_seq"'::regclass);


--
-- Name: Notification id; Type: DEFAULT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification" ALTER COLUMN id SET DEFAULT nextval('public."Notification_id_seq"'::regclass);


--
-- Name: Post id; Type: DEFAULT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Post" ALTER COLUMN id SET DEFAULT nextval('public."Post_id_seq"'::regclass);


--
-- Name: PostLike id; Type: DEFAULT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."PostLike" ALTER COLUMN id SET DEFAULT nextval('public."PostLike_id_seq"'::regclass);


--
-- Name: Profile id; Type: DEFAULT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Profile" ALTER COLUMN id SET DEFAULT nextval('public."Profile_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: Bookmark; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."Bookmark" ("createdAt", "profileId", "postId") FROM stdin;
2024-11-07 00:26:48.829	3	2
2024-11-15 12:19:41.194	36	43
2024-12-03 21:47:53.01	3	55
2024-12-03 21:48:09.202	3	53
\.


--
-- Data for Name: Comment; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."Comment" (id, "createdAt", body, "postId", "profileId") FROM stdin;
2	2024-11-07 03:33:33.404	No I'm not. What are you gonna do about it	27	3
3	2024-11-07 03:33:55.687	Ok I'm good now. Now I'm paying attention	27	8
6	2024-11-07 03:36:51.637	Hey don't snitch on me Mikey!	28	3
9	2024-11-07 03:38:46.677	I couldn't eat with the cone 😭	29	8
11	2024-11-07 03:43:10.028	I know they won't do anything to punish me. Cowards	31	3
12	2024-11-07 03:50:34.648	I'm gonna get you when you least expect it	33	3
13	2024-11-07 03:51:05.417	That's actually me, good kitty. You don't have to be afraid	34	8
16	2024-11-07 04:28:42.571	hmmm looks like my evil counterpart the way she is creeping in the bushes	36	8
17	2024-11-08 22:10:03.824	So you're saying that's actually me	39	8
20	2024-11-12 00:39:22.114	Skinny kitty	29	3
22	2024-11-13 23:03:46.448	inquisitive kitty	42	3
23	2024-11-13 23:19:00.075	Little haggis	37	3
24	2024-11-14 09:56:40.522	Very impressive by this website! How did you do the animations? 	43	22
25	2024-11-14 17:02:56.725	Thank you! I worked really hard on it. You're cat is so beautiful 😭	47	3
26	2024-11-14 17:04:31.696	Animations are done with regular css classes linked to animation keyframes. The animations run once when a component mounts in react	43	3
27	2024-11-14 23:17:12.808	RIP you were a good kitty haggis. You will be missed	37	3
28	2024-11-14 23:17:52.662	I look goooood	41	3
29	2024-11-14 23:24:35.029	Plants can be pets too	48	8
32	2024-11-15 09:27:28.573	So much grace going on here!	40	52
33	2024-11-15 10:17:08.569	what a sweet little chonker 	40	53
37	2024-11-18 08:18:25.561	nice dog	50	3
38	2024-11-22 20:39:48.704	Looks like a guy I can get up to some mischief with	53	3
\.


--
-- Data for Name: CommentLike; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."CommentLike" (id, "createdAt", "commentId", "profileId") FROM stdin;
3	2024-11-07 03:34:34.859	2	8
4	2024-11-07 03:34:35.488	3	8
7	2024-11-12 00:38:50.293	11	3
18	2024-11-14 21:05:17.142	25	36
28	2024-11-14 22:17:47.062	24	3
29	2024-11-14 22:17:48.451	26	3
30	2024-11-14 23:16:39.947	25	3
31	2024-11-14 23:17:54.924	28	3
32	2024-11-14 23:24:38.094	29	8
35	2024-11-14 23:27:54.756	22	8
37	2024-11-14 23:57:04.159	24	8
40	2024-11-15 01:01:50.884	26	8
41	2024-11-15 01:03:20.887	27	8
42	2024-11-15 01:03:25.075	23	8
43	2024-11-15 07:33:36.017	17	8
48	2024-11-15 12:19:38.631	24	36
49	2024-11-15 12:19:44.772	26	36
50	2024-11-15 16:29:02.701	33	8
51	2024-11-15 16:29:05.309	32	8
52	2024-11-22 20:32:53.808	37	8
53	2024-11-22 20:40:30.78	11	101
54	2024-11-25 18:33:16.18	38	8
55	2024-12-03 21:48:23.646	38	3
\.


--
-- Data for Name: Follow; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."Follow" ("profileId", "followerId") FROM stdin;
3	9
8	9
9	8
8	10
3	10
9	10
10	8
3	8
22	3
22	36
3	36
36	8
22	8
8	52
83	3
3	98
10	98
8	98
98	8
98	3
101	8
8	101
3	101
98	101
10	101
101	3
\.


--
-- Data for Name: Notification; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."Notification" (id, "createdAt", "followerId", "followingId", "commentId", "postLikeId", "commentLikeId", "postId", "notifiedProfileId", "profileId") FROM stdin;
85	2024-11-07 23:39:51.27	\N	\N	\N	45	\N	\N	10	3
172	2024-11-14 22:17:47.067	\N	\N	\N	\N	28	\N	22	3
247	2024-11-18 06:55:41.873	\N	\N	\N	128	\N	\N	83	3
248	2024-11-18 06:55:49.031	3	83	\N	\N	\N	\N	83	3
249	2024-11-18 08:18:25.565	\N	\N	37	\N	\N	\N	83	3
178	2024-11-14 23:16:53.805	\N	\N	\N	98	\N	\N	22	3
179	2024-11-14 23:17:12.811	\N	\N	27	\N	\N	\N	10	3
94	2024-11-07 23:41:20.26	\N	\N	\N	53	\N	\N	10	3
95	2024-11-08 16:50:32.03	\N	\N	\N	54	\N	\N	9	3
180	2024-11-14 23:17:26.639	\N	\N	\N	99	\N	\N	10	3
25	2024-11-07 03:20:49.477	8	9	\N	\N	\N	\N	9	8
26	2024-11-07 03:20:53.784	\N	\N	\N	14	\N	\N	9	8
27	2024-11-07 03:20:57.154	\N	\N	\N	15	\N	\N	9	8
28	2024-11-07 03:21:00.746	\N	\N	\N	16	\N	\N	9	8
259	2024-11-20 06:49:22.921	\N	\N	\N	137	\N	\N	3	8
33	2024-11-07 03:27:02.457	10	9	\N	\N	\N	\N	9	10
260	2024-11-22 01:01:17.131	98	3	\N	\N	\N	\N	3	98
261	2024-11-22 01:01:28.306	98	10	\N	\N	\N	\N	10	98
262	2024-11-22 01:01:32.77	98	8	\N	\N	\N	\N	8	98
263	2024-11-22 01:02:20.223	8	98	\N	\N	\N	\N	98	8
187	2024-11-14 23:24:35.035	\N	\N	29	\N	\N	\N	36	8
264	2024-11-22 03:22:49.321	3	98	\N	\N	\N	\N	98	3
265	2024-11-22 20:32:53.814	\N	\N	\N	\N	52	\N	3	8
189	2024-11-14 23:24:44.862	8	36	\N	\N	\N	\N	36	8
266	2024-11-22 20:32:56.532	\N	\N	\N	138	\N	\N	83	8
267	2024-11-22 20:33:15.234	\N	\N	\N	\N	\N	51	3	8
268	2024-11-22 20:37:27.409	\N	\N	\N	139	\N	\N	101	8
111	2024-11-12 00:39:22.118	\N	\N	20	\N	\N	\N	10	3
193	2024-11-14 23:27:11.271	\N	\N	\N	107	\N	\N	10	8
269	2024-11-22 20:38:37.058	8	101	\N	\N	\N	\N	101	8
270	2024-11-22 20:38:57.149	\N	\N	\N	140	\N	\N	101	3
195	2024-11-14 23:27:28.284	\N	\N	\N	108	\N	\N	10	8
271	2024-11-22 20:39:48.707	\N	\N	38	\N	\N	\N	101	3
273	2024-11-22 20:40:30.786	\N	\N	\N	\N	53	\N	3	101
274	2024-11-22 20:40:47.317	\N	\N	\N	141	\N	\N	8	101
275	2024-11-23 05:38:39.536	101	8	\N	\N	\N	\N	8	101
276	2024-11-23 05:38:45.901	101	3	\N	\N	\N	\N	3	101
277	2024-11-23 05:38:49.43	101	98	\N	\N	\N	\N	98	101
278	2024-11-23 05:38:56.207	101	10	\N	\N	\N	\N	10	101
201	2024-11-14 23:55:48.667	\N	\N	\N	110	\N	\N	22	8
202	2024-11-14 23:56:51.024	\N	\N	\N	111	\N	\N	36	8
203	2024-11-14 23:57:04.165	\N	\N	\N	\N	37	\N	22	8
279	2024-11-23 15:56:50.176	\N	\N	\N	142	\N	\N	101	3
280	2024-11-23 15:58:16.083	\N	\N	\N	143	\N	\N	101	8
281	2024-11-23 15:58:35.726	\N	\N	\N	144	\N	\N	3	8
130	2024-11-13 23:19:00.084	\N	\N	23	\N	\N	\N	10	3
282	2024-11-25 18:33:16.188	\N	\N	\N	\N	54	\N	3	8
283	2024-11-26 04:11:29.866	\N	\N	\N	145	\N	\N	8	8
67	2024-11-07 04:28:42.574	\N	\N	16	\N	\N	\N	10	8
71	2024-11-07 04:29:13.551	\N	\N	\N	31	\N	\N	10	8
72	2024-11-07 04:29:18.647	\N	\N	\N	32	\N	\N	10	8
73	2024-11-07 04:29:20.839	\N	\N	\N	33	\N	\N	10	8
74	2024-11-07 04:29:22.472	\N	\N	\N	34	\N	\N	10	8
75	2024-11-07 04:29:24.267	\N	\N	\N	35	\N	\N	10	8
76	2024-11-07 04:29:26.726	\N	\N	\N	36	\N	\N	10	8
287	2024-12-03 07:05:21.918	3	101	\N	\N	\N	\N	101	3
288	2024-12-03 21:48:23.656	\N	\N	\N	\N	55	\N	3	3
137	2024-11-14 17:02:56.728	\N	\N	25	\N	\N	\N	22	3
212	2024-11-15 01:02:50.591	8	22	\N	\N	\N	\N	22	8
141	2024-11-14 17:05:04.718	3	22	\N	\N	\N	\N	22	3
144	2024-11-14 19:36:28.457	\N	\N	\N	82	\N	\N	22	34
149	2024-11-14 21:02:44.568	36	22	\N	\N	\N	\N	22	36
155	2024-11-14 21:04:52.63	\N	\N	\N	89	\N	\N	22	36
223	2024-11-15 10:14:40.22	\N	\N	\N	118	\N	\N	22	53
231	2024-11-15 12:19:38.636	\N	\N	\N	\N	48	\N	22	36
234	2024-11-15 16:29:02.722	\N	\N	\N	\N	50	\N	53	8
235	2024-11-15 16:29:05.314	\N	\N	\N	\N	51	\N	52	8
\.


--
-- Data for Name: Post; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."Post" (id, "createdAt", "mediaUrl", body, published, "mediaUploadId", "profileId") FROM stdin;
2	2024-11-06 22:14:39.695	https://res.cloudinary.com/dm4tmla72/image/upload/v1730931279/pawprint/kfcm0rgk5vmevgf83ndm.jpg	This is me and my best friend Mike	t	pawprint/kfcm0rgk5vmevgf83ndm	3
6	2024-11-07 02:26:38.744	https://res.cloudinary.com/dm4tmla72/image/upload/v1730946398/pawprint/vapflkx3lwfmnmumggyh.jpg	Howdy friends & neighbors. . On the farm, we hear a lot of jokes about sheep. We’d tell them to the dog, but he’d herd them all!	t	pawprint/vapflkx3lwfmnmumggyh	9
7	2024-11-07 03:08:42.229	https://res.cloudinary.com/dm4tmla72/image/upload/v1730948921/pawprint/jxrzmmsvnmdmbf09jwsn.jpg	Despite my cuteness I love to fight. I definitely won this fight by the way	t	pawprint/jxrzmmsvnmdmbf09jwsn	3
8	2024-11-07 03:09:09.791	https://res.cloudinary.com/dm4tmla72/image/upload/v1730948948/pawprint/rej2txt3y2g1ifzdscwp.jpg	Full embodiment of anger and fury	t	pawprint/rej2txt3y2g1ifzdscwp	3
10	2024-11-07 03:10:32.735	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949031/pawprint/etevztmmz6mylh8l3a2y.jpg	I always see this guy outside my house and I want to fight him	t	pawprint/etevztmmz6mylh8l3a2y	3
11	2024-11-07 03:11:39.195	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949098/pawprint/qoryyezxhjyjiztbdj56.jpg	Meet my friend Gigi! She’s a pole watcher.	t	pawprint/qoryyezxhjyjiztbdj56	9
12	2024-11-07 03:12:07.029	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949126/pawprint/vdm6yhilbpmsqhgxcq64.jpg	Back in my kitten thug gangster days with my chain	t	pawprint/vdm6yhilbpmsqhgxcq64	3
13	2024-11-07 03:13:02.152	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949181/pawprint/ihw4ygfesexlgddluwom.jpg	I'm freeee! You'll never catch me humans	t	pawprint/ihw4ygfesexlgddluwom	3
14	2024-11-07 03:14:38.416	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949277/pawprint/b9pcabdjhjbvdmromrpr.jpg	I dare you to try and come get your jeans	t	pawprint/b9pcabdjhjbvdmromrpr	3
15	2024-11-07 03:15:44.525	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949343/pawprint/h8crzzbvtooet29abwnm.jpg	I love sleeping	t	pawprint/h8crzzbvtooet29abwnm	8
16	2024-11-07 03:16:12.317	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949371/pawprint/y38wrrhlfco4nag0meca.jpg	My happy place!	t	pawprint/y38wrrhlfco4nag0meca	9
17	2024-11-07 03:16:27.705	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949387/pawprint/rk0bkjcxj8hwntr79wro.jpg	The great explorer of the crevasse	t	pawprint/rk0bkjcxj8hwntr79wro	8
18	2024-11-07 03:17:01.415	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949420/pawprint/aafockzvxrapowapmka9.jpg	Imagining escape	t	pawprint/aafockzvxrapowapmka9	8
19	2024-11-07 03:17:33.619	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949452/pawprint/w8frbflaikqfhgpfnkbf.jpg	Perfectly basket sized	t	pawprint/w8frbflaikqfhgpfnkbf	8
20	2024-11-07 03:19:02.954	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949541/pawprint/ffvk42kvgpagyasphj4z.jpg	No thoughts, just dangle	t	pawprint/ffvk42kvgpagyasphj4z	8
21	2024-11-07 03:20:08.158	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949607/pawprint/qnoaz6bsdwigdpnr5llj.jpg	Mlem	t	pawprint/qnoaz6bsdwigdpnr5llj	8
22	2024-11-07 03:23:06.512	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949786/pawprint/r7lwfrglj0fnr2igakly.jpg	I’m king of my castle!! Wait till u see my Queen!	t	pawprint/r7lwfrglj0fnr2igakly	10
23	2024-11-07 03:23:40.226	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949819/pawprint/mnngxhm9lxcqfikumx9i.jpg	My Queen!!	t	pawprint/mnngxhm9lxcqfikumx9i	10
24	2024-11-07 03:25:02.061	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949901/pawprint/xlrind2inu13pagwgrxg.jpg	Almost Christmas time! I hope I get a tin foil ball	t	pawprint/xlrind2inu13pagwgrxg	8
27	2024-11-07 03:31:14.822	https://res.cloudinary.com/dm4tmla72/image/upload/v1730950274/pawprint/xpqwp6xmjizo1pilkbkb.jpg	Are u paying attention?	t	pawprint/xpqwp6xmjizo1pilkbkb	10
28	2024-11-07 03:35:14.873	https://res.cloudinary.com/dm4tmla72/image/upload/v1730950514/pawprint/cwretepcdcu23ctffeh0.jpg	Evil kitty! They told u not to go there!!	t	pawprint/cwretepcdcu23ctffeh0	10
29	2024-11-07 03:37:35.414	https://res.cloudinary.com/dm4tmla72/image/upload/v1730950654/pawprint/gtiyimleunytyt48tjdr.jpg	Here’s how good kitty lost so much weight!	t	pawprint/gtiyimleunytyt48tjdr	10
30	2024-11-07 03:40:45.536	https://res.cloudinary.com/dm4tmla72/image/upload/v1730950845/pawprint/bkyqrh3rwycaiyqa4s2g.jpg	Trapped inside again ☹️	t	pawprint/bkyqrh3rwycaiyqa4s2g	8
31	2024-11-07 03:41:19.787	https://res.cloudinary.com/dm4tmla72/image/upload/v1730950879/pawprint/tu1k6jrkqsyoopxdmyeb.jpg	Evil Kitty’s surprise for her owners	t	pawprint/tu1k6jrkqsyoopxdmyeb	10
33	2024-11-07 03:46:45.748	https://res.cloudinary.com/dm4tmla72/image/upload/v1730951205/pawprint/rkhqjxrorcjxb2xpvv7c.jpg	Evil kitty is always lurking about in the background!	t	pawprint/rkhqjxrorcjxb2xpvv7c	10
34	2024-11-07 03:50:21.878	https://res.cloudinary.com/dm4tmla72/image/upload/v1730951421/pawprint/hqrzv9hbi0ajmxonxeau.jpg	Noooo! She’s always watching!!!	t	pawprint/hqrzv9hbi0ajmxonxeau	10
35	2024-11-07 03:53:45.578	https://res.cloudinary.com/dm4tmla72/image/upload/v1730951625/pawprint/o4cqehhs5hdkslxposbi.jpg	Merry Mikey!!	t	pawprint/o4cqehhs5hdkslxposbi	10
36	2024-11-07 03:55:47.608	https://res.cloudinary.com/dm4tmla72/image/upload/v1730951747/pawprint/jncsd9ya6y2q5xyyo64d.jpg	Don’t look up!! Is it good or evil kitty?	t	pawprint/jncsd9ya6y2q5xyyo64d	10
37	2024-11-07 04:02:33.703	https://res.cloudinary.com/dm4tmla72/image/upload/v1730952152/pawprint/yy4czkzqhyuyydq5pk7s.jpg	In honor of my old friend Tosh! You rock Haggis Macintosh!!	t	pawprint/yy4czkzqhyuyydq5pk7s	10
39	2024-11-08 18:49:38.806	https://res.cloudinary.com/dm4tmla72/image/upload/v1731091776/pawprint/rtz1ozxa32flxhnfiynd.jpg	Me in my younger days before i became evil	t	pawprint/rtz1ozxa32flxhnfiynd	3
40	2024-11-08 22:09:14.08	https://res.cloudinary.com/dm4tmla72/image/upload/v1731103752/pawprint/gvc3hag14hvbvlzohi13.jpg	My favorite sleeping spot	t	pawprint/gvc3hag14hvbvlzohi13	8
41	2024-11-12 01:14:57.179	https://res.cloudinary.com/dm4tmla72/image/upload/v1731374095/pawprint/fdjms0cdxatgjlr8qj7i.jpg	I'm bootiful 😸	t	pawprint/fdjms0cdxatgjlr8qj7i	3
42	2024-11-12 01:18:54.928	https://res.cloudinary.com/dm4tmla72/image/upload/v1731374332/pawprint/zevop1pcmyfcayfokbal.jpg	You got games on your phone?	t	pawprint/zevop1pcmyfcayfokbal	8
43	2024-11-13 01:39:42.735	https://res.cloudinary.com/dm4tmla72/image/upload/v1731461980/pawprint/neuivondvpovd0rkl42b.jpg	I see human, I attack 😈	t	pawprint/neuivondvpovd0rkl42b	3
47	2024-11-14 09:55:25.03	https://res.cloudinary.com/dm4tmla72/image/upload/v1731578123/pawprint/bg9xzzqrat6wgginzocd.jpg	This is one of the most impressive submissions! Amazing work =) Here is my cat	t	pawprint/bg9xzzqrat6wgginzocd	22
48	2024-11-14 21:01:51.846	https://res.cloudinary.com/dm4tmla72/image/upload/v1731618111/pawprint/lkyrnpsxsjgfwop0j1ug.jpg	A red rose	t	pawprint/lkyrnpsxsjgfwop0j1ug	36
50	2024-11-18 06:55:21.067	https://res.cloudinary.com/dm4tmla72/image/upload/v1731912918/pawprint/neownidpfciqtk9s7guy.png		t	pawprint/neownidpfciqtk9s7guy	83
51	2024-11-20 02:38:01.29	https://res.cloudinary.com/dm4tmla72/image/upload/v1732070279/pawprint/f6x2hlo8gqnnczah1mg2.jpg	Where is my dinner? I demand it immediately	t	pawprint/f6x2hlo8gqnnczah1mg2	3
53	2024-11-22 20:36:52.7	https://res.cloudinary.com/dm4tmla72/image/upload/v1732307810/pawprint/kojupjuqjiy0mynulkkn.jpg	Eyes set on sum ankles	t	pawprint/kojupjuqjiy0mynulkkn	101
54	2024-11-22 20:42:16.029	https://res.cloudinary.com/dm4tmla72/image/upload/v1732308134/pawprint/tqyfxq3bk1goidvurluu.jpg	Witness my beauty. Bow before me in homage and servitude	t	pawprint/tqyfxq3bk1goidvurluu	3
55	2024-11-23 05:38:24.207	https://res.cloudinary.com/dm4tmla72/image/upload/v1732340302/pawprint/hekxoyjllyqdc7tox9ui.jpg	I eat scraps and I plot	t	pawprint/hekxoyjllyqdc7tox9ui	101
\.


--
-- Data for Name: PostLike; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."PostLike" (id, "createdAt", "postId", "profileId") FROM stdin;
110	2024-11-14 23:55:48.662	47	8
111	2024-11-14 23:56:51.016	48	8
116	2024-11-15 01:01:52.945	43	8
117	2024-11-15 09:28:07.316	40	52
118	2024-11-15 10:14:40.214	47	53
119	2024-11-15 10:16:28.403	43	53
11	2024-11-07 03:13:12.051	8	9
12	2024-11-07 03:16:24.285	15	9
13	2024-11-07 03:16:32.748	14	9
14	2024-11-07 03:20:53.78	16	8
15	2024-11-07 03:20:57.149	11	8
16	2024-11-07 03:21:00.744	6	8
120	2024-11-15 12:19:19.332	43	36
18	2024-11-07 03:32:52.353	27	8
19	2024-11-07 03:36:52.998	28	3
20	2024-11-07 03:38:09.422	29	3
21	2024-11-07 03:43:12.779	31	3
24	2024-11-07 03:47:06.16	33	3
28	2024-11-07 03:56:10.328	30	10
31	2024-11-07 04:29:13.538	35	8
32	2024-11-07 04:29:18.642	34	8
33	2024-11-07 04:29:20.836	33	8
34	2024-11-07 04:29:22.465	31	8
35	2024-11-07 04:29:24.26	29	8
36	2024-11-07 04:29:26.721	28	8
128	2024-11-18 06:55:41.859	50	3
45	2024-11-07 23:39:51.266	35	3
137	2024-11-20 06:49:22.859	51	8
138	2024-11-22 20:32:56.524	50	8
49	2024-11-07 23:40:42.467	7	3
50	2024-11-07 23:40:45.551	12	3
51	2024-11-07 23:40:49.473	10	3
52	2024-11-07 23:40:54.571	13	3
53	2024-11-07 23:41:20.253	34	3
54	2024-11-08 16:50:32.023	6	3
139	2024-11-22 20:37:27.406	53	8
57	2024-11-08 22:09:23.542	30	8
58	2024-11-08 22:09:26.974	24	8
59	2024-11-08 22:09:32.159	21	8
60	2024-11-08 22:09:46.434	39	8
61	2024-11-11 23:34:12.915	2	3
140	2024-11-22 20:38:57.143	53	3
63	2024-11-12 00:38:03.229	39	3
64	2024-11-12 00:38:10.476	14	3
141	2024-11-22 20:40:47.302	20	101
66	2024-11-12 01:15:06.33	41	3
142	2024-11-23 15:56:50.163	55	3
143	2024-11-23 15:58:16.079	55	8
144	2024-11-23 15:58:35.722	54	8
145	2024-11-26 04:11:29.855	40	8
79	2024-11-14 09:56:18.336	43	22
82	2024-11-14 19:36:28.45	47	34
89	2024-11-14 21:04:52.619	47	36
90	2024-11-14 21:14:37.172	48	3
98	2024-11-14 23:16:53.8	47	3
99	2024-11-14 23:17:26.635	36	3
101	2024-11-14 23:23:47.686	43	3
103	2024-11-14 23:23:57.651	8	3
106	2024-11-14 23:27:05.54	41	8
107	2024-11-14 23:27:11.263	37	8
108	2024-11-14 23:27:28.28	36	8
109	2024-11-14 23:27:57.092	42	8
\.


--
-- Data for Name: Profile; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."Profile" (id, username, species, bio, "profilePicUrl", birthday, "userId", active, breed, "petName", "profilePicUploadId") FROM stdin;
53	macgroovin			\N	\N	51	t		Default	\N
57	aj4short	\N	\N	\N	\N	55	t	\N	Default	\N
58	ABCD			\N	\N	56	t		Default	\N
9	Billy Bob		Pig	https://res.cloudinary.com/dm4tmla72/image/upload/v1730949628/pawprint/gzupphtyn85dfv7o1y4w.jpg	\N	8	f		Billy Bob	pawprint/gzupphtyn85dfv7o1y4w
10	Mikey			https://res.cloudinary.com/dm4tmla72/image/upload/v1730949597/pawprint/kpbbwbbhvhgyw8ig5rhd.jpg	\N	8	t		Mikey	pawprint/kpbbwbbhvhgyw8ig5rhd
22	Legalunicorn		Hi	https://res.cloudinary.com/dm4tmla72/image/upload/v1731578233/pawprint/zuhvxmdq6b9m7tia6gjd.jpg	\N	20	t		Default	pawprint/zuhvxmdq6b9m7tia6gjd
119	darwv	\N	\N	\N	\N	116	t	\N	Default	\N
121	hamidrobgo009@gmail.com	\N	\N	\N	\N	118	t	\N	Default	\N
104	darwishbasem2@gmail.com	\N	\N	\N	\N	101	t	\N	Default	\N
98	Testiclese	Cat	The best street runt	https://res.cloudinary.com/dm4tmla72/image/upload/v1732307995/pawprint/dgqdqgz6c2wola14ezmx.jpg	\N	96	f		Testiclese	pawprint/dgqdqgz6c2wola14ezmx
12	Test Account	Animal	I am definitely not a human and this is a test account	https://res.cloudinary.com/dm4tmla72/image/upload/v1731471124/pawprint/rbad3fwswx4vixnvveml.png	\N	10	t		Inhuman	pawprint/rbad3fwswx4vixnvveml
101	Goblin	Goblin	The crown jewel of Stonebridge Manor	https://res.cloudinary.com/dm4tmla72/image/upload/v1732307899/pawprint/cwgwgnwbtdemwdtytydg.jpg	\N	96	t		Goblin	pawprint/cwgwgnwbtdemwdtytydg
106	moeezsindhu	\N	\N	\N	\N	103	t	\N	Default	\N
76	odinthedog	\N	\N	\N	\N	74	t	\N	Default	\N
78	sdvsdv	\N	\N	\N	\N	76	t	\N	Default	\N
30	alex	Cat		\N	\N	28	t		Kiki	\N
83	zsmith	Dog		\N	\N	81	t	Portuguese Water Dog	Xailie	\N
111	shettimababashehu57	\N	\N	\N	\N	108	t	\N	Default	\N
20	jawleabhinav7@gmail.com	\N	\N	\N	\N	18	t	\N	Default	\N
115	zahranmarwan751	\N	\N	\N	\N	112	t	\N	Default	\N
34	frandellavedova05@gmail.com	\N	\N	\N	\N	32	t	\N	Default	\N
36	mehrab7fm@gmail.com	\N	\N	\N	\N	34	t	\N	Default	\N
3	Evil kitty	Cat	I'm a mischievous and rambunctious kitty. This is where you can see all the trouble I get myself into!	https://res.cloudinary.com/dm4tmla72/image/upload/v1730931223/pawprint/mbfyqpogiqptmyqvklpu.jpg	\N	3	f	Turkish Angora	Kitty	pawprint/mbfyqpogiqptmyqvklpu
89	lucatonello097	\N	\N	\N	\N	87	t	\N	Default	\N
8	Good kitty	Cat	I'm just a little innocent kitty. This is where you can see all the cute and good things I'm up to!	https://res.cloudinary.com/dm4tmla72/image/upload/v1730941237/pawprint/bevtxnatq9x3te8wv4wx.jpg	\N	3	t	Turkish Angora	Kitty	pawprint/bevtxnatq9x3te8wv4wx
39	Vicokefie	\N	\N	\N	\N	37	t	\N	Default	\N
45	k.sunilkumar8309101725@gmail.com	\N	\N	\N	\N	43	t	\N	Default	\N
52	ScaredOfSpiders			\N	\N	50	t		Koti	\N
\.


--
-- Data for Name: Search; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."Search" ("createdAt", "searchedProfileId", "profileId") FROM stdin;
2024-11-07 03:20:28.253	9	8
2024-11-07 04:28:52.536	3	8
2024-11-18 06:53:29.43	83	3
2024-11-18 17:36:45.981	57	3
2024-11-20 20:35:41.147	12	3
2024-12-03 06:57:42.693	22	8
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public."User" (id, "firstName", "lastName", email, password, "createdAt", "facebookId", "googleId", role) FROM stdin;
74	Odin	The Dog	odinthedog@test.com	$2a$10$C4CIm.SOhw0C2TKXEheZ6ernYdlG/djoFAjM8wxMpcVm2GVtoNlum	2024-11-16 20:52:43.23	\N	\N	USER
3	Ben	Long	benjlong@gmail.com	$2a$10$A/kUIvFhtiwBdjwmasOIEO0BYNa2Qm8eyEzRrrcsfnIO3L4rvlSta	2024-11-06 19:44:24.434	\N	\N	USER
76	sv	sdvs	sdvsdv@gmail.com	$2a$10$UZXa6m5Fo0ENUI.ZdLYyq.a9y8DS9jn2GOQ27S5HAzHLcBnb/178W	2024-11-17 09:54:15.643	\N	\N	USER
8	Carolyn	Long	weblo@gmail.com	$2a$10$UeNzsU1BvugUJHR/.hyz.eDn9wSbvUHzLIK98aSADzNZOSJDUH9Zy	2024-11-07 02:09:21.716	\N	\N	USER
10	Ben	Long	benjlong50@gmail.com	\N	2024-11-07 03:57:33.492	7946038478782488	\N	USER
81	Zachary	Smith	zsmith1228@gmail.com	$2a$10$a9T26r0NAfWR5GWUI3IuROLuHUrCvHL0q6l1QPd8rFVWQtA1PXcxO	2024-11-18 06:51:45.075	\N	\N	USER
18	Jawle	Abhinav	jawleabhinav7@gmail.com	\N	2024-11-14 05:04:57.563	\N	105427941654812141203	USER
87	Luca	Tonello	lucatonello097@gmail.com	$2a$10$HbDtRimeaLnubyEL2tb2Auw.Fo66Rbs3a6zCEHAIFO.ChgxOPNfmm	2024-11-19 19:53:41.572	\N	\N	USER
20	Legal	Unicorn	nyeo700@gmail.com	\N	2024-11-14 09:53:59.543	\N	109125117092353893706	USER
28	Alexandro	Espino	expinole12@gmail.com	\N	2024-11-14 18:28:41.877	\N	118087837617657896973	USER
96	Zach	Long	zachadellic@gmail.com	\N	2024-11-22 00:59:44.9	\N	101652022793143656078	USER
32	Francisco	Della	frandellavedova05@gmail.com	\N	2024-11-14 19:34:53.596	\N	117921246144829508892	USER
34	Mehrab	Farhadzadeh	mehrab7fm@gmail.com	\N	2024-11-14 21:00:24.591	\N	114747979222640896729	USER
37	Victor	Okefie	Vicokefie@gmail.com	$2a$10$aN8JgjWMfo5aIrwq6S84kO5W2dERK1LaxayH6jExxkkL5Lvnfd8U2	2024-11-14 23:28:27.703	\N	\N	USER
101	basem	darwish	darwishbasem2@gmail.com	\N	2024-11-24 12:53:52.461	\N	107531912035628286710	USER
103	Yasir	Moeez	moeezsindhu@gmail.com	$2a$10$UHXEzvwJb3g151LE8fpj6OYQqDl8X.JzohOHDovGTvH4vXMI60VTa	2024-11-26 09:45:34.37	\N	\N	USER
43	sunil	kumAr	k.sunilkumar8309101725@gmail.com	\N	2024-11-15 01:23:58.024	\N	109798637055776226928	USER
108	BabaShehu	Musti	shettimababashehu57@gmail.com	$2a$10$cDXudgN4Cnfp1LItMKuzSOIKm6zU3U/bkX4rOq020sTQkJZJ9p0Da	2024-12-01 10:43:42.219	\N	\N	USER
50	Plamen	Hadzhiev	plmn9595@gmail.com	$2a$10$u9w9fLQYg5hVqZe/44xZXOkhI0RF2rFZeEZGB6P7AtTck8Y7oc7Be	2024-11-15 09:26:14.841	\N	\N	USER
51	Masson	Corlette	massoncorlette07@gmail.com	$2a$10$OTl3S2Nx44JEKDJZGW9wQObSTRGySVA4MWdOyNgh74hToCi6enXhG	2024-11-15 10:13:50.532	\N	\N	USER
112	cfgbgf	vbcxvf	zahranmarwan751@gmail.com	$2a$10$VB8hHZa0XIb6SlA0xj75fe5GTbcasnMMtwaw7dygAO0poWV3bgWES	2024-12-02 19:56:00.914	\N	\N	USER
55	Ajiri	Manuel	aj4short@rocketmail.com	$2a$10$8vYCLqx/m0MZbUtCI8OV.uvcqjus30REmVrdSC7uo/8GUgCLhmej.	2024-11-15 11:13:45.513	\N	\N	USER
56	Ahmed	Hannan	ahmedhannansidra2@gmail.com	$2a$10$5OpyRMzrIAKFfCBIyCWue.8R9SJD9mkT21by.sBENhuZ0399me5aW	2024-11-15 13:14:40.054	\N	\N	USER
116	fcf	ddf	darwv@gn	$2a$10$y.KU4dBJ.kwdO.KaXC81besdimcBPkGo.GUXMesH8eOBOrnhZTkuC	2024-12-03 10:48:21.766	\N	\N	USER
118	Abdul	Hamid	hamidrobgo009@gmail.com	\N	2024-12-03 17:05:42.59	\N	111007965246070512693	USER
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
7af5d1c4-98ab-4710-b8d6-86124a4e81b8	9ff3135411f153917ff34b33b93caaeaa36e4007e9946baec53449cdfda462f9	2024-11-06 00:17:46.217325+00	20240814052314_dev_1	\N	\N	2024-11-06 00:17:45.834786+00	1
ad19eda1-1900-48ac-b7b2-80c44fbf4eef	e9f44eb277ebda733b2972e3789c4e9601171418b00f1800080bc915ba652688	2024-11-06 00:19:42.27725+00	20241106001930_prod_1	\N	\N	2024-11-06 00:19:41.849813+00	1
7e121147-2d43-47b7-8b6b-6248005947f0	0ce48de04bbb6322aecd87bdafc98327d0e4fc0a0668785bb742126ef74863ab	2024-11-06 01:08:02.411893+00	20241106010748_prod_2	\N	\N	2024-11-06 01:08:02.155032+00	1
5cf2b02a-e8e1-4dc2-a099-52c918353db0	ae01478de98d5dd4d4af03f6dc2e27d65721214547b0f744ba69780286ba84d3	2024-11-06 19:27:25.858786+00	20241106192713_prod_3	\N	\N	2024-11-06 19:27:25.610058+00	1
\.


--
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: pawprint_database_user
--

COPY public.session (sid, sess, expire) FROM stdin;
-mGnKjesgSKu2LO1_8cmWG6cYt7U9WU_	{"cookie":{"originalMaxAge":14400000,"expires":"2024-12-04T23:14:47.690Z","secure":true,"httpOnly":true,"path":"/","sameSite":"none"},"passport":{"user":3}}	2024-12-05 02:26:28
\.


--
-- Name: CommentLike_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pawprint_database_user
--

SELECT pg_catalog.setval('public."CommentLike_id_seq"', 55, true);


--
-- Name: Comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pawprint_database_user
--

SELECT pg_catalog.setval('public."Comment_id_seq"', 39, true);


--
-- Name: Notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pawprint_database_user
--

SELECT pg_catalog.setval('public."Notification_id_seq"', 288, true);


--
-- Name: PostLike_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pawprint_database_user
--

SELECT pg_catalog.setval('public."PostLike_id_seq"', 145, true);


--
-- Name: Post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pawprint_database_user
--

SELECT pg_catalog.setval('public."Post_id_seq"', 55, true);


--
-- Name: Profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pawprint_database_user
--

SELECT pg_catalog.setval('public."Profile_id_seq"', 123, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pawprint_database_user
--

SELECT pg_catalog.setval('public."User_id_seq"', 120, true);


--
-- Name: Bookmark Bookmark_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Bookmark"
    ADD CONSTRAINT "Bookmark_pkey" PRIMARY KEY ("profileId", "postId");


--
-- Name: CommentLike CommentLike_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_pkey" PRIMARY KEY (id);


--
-- Name: Comment Comment_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_pkey" PRIMARY KEY (id);


--
-- Name: Follow Follow_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Follow"
    ADD CONSTRAINT "Follow_pkey" PRIMARY KEY ("profileId", "followerId");


--
-- Name: Notification Notification_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_pkey" PRIMARY KEY (id);


--
-- Name: PostLike PostLike_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."PostLike"
    ADD CONSTRAINT "PostLike_pkey" PRIMARY KEY (id);


--
-- Name: Post Post_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_pkey" PRIMARY KEY (id);


--
-- Name: Profile Profile_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Profile"
    ADD CONSTRAINT "Profile_pkey" PRIMARY KEY (id);


--
-- Name: Search Search_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Search"
    ADD CONSTRAINT "Search_pkey" PRIMARY KEY ("searchedProfileId", "profileId");


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (sid);


--
-- Name: Bookmark_profileId_postId_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "Bookmark_profileId_postId_key" ON public."Bookmark" USING btree ("profileId", "postId");


--
-- Name: CommentLike_profileId_commentId_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "CommentLike_profileId_commentId_key" ON public."CommentLike" USING btree ("profileId", "commentId");


--
-- Name: Follow_profileId_followerId_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "Follow_profileId_followerId_key" ON public."Follow" USING btree ("profileId", "followerId");


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE INDEX "IDX_session_expire" ON public.session USING btree (expire);


--
-- Name: PostLike_profileId_postId_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "PostLike_profileId_postId_key" ON public."PostLike" USING btree ("profileId", "postId");


--
-- Name: Profile_username_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "Profile_username_key" ON public."Profile" USING btree (username);


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: User_facebookId_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "User_facebookId_key" ON public."User" USING btree ("facebookId");


--
-- Name: User_googleId_key; Type: INDEX; Schema: public; Owner: pawprint_database_user
--

CREATE UNIQUE INDEX "User_googleId_key" ON public."User" USING btree ("googleId");


--
-- Name: Bookmark Bookmark_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Bookmark"
    ADD CONSTRAINT "Bookmark_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Bookmark Bookmark_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Bookmark"
    ADD CONSTRAINT "Bookmark_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CommentLike CommentLike_commentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES public."Comment"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: CommentLike CommentLike_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."CommentLike"
    ADD CONSTRAINT "CommentLike_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Comment Comment_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Comment Comment_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Comment"
    ADD CONSTRAINT "Comment_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Follow Follow_followerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Follow"
    ADD CONSTRAINT "Follow_followerId_fkey" FOREIGN KEY ("followerId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Follow Follow_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Follow"
    ADD CONSTRAINT "Follow_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_commentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES public."Comment"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_commentLikeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_commentLikeId_fkey" FOREIGN KEY ("commentLikeId") REFERENCES public."CommentLike"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_followingId_followerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_followingId_followerId_fkey" FOREIGN KEY ("followingId", "followerId") REFERENCES public."Follow"("profileId", "followerId") ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_notifiedProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_notifiedProfileId_fkey" FOREIGN KEY ("notifiedProfileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_postLikeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_postLikeId_fkey" FOREIGN KEY ("postLikeId") REFERENCES public."PostLike"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Notification Notification_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Notification"
    ADD CONSTRAINT "Notification_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PostLike PostLike_postId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."PostLike"
    ADD CONSTRAINT "PostLike_postId_fkey" FOREIGN KEY ("postId") REFERENCES public."Post"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: PostLike PostLike_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."PostLike"
    ADD CONSTRAINT "PostLike_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Post Post_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Post"
    ADD CONSTRAINT "Post_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Profile Profile_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Profile"
    ADD CONSTRAINT "Profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Search Search_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Search"
    ADD CONSTRAINT "Search_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Search Search_searchedProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pawprint_database_user
--

ALTER TABLE ONLY public."Search"
    ADD CONSTRAINT "Search_searchedProfileId_fkey" FOREIGN KEY ("searchedProfileId") REFERENCES public."Profile"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO pawprint_database_user;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO pawprint_database_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO pawprint_database_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO pawprint_database_user;


--
-- PostgreSQL database dump complete
--

