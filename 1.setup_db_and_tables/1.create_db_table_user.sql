CREATE DATABASE retail_db;

CREATE USER retail_db_user WITH ENCRYPTED PASSWORD 'retail_user';

GRANT ALL ON DATABASE retail_db TO retail_db_user;