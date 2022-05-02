USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME DEFAULT NOW() NOT NULL,
	rel_table varchar(50) NOT NULL,
	rel_id BIGINT UNSIGNED NOT NULL,
	rel_name varchar(100) NOT NULL
)
ENGINE=ARCHIVE
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

DROP TRIGGER IF EXISTS after_insert_users;
DELIMITER //

CREATE TRIGGER after_insert_users
AFTER INSERT
ON shop.users 
FOR EACH ROW BEGIN 
	INSERT INTO logs (rel_table, rel_id, rel_name) VALUES ("users", NEW.id, NEW.name);
END//
DELIMITER ;


INSERT INTO users (name) VALUES ("Alex");




DROP TRIGGER IF EXISTS after_insert_catalogs;
DELIMITER //

CREATE TRIGGER after_insert_catalogs
AFTER INSERT
ON shop.catalogs
FOR EACH ROW BEGIN 
	INSERT INTO logs (rel_table, rel_id, rel_name) VALUES ("catalogs", NEW.id, NEW.name);
END//
DELIMITER ;

INSERT INTO catalogs(name) VALUES ("RAM");




DROP TRIGGER IF EXISTS after_insert_products;
DELIMITER //

CREATE TRIGGER after_insert_products
AFTER INSERT
ON shop.products
FOR EACH ROW BEGIN 
	INSERT INTO logs (rel_table, rel_id, rel_name) VALUES ("products", NEW.id, NEW.name);
END//
DELIMITER ;

INSERT INTO products(name) VALUES ("Kingstone 8 GB");




##-----------------------------------------------------------------------------------------------
/*
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');
 
 */

DROP FUNCTION IF EXISTS Random_string;
DELIMITER //
CREATE FUNCTION Random_string(len INT)
RETURNS TEXT DETERMINISTIC
BEGIN
	DECLARE s VARCHAR(100) DEFAULT CHAR(FLOOR(65+(RAND()*25)));
	DECLARE i INT DEFAULT 1;
    	REPEAT
    		SET s = CONCAT(s, CHAR(FLOOR(97+(RAND()*25))));
    		SET i = i + 1; 
   		UNTIL i > len END REPEAT;
	RETURN s;
END//
DELIMITER ;


DROP PROCEDURE IF EXISTS Insert_Users;
DELIMITER //
CREATE PROCEDURE Insert_Users(coun INT)
BEGIN
    DECLARE i INT DEFAULT 1;
	DECLARE l INT DEFAULT 4;
    REPEAT
		SET l = FLOOR(4+(RAND()*3));
        INSERT INTO users (name) VALUES (Random_string(l));
        SET i = i + 1; 
    UNTIL i > coun END REPEAT;
END//
DELIMITER ;

CALL Insert_Users(1000);

SELECT COUNT(*) FROM users;

