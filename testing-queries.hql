USE mz_exam_db;

-- View tables
SHOW TABLES;

-- Preview each table
SELECT * FROM title_akas LIMIT 5;
SELECT * FROM title_basics LIMIT 5;
SELECT * FROM title_crew LIMIT 5;
SELECT * FROM title_episode LIMIT 5;
SELECT * FROM title_principals LIMIT 5;
SELECT * FROM names_basics LIMIT 5;
SELECT * FROM title_ratings LIMIT 5;

-- 106
Select count(distinct(language)) from title_akas;

