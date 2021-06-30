-- Table: dev.user

-- DROP TABLE dev."user";

CREATE TABLE IF NOT EXISTS dev."user"
(
    user_id bigint NOT NULL DEFAULT nextval('dev.user_user_id_seq'::regclass),
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    role character varying(10) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_id_unique UNIQUE (user_id)
)

TABLESPACE pg_default;

ALTER TABLE dev."user"
    OWNER to postgres;


-- Table: dev.child

-- DROP TABLE dev.child;

CREATE TABLE IF NOT EXISTS dev.child
(
    child_id bigint NOT NULL DEFAULT nextval('dev.child_child_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    age integer NOT NULL,
    bio character varying(255) COLLATE pg_catalog."default" NOT NULL,
    location character varying(50) COLLATE pg_catalog."default" NOT NULL,
    partner_id bigint NOT NULL DEFAULT nextval('dev.child_partner_id_seq'::regclass),
    CONSTRAINT child_child_id_key UNIQUE (child_id),
    CONSTRAINT partner_id FOREIGN KEY (partner_id)
        REFERENCES dev.partner (partner_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE dev.child
    OWNER to postgres;


-- Table: dev.partner

-- DROP TABLE dev.partner;

CREATE TABLE IF NOT EXISTS dev.partner
(
    partner_id bigint NOT NULL DEFAULT nextval('dev.partner_partner_id_seq'::regclass),
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    website character varying(255) COLLATE pg_catalog."default" NOT NULL,
    country_code character varying(4) COLLATE pg_catalog."default" NOT NULL,
    phone character varying(10) COLLATE pg_catalog."default" NOT NULL,
    country character varying(10) COLLATE pg_catalog."default" NOT NULL,
    address_line_1 character varying(255) COLLATE pg_catalog."default" NOT NULL,
    address_line_2 character varying(255) COLLATE pg_catalog."default" NOT NULL,
    city character varying(50) COLLATE pg_catalog."default" NOT NULL,
    state character varying(50) COLLATE pg_catalog."default" NOT NULL,
    isapproved boolean NOT NULL,
    user_id bigint NOT NULL DEFAULT nextval('dev.partner_user_id_seq'::regclass),
    CONSTRAINT partner_id_unique UNIQUE (partner_id),
    CONSTRAINT user_id FOREIGN KEY (user_id)
        REFERENCES dev."user" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE dev.partner
    OWNER to postgres;



-- Table: dev.payment

-- DROP TABLE dev.payment;

CREATE TABLE IF NOT EXISTS dev.payment
(
    payment_id bigint NOT NULL DEFAULT nextval('dev.payment_payment_id_seq'::regclass),
    payment_provider character varying(24) COLLATE pg_catalog."default" NOT NULL,
    pmethod_id character varying(80) COLLATE pg_catalog."default",
    status character varying(10) COLLATE pg_catalog."default",
    trans_id character varying(80) COLLATE pg_catalog."default",
    amount double precision NOT NULL DEFAULT 0,
    payment_dt timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
    currency character varying(24) COLLATE pg_catalog."default" NOT NULL,
    currency_symbol character varying(4) COLLATE pg_catalog."default" NOT NULL,
    child_id bigint NOT NULL DEFAULT nextval('dev.payment_child_id_seq'::regclass),
    user_id bigint NOT NULL DEFAULT nextval('dev.payment_user_id_seq'::regclass),
    partner_id bigint NOT NULL DEFAULT nextval('dev.payment_partner_id_seq'::regclass),
    CONSTRAINT payment_payment_id_key UNIQUE (payment_id),
    CONSTRAINT child_id FOREIGN KEY (child_id)
        REFERENCES dev.child (child_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT partner_id FOREIGN KEY (partner_id)
        REFERENCES dev.partner (partner_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT user_id FOREIGN KEY (user_id)
        REFERENCES dev."user" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE dev.payment
    OWNER to postgres;