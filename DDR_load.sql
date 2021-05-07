SET ECHO ON;

DELETE FROM DDR_RENTAL;
DELETE FROM DDR_ACCOUNT;
DELETE FROM DDR_TITLE_PRICE;
DELETE FROM DDR_TITLE_DIRECTOR;
DELETE FROM DDR_DIRECTOR;
DELETE FROM DDR_TITLE_CAST;
DELETE FROM DDR_CAST;
DELETE FROM DDR_TITLE_GENRE;
DELETE FROM DDR_GENRE;
DELETE FROM DDR_TITLE;
DELETE FROM DDR_PRICE;

ALTER TABLE DDR_CAST MODIFY(cast_id GENERATED AS IDENTITY (START WITH 1));
ALTER TABLE DDR_GENRE MODIFY(genre_id GENERATED AS IDENTITY (START WITH 1));
ALTER TABLE DDR_DIRECTOR MODIFY(director_id GENERATED AS IDENTITY (START WITH 1));
ALTER TABLE DDR_RENTAL MODIFY(rental_code GENERATED AS IDENTITY (START WITH 1));
ALTER TABLE DDR_ACCOUNT MODIFY(customer_no GENERATED AS IDENTITY (START WITH 1));


START C:\cprg250s\finalProject\datascripts\add_price_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_title_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_genre_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_title_genre_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_cast_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_title_cast_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_director_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_title_director_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_title_price_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_account_data.sql
COMMIT;
START C:\cprg250s\finalProject\datascripts\add_rental_data.sql
COMMIT;