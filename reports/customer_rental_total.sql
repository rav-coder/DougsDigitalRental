
SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

set linesize 180
set pagesize 25

TTITLE CENTER 'Rentals for a' SKIP CENTER 'Specific Customer' SKIP 3
BTITLE CENTER '--End Of Report--'

COLUMN "Name" FORMAT A50
COLUMN "Format" FORMAT A6
COLUMN movie_title FORMAT A100 HEADING 'Title'
COLUMN refund_YorN FORMAT A6 HEADING 'Refund'
COLUMN "Price" FORMAT $90.99
ACCEPT fName PROMPT 'Enter the customer first name: '
ACCEPT lName PROMPT 'Enter the customer last name: '

BREAK ON "Name" SKIP 1 ON report

COMPUTE SUM LABEL 'Rental Total: ' OF "Price" ON "Name"


SPOOL C:\cprg250s\finalProject\reports\customer_rental_total.txt

SELECT firstName || ', ' || lastName as "Name", dr.movie_format "Format", movie_title, refund_YorN,
		   case when dr.refund_YorN = 'Y' then rental_price * (0)
		   else rental_price end as "Price"
FROM ddr_account da JOIN ddr_rental dr ON (da.customer_no = dr.customer_no)
					JOIN ddr_title dt ON (dr.title_code = dt.title_code)
					JOIN ddr_title_price dtp ON (dt.title_code = dtp.title_code)
					JOIN ddr_price dp ON (dtp.movie_format = dp.movie_format AND dtp.rental_class = dp.rental_class)
WHERE (UPPER(firstName) LIKE UPPER('&fname%')) AND (UPPER(lastName) LIKE UPPER('&lname%')) AND dp.movie_format = dr.movie_format;

SPOOL OFF;
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

