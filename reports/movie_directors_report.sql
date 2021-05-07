SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

SET LINESIZE 180
SET PAGESIZE 15

TTITLE CENTER 'Movies For A' SKIP CENTER 'Specific Director' SKIP 3
BTITLE CENTER '--End Of Report--'

COLUMN movie_title FORMAT A100 HEADING 'Title'
COLUMN "FirstName" FORMAT A25
COLUMN "LastName" FORMAT A25

ACCEPT fName PROMPT 'Enter the director first name: '
ACCEPT lName PROMPT 'Enter the director last name: '

SPOOL C:\cprg250s\finalProject\reports\movies_directors_report.txt

SELECT d.firstName "FirstName", d.lastName "LastName", d.director_id "Director ID" , movie_title
FROM ddr_title t join ddr_title_director td on (t.title_code = td.title_code)
				 join ddr_director d on (td.director_id = d.director_id)
WHERE (UPPER(firstName) LIKE UPPER('&fname%')) AND (UPPER(lastName) LIKE UPPER('&lname%')) AND td.director_id = d.director_id
ORDER BY d.director_id;

SPOOL OFF;
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES