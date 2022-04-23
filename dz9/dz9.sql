DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';
START TRANSACTION;
INSERT INTO users
SELECT * 
FROM shop.users
WHERE shop.users.id = 1;
COMMIT;

#---------------------------------------------------------------

USE shop;
DROP VIEW IF EXISTS prod;
CREATE VIEW prod
AS SELECT p.name, c.name as cat_name
FROM products p
	JOIN catalogs c ON p.catalog_id = c.id 
;

SELECT * FROM prod;

#---------------------------------------------------------------

DROP TABLE IF EXISTS datetbl;
CREATE TABLE datetbl (created_at DATE);
INSERT INTO datetbl VALUES ('2018-08-01');
INSERT INTO datetbl VALUES ('2018-08-04');
INSERT INTO datetbl VALUES ('2018-08-16');
INSERT INTO datetbl VALUES ('2018-08-17');


DELIMITER //
DROP PROCEDURE IF EXISTS temp_tbl//
CREATE PROCEDURE temp_tbl (IN st DATETIME, cnt INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	DROP TABLE IF EXISTS temp;
	CREATE TABLE temp (created_at DATE);
	WHILE i < cnt DO
		INSERT INTO temp 
		VALUES (ADDDATE(ST, i));
		SET i = i + 1;
	END WHILE;
END//
DELIMITER ;


CALL temp_tbl('2018-08-01', 31);


SELECT t.created_at, 
		IF(t.created_at IN (SELECT created_at FROM datetbl d2),1,0) as rez 
FROM temp t
	LEFT JOIN datetbl d on t.created_at = d.created_at 

	
#---------------------------------------------------------------	

	
CALL temp_tbl('2022-01-01', 110);
SELECT * FROM temp t ;
DELETE FROM temp 
WHERE created_at NOT IN (SELECT * FROM(
		SELECT created_at FROM temp ORDER BY created_at DESC LIMIT 5) as tmp);
SELECT * FROM temp t ;


#---------------------------------------------------------------	

CREATE USER shop IDENTIFIED WITH sha256_password BY '1234';
CREATE USER shop_read IDENTIFIED WITH sha256_password BY '1234';
GRANT ALL ON shop.* TO 'shop';
GRANT SELECT ON shop.* TO 'shop_read';


#---------------------------------------------------------------	

USE shop;
DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	id BIGINT UNSIGNED auto_increment PRIMARY KEY NOT NULL,
	name varchar(100) NOT NULL,
	pass varchar(100) NOT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

DROP VIEW IF EXISTS username;
CREATE VIEW username
AS SELECT id, name
FROM accounts;

DROP USER user_read;
CREATE USER user_read IDENTIFIED WITH sha256_password BY '1234';
GRANT SELECT ON shop.username TO 'user_read';


#---------------------------------------------------------------

DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello ()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE hh INT DEFAULT HOUR(NOW());
    RETURN IF(hh >= 0 AND hh < 6, 'Доброй ночи', 
           IF(hh >= 6 AND hh < 12,'Доброе утро',
           IF(hh >= 12 AND hh < 18,'Добрый день',
           IF(hh >= 18 AND hh < 24,'Добрый вечер',
           'Ошибка'))));
END//
DELIMITER ;

SELECT hello();


#---------------------------------------------------------------

USE shop;
DROP TRIGGER IF EXISTS before_insert_validation;
DELIMITER //

CREATE TRIGGER before_insert_validation
BEFORE INSERT
ON shop.products 
FOR EACH ROW BEGIN 
	IF NEW.description IS NULL AND NEW.name IS NULL THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error';
	END IF;
END//
DELIMITER ;

DROP TRIGGER IF EXISTS before_update_validation;
DELIMITER //

CREATE TRIGGER before_update_validation
BEFORE UPDATE
ON shop.products 
FOR EACH ROW BEGIN 
	IF NEW.description IS NULL AND NEW.name IS NULL THEN
		SET NEW.name = OLD.name;
		SET NEW.description = OLD.description;
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error';
	END IF;
END//
DELIMITER ;




INSERT INTO products
(name, description)
VALUES
(NULL, NULL);

UPDATE products 
SET name = NULL, description = NULL
WHERE id = 1;


#---------------------------------------------------------------


DELIMITER //
DROP FUNCTION IF EXISTS fibo//
CREATE FUNCTION fibo (val INT UNSIGNED)
RETURNS BIGINT UNSIGNED DETERMINISTIC
BEGIN
    DECLARE n0 BIGINT UNSIGNED DEFAULT 0;
    DECLARE n1 BIGINT UNSIGNED DEFAULT 1;
    DECLARE n2 BIGINT UNSIGNED DEFAULT 1;
    DECLARE i INT UNSIGNED DEFAULT 1;
    IF val < 2 THEN
    	RETURN val;
    END IF;
    WHILE i < val DO
		SET n2 = n1 + n0;
		SET n0 = n1;
		SET n1 = n2;
		SET i = i + 1;
	END WHILE;
    RETURN n2;
END//
DELIMITER ;

SELECT fibo(80);
#23 416 728 348 467 685

