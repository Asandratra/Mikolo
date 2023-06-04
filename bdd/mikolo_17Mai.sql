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

CREATE SEQUENCE seq_id_laptop START WITH 1;
CREATE TABLE laptop(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_laptop'::regclass) NOT NULL,
    id_brand INTEGER REFERENCES brand(id),
    reference VARCHAR(255) NOT NULL UNIQUE,
    id_ram INTEGER REFERENCES ram_option(id),
    id_storage INTEGER REFERENCES storage_option(id),
    id_processor INTEGER REFERENCES processor(id),
    screen_size INTEGER NOT NULL CHECK(screen_size>0)
);

CREATE SEQUENCE seq_id_transaction_request START WITH 1;
CREATE TABLE transaction_request(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_transaction_request'::regclass) NOT NULL,
    id_shop_from INTEGER REFERENCES shop(id),
    id_shop_to INTEGER REFERENCES shop(id),
    id_laptop INTEGER REFERENCES laptop(id),
    date DATE NOT NULL DEFAULT now() CHECK(date<=now())
);


CREATE SEQUENCE seq_id_reception START WITH 1;
CREATE TABLE reception(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_reception'::regclass) NOT NULL,
    id_transaction INTEGER REFERENCES transaction_request(id),
    quantity INTEGER NOT NULL CHECK(quantity>0),
    date DATE NOT NULL DEFAULT now() CHECK(date<=now())
);

CREATE SEQUENCE seq_id_stock_change START WITH 1;
CREATE TABLE stock_change(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_stock_change'::regclass) NOT NULL,
    id_shop INTEGER REFERENCES shop(id),
    id_laptop INTEGER REFERENCES laptop(id),
    date DATE NOT NULL DEFAULT now() CHECK(date<=now()),
    stock_in INTEGER NOT NULL DEFAULT 0 CHECK(stock_in>=0),
    stock_out INTEGER NOT NULL DEFAULT 0 CHECK(stock_out>=0),
    value NUMERIC NOT NULL CHECK(value>=0)
);

CREATE SEQUENCE seq_id_commission START WITH 1;
CREATE TABLE commission(
    id INTEGER PRIMARY KEY DEFAULT nextval('seq_id_commission'::regclass) NOT NULL,
    total_min NUMERIC NOT NULL DEFAULT 0 CHECK(total_min>=0),
    total_max NUMERIC NOT NULL DEFAULT 0 CHECK(total_max>=0),
    percentage NUMERIC NOT NULL DEFAULT 0 CHECK(percentage>=0 AND percentage<=100)
);

ALTER TABLE transaction_request ADD COLUMN confirmed INTEGER DEFAULT 0;
ALTER TABLE laptop ADD COLUMN name VARCHAR(255) NOT NULL;
ALTER TABLE transaction_request ADD COLUMN n_laptop INTEGER NOT NULL CHECK(n_laptop>0);
ALTER TABLE stock_change drop constraint stock_change_value_check;
ALTER TABLE stock_change add constraint stock_change_value_check CHECK(value>=0);
ALTER TABLE laptop ADD COLUMN price NUMERIC DEFAULT 0 CHECK(price>=0);
UPDATE laptop Set price=1200000;

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

CREATE OR REPLACE VIEW v_transaction_init AS(
    SELECT
    transaction_request.id AS id,
    transaction_request.id_shop_from AS id_shop_from,
    transaction_request.id_shop_to AS id_shop_to,
    transaction_request.id_laptop AS id_laptop,
    transaction_request.date AS date,
    CASE
        WHEN sum(reception.quantity) IS NOT NULL THEN transaction_request.n_laptop - sum(reception.quantity)
        ELSE transaction_request.n_laptop
    END AS n_laptop,
    transaction_request.confirmed AS confirmed
    FROM reception
    FULL JOIN transaction_request ON
    reception.id_transaction = transaction_request.id
    GROUP BY transaction_request.id
);

CREATE OR REPLACE VIEW v_transaction AS(
    SELECT * from v_transaction_init
);


CREATE OR REPLACE VIEW v_stock_init AS(
    SELECT
    id,
    id_shop,
    id_laptop,
    date,
    stock_in,
    stock_out,
    CASE
        WHEN stock_out > 0 THEN 0
        ELSE value
    END AS value
    FROM stock_change
);

CREATE OR REPLACE VIEW v_stock_init1 AS(
    SELECT
    id_laptop,
    sum(value) AS value
    FROM v_stock_init
    WHERE stock_in > 0
    GROUP BY id_laptop
);

CREATE OR REPLACE VIEW v_stock AS(
    SELECT
    max(v_stock_init.id) AS id,
    v_stock_init.id_shop,
    v_stock_init.id_laptop,
    max(v_stock_init.date) AS date,
    sum(v_stock_init.stock_in) AS stock_in,
    sum(v_stock_init.stock_out) AS stock_out,
    avg(v_stock_init1.value) AS value
    FROM v_stock_init
    FULL JOIN v_stock_init1 ON
    v_stock_init.id_laptop=v_stock_init1.id_laptop
    GROUP BY v_stock_init.id_shop,v_stock_init.id_laptop
);

CREATE OR REPLACE VIEW v_stock_by_month AS(
    SELECT *, EXTRACT(MONTH FROM date) from stock_change
);


CREATE OR REPLACE view v_vente_magasin AS(
    SELECT
    max(id) as id,
    id_shop,
    id_laptop,
    date,
    sum(stock_out) as n
    from stock_change
    WHERE stock_out>0 and value>0
    GROUP BY id_shop,id_laptop,date
);

CREATE OR REPLACE view v_profit_magasin AS(
    SELECT
    max(id) as id,
    id_shop,
    date,
    sum(stock_out * value) as n
    from stock_change
    WHERE stock_out>0 and value>0
    GROUP BY id_shop,date
);

/*
* SHOP (id)
* DATE
* LAPTOP (id)
* NOMBRE (stock_out)
* VENTE (value)
* ACHAT (select value from v_stock where id_laptop=id_laptop and id_shop=1)
* PERTE (select sum(n_laptop) from v_transaction where id_laptop=id_laptop and confirmed=1)
*/

CREATE OR REPLACE VIEW v_vente_init AS(
    SELECT
    max(stock_change.id) AS id,
    stock_change.id_shop AS id_shop,
    stock_change.date AS date,
    stock_change.id_laptop AS id_laptop,
    sum(stock_change.stock_out) AS nombre,
    stock_change.value as vente,
    (select value from v_stock where id_laptop=stock_change.id_laptop and id_shop=1) AS achat,
    (select sum(n_laptop) from v_transaction where id_laptop=stock_change.id_laptop and confirmed=1) AS perte
    FROM
    stock_change
    WHERE stock_out>0 AND value>0
    GROUP BY id_shop,date,id_laptop,value
);

CREATE OR REPLACE VIEW v_vente AS(
    SELECT
    id,
    id_shop,
    date,
    id_laptop,
    nombre,
    (nombre*vente) AS vente,
    (nombre*achat) AS achat,
    ((nombre*vente)-(nombre*achat)) AS benefice_brute,
    (perte*achat) AS perte
    FROM v_vente_init
)ORDER BY date ASC;

CREATE OR REPLACE VIEW v_perte AS(
    select 
    EXTRACT(month from date) as id_month,
    EXTRACT(year from date) as year,
    id_laptop,
    sum(n_laptop)*(select value from v_stock where id_laptop=v_transaction.id_laptop and id_shop=1) AS perte
    from v_transaction 
    where confirmed=1
    group by extract(month from date),extract(year from date),id_laptop
);

CREATE OR REPLACE VIEW v_benefice_init AS(
    SELECT
    max(id) AS id,
    EXTRACT(MONTH FROM date) as id_month,
    CASE EXTRACT(MONTH FROM date)
        WHEN 1 THEN 'January'
        WHEN 2 THEN 'February'
        WHEN 3 THEN 'March'
        WHEN 4 THEN 'April'
        WHEN 5 THEN 'May'
        WHEN 6 THEN 'June'
        WHEN 7 THEN 'July'
        WHEN 8 THEN 'August'
        WHEN 9 THEN 'September'
        WHEN 10 THEN 'October'
        WHEN 11 THEN 'November'
        WHEN 12 THEN 'December'
    END AS month,
    EXTRACT(YEAR FROM date) as year,
    sum(vente) AS total_vente,
    sum(achat) AS total_achat,
    sum(benefice_brute) AS total_benefice_brute,
    (SELECT sum(perte) from v_perte where year=EXTRACT(year FROM v_vente.date) and id_month=EXTRACT(month from v_vente.date) GROUP BY id_month,year) AS total_perte
    FROM v_vente
    GROUP BY EXTRACT(MONTH FROM v_vente.date),EXTRACT(YEAR FROM v_vente.date),date
)ORDER BY year,id_month ASC;

CREATE OR REPLACE VIEW v_benefice AS(
    SELECT
    max(id) as id,
    id_month,
    month,
    year,
    sum(total_vente) AS total_vente,
    sum(total_achat) AS total_achat,
    sum(total_benefice_brute) AS total_benefice_brute,
    CASE
        when total_perte>0 THEN total_perte
        ELSE 0.0
    END AS total_perte
    FROM v_benefice_init
    GROUP BY id_month,month,year,total_perte
);
