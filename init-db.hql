DROP DATABASE IF EXISTS mz_exam_db CASCADE; 


CREATE DATABASE mz_exam_db;
USE mz_exam_db;
 
SET hive.exec.dynamic.partition=true;
SET hive.exec.dynamic.partition.mode=nonstrict;

 
-- creation de la table title.basics.tsv
CREATE TABLE title_basics
(
    tconst VARCHAR(255),
    titleType VARCHAR(255),
    primaryTitle VARCHAR(255),
    originalTitle VARCHAR(255),
    isAdult INT,
    startYear INT,
    endYear INT,
    runtimeMinutes INT,
    genres STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\n"
STORED AS TEXTFILE;

LOAD DATA INPATH '/title.basics.tsv'  
INTO TABLE title_basics;



-- creation de la table title.crew.tsv
CREATE TABLE title_crew
(
    tconst VARCHAR(255),
    directors VARCHAR(255),
    writers VARCHAR(255)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\n"
STORED AS TEXTFILE;

LOAD DATA INPATH '/title.crew.tsv'  
INTO TABLE title_crew;




-- creation de la table title.episode.tsv
CREATE TABLE title_episode
(
    tconst VARCHAR(255),
    parentTconst VARCHAR(255),
    seasonNumber INT,
    episodeNumber INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\n"
STORED AS TEXTFILE;

LOAD DATA INPATH '/title.episode.tsv'  
INTO TABLE title_episode;




-- creation de la table title.principals.tsv
CREATE TABLE title_principals
(
    tconst VARCHAR(255),
    ordering INT,
    nconst VARCHAR(255),
    category VARCHAR(255),
    job VARCHAR(255),
    characters VARCHAR(255)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\n"
STORED AS TEXTFILE;

LOAD DATA INPATH '/title.principals.tsv'  
INTO TABLE title_principals;



-- creation de la table title.ratings.tsv
CREATE TABLE title_ratings
(
    tconst VARCHAR(255),
    averageRating DOUBLE,
    numVotes INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\n"
STORED AS TEXTFILE;

LOAD DATA INPATH '/title.ratings.tsv'  
INTO TABLE title_ratings;


CREATE TABLE title_ratings_part
(
    tconst VARCHAR(255),
    numVotes INT
)
PARTITIONED BY (averageRating DOUBLE)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\n"
STORED AS TEXTFILE;

INSERT INTO TABLE title_ratings_part
PARTITION (averageRating)
SELECT tconst, numVotes, averageRating
FROM title_ratings;



-- creation de la table names
CREATE TABLE names_basics
(
    nconst VARCHAR(255),
    titleType VARCHAR(255),
    primaryName VARCHAR(255),
    birthYear INT,
    deathYear INT,
    primaryProfession STRING,
    knownForTitles STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY "\t"
LINES TERMINATED BY "\n"
STORED AS TEXTFILE;

LOAD DATA INPATH '/name.basics.tsv'   
INTO TABLE names_basics;








