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

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bans (
    id bigint NOT NULL,
    sub_id bigint,
    user_id bigint NOT NULL,
    banned_by_id bigint NOT NULL,
    reason character varying,
    permanent boolean DEFAULT false NOT NULL,
    days integer,
    end_at timestamp without time zone,
    updated_at timestamp without time zone,
    created_at timestamp without time zone
);


--
-- Name: bans_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bans_id_seq OWNED BY public.bans.id;


--
-- Name: blacklisted_domains; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blacklisted_domains (
    id bigint NOT NULL,
    sub_id bigint,
    domain character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: blacklisted_domains_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blacklisted_domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blacklisted_domains_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blacklisted_domains_id_seq OWNED BY public.blacklisted_domains.id;


--
-- Name: bookmarks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bookmarks (
    id bigint NOT NULL,
    thing_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: bookmarks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bookmarks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bookmarks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bookmarks_id_seq OWNED BY public.bookmarks.id;


--
-- Name: contributors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contributors (
    id bigint NOT NULL,
    sub_id bigint,
    user_id bigint NOT NULL,
    approved_by_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: contributors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contributors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contributors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contributors_id_seq OWNED BY public.contributors.id;


--
-- Name: deletion_reasons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deletion_reasons (
    id bigint NOT NULL,
    sub_id bigint,
    title character varying NOT NULL,
    description character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: deletion_reasons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deletion_reasons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deletion_reasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deletion_reasons_id_seq OWNED BY public.deletion_reasons.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.follows (
    id bigint NOT NULL,
    sub_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.logs (
    id bigint NOT NULL,
    sub_id bigint,
    user_id bigint NOT NULL,
    loggable_id integer,
    loggable_type character varying,
    action integer NOT NULL,
    details json DEFAULT '{}'::json NOT NULL,
    details_html character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: moderators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.moderators (
    id bigint NOT NULL,
    sub_id bigint,
    user_id bigint NOT NULL,
    invited_by_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: moderators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.moderators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: moderators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.moderators_id_seq OWNED BY public.moderators.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    thing_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pages (
    id bigint NOT NULL,
    sub_id bigint,
    edited_by_id bigint NOT NULL,
    title character varying NOT NULL,
    text character varying NOT NULL,
    text_html character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    edited_at timestamp without time zone NOT NULL
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: rate_limits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rate_limits (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    key character varying NOT NULL,
    hits integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rate_limits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rate_limits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rate_limits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rate_limits_id_seq OWNED BY public.rate_limits.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reports (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    thing_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    text character varying NOT NULL
);


--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- Name: rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rules (
    id bigint NOT NULL,
    sub_id bigint,
    title character varying NOT NULL,
    description character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rules_id_seq OWNED BY public.rules.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: subs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subs (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    url character varying NOT NULL,
    follows_count integer DEFAULT 0 NOT NULL,
    description character varying,
    title character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: subs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.subs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: subs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.subs_id_seq OWNED BY public.subs.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    sub_id bigint,
    title character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: things; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.things (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    sub_id bigint NOT NULL,
    post_id bigint,
    comment_id bigint,
    comments_count integer DEFAULT 0 NOT NULL,
    up_votes_count integer DEFAULT 0 NOT NULL,
    down_votes_count integer DEFAULT 0 NOT NULL,
    hot_score double precision DEFAULT 0.0 NOT NULL,
    best_score double precision DEFAULT 0.0 NOT NULL,
    top_score integer DEFAULT 0 NOT NULL,
    controversy_score integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    edited_at timestamp without time zone NOT NULL,
    deleted_at timestamp without time zone,
    deleted boolean DEFAULT false NOT NULL,
    deletion_reason character varying,
    approved_at timestamp without time zone,
    approved boolean DEFAULT false NOT NULL,
    approved_by_id bigint,
    title character varying,
    text character varying,
    text_html character varying,
    explicit boolean DEFAULT false NOT NULL,
    spoiler boolean DEFAULT false NOT NULL,
    tag character varying,
    url character varying,
    file_data character varying,
    thing_type integer NOT NULL,
    content_type integer NOT NULL,
    receive_notifications boolean DEFAULT false NOT NULL,
    ignore_reports boolean DEFAULT false NOT NULL,
    deleted_by_id bigint
);


--
-- Name: things_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.things_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: things_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.things_id_seq OWNED BY public.things.id;


--
-- Name: topics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.topics (
    id bigint NOT NULL,
    post_id bigint NOT NULL,
    branch jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: topics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: topics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying NOT NULL,
    email character varying,
    password_digest character varying NOT NULL,
    forgot_password_token character varying NOT NULL,
    posts_points integer DEFAULT 0 NOT NULL,
    comments_points integer DEFAULT 0 NOT NULL,
    notifications_count integer DEFAULT 0 NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    forgot_password_email_sent_at timestamp without time zone DEFAULT (now())::timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.votes (
    id bigint NOT NULL,
    thing_id bigint NOT NULL,
    user_id bigint NOT NULL,
    vote_type integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: votes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.votes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: votes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.votes_id_seq OWNED BY public.votes.id;


--
-- Name: bans id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bans ALTER COLUMN id SET DEFAULT nextval('public.bans_id_seq'::regclass);


--
-- Name: blacklisted_domains id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blacklisted_domains ALTER COLUMN id SET DEFAULT nextval('public.blacklisted_domains_id_seq'::regclass);


--
-- Name: bookmarks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks ALTER COLUMN id SET DEFAULT nextval('public.bookmarks_id_seq'::regclass);


--
-- Name: contributors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contributors ALTER COLUMN id SET DEFAULT nextval('public.contributors_id_seq'::regclass);


--
-- Name: deletion_reasons id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deletion_reasons ALTER COLUMN id SET DEFAULT nextval('public.deletion_reasons_id_seq'::regclass);


--
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: moderators id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderators ALTER COLUMN id SET DEFAULT nextval('public.moderators_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: rate_limits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limits ALTER COLUMN id SET DEFAULT nextval('public.rate_limits_id_seq'::regclass);


--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- Name: rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rules ALTER COLUMN id SET DEFAULT nextval('public.rules_id_seq'::regclass);


--
-- Name: subs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subs ALTER COLUMN id SET DEFAULT nextval('public.subs_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: things id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things ALTER COLUMN id SET DEFAULT nextval('public.things_id_seq'::regclass);


--
-- Name: topics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: votes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes ALTER COLUMN id SET DEFAULT nextval('public.votes_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bans bans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bans
    ADD CONSTRAINT bans_pkey PRIMARY KEY (id);


--
-- Name: blacklisted_domains blacklisted_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blacklisted_domains
    ADD CONSTRAINT blacklisted_domains_pkey PRIMARY KEY (id);


--
-- Name: bookmarks bookmarks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT bookmarks_pkey PRIMARY KEY (id);


--
-- Name: contributors contributors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contributors
    ADD CONSTRAINT contributors_pkey PRIMARY KEY (id);


--
-- Name: deletion_reasons deletion_reasons_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deletion_reasons
    ADD CONSTRAINT deletion_reasons_pkey PRIMARY KEY (id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: moderators moderators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderators
    ADD CONSTRAINT moderators_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: rate_limits rate_limits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limits
    ADD CONSTRAINT rate_limits_pkey PRIMARY KEY (id);


--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: rules rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT rules_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: subs subs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subs
    ADD CONSTRAINT subs_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: things things_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things
    ADD CONSTRAINT things_pkey PRIMARY KEY (id);


--
-- Name: topics topics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: votes votes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (id);


--
-- Name: index_bans_on_banned_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bans_on_banned_by_id ON public.bans USING btree (banned_by_id);


--
-- Name: index_bans_on_end_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bans_on_end_at ON public.bans USING btree (end_at);


--
-- Name: index_bans_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bans_on_sub_id ON public.bans USING btree (sub_id);


--
-- Name: index_bans_on_sub_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bans_on_sub_id_and_user_id ON public.bans USING btree (sub_id, user_id);


--
-- Name: index_bans_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bans_on_user_id ON public.bans USING btree (user_id);


--
-- Name: index_blacklisted_domains_on_lower_domain; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blacklisted_domains_on_lower_domain ON public.blacklisted_domains USING btree (lower((domain)::text));


--
-- Name: index_blacklisted_domains_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_blacklisted_domains_on_sub_id ON public.blacklisted_domains USING btree (sub_id);


--
-- Name: index_blacklisted_domains_on_sub_id_lower_domain; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_blacklisted_domains_on_sub_id_lower_domain ON public.blacklisted_domains USING btree (sub_id, lower((domain)::text));


--
-- Name: index_bookmarks_on_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookmarks_on_thing_id ON public.bookmarks USING btree (thing_id);


--
-- Name: index_bookmarks_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bookmarks_on_user_id ON public.bookmarks USING btree (user_id);


--
-- Name: index_bookmarks_on_user_id_and_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_bookmarks_on_user_id_and_thing_id ON public.bookmarks USING btree (user_id, thing_id);


--
-- Name: index_contributors_on_approved_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contributors_on_approved_by_id ON public.contributors USING btree (approved_by_id);


--
-- Name: index_contributors_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contributors_on_sub_id ON public.contributors USING btree (sub_id);


--
-- Name: index_contributors_on_sub_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_contributors_on_sub_id_and_user_id ON public.contributors USING btree (sub_id, user_id);


--
-- Name: index_contributors_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contributors_on_user_id ON public.contributors USING btree (user_id);


--
-- Name: index_deletion_reasons_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_deletion_reasons_on_sub_id ON public.deletion_reasons USING btree (sub_id);


--
-- Name: index_follows_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_follows_on_sub_id ON public.follows USING btree (sub_id);


--
-- Name: index_follows_on_sub_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_follows_on_sub_id_and_user_id ON public.follows USING btree (sub_id, user_id);


--
-- Name: index_follows_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_follows_on_user_id ON public.follows USING btree (user_id);


--
-- Name: index_logs_on_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_logs_on_action ON public.logs USING btree (action);


--
-- Name: index_logs_on_loggable_id_and_loggable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_logs_on_loggable_id_and_loggable_type ON public.logs USING btree (loggable_id, loggable_type);


--
-- Name: index_logs_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_logs_on_sub_id ON public.logs USING btree (sub_id);


--
-- Name: index_logs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_logs_on_user_id ON public.logs USING btree (user_id);


--
-- Name: index_moderators_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_moderators_on_invited_by_id ON public.moderators USING btree (invited_by_id);


--
-- Name: index_moderators_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_moderators_on_sub_id ON public.moderators USING btree (sub_id);


--
-- Name: index_moderators_on_sub_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_moderators_on_sub_id_and_user_id ON public.moderators USING btree (sub_id, user_id);


--
-- Name: index_moderators_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_moderators_on_user_id ON public.moderators USING btree (user_id);


--
-- Name: index_notifications_on_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_notifications_on_thing_id ON public.notifications USING btree (thing_id);


--
-- Name: index_notifications_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_user_id ON public.notifications USING btree (user_id);


--
-- Name: index_pages_on_edited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_edited_by_id ON public.pages USING btree (edited_by_id);


--
-- Name: index_pages_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_sub_id ON public.pages USING btree (sub_id);


--
-- Name: index_rate_limits_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rate_limits_on_created_at ON public.rate_limits USING btree (created_at);


--
-- Name: index_rate_limits_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rate_limits_on_key ON public.rate_limits USING btree (key);


--
-- Name: index_rate_limits_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rate_limits_on_user_id ON public.rate_limits USING btree (user_id);


--
-- Name: index_reports_on_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reports_on_thing_id ON public.reports USING btree (thing_id);


--
-- Name: index_reports_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_reports_on_user_id ON public.reports USING btree (user_id);


--
-- Name: index_reports_on_user_id_and_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_reports_on_user_id_and_thing_id ON public.reports USING btree (user_id, thing_id);


--
-- Name: index_rules_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_rules_on_sub_id ON public.rules USING btree (sub_id);


--
-- Name: index_subs_on_lower_url; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_subs_on_lower_url ON public.subs USING btree (lower((url)::text));


--
-- Name: index_subs_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_subs_on_user_id ON public.subs USING btree (user_id);


--
-- Name: index_tags_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tags_on_sub_id ON public.tags USING btree (sub_id);


--
-- Name: index_tags_on_sub_id_lower_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_sub_id_lower_title ON public.tags USING btree (sub_id, lower((title)::text));


--
-- Name: index_things_on_approved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_approved ON public.things USING btree (approved);


--
-- Name: index_things_on_approved_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_approved_by_id ON public.things USING btree (approved_by_id);


--
-- Name: index_things_on_best_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_best_score ON public.things USING btree (best_score);


--
-- Name: index_things_on_comment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_comment_id ON public.things USING btree (comment_id);


--
-- Name: index_things_on_controversy_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_controversy_score ON public.things USING btree (controversy_score);


--
-- Name: index_things_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_created_at ON public.things USING btree (created_at);


--
-- Name: index_things_on_deleted; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_deleted ON public.things USING btree (deleted);


--
-- Name: index_things_on_deleted_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_deleted_by_id ON public.things USING btree (deleted_by_id);


--
-- Name: index_things_on_hot_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_hot_score ON public.things USING btree (hot_score DESC);


--
-- Name: index_things_on_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_post_id ON public.things USING btree (post_id);


--
-- Name: index_things_on_sub_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_sub_id ON public.things USING btree (sub_id);


--
-- Name: index_things_on_thing_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_thing_type ON public.things USING btree (thing_type);


--
-- Name: index_things_on_top_score; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_top_score ON public.things USING btree (top_score);


--
-- Name: index_things_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_things_on_user_id ON public.things USING btree (user_id);


--
-- Name: index_topics_on_post_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_topics_on_post_id ON public.topics USING btree (post_id);


--
-- Name: index_users_on_forgot_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_forgot_password_token ON public.users USING btree (forgot_password_token);


--
-- Name: index_users_on_lower_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_lower_email ON public.users USING btree (lower((email)::text));


--
-- Name: index_users_on_lower_username; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_lower_username ON public.users USING btree (lower((username)::text));


--
-- Name: index_votes_on_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_thing_id ON public.votes USING btree (thing_id);


--
-- Name: index_votes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_user_id ON public.votes USING btree (user_id);


--
-- Name: index_votes_on_user_id_and_thing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_votes_on_user_id_and_thing_id ON public.votes USING btree (user_id, thing_id);


--
-- Name: index_votes_on_vote_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_votes_on_vote_type ON public.votes USING btree (vote_type);


--
-- Name: bans fk_rails_070022cd76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bans
    ADD CONSTRAINT fk_rails_070022cd76 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: things fk_rails_13c43b4a24; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things
    ADD CONSTRAINT fk_rails_13c43b4a24 FOREIGN KEY (approved_by_id) REFERENCES public.users(id);


--
-- Name: bookmarks fk_rails_1db505e406; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_1db505e406 FOREIGN KEY (thing_id) REFERENCES public.things(id);


--
-- Name: bans fk_rails_20d480679b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bans
    ADD CONSTRAINT fk_rails_20d480679b FOREIGN KEY (banned_by_id) REFERENCES public.users(id);


--
-- Name: topics fk_rails_20d6eae1b8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT fk_rails_20d6eae1b8 FOREIGN KEY (post_id) REFERENCES public.things(id);


--
-- Name: things fk_rails_25f037a748; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things
    ADD CONSTRAINT fk_rails_25f037a748 FOREIGN KEY (post_id) REFERENCES public.things(id);


--
-- Name: rules fk_rails_2acf6061a2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rules
    ADD CONSTRAINT fk_rails_2acf6061a2 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: deletion_reasons fk_rails_2ec4f93133; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deletion_reasons
    ADD CONSTRAINT fk_rails_2ec4f93133 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: tags fk_rails_313e753d97; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT fk_rails_313e753d97 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: follows fk_rails_32479bd030; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_rails_32479bd030 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: contributors fk_rails_41647502bc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contributors
    ADD CONSTRAINT fk_rails_41647502bc FOREIGN KEY (approved_by_id) REFERENCES public.users(id);


--
-- Name: notifications fk_rails_4d1f56ac6a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_4d1f56ac6a FOREIGN KEY (thing_id) REFERENCES public.things(id);


--
-- Name: rate_limits fk_rails_503ad46b83; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rate_limits
    ADD CONSTRAINT fk_rails_503ad46b83 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: contributors fk_rails_50cd364c86; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contributors
    ADD CONSTRAINT fk_rails_50cd364c86 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: pages fk_rails_5aaf9853f4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT fk_rails_5aaf9853f4 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: subs fk_rails_67f5376a4c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.subs
    ADD CONSTRAINT fk_rails_67f5376a4c FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: things fk_rails_6f4cb1efd2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things
    ADD CONSTRAINT fk_rails_6f4cb1efd2 FOREIGN KEY (comment_id) REFERENCES public.things(id);


--
-- Name: reports fk_rails_706a779751; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_rails_706a779751 FOREIGN KEY (thing_id) REFERENCES public.things(id);


--
-- Name: contributors fk_rails_75adfa0433; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contributors
    ADD CONSTRAINT fk_rails_75adfa0433 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: votes fk_rails_8a672aea00; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT fk_rails_8a672aea00 FOREIGN KEY (thing_id) REFERENCES public.things(id);


--
-- Name: things fk_rails_8a69a3b738; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things
    ADD CONSTRAINT fk_rails_8a69a3b738 FOREIGN KEY (deleted_by_id) REFERENCES public.users(id);


--
-- Name: logs fk_rails_8fc980bf44; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT fk_rails_8fc980bf44 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: notifications fk_rails_b080fb4855; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_b080fb4855 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: follows fk_rails_b61b5b4590; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_rails_b61b5b4590 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: things fk_rails_b9af16ffb5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things
    ADD CONSTRAINT fk_rails_b9af16ffb5 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: moderators fk_rails_be7d88c486; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderators
    ADD CONSTRAINT fk_rails_be7d88c486 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: moderators fk_rails_bea2ed4b81; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderators
    ADD CONSTRAINT fk_rails_bea2ed4b81 FOREIGN KEY (invited_by_id) REFERENCES public.users(id);


--
-- Name: bookmarks fk_rails_c1ff6fa4ac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bookmarks
    ADD CONSTRAINT fk_rails_c1ff6fa4ac FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: logs fk_rails_c5600a1448; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT fk_rails_c5600a1448 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: reports fk_rails_c7699d537d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT fk_rails_c7699d537d FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: bans fk_rails_c7c525ef40; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bans
    ADD CONSTRAINT fk_rails_c7c525ef40 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: votes fk_rails_c9b3bef597; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.votes
    ADD CONSTRAINT fk_rails_c9b3bef597 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: moderators fk_rails_e69979a229; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moderators
    ADD CONSTRAINT fk_rails_e69979a229 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: things fk_rails_e9811c537d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.things
    ADD CONSTRAINT fk_rails_e9811c537d FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: blacklisted_domains fk_rails_fa89ffc1f3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blacklisted_domains
    ADD CONSTRAINT fk_rails_fa89ffc1f3 FOREIGN KEY (sub_id) REFERENCES public.subs(id);


--
-- Name: pages fk_rails_fdd8b754a1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT fk_rails_fdd8b754a1 FOREIGN KEY (edited_by_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20190604150812'),
('20190607040618'),
('20190614145100'),
('20190614152509'),
('20190614153421'),
('20190614153836'),
('20190614154235'),
('20190616102128'),
('20190616104344'),
('20190616105241'),
('20190619151146'),
('20190624121820'),
('20190709090102'),
('20190709090252'),
('20190709092346'),
('20190709092704'),
('20190716102457'),
('20190716105255'),
('20190716120617'),
('20190716120925'),
('20190716121355'),
('20190716122420'),
('20190716171022'),
('20190716175842'),
('20190717121108'),
('20190717122330'),
('20190717123516'),
('20190717171335'),
('20190721143014'),
('20190721153911'),
('20190721195133'),
('20190721202518'),
('20190721202915'),
('20190722001031');


