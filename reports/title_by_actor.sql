SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

SET LINESIZE 120
SET PAGESIZE 20

TTITLE CENTER 'Movies For A' SKIP CENTER 'Specific Actor' SKIP 3
BTITLE CENTER '--End Of Report--'

COLUMN movie_title FORMAT A50 HEADING 'Title'
COLUMN Firstname FORMAT A25 HEADING 'Firstname'
COLUMN lastname FORMAT A25 HEADING 'Lastname'

spool C:\cprg250s\finalProject\reports\title_by_actor.txt

ACCEPT firstName PROMPT 'Enter the cast first name: '
ACCEPT lastName PROMPT 'Enter the cast last name: '

SELECT 
  c.FirstName,
  c.LastName,
  c.Cast_id AS "Cast ID",
  Movie_title
FROM
  ddr_title t join ddr_title_cast tc on (t.title_code = tc.title_code)
				      join ddr_cast c on (tc.cast_id = c.cast_id)
WHERE
  (UPPER(firstName) LIKE UPPER('&firstName%')) AND
  (UPPER(lastName) LIKE UPPER('&lastName%')) AND
  tc.cast_id = c.cast_id;

SPOOL OFF;
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES