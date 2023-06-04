/*
* Avec des models de laptop contenant la marque
*/

CREATE SEQUENCE seq_id_shop_type START WITH 1;
CREATE TABLE shop_type(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_shop_type'::regclass) NOT NULL,
    name VARCHAR(255) NOT NULL UNIQUE
);

CREATE SEQUENCE seq_id_shop START WITH 1;
CREATE TABLE shop(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_shop'::regclass) NOT NULL,
    localisation VARCHAR(255) NOT NULL UNIQUE,
    id_shop_type INTEGER REFERENCES shop_type(id) DEFAULT 1
);

CREATE SEQUENCE seq_id_profile START WITH 1;
CREATE TABLE profile(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_profile'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES shop(id),
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE SEQUENCE seq_id_brand START WITH 1;
CREATE TABLE brand(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_brand'::regclass) NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE SEQUENCE seq_id_operating_system START WITH 1;
CREATE TABLE operating_system(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_operating_system'::regclass) NOT NULL,
    name VARCHAR(255) NOT NULL
);

CREATE SEQUENCE seq_id_processor START WITH 1;
CREATE TABLE processor(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_processor'::regclass) NOT NULL,
    name VARCHAR NOT NULL UNIQUE,
    frequency NUMERIC NOT NULL CHECK(frequency>0),
    n_core INTEGER NOT NULL CHECK(n_core>0)
);

CREATE SEQUENCE seq_id_ram_option START WITH 1;
CREATE TABLE ram_option(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_ram_option'::regclass) NOT NULL,
    name VARCHAR(10) NOT NULL UNIQUE,
    capacity INTEGER NOT NULL CHECK(capacity > 0)
);
/* 2,4,8,16,32,64,128 */

CREATE SEQUENCE seq_id_storage_option START WITH 1;
CREATE TABLE storage_option(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_storage_option'::regclass) NOT NULL,
    name VARCHAR(10) NOT NULL UNIQUE,
    capacity INTEGER NOT NULL CHECK(capacity > 0)
);
/*256GB:256,512GB:512,1T:1024,2T:2048,4T:4096*/

CREATE SEQUENCE seq_id_laptop_model START WITH 1;
CREATE TABLE laptop_model(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_laptop_model'::regclass) NOT NULL,
    id_brand INTEGER REFERENCES brand(id),
    reference VARCHAR(255) NOT NULL UNIQUE,
    id_ram INTEGER REFERENCES ram_option(id),
    id_storage INTEGER REFERENCES storage_option(id),
    id_processor INTEGER REFERENCES processor(id),
    screen_size INTEGER NOT NULL CHECK(screen_size>0)
);

CREATE SEQUENCE seq_id_laptop START WITH 1;
CREATE TABLE laptop(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_laptop'::regclass) NOT NULL,
    id_model INTEGER REFERENCES laptop_model(id),
    name VARCHAR() NOT NULL,
    id_os INTEGER REFERENCES operating_system(id),
);

CREATE SEQUENCE seq_id_stock_change START WITH 1;
CREATE TABLE stock_change(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_stock_change'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES shop(id),
    id_laptop INTEGER REFERENCES laptop(id),
    date DATE NOT NULL CHECK(date<=now()),
    stock_in INTEGER NOT NULL DEFAULT 0 CHECK(stock_in>=0),
    stock_out INTEGER NOT NULL DEFAULT 0 CHECK(stock_out>=0),
    value NUMERIC NOT NULL CHECK(value>0)
);

CREATE SEQUENCE seq_id_discount START WITH 1;
CREATE TABLE discount(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_discount'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES shop(id),
    id_laptop INTEGER REFERENCES laptop(id),
    date DATE NOT NULL CHECK(date >= now()),
    percentage NUMERIC NOT NULL CHECK(percentage>0)
);

CREATE SEQUENCE seq_id_transfer_request START WITH 1;
CREATE TABLE transfer_request(
    id_shop_from,
    if_shop_to
    id_
);

INSERT INTO shop_type VALUES
(1,'Point de vente'),
(2,'Magasin central');
ALTER SEQUENCE seq_id_shop_type RESTART WITH 3;

INSERT INTO shop VALUES
(1,'Mikolo SHOP CENTER',2);
ALTER SEQUENCE seq_id_shop RESTART WITH 2;

INSERT INTO profile VALUES
(1,1,'asandratra','asandratra.rakotondramaka@gmail.com','asaminya');
ALTER SEQUENCE seq_id_profile RESTART WITH 2;
