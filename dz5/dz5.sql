-- Задание 1
UPDATE users SET created_at = NOW() WHERE created_at IS NULL
UPDATE users SET updated_at = NOW() WHERE updated_at IS NULL

-- Задание 2

CREATE TABLE IF NOT EXISTS users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100),
	created_at VARCHAR(50),
	updated_at VARCHAR(50),
	birthday DATETIME NOT NULL

	
);
INSERT INTO users (name,created_at, updated_at, birthday) VALUES ('Саша','20.10.2017 8:09','20.10.2017 8:10', '2001-05-01');
INSERT INTO users (name,created_at, updated_at, birthday) VALUES ('Катя','21.10.2017 8:09','20.10.2017 8:10','1999-01-01');
INSERT INTO users (name,created_at, updated_at, birthday) VALUES ('Паша','22.10.2017 8:09','20.10.2017 8:00','1995-08-20');
INSERT INTO users (name,created_at, updated_at, birthday) VALUES ('Ира','23.10.2017 8:09','20.10.2017 8:10','2015-12-20');

CREATE TABLE IF NOT EXISTS users2 (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT NOW(),
	birthday DATETIME NOT NULL
);

INSERT INTO users2
SELECT id, name, STR_TO_DATE(created_at,"%d.%m.%Y %k:%i"), STR_TO_DATE(updated_at,"%d.%m.%Y %k:%i"), birthday 
FROM users;

DROP TABLE users;

ALTER TABLE users2 RENAME users



-- Задание 3

CREATE TABLE IF NOT EXISTS storehouses_products(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(100),
	value BIGINT UNSIGNED NOT NULL DEFAULT 0
);

INSERT INTO storehouses_products (name,value) VALUES ('Сахар', 1000);
INSERT INTO storehouses_products (name,value) VALUES ('Гречка', 1200);
INSERT INTO storehouses_products (name,value) VALUES ('Соль', 500);
INSERT INTO storehouses_products (name,value) VALUES ('Спички', 0);
INSERT INTO storehouses_products (name,value) VALUES ('Конфеты', 0);
INSERT INTO storehouses_products (name,value) VALUES ('Молоко', 10000);


SELECT * FROM storehouses_products ORDER BY IF (value > 0, value, 9999999) ASC;



-- Задание 4


SELECT * FROM users WHERE DATE_FORMAT(birthday,'%M') IN ('May', 'August');


-- Задание 5
INSERT INTO catalogs (name) VALUES ('Продукты');
INSERT INTO catalogs (name) VALUES ('Лекарства');
INSERT INTO catalogs (name) VALUES ('Техника');
INSERT INTO catalogs (name) VALUES ('Игрушки');
INSERT INTO catalogs (name) VALUES ('Посуда');



SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

-- Задание 6

SELECT ROUND(AVG(DATEDIFF(NOW(),birthday))/365.25) 'Avg age' FROM users 



-- Задание 7

SELECT
CASE
	WHEN DAYOFWEEK(CONCAT(YEAR(NOW()),'-', RIGHT(DATE(birthday),5))) = 1 THEN 'Понедельник'
	WHEN DAYOFWEEK(CONCAT(YEAR(NOW()),'-', RIGHT(DATE(birthday),5))) = 2 THEN 'Вторник'
	WHEN DAYOFWEEK(CONCAT(YEAR(NOW()),'-', RIGHT(DATE(birthday),5))) = 3 THEN 'Среда'
	WHEN DAYOFWEEK(CONCAT(YEAR(NOW()),'-', RIGHT(DATE(birthday),5))) = 4 THEN 'Четверг'
	WHEN DAYOFWEEK(CONCAT(YEAR(NOW()),'-', RIGHT(DATE(birthday),5))) = 5 THEN 'Пятница'
	WHEN DAYOFWEEK(CONCAT(YEAR(NOW()),'-', RIGHT(DATE(birthday),5))) = 6 THEN 'Суббота'
	WHEN DAYOFWEEK(CONCAT(YEAR(NOW()),'-', RIGHT(DATE(birthday),5))) = 7 THEN 'Воскресенье'
END as day_of_week,
COUNT(*) as summ
FROM users
GROUP BY day_of_week 
;


-- Задание 8

INSERT INTO value (value) VALUES (1);
INSERT INTO value (value) VALUES (2);
INSERT INTO value (value) VALUES (3);
INSERT INTO value (value) VALUES (4);
INSERT INTO value (value) VALUES (5);

SELECT  EXP(SUM(LOG(value))) AS multi FROM value 