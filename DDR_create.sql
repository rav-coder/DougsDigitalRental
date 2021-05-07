SET ECHO ON;

DROP TABLE DDR_TITLE_GENRE;
DROP TABLE DDR_TITLE_CAST;
DROP TABLE DDR_TITLE_DIRECTOR;
DROP TABLE DDR_TITLE_PRICE;

DROP TABLE DDR_RENTAL;
DROP TABLE DDR_ACCOUNT;
DROP TABLE DDR_CAST;
DROP TABLE DDR_DIRECTOR;
DROP TABLE DDR_GENRE;
DROP TABLE DDR_TITLE;
DROP TABLE DDR_PRICE;

CREATE TABLE DDR_PRICE
	(
		movie_format VARCHAR2(2),
		rental_class VARCHAR2(1),
		rental_price NUMBER(3,2) CONSTRAINT DDR_PRICE_RENTAL_PRICE_NN NOT NULL,
		CONSTRAINT DDR_PRICE_MOVIE_FORMAT_CK CHECK( movie_format IN ('SD', 'HD') ),
		CONSTRAINT DDR_PRICE_RENTAL_CLASS_CK CHECK( rental_class IN ('A', 'B', 'C') ),
		PRIMARY KEY(rental_class, movie_format)
	);
	
	
CREATE TABLE DDR_TITLE
	(
		title_code VARCHAR2(15) CONSTRAINT DDR_TITLE_PK PRIMARY KEY,
		rental_class VARCHAR2(1),
		movie_title VARCHAR2(100) CONSTRAINT DDR_TITLE_MOVIE_TITLE_NN NOT NULL,
		star_rating NUMBER(3,2),
		age_rating VARCHAR2(3) CONSTRAINT DDR_TITLE_AGE_RATING_NN NOT NULL,
		runtime NUMBER,
		release_year NUMBER(4),
		plot_summary VARCHAR2(4000),
		CONSTRAINT DDR_TITLE_AGE_RATING_CK CHECK ((age_rating) IN ('G', 'PG', '14A', '18A', 'R')),
		CONSTRAINT DDR_TITLE_RUNTIME_CK CHECK (runtime > 0)
	);
	
	
CREATE TABLE DDR_TITLE_PRICE
	(
		movie_format VARCHAR2(2) ,
		rental_class VARCHAR2(1),
		title_code VARCHAR2(15),
		PRIMARY KEY(movie_format, rental_class, title_code),
		CONSTRAINT DDR_TITLE_PRICE_RENTAL_FORMAT_FK FOREIGN KEY (rental_class, movie_format) 
			REFERENCES DDR_PRICE(rental_class, movie_format),
		CONSTRAINT DDR_TITLE_PRICE_TITLE_CODE_FK FOREIGN KEY (title_code) 
			REFERENCES DDR_TITLE(title_code)
	);


CREATE TABLE DDR_GENRE
	(
		genre_id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
		genre_description VARCHAR(25) CONSTRAINT DDR_GENRE_DESCRIPTION_NN NOT NULL
	);
	
CREATE TABLE DDR_TITLE_GENRE
	(
		genre_id NUMBER,
		title_code VARCHAR2(15),
		PRIMARY KEY(genre_id, title_code),
		CONSTRAINT DDR_TITLE_GENRE_ID_FK FOREIGN KEY (genre_id) 
			REFERENCES DDR_GENRE(genre_id),
		CONSTRAINT DDR_TITLE_GENRE_TITLE_CODE_FK FOREIGN KEY (title_code) 
			REFERENCES DDR_TITLE(title_code)
	);
	
CREATE TABLE DDR_CAST
	(
		cast_id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
		firstName VARCHAR2(25),
		lastName VARCHAR2(25)
	);
	
