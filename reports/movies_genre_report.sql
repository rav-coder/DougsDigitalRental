SET ECHO OFF
SET VERIFY OFF
SET FEEDBACK OFF
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES

SET LINESIZE 140
SET PAGESIZE 30

TTITLE CENTER 'Movies In A' SKIP CENTER 'Specific Genre' SKIP 3
BTITLE CENTER '--End Of Report--'

COLUMN movie_title FORMAT A100 HEADING 'Title'
COLUMN genre_description FORMAT A25 HEADING 'Genre'

ACCEPT genre prompt 'Enter the Genre:'

SPOOL C:\cprg250s\finalProject\reports\movies_genre_report.txt

SELECT movie_title, genre_description
FROM ddr_title t join ddr_title_genre tg on (t.title_code = tg.title_code)
				 join ddr_genre g on (tg.genre_id = g.genre_id)
WHERE (UPPER(genre_description) LIKE UPPER('&genre%'))
ORDER BY movie_title;

SPOOL OFF;
CLEAR COLUMNS
CLEAR BREAKS
CLEAR COMPUTES