psql -U postgres
CREATE DATABASE mikolo2;
CREATE ROLE mikolo2 LOGIN PASSWORD 'mikolo2';
ALTER DATABASE mikolo2 OWNER TO mikolo2;
\q

psql -U mikolo2
