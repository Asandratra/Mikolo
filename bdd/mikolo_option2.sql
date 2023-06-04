/*
* Sans subdiviser les laptops en modeles
* Mettre directement la marque du PC dans les attributs de laptop
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
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_my_user'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES user_type(id),
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

CREATE SEQUENCE seq_id_laptop START WITH 1;
CREATE TABLE laptop(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_laptop'::regclass) NOT NULL,
    id_brand INTEGER REFERENCES brand(id),
    id_os INTEGER REFERENCES operating_system(id),
    id_ram INTEGER REFERENCES ram_option(id),
    id_storage INTEGER REFERENCES storage_option(id),
    release_date DATE NOT NULL CHECK(release_date <= now()),
    price NUMERIC NOT NULL CHECK(price>0)
);

CREATE SEQUENCE seq_id_stock_change START WITH 1;
CREATE TABLE stock_change(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_stock_change'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES shop(id),
    id_laptop INTEGER REFERENCES laptop(id),
    date DATE NOT NULL CHECK(date<=now())
    stock_in INTEGER NOT NULL DEFAULT 0 CHECK(stock_in>=0),
    stock_out INTEGER NOT NULL DEFAULT 0 CHECK(stock_out>=0)
);

CREATE SEQUENCE seq_id_discount START WITH 1;
CREATE TABLE discount(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_discount'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES shop(id),
    id_laptop INTEGER REFERENCES laptop(id),
    date DATE NOT NULL CHECK(date >= now()),
    percentage NUMERIC NOT NULL CHECK(percentage>0)
);

CREATE SEQUENCE seq_id_sell START WITH 1;
CREATE TABLE sell(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_sell'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES shop(id),
    id_laptop INTEGER REFERENCES laptop(id),
    date DATE NOT NULL CHECK(date<=now()),
    price NUMERIC NOT NULL CHECK(price>0)
);

INSERT INTO shop_type VALUES
(1,'Point de vente'),
(2,'Magasin central');
ALTER SEQUENCE seq_id_shop_type RESTART WITH 3;

INSERT INTO profile VALUES
(1,2,'asandratra','asandratra.rakotondramaka@gmail.com','asaminya');
ALTER SEQUENCE seq_id_profile RESTART WITH 2;