CREATE TABLE DDR_TITLE_CAST
	(
		cast_id NUMBER,
		title_code VARCHAR2(15),
		PRIMARY KEY(cast_id, title_code),
		CONSTRAINT DDR_TITLE_CAST_ID_FK FOREIGN KEY (cast_id) 
			REFERENCES DDR_CAST(cast_id),
		CONSTRAINT DDR_TITLE_CAST_TITLE_CODE_FK FOREIGN KEY (title_code) 
			REFERENCES DDR_TITLE(title_code)
	);
	
CREATE TABLE DDR_DIRECTOR
	(
		director_id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
		firstName VARCHAR2(25),
		lastName VARCHAR2(25)
	);
	
CREATE TABLE DDR_TITLE_DIRECTOR
	(
		director_id NUMBER,
		title_code VARCHAR2(15),
		PRIMARY KEY(director_id, title_code),
		CONSTRAINT DDR_TITLE_DIRECTOR_ID_FK FOREIGN KEY (director_id) 
			REFERENCES DDR_DIRECTOR(director_id),
		CONSTRAINT DDR_TITLE_DIRECTOR_TITLE_CODE_FK FOREIGN KEY (title_code) 
			REFERENCES DDR_TITLE(title_code)
	);
	
CREATE TABLE DDR_ACCOUNT
	(
		customer_no NUMBER GENERATED AS IDENTITY PRIMARY KEY,
		firstName VARCHAR2(25) CONSTRAINT DDR_ACCOUNT_FIRSTNAME_NN NOT NULL,
		lastName VARCHAR2(25) CONSTRAINT DDR_ACCOUNT_LASTNAME_NN NOT NULL,
		address VARCHAR2(100),
		postal_code VARCHAR2(6),
		phone_number VARCHAR2(12),
		date_of_birth DATE CONSTRAINT DDR_ACCOUNT_BIRTH_DATE_NN NOT NULL,
		payment_card_type VARCHAR2(2) CONSTRAINT DDR_ACCOUNT_PAYMENT_NN NOT NULL,
		card_number VARCHAR2(16) CONSTRAINT DDR_ACCOUNT_CARD_NUMBER_NN NOT NULL,
		CONSTRAINT DDR_ACCOUNT_PHONE_UK UNIQUE (phone_number),
		CONSTRAINT DDR_ACCOUNT_PHONE_NUMBER_CK CHECK (REGEXP_LIKE(phone_number,'[0-9]{3}[.][0-9]{3}[.][0-9]{4}')),
		CONSTRAINT DDR_ACCOUNT_POSTAL_CODE_CK CHECK (REGEXP_LIKE(postal_code,'^[A-Za-z]\d[A-Za-z]\d[A-Za-z]\d$')),
		CONSTRAINT DDR_ACCOUNT_PAYMENT_CK CHECK((payment_card_type) IN ('DB', 'AX', 'MC', 'VS'))
	);

	
CREATE TABLE DDR_RENTAL
	(
		rental_code NUMBER GENERATED AS IDENTITY PRIMARY KEY,
		title_code VARCHAR2(15),
		movie_format VARCHAR2(2),
		customer_no NUMBER,
		rental_date DATE CONSTRAINT DDR_RENTAL_DATE_NN NOT NULL,
		rental_start_date DATE,
		rental_expiry_date DATE,
		customer_rating NUMBER(1),
		refund_YorN VARCHAR2(1),
		CONSTRAINT DDR_RENTAL_CUSTOMER_NUMBER_FK FOREIGN KEY (customer_no) 
			REFERENCES DDR_ACCOUNT(customer_no),
		CONSTRAINT DDR_RENTAL_TITLE_CODE_FK FOREIGN KEY (title_code) 
			REFERENCES DDR_TITLE(title_code),
		CONSTRAINT DDR_RENTAL_START_DATE_CK CHECK( rental_start_date >= rental_date ),
		CONSTRAINT DDR_RENTAL_EXPIRY_DATE_CK CHECK( rental_expiry_date > rental_start_date),
		CONSTRAINT DDR_RENTAL_CUSTOMER_RATING_CK CHECK( customer_rating >= 1 AND customer_rating <= 5)
	);
