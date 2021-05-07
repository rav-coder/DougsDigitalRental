SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

set linesize 120
set pagesize 25

TTITLE CENTER 'Lowest Price Movies In A' SKIP CENTER 'Rental Cass' SKIP 3
BTITLE CENTER '--End Of Report--'
COLUMN movie_title FORMAT A100 HEADING 'Title'
COLUMN rental_price FORMAT $0.99 HEADING 'Price'
COLUMN "Format" FORMAT A6
ACCEPT userRental CHAR PROMPT 'Enter the rental class(A, B, C): '

SPOOL C:\cprg250s\finalProject\reports\movies_lowest_price_tier.txt

SELECT movie_title, dp.movie_format "Format" , rental_price
FROM ddr_title dt JOIN ddr_title_price dtp ON (dt.title_code = dtp.title_code)
			   JOIN ddr_price dp ON (dtp.movie_format = dp.movie_format AND dtp.rental_class = dp.rental_class)
WHERE dp.movie_format IN ('SD') AND dp.rental_class IN('&userRental');


SPOOL OFF;
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES
