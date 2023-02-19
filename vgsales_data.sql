CREATE DATABASE	vgsales_db;

USE vgsales_db;

DROP TABLE IF EXISTS vgsales_master_table;

CREATE TABLE vgsales_master_table (
	game_rank INTEGER PRIMARY KEY,
    game_name VARCHAR(200),
    platform VARCHAR(100),
    year_produced VARCHAR(4),
    genre VARCHAR(100),
    game_publisher VARCHAR(100),
    sales_na DECIMAL,
    sales_eu DECIMAL,
    sales_jp DECIMAL,
    sales_other DECIMAL,
    sales_global DECIMAL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vgsales.csv'
INTO TABLE vgsales_master_table
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS;

SELECT * FROM
(
	SELECT game_name, platform, year_produced, genre, game_publisher, sales_na AS sales, 'North America' AS region
	FROM vgsales_master_table
	UNION
	SELECT game_name, platform, year_produced, genre, game_publisher, sales_eu AS sales, 'EU' AS region
	FROM vgsales_master_table
    UNION
	SELECT game_name, platform, year_produced, genre, game_publisher, sales_jp AS sales, 'Japan' AS region
	FROM vgsales_master_table
    UNION
	SELECT game_name, platform, year_produced, genre, game_publisher, sales_other AS sales, 'Other' AS region
	FROM vgsales_master_table
) master_table;

