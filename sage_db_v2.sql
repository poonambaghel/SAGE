CREATE TABLE "user"
(
    user_id SERIAL NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(20) NOT NULL,
	  reg_date DATE NOT NULL,
	  last_login timestamptz,
    PRIMARY KEY (user_id)
)

CREATE TABLE partner
(
  partner_id SERIAL NOT NULL UNIQUE,
	name VARCHAR(100) NOT NULL UNIQUE,
	website VARCHAR(255),
  description TEXT,
	phone_prefix VARCHAR(4) NOT NULL,
	phone VARCHAR(10) NOT NULL,
	country VARCHAR(30) NOT NULL,
	address_line1 VARCHAR(255) NOT NULL,
	address_line2 VARCHAR(255),
	city VARCHAR(80) NOT NULL,
	state VARCHAR(80) NOT NULL,
	status VARCHAR(15) DEFAULT 'pending',
  PRIMARY KEY (partner_id),
	user_id SERIAL,
	CONSTRAINT user_id
    FOREIGN KEY(user_id) 
	  REFERENCES "user"(user_id)
	  ON DELETE RESTRICT
)

CREATE TABLE child
(
  child_id SERIAL NOT NULL UNIQUE,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50),
	dob DATE NOT NULL,
	gender VARCHAR(20) DEFAULT 'female',
	bio TEXT,
	location VARCHAR(80),
  PRIMARY KEY (child_id),
	partner_id SERIAL,
	CONSTRAINT partner_id
    FOREIGN KEY(partner_id) 
	  REFERENCES partner(partner_id)
	  ON DELETE RESTRICT
	  ON UPDATE RESTRICT
)

CREATE TABLE payment
(
  payment_id SERIAL NOT NULL UNIQUE,
	payment_provider VARCHAR(24),
  status VARCHAR(20),
	trans_id VARCHAR(225),
	amount int,
	payment_dt timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
	currency VARCHAR(40),
	currency_symbol VARCHAR(20),
    PRIMARY KEY (payment_id),
	child_id SERIAL,
	user_id SERIAL,
	CONSTRAINT user_id
    FOREIGN KEY(user_id) 
	  REFERENCES "user"(user_id)
	  ON DELETE RESTRICT
	  ON UPDATE RESTRICT,
	CONSTRAINT child_id
    FOREIGN KEY(child_id) 
	  REFERENCES child(child_id)
	  ON DELETE RESTRICT
	  ON UPDATE RESTRICT
	
)

