--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.groups (
    id uuid NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.groups OWNER TO postgres;

--
-- Name: lab_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab_files (
    id uuid NOT NULL,
    lab_id uuid NOT NULL,
    file_name character varying(255) NOT NULL,
    file_path character varying(255) NOT NULL
);


ALTER TABLE public.lab_files OWNER TO postgres;

--
-- Name: lab_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab_groups (
    lab_id uuid NOT NULL,
    group_id uuid NOT NULL
);


ALTER TABLE public.lab_groups OWNER TO postgres;

--
-- Name: lab_submission_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab_submission_files (
    id uuid NOT NULL,
    lab_submission_id uuid NOT NULL,
    file_name character varying(255) NOT NULL,
    file_path character varying(255) NOT NULL
);


ALTER TABLE public.lab_submission_files OWNER TO postgres;

--
-- Name: lab_submissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lab_submissions (
    id uuid NOT NULL,
    lab_id uuid,
    student_id uuid,
    grade integer,
    submitted_at timestamp without time zone
);


ALTER TABLE public.lab_submissions OWNER TO postgres;

--
-- Name: labs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.labs (
    id uuid NOT NULL,
    lecturer_id uuid,
    subject_id uuid,
    title character varying(255),
    description text,
    created timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.labs OWNER TO postgres;

--
-- Name: lecturer_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecturer_groups (
    lecturer_id uuid NOT NULL,
    group_id uuid NOT NULL
);


ALTER TABLE public.lecturer_groups OWNER TO postgres;

--
-- Name: lecturer_subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecturer_subjects (
    lecturer_id uuid NOT NULL,
    subject_id uuid NOT NULL
);


ALTER TABLE public.lecturer_subjects OWNER TO postgres;

--
-- Name: lecturers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lecturers (
    user_id uuid NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255)
);


ALTER TABLE public.lecturers OWNER TO postgres;

--
-- Name: students; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.students (
    user_id uuid NOT NULL,
    first_name character varying(255),
    middle_name character varying(255),
    last_name character varying(255),
    group_id uuid
);


ALTER TABLE public.students OWNER TO postgres;

--
-- Name: subjects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subjects (
    id uuid NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.subjects OWNER TO postgres;

--
-- Name: temp_tokens; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.temp_tokens (
    user_id uuid NOT NULL,
    temp_token text NOT NULL,
    code text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone
);


ALTER TABLE public.temp_tokens OWNER TO postgres;

--
-- Name: token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.token (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    refresh_token text NOT NULL,
    ip_address inet NOT NULL,
    user_agent text,
    unique_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone,
    is_revoked boolean DEFAULT false
);


ALTER TABLE public.token OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    role character varying(20) NOT NULL,
    CONSTRAINT users_role_check CHECK (((role)::text = ANY (ARRAY[('admin'::character varying)::text, ('lecturer'::character varying)::text, ('student'::character varying)::text])))
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.groups (id, name) FROM stdin;
546e11a6-1a22-4085-940d-ed76a6d8d952	ПО1-21
2c142c75-6eae-46a5-b249-0cd4ec823c9b	ПО2-21
09e9f3ee-02d4-498d-b4c2-f8b001277fe2	АС-21
293f3e15-40b2-4b5c-9a06-87c651008027	ИВТ2-24
\.


--
-- Data for Name: lab_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab_files (id, lab_id, file_name, file_path) FROM stdin;
\.


--
-- Data for Name: lab_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab_groups (lab_id, group_id) FROM stdin;
\.


--
-- Data for Name: lab_submission_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab_submission_files (id, lab_submission_id, file_name, file_path) FROM stdin;
\.


--
-- Data for Name: lab_submissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lab_submissions (id, lab_id, student_id, grade, submitted_at) FROM stdin;
\.


--
-- Data for Name: labs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.labs (id, lecturer_id, subject_id, title, description, created) FROM stdin;
\.


--
-- Data for Name: lecturer_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecturer_groups (lecturer_id, group_id) FROM stdin;
\.


--
-- Data for Name: lecturer_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecturer_subjects (lecturer_id, subject_id) FROM stdin;
\.


--
-- Data for Name: lecturers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lecturers (user_id, first_name, middle_name, last_name) FROM stdin;
\.


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.students (user_id, first_name, middle_name, last_name, group_id) FROM stdin;
3765ba28-8fd1-4282-aaa2-301b7a4e1243	Алексей	Сергеевич	Петров	546e11a6-1a22-4085-940d-ed76a6d8d952
c75cdc4c-f1a2-45a6-b6ce-1c2a5e45f52b	Мария	Алексеевна	Кузнецова	546e11a6-1a22-4085-940d-ed76a6d8d952
24d516ce-bcbc-4599-96c8-5d29ad8ebb17	Дмитрий	Михайлович	Сидоров	546e11a6-1a22-4085-940d-ed76a6d8d952
f7cfbdbc-10c9-44b5-ab40-26536c43c5ec	Анна	Игоревна	Смирнова	546e11a6-1a22-4085-940d-ed76a6d8d952
09eacf5c-bf6a-4386-8fd0-2c965fe4bd11	Олег	Дмитриевич	Федоров	546e11a6-1a22-4085-940d-ed76a6d8d952
6fe8cb5a-3a13-4839-ac15-2185b8278b03	Елена	Сергеевна	Ковалёва	546e11a6-1a22-4085-940d-ed76a6d8d952
62e33771-fef5-4ce8-b648-3d7069fc5559	Никита	Петрович	Морозов	546e11a6-1a22-4085-940d-ed76a6d8d952
2e85adfb-58c1-401f-86f8-3187d6ff2aa6	Ирина	Андреевна	Волкова	546e11a6-1a22-4085-940d-ed76a6d8d952
94fb598e-e6b0-4bda-8f1a-74cb2e141301	Оксана	Михайловна	Лебедева	546e11a6-1a22-4085-940d-ed76a6d8d952
817cd68d-335d-4077-b51a-7e64a66d1dc7	Максим	Иванович	Козлов	546e11a6-1a22-4085-940d-ed76a6d8d952
31f9b886-d8cc-4d62-b0f5-acfc0dc3f429	Татьяна	Андреевна	Новикова	546e11a6-1a22-4085-940d-ed76a6d8d952
4e04a932-14e5-4e74-9001-83bff91329ba	Кирилл	Сергеевич	Зайцев	546e11a6-1a22-4085-940d-ed76a6d8d952
076d2b43-bfe2-4a79-9b85-11269b813287	Валерия	Алексеевна	Сорокина	546e11a6-1a22-4085-940d-ed76a6d8d952
88bd594d-b1b7-4659-b0ba-cc9fdb2a94b2	Владислав	Павлович	Белов	546e11a6-1a22-4085-940d-ed76a6d8d952
5eca50a6-5494-4f07-93eb-6eb9a020f1a4	Ольга	Игоревна	Комарова	546e11a6-1a22-4085-940d-ed76a6d8d952
ef8b1618-4992-4657-97cb-c8f01a482552	Евгений	Михайлович	Орлов	546e11a6-1a22-4085-940d-ed76a6d8d952
519b7832-f078-4e2d-aba0-6932ea8f42c4	Алиса	Викторовна	Киселёва	546e11a6-1a22-4085-940d-ed76a6d8d952
dee016b5-2f24-4ca6-8dc9-58fe2663ed2d	Вячеслав	Олегович	Макаров	546e11a6-1a22-4085-940d-ed76a6d8d952
48ba261b-5f1c-4be5-9af4-142c11732959	Павел	Владимирович	Гусев	2c142c75-6eae-46a5-b249-0cd4ec823c9b
bc093926-6c17-4e24-a8a3-956d05b2a6fd	Наталья	Андреевна	Белова	2c142c75-6eae-46a5-b249-0cd4ec823c9b
1f077a35-f65f-4db8-9045-ca9e98ea3b65	Сергей	Олегович	Медведев	2c142c75-6eae-46a5-b249-0cd4ec823c9b
448237d0-2fbb-43c1-850b-b27888b8bc87	Юлия	Игоревна	Баранова	2c142c75-6eae-46a5-b249-0cd4ec823c9b
59cefd38-3826-4a10-923f-2bd99000bc9a	Александр	Сергеевич	Виноградов	2c142c75-6eae-46a5-b249-0cd4ec823c9b
fd53c4e2-4323-4446-b18a-3a5d573bdd39	Марина	Петровна	Мельникова	2c142c75-6eae-46a5-b249-0cd4ec823c9b
ec00ae00-1841-48fc-8e20-3485f1b2a724	Игорь	Андреевич	Денисов	2c142c75-6eae-46a5-b249-0cd4ec823c9b
97d3b527-643c-4abb-9900-3bf74e372995	Алина	Сергеевна	Киселёва	2c142c75-6eae-46a5-b249-0cd4ec823c9b
5bdb9930-7042-4eab-926d-44f67e7d33c4	Виктор	Олегович	Блинов	2c142c75-6eae-46a5-b249-0cd4ec823c9b
eac1c7b9-39b0-4f8b-a630-f59a64d3977b	Светлана	Ивановна	Фролова	2c142c75-6eae-46a5-b249-0cd4ec823c9b
6d166c99-b7cd-4d20-9a0a-22af61bb96e1	Роман	Владимирович	Щербаков	2c142c75-6eae-46a5-b249-0cd4ec823c9b
0ee1ad5b-de0e-4ca4-8f05-9c7c58607028	Дарья	Алексеевна	Никитина	2c142c75-6eae-46a5-b249-0cd4ec823c9b
f1a48803-5c3b-49af-93cc-88f05a6e4936	Михаил	Сергеевич	Соболев	2c142c75-6eae-46a5-b249-0cd4ec823c9b
b38f5108-3498-4c64-967a-7e6661ffda2a	Ольга	Михайловна	Рябова	2c142c75-6eae-46a5-b249-0cd4ec823c9b
15792ed1-8cd7-42ba-8aef-b22f6d21e263	Даниил	Андреевич	Симонов	2c142c75-6eae-46a5-b249-0cd4ec823c9b
06720f27-69da-4b92-8bbb-e1a0e73ce54c	Анастасия	Павловна	Горбунова	2c142c75-6eae-46a5-b249-0cd4ec823c9b
c5409e05-60bc-4270-862e-8f13a7ae8fd6	Глеб	Игоревич	Власов	2c142c75-6eae-46a5-b249-0cd4ec823c9b
a7fb6c80-2492-4546-a0ba-e841ef100577	Екатерина	Дмитриевна	Полякова	2c142c75-6eae-46a5-b249-0cd4ec823c9b
6fcd2a1d-6cc9-49f3-8378-c3c4ce9f4eba	Виталий	Викторович	Жуков	2c142c75-6eae-46a5-b249-0cd4ec823c9b
8ad19fa5-91ee-44e3-9e76-56f777dced66	Ксения	Алексеевна	Исаева	2c142c75-6eae-46a5-b249-0cd4ec823c9b
8e7c7e65-7c26-4e81-a137-9d2c0e6071aa	Андрей	Михайлович	Федотов	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
f297a29d-5753-434a-a2ea-a1e26a6291c6	София	Игоревна	Кудрявцева	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
4a7b6022-af8b-4ceb-92b0-fced9674797a	Борис	Владимирович	Осипов	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
e5694bde-e395-4752-9285-805fc12e99d1	Людмила	Петровна	Титова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
27f3354a-62f2-4901-8a36-f5de5294433d	Василий	Алексеевич	Бобров	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
5b6e895a-7187-45d3-88dc-2c3f7e29cfa2	Жанна	Олеговна	Павлова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
c25286f2-e0ea-492f-b6e9-0ddb22bb5cb4	Егор	Михайлович	Дорофеев	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
149a0712-b585-4946-8b92-d0b6342613a3	Тамара	Андреевна	Суханова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
35f9d42a-34f6-4698-9fdb-4356fb0b8b4c	Илья	Петрович	Ефимов	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
a8af231b-110f-4087-890b-168ad9d37c42	Кристина	Алексеевна	Гордеева	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
6f9aa6bc-9102-48c8-926b-0837a2f22948	Руслан	Сергеевич	Князев	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
1284dc8e-2118-415a-a5b4-8208bd54e8a7	Лилия	Михайловна	Самойлова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
2528f170-ba45-4a96-97fd-8e3a9ce84804	Пётр	Андреевич	Прохоров	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
ccc68bf1-670f-4020-bdad-35a875696c3e	Агата	Павловна	Горшкова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
7a7078ae-6fe6-427a-972b-f86a3fa3a017	Артур	Игоревич	Бессонов	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
be1ecf93-7f48-4931-9a38-a0435fbe1506	Яна	Дмитриевна	Миронова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
7c365cee-2a0f-4b87-b482-72c8cc8253b1	Степан	Викторович	Крылов	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
2c7875ae-445e-46bd-b7df-cf80e16c3e52	Вера	Алексеевна	Лаврова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
135a70d7-cf51-4cc0-a5e8-c0a2a167a6f3	Григорий	Михайлович	Антипов	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
c8d7d999-eef3-4307-be26-aff8774f687d	Евгения	Игоревна	Корнилова	09e9f3ee-02d4-498d-b4c2-f8b001277fe2
e8a78c4c-5693-4a20-a264-9639a05fb4c1	Алексей	Олегович	Афанасьев	293f3e15-40b2-4b5c-9a06-87c651008027
78d83370-35a3-4f60-8b50-647fc21ba9bc	Елизавета	Павловна	Громова	293f3e15-40b2-4b5c-9a06-87c651008027
f01351e2-b091-4a6a-9c79-0e82c248bf3b	Иван	Игоревич	Бобров	293f3e15-40b2-4b5c-9a06-87c651008027
d2a70973-e791-4813-ae0f-47968a5a9fa0	Мария	Сергеевна	Воронова	293f3e15-40b2-4b5c-9a06-87c651008027
2c501aa8-b964-4258-adb6-e346b00286b4	Станислав	Викторович	Давыдов	293f3e15-40b2-4b5c-9a06-87c651008027
36a84788-644f-490d-b6df-ab5c67abd44a	Анастасия	Андреевна	Мухина	293f3e15-40b2-4b5c-9a06-87c651008027
a7fefe6d-8141-4179-ae26-406c9f5d2352	Игорь	Петрович	Селезнёв	293f3e15-40b2-4b5c-9a06-87c651008027
b59127bb-b937-4ef0-aec5-d61280dacb1a	Кристина	Игоревна	Сафонова	293f3e15-40b2-4b5c-9a06-87c651008027
c3354e93-9fca-4bcc-aa66-208f18c51613	Владимир	Владимирович	Трофимов	293f3e15-40b2-4b5c-9a06-87c651008027
3748e239-ceaa-4709-b621-9e3252d6a998	Полина	Дмитриевна	Фомина	293f3e15-40b2-4b5c-9a06-87c651008027
9cc52dea-6f61-4984-ada4-28902e603868	Денис	Андреевич	Сидоров	293f3e15-40b2-4b5c-9a06-87c651008027
150ca7cf-78e1-4aa8-9f05-eeb812550d50	Екатерина	Сергеевна	Чернова	293f3e15-40b2-4b5c-9a06-87c651008027
899ad703-0707-4dec-8a89-2dd09c1cf696	Арсений	Михайлович	Галкин	293f3e15-40b2-4b5c-9a06-87c651008027
b1a27612-40ef-4b84-a838-2d696b2b1ef8	Юлия	Ивановна	Романова	293f3e15-40b2-4b5c-9a06-87c651008027
c99157e7-2e57-4572-bf2b-37f34dfed17a	Виктория	Олеговна	Макарова	293f3e15-40b2-4b5c-9a06-87c651008027
461fdafb-a9ca-4c1b-9805-c6942c8af0bf	Артемий	Андреевич	Носов	293f3e15-40b2-4b5c-9a06-87c651008027
13c1f7c2-fe59-4f3b-bea2-7d803c9a19da	Алиса	Петровна	Широкова	293f3e15-40b2-4b5c-9a06-87c651008027
5e48fd28-3fb0-4c3e-8e17-9a620c0293ba	Михаил	Сергеевич	Киселёв	293f3e15-40b2-4b5c-9a06-87c651008027
c77f38f1-5bc0-4fa1-8061-16e7a2e2d83c	Вероника	Дмитриевна	Мартынова	293f3e15-40b2-4b5c-9a06-87c651008027
6507bc02-426c-4b33-98ad-46c4a38983c4	Платон	Иванович	Григорьев	293f3e15-40b2-4b5c-9a06-87c651008027
\.


--
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (id, name) FROM stdin;
\.


--
-- Data for Name: temp_tokens; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.temp_tokens (user_id, temp_token, code, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, password, role) FROM stdin;
3a5dc4b2-8cc2-43eb-b3c4-40cebcbf07d7	test1@mail.ru	$2b$10$gm13m0/oprqgQ15ZUHnRz.Q5OlEdCU.eQHI8S97TfHMKoec.hpcSW	admin
3765ba28-8fd1-4282-aaa2-301b7a4e1243	test3@mail.ru	$2b$10$/UtfKMHexTN8pjOzBSVCu.RViSPU1EQsuZa9WRu3lFEOx2ubuNu3a	student
c75cdc4c-f1a2-45a6-b6ce-1c2a5e45f52b	test4@mail.ru	$2b$10$dO0MhY9shTS1QbVcsM3rDuJqB6k6HOrzWq.GtUzsYKnd5Fanz307O	student
24d516ce-bcbc-4599-96c8-5d29ad8ebb17	test5@mail.ru	$2b$10$1ENEEQ2lrwMWUTxNcTfZrOP0dAomd78l4ixhlCQdmiRc5wzcVaMmK	student
f7cfbdbc-10c9-44b5-ab40-26536c43c5ec	test6@mail.ru	$2b$10$yD5zCgZG.c8UqsUOp0MlWOcR2ZgkYfVCl34vtWrVSaNUEFf7kHXKS	student
09eacf5c-bf6a-4386-8fd0-2c965fe4bd11	test7@mail.ru	$2b$10$nTPL8I4/K9rrzXwrxgUqreBd0ek.dYgAV6hM77ecv6so1eTp51fOe	student
6fe8cb5a-3a13-4839-ac15-2185b8278b03	test8@mail.ru	$2b$10$B4jVOqXsheeDIj5tE7wf0.jGQdfdB59XBbk6/3UoT2Rg5n1d3r31a	student
62e33771-fef5-4ce8-b648-3d7069fc5559	test9@mail.ru	$2b$10$uxV9aipA7Bs2lNTpnRHTOemBBNimklgRQAYlqpMGTOOSj.U2HQaNq	student
2e85adfb-58c1-401f-86f8-3187d6ff2aa6	test10@mail.ru	$2b$10$QacbFXLBvpVHd2/UXFU65ucU4kJ4fMJXYP/XeFtyuZO5V52WhjZWm	student
94fb598e-e6b0-4bda-8f1a-74cb2e141301	test12@mail.ru	$2b$10$VWvSS2PeOqHhPcs0YAbvt.j9eYa5VUi.5VjqXNosfzMUzl65bmzqy	student
817cd68d-335d-4077-b51a-7e64a66d1dc7	test13@mail.ru	$2b$10$zXqrB5HTLtugQVGn4.pAwuFEfAKrCTLP5xLJcJ2SPG.RwGuEkZQFm	student
31f9b886-d8cc-4d62-b0f5-acfc0dc3f429	test14@mail.ru	$2b$10$kfORaIORklwBfbA3zClRfeRl7SiYuC3Ue087AXc34vuMiklhLkDPO	student
4e04a932-14e5-4e74-9001-83bff91329ba	test15@mail.ru	$2b$10$Yh.lOWLOOQsMzyBbvQezde4A3E.x45vsjFWfOFF3grxIZxaM0U8Py	student
076d2b43-bfe2-4a79-9b85-11269b813287	test16@mail.ru	$2b$10$y.B8C9ixlB7KmIBtDrxWnuPMqNC1b65YeiR/3C.yB1oeKWcwKpBhm	student
88bd594d-b1b7-4659-b0ba-cc9fdb2a94b2	test17@mail.ru	$2b$10$IMgFMHnM.Waiirr3IX0R4.e4ZT3eVLi77V15cdwqiIRhbfFQqpaam	student
5eca50a6-5494-4f07-93eb-6eb9a020f1a4	test18@mail.ru	$2b$10$m6ZVGJriJcfbR8GWDb5RiubOip3tHPWPWOWLXgFbmyT3wIKV2jJmq	student
ef8b1618-4992-4657-97cb-c8f01a482552	test19@mail.ru	$2b$10$m1DknSlxUff2IVt9O6oE2upaKetoQgfcwlEPvDvrz.lf3zn58Uny2	student
519b7832-f078-4e2d-aba0-6932ea8f42c4	test20@mail.ru	$2b$10$gVNz5x0iQhHhfnVrYDS.V.hT6EBRB/Fo0PXKaa1513rGE7EnG/SbO	student
dee016b5-2f24-4ca6-8dc9-58fe2663ed2d	test21@mail.ru	$2b$10$y/4QIMU1DJbVMQ73fQq9HuhEHRuIQO0XU9OH5ThoKDZNQlX2uVGg2	student
48ba261b-5f1c-4be5-9af4-142c11732959	test23@mail.ru	$2b$10$bsMogVcjDTeT6IsgAAvuE.7o1ZczVGxuX3nqq9LcdyvznTZqUmHoS	student
bc093926-6c17-4e24-a8a3-956d05b2a6fd	test24@mail.ru	$2b$10$0whPnPpBLzDeDi8mqawotuJBcB0uHevS71UhM7bxEV3J0WyG8vUeO	student
1f077a35-f65f-4db8-9045-ca9e98ea3b65	test25@mail.ru	$2b$10$OYI3EK3xWxqgIcHio3jz4uW.vNLEOYAeuTqigyKc3kZEiRHlhjBca	student
448237d0-2fbb-43c1-850b-b27888b8bc87	test26@mail.ru	$2b$10$D5419N7gR2BuDX3deRSfDec9g4SxpbtEFkzvNuBF6Qub/7U8YcoBq	student
59cefd38-3826-4a10-923f-2bd99000bc9a	test27@mail.ru	$2b$10$jpwNWuO4TBh4T6zYFCX6/uPRlYzwfEhVIXbaF4IEIWJ8xlJ.NRbBW	student
fd53c4e2-4323-4446-b18a-3a5d573bdd39	test28@mail.ru	$2b$10$sj9rjN8gcHeyzaUTMl2FjujWfuI2A90Qc0dd6s0HquqyfYNi7Eye2	student
ec00ae00-1841-48fc-8e20-3485f1b2a724	test29@mail.ru	$2b$10$X8R.TmmA2TF/j65ly2Fleu74Gf5Csh6UGz4tKxKB35GUs2saFjQna	student
97d3b527-643c-4abb-9900-3bf74e372995	test30@mail.ru	$2b$10$4sVidEJ4VYLCVhp5Ik273Oq8Y77ny2JnL1fpMEo1E7qbFVt3sZYQC	student
5bdb9930-7042-4eab-926d-44f67e7d33c4	test31@mail.ru	$2b$10$kG1xSHONy8Xqbqdf5O9moeQWzf0YPp5wFG1P2/SMi8kNdxue4GhJW	student
eac1c7b9-39b0-4f8b-a630-f59a64d3977b	test32@mail.ru	$2b$10$eaBmuah6E2TytMPMmP2Vg.AYqtlkYfZgF5ZGqzYIuRmRsNGmECrlW	student
6d166c99-b7cd-4d20-9a0a-22af61bb96e1	test33@mail.ru	$2b$10$DZ54Jerpn5BZwQ0Gogl4KeGCU2r2UDmnJ1lPXkAdz3NO14aVsP1aW	student
0ee1ad5b-de0e-4ca4-8f05-9c7c58607028	test34@mail.ru	$2b$10$zImiel6pYwRGCSDqGLbP5eovA7f.f7iO0W1jwBTAGS7ZJMk1.7yoe	student
f1a48803-5c3b-49af-93cc-88f05a6e4936	test35@mail.ru	$2b$10$9PELW3AF2DnXlelyFP69Q.TclD.e.Vvs9d1eNJAxoMZrmmqG31KGi	student
b38f5108-3498-4c64-967a-7e6661ffda2a	test36@mail.ru	$2b$10$xIq8vmxGCV29EhgtGXCT0OMfQiezI97Zy/jGZilj.Y1kqIt7Ju/2y	student
15792ed1-8cd7-42ba-8aef-b22f6d21e263	test37@mail.ru	$2b$10$SZOSjSh4Qj6pf3UYIZfmBOeA7.R2ipwn5Ke9Z1ohbb16eGnRQWcse	student
06720f27-69da-4b92-8bbb-e1a0e73ce54c	test38@mail.ru	$2b$10$NmEDpkTCze//AMlAXm97Nu0ZIGIzPz2jAj/HJ8J2tJM3b1wApszGG	student
c5409e05-60bc-4270-862e-8f13a7ae8fd6	test39@mail.ru	$2b$10$qt8wQJSGFXYp1zxzL3GOuu0O3Rao0n/5IQ.Mto/eokV8sQ1A8ARKa	student
a7fb6c80-2492-4546-a0ba-e841ef100577	test40@mail.ru	$2b$10$ArD28iGoY/MM1H35Iy5B/eodBsjsfT3CpxNvjDp7Eeb6./RNa1A5y	student
6fcd2a1d-6cc9-49f3-8378-c3c4ce9f4eba	test41@mail.ru	$2b$10$g9OKRm5tFTXfLUeBX7/7z.gSpzSfcZ.ZsKfchy3g3RSDLlEMmucW.	student
8ad19fa5-91ee-44e3-9e76-56f777dced66	test42@mail.ru	$2b$10$HliXd5kvCXtJVnjvB9N.POPOzCtTsd84Ug3926LkVFg105W3Mr8bK	student
8e7c7e65-7c26-4e81-a137-9d2c0e6071aa	test43@mail.ru	$2b$10$WvhrasAufw//6XTfbUhQMOxlHfRiD6h353p9OPHAcgA/z8qnh8PN2	student
f297a29d-5753-434a-a2ea-a1e26a6291c6	test44@mail.ru	$2b$10$qck4VE.jdDjOPLQmiLxaxeUBE57STxshA/NxI7OeL6lSH1d10..8C	student
4a7b6022-af8b-4ceb-92b0-fced9674797a	test45@mail.ru	$2b$10$.qIE9gsf0Bbyfq5AFmcRQOidxbY5fU5SxMKeex6PK9qqqj8s9yUES	student
e5694bde-e395-4752-9285-805fc12e99d1	test46@mail.ru	$2b$10$jLeFBeLoQAr43qKmqd2k3eOOJW3dOhclvQCMXBEsdAoNSgLHn96Ry	student
27f3354a-62f2-4901-8a36-f5de5294433d	test47@mail.ru	$2b$10$/GckW6anS2cxIZlPvS1gjux1ovDjzVdkcOLzPf1Gc44RmnNM/SLDy	student
5b6e895a-7187-45d3-88dc-2c3f7e29cfa2	test48@mail.ru	$2b$10$1.f46m9kOA9ORun78zkaAek1aZW7iXBuqVaJC10aDuhoPJkdGZxRa	student
c25286f2-e0ea-492f-b6e9-0ddb22bb5cb4	test49@mail.ru	$2b$10$0poPKlaSTKgg6euabpAvWepWNMTxYzvyuLwiPqA4bTkE6nwH3sP4i	student
149a0712-b585-4946-8b92-d0b6342613a3	test50@mail.ru	$2b$10$Ct3JKEzHzrHHXTIIMoTbAOC7yxK4pej9eUo/3z9X98vHCzd/L4MeC	student
35f9d42a-34f6-4698-9fdb-4356fb0b8b4c	test51@mail.ru	$2b$10$mKg10pMyuJD3fZYFEhf7m.D103r10UN35xmSzqHgrLg4EVjz9nbv6	student
a8af231b-110f-4087-890b-168ad9d37c42	test52@mail.ru	$2b$10$Gv1FG1X2iwuvETTQBlJifezFwJ0qtzZtQq5H6ebSEHmRh1X.hzP/K	student
6f9aa6bc-9102-48c8-926b-0837a2f22948	test53@mail.ru	$2b$10$ZEFCvmbz66LludhJOgtmFuEmFbvV3AnfRa72lJyAeEXtkmD5Do61u	student
1284dc8e-2118-415a-a5b4-8208bd54e8a7	test54@mail.ru	$2b$10$yC3BF95pov1puMC4gW04huUCPvB97hQtU1p38wgeufWOFLkkUF30W	student
2528f170-ba45-4a96-97fd-8e3a9ce84804	test55@mail.ru	$2b$10$WnFLGqcafA/3XsdnVdONYu0xwvxa0qTF0BLprR6cLEDCZBb.YcJGK	student
ccc68bf1-670f-4020-bdad-35a875696c3e	test56@mail.ru	$2b$10$GgMAdnNncaUMsETUOZHMwua4IUTB1ulwHWZdpnuqLUlwtnCbMUoSK	student
7a7078ae-6fe6-427a-972b-f86a3fa3a017	test57@mail.ru	$2b$10$fxe7Vvq.kfJq.MFDNUnv0u1EMbCjH2hVFQaqiaV8GS5dloOzavMVm	student
be1ecf93-7f48-4931-9a38-a0435fbe1506	test58@mail.ru	$2b$10$wSuYKMjRrwNdoh3kjm.9n.4gSwRiruTBvoaM0qo23hV2KM2xJZ666	student
7c365cee-2a0f-4b87-b482-72c8cc8253b1	test59@mail.ru	$2b$10$Fi4pnTzWIyXnt.ZEQEIUSewb6el6jdsycrD0YVZCeItVYA/fEACqa	student
2c7875ae-445e-46bd-b7df-cf80e16c3e52	test60@mail.ru	$2b$10$nOGzyYVPmqym13htXM/QBuDuCUvMmJsFXSNPCaog8L6symE7odHUW	student
135a70d7-cf51-4cc0-a5e8-c0a2a167a6f3	test61@mail.ru	$2b$10$K7y9TreoKvH3M9TLdBUMvOHtNEi0OtKSOI6gBJmRbjyuYgGTRa3uS	student
c8d7d999-eef3-4307-be26-aff8774f687d	test62@mail.ru	$2b$10$NmP2.OIhDeNty64ViCln2eJO//XlBjZdm/sv1dh9pCPbqTbt0/QJ2	student
e8a78c4c-5693-4a20-a264-9639a05fb4c1	test63@mail.ru	$2b$10$r6Qldo36nzu13PXseX8UsuwZswE.ytx7rFvj0JcJ2BOr7MnpM484i	student
78d83370-35a3-4f60-8b50-647fc21ba9bc	test64@mail.ru	$2b$10$TiphbOTZ6Y12OrzHc7xMJOw.xi4FjMq5DdvKpEEv2Ms5Ktgnf6eQu	student
f01351e2-b091-4a6a-9c79-0e82c248bf3b	test65@mail.ru	$2b$10$Jdjoey.vtgs0..ZztrLYnO.IPIAz2MWje55wyxAR6KuN857RNZlm6	student
d2a70973-e791-4813-ae0f-47968a5a9fa0	test66@mail.ru	$2b$10$HEUGOr.P7TjZWOrTOGambenZl8VvsCKYErleFuwxhgsfqJrKa0M0u	student
2c501aa8-b964-4258-adb6-e346b00286b4	test67@mail.ru	$2b$10$Pc8hDJ1F5DDwEgYu9o3VZOSDBxHGRrSyXkMuYnY48P4qONH4AiDUa	student
36a84788-644f-490d-b6df-ab5c67abd44a	test68@mail.ru	$2b$10$7xfvp7o4t.DPie3Ert2AqO/P7pS3CV7PZxt2OZgVRVRZJUycs5zU6	student
a7fefe6d-8141-4179-ae26-406c9f5d2352	test69@mail.ru	$2b$10$lEaqW9F2n6gO4T6vlI/0K.orXa54KakTY0wD6LzZ7vvAhFgkO6O8K	student
b59127bb-b937-4ef0-aec5-d61280dacb1a	test70@mail.ru	$2b$10$5uhF59f0tE4fY20nTaLj.uom9ByueEDqvP5USHUgURoefA9BVq4w2	student
c3354e93-9fca-4bcc-aa66-208f18c51613	test71@mail.ru	$2b$10$MWTbb7PXBNBlHBs6Mvchl.zKjeGjqtSOFWpBs0TOFnob9K5myQ/ga	student
3748e239-ceaa-4709-b621-9e3252d6a998	test72@mail.ru	$2b$10$SZq9w3nYP3jHEuhfgcnRne9qkrA4IFmRjkMBPZqWxvj9Ty7DM3j.a	student
9cc52dea-6f61-4984-ada4-28902e603868	test73@mail.ru	$2b$10$lvjmQb23Hb6Y8ogGchtcpeScV/brxEVXKW5Ifwgpr8LdjaAev9NXy	student
150ca7cf-78e1-4aa8-9f05-eeb812550d50	test74@mail.ru	$2b$10$QLHQVjnovbpjMaSg0QQzGOqU8LQDlI25n.qPSuXJhjA7FoC7GVaqC	student
899ad703-0707-4dec-8a89-2dd09c1cf696	test75@mail.ru	$2b$10$G4ay.ComeCfK65HimeyqA.6Zxrqtqceykk2ZGwROT9UZGUBRY9/vW	student
b1a27612-40ef-4b84-a838-2d696b2b1ef8	test76@mail.ru	$2b$10$vWWAoBExU2quKN1O4VkGX.qqrRhHiCHDaeiy3NKcllFu6AiKbtVmG	student
c99157e7-2e57-4572-bf2b-37f34dfed17a	test77@mail.ru	$2b$10$Lio6w8fXlMb6PNmKx1jbJO9uT8/1voNQoKOu.4Ms1VZoeCqUcn43K	student
461fdafb-a9ca-4c1b-9805-c6942c8af0bf	test78@mail.ru	$2b$10$SXItvQiISXrF06Vz53At6.5IXMXIZN4PTeshFtEOm9kYyYsAm8gvm	student
13c1f7c2-fe59-4f3b-bea2-7d803c9a19da	test79@mail.ru	$2b$10$L2u2KXZYpE39jGKzBk12OOl2rnVcwlrkm3Ojk50wQzBJb7qtvJtnK	student
5e48fd28-3fb0-4c3e-8e17-9a620c0293ba	test80@mail.ru	$2b$10$yrm6pWOIbp0YMteorm7PwuHjKfiP0AwaYd2u4ylx6sVawhKh.T5s2	student
c77f38f1-5bc0-4fa1-8061-16e7a2e2d83c	test81@mail.ru	$2b$10$QfbWo5aYWw5v.Qj0wg8KlO.lVScz0T4c0W6W0G5f7vUtRrXelRdS6	student
6507bc02-426c-4b33-98ad-46c4a38983c4	test82@mail.ru	$2b$10$SNxWLgzUf01rSw.wIzq/CuOF99ygd9S1fP0/izu.FXLEEK3ZFsezO	student
\.


--
-- Name: groups groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);


--
-- Name: lab_files lab_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_files
    ADD CONSTRAINT lab_files_pkey PRIMARY KEY (id);


--
-- Name: lab_groups lab_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_groups
    ADD CONSTRAINT lab_groups_pkey PRIMARY KEY (lab_id, group_id);


--
-- Name: lab_submission_files lab_submission_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_submission_files
    ADD CONSTRAINT lab_submission_files_pkey PRIMARY KEY (id);


--
-- Name: lab_submissions lab_submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_submissions
    ADD CONSTRAINT lab_submissions_pkey PRIMARY KEY (id);


--
-- Name: labs labs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labs
    ADD CONSTRAINT labs_pkey PRIMARY KEY (id);


--
-- Name: lecturer_groups lecturer_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer_groups
    ADD CONSTRAINT lecturer_groups_pkey PRIMARY KEY (lecturer_id, group_id);


--
-- Name: lecturer_subjects lecturer_subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer_subjects
    ADD CONSTRAINT lecturer_subjects_pkey PRIMARY KEY (lecturer_id, subject_id);


--
-- Name: lecturers lecturers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_pkey PRIMARY KEY (user_id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (user_id);


--
-- Name: subjects subjects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subjects
    ADD CONSTRAINT subjects_pkey PRIMARY KEY (id);


--
-- Name: temp_tokens temp_tokens_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temp_tokens
    ADD CONSTRAINT temp_tokens_user_id_key UNIQUE (user_id);


--
-- Name: token token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_pkey PRIMARY KEY (id);


--
-- Name: token token_user_id_unique_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_user_id_unique_id_key UNIQUE (user_id, unique_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: lab_files lab_files_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_files
    ADD CONSTRAINT lab_files_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES public.labs(id) ON DELETE CASCADE;


--
-- Name: lab_groups lab_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_groups
    ADD CONSTRAINT lab_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: lab_groups lab_groups_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_groups
    ADD CONSTRAINT lab_groups_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES public.labs(id) ON DELETE CASCADE;


--
-- Name: lab_submission_files lab_submission_files_lab_submission_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_submission_files
    ADD CONSTRAINT lab_submission_files_lab_submission_id_fkey FOREIGN KEY (lab_submission_id) REFERENCES public.lab_submissions(id) ON DELETE CASCADE;


--
-- Name: lab_submissions lab_submissions_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_submissions
    ADD CONSTRAINT lab_submissions_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES public.labs(id) ON DELETE CASCADE;


--
-- Name: lab_submissions lab_submissions_student_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lab_submissions
    ADD CONSTRAINT lab_submissions_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.students(user_id) ON DELETE CASCADE;


--
-- Name: labs labs_lecturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labs
    ADD CONSTRAINT labs_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES public.lecturers(user_id) ON DELETE RESTRICT;


--
-- Name: labs labs_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.labs
    ADD CONSTRAINT labs_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(id) ON DELETE CASCADE;


--
-- Name: lecturer_groups lecturer_groups_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer_groups
    ADD CONSTRAINT lecturer_groups_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE CASCADE;


--
-- Name: lecturer_groups lecturer_groups_lecturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer_groups
    ADD CONSTRAINT lecturer_groups_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES public.lecturers(user_id) ON DELETE CASCADE;


--
-- Name: lecturer_subjects lecturer_subjects_lecturer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer_subjects
    ADD CONSTRAINT lecturer_subjects_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES public.lecturers(user_id) ON DELETE CASCADE;


--
-- Name: lecturer_subjects lecturer_subjects_subject_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturer_subjects
    ADD CONSTRAINT lecturer_subjects_subject_id_fkey FOREIGN KEY (subject_id) REFERENCES public.subjects(id) ON DELETE CASCADE;


--
-- Name: lecturers lecturers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: students students_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_group_id_fkey FOREIGN KEY (group_id) REFERENCES public.groups(id) ON DELETE SET NULL;


--
-- Name: students students_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: temp_tokens temp_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.temp_tokens
    ADD CONSTRAINT temp_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: token token_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.token
    ADD CONSTRAINT token_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

