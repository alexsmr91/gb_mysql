DROP DATABASE IF EXISTS avito;
CREATE DATABASE avito;
USE avito;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL primary key,
	email varchar(100) unique NOT NULL,
	phone BIGINT UNSIGNED unique NOT NULL,
	password_hash varchar(100) NOT NULL,
	name varchar(100) NOT NULL,
	photo varchar(100),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW()
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	id SERIAL primary key,
	category_name varchar(100) NOT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS city_states;
CREATE TABLE city_states (
	id SERIAL PRIMARY KEY,
	state_name varchar(100) NOT NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	city_name varchar(100) NOT NULL,
	city_state_id BIGINT UNSIGNED NOT NULL,
	CONSTRAINT cities_FK FOREIGN KEY (city_state_id) REFERENCES city_states(id) ON DELETE SET DEFAULT ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


DROP TABLE IF EXISTS adverts;
CREATE TABLE adverts (
	id SERIAL primary key,
	category_id BIGINT UNSIGNED DEFAULT 0 NOT NULL,
	user_id BIGINT UNSIGNED DEFAULT 0 NOT NULL,
	price BIGINT UNSIGNED DEFAULT 0 NOT NULL,
	header varchar(200) NOT NULL,
	body TEXT(3000) NOT NULL,
	city_id BIGINT UNSIGNED NOT NULL,
	photos json NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	CONSTRAINT adverts_FK FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
	CONSTRAINT adverts_FK_1 FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
	CONSTRAINT adverts_FK_2 FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE SET DEFAULT ON UPDATE CASCADE,
	INDEX adverts_idx(header, body(568))
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS favorite_ads;
CREATE TABLE favorite_ads (
	id SERIAL primary key,
	user_id BIGINT UNSIGNED NOT NULL,
	ad_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	UNIQUE(user_id, ad_id),
	CONSTRAINT favorite_ads_FK FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT favorite_ads_FK_1 FOREIGN KEY (ad_id) REFERENCES adverts(id) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS favorite_users;
CREATE TABLE favorite_users (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	favorite_user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE NOW(),
	UNIQUE(user_id, favorite_user_id),
	CONSTRAINT favorite_users_FK FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT favorite_users_FK_1 FOREIGN KEY (favorite_user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id SERIAL PRIMARY KEY,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	status ENUM('sended', 'readed'),
	CONSTRAINT messages_FK FOREIGN KEY (from_user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT messages_FK_1 FOREIGN KEY (to_user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
	)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('kulas.eldon@example.net', '0', '42ad7cedbc9ebb9d8c8864a721d8b39295aab3a7', 'Stephan', 'Schmidt', '1979-10-14 20:18:10', '1979-03-25 08:06:25');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('sigrid.rippin@example.net', '1', '508f94badde5c533601859cbbc85dab41d76b49f', 'Lucas', 'Hoeger', '1979-03-13 13:02:58', '1982-08-31 08:51:46');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('grady.elias@example.org', '81', 'ed205e1c00485fa26842d60a08a9f7c9c5a5c917', 'Christopher', 'Schamberger', '2011-12-08 04:40:27', '2010-08-03 11:48:09');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('aditya.kris@example.org', '36', 'f27ebbf44d4de54b32779a0fb3c503b9e1db825c', 'Lorine', 'Koelpin', '1970-03-01 02:07:24', '2018-09-15 19:55:50');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ( 'linnie35@example.com', '541024', '75e7812305259def6ebfbf236f07b215dc9ff0c3', 'Nickolas', 'Schumm', '1983-04-17 09:00:07', '1991-06-24 02:00:39');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('chelsea.heidenreich@example.org', '377168', '0f512d6e436cba523015da9382bb71edd78ce294', 'Lea', 'Towne', '1999-01-27 05:43:17', '1988-09-26 11:06:55');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('maude14@example.com', '59', 'b925014b94b52e278c6756dbd8abbe8754cf6433', 'Myra', 'Fisher', '1998-12-09 21:53:34', '2016-06-01 05:17:30');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('webster.walker@example.org', '271681', 'b4559197b1c9c68bfd91784f51827982c96a155a', 'Zita', 'Nader', '2015-10-27 06:43:25', '1984-11-16 23:17:46');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('pagac.charlotte@example.com', '576555', '18e9ec6923563b8125d6953d776fb2098917178c', 'Brionna', 'Rogahn', '1977-03-03 02:17:43', '1995-05-04 15:54:25');
INSERT INTO users (email, phone, password_hash, name, photo, created_at, updated_at) VALUES ('timothy.moen@example.org', '6', '3d604a15d342fbf62a678bd40d7f805f539ae81d', 'Ashlynn', 'Conn', '2005-06-12 15:10:50', '1982-11-09 10:25:33');


INSERT INTO categories (category_name) VALUES ('Личные вещи');
INSERT INTO categories (category_name) VALUES ('Транспорт');
INSERT INTO categories (category_name) VALUES ('Работа');
INSERT INTO categories (category_name) VALUES ('Автозапчасти');
INSERT INTO categories (category_name) VALUES ('Для дома и дачи');
INSERT INTO categories (category_name) VALUES ('Недвижимость');
INSERT INTO categories (category_name) VALUES ('Услуги');
INSERT INTO categories (category_name) VALUES ('Хобби');
INSERT INTO categories (category_name) VALUES ('Электроника');
INSERT INTO categories (category_name) VALUES ('Животные');


INSERT INTO city_states (id, state_name) VALUES ('1', 'Московская область');
INSERT INTO city_states (id, state_name) VALUES ('2', 'Москва');
INSERT INTO city_states (id, state_name) VALUES (3, 'Самарская область');
INSERT INTO city_states (id, state_name) VALUES (4, 'Свердловская область');
INSERT INTO city_states (id, state_name) VALUES (5, 'Республика Татарстан');
INSERT INTO city_states (id, state_name) VALUES (6, 'Республика Адыгея');
INSERT INTO city_states (id, state_name) VALUES (7, 'Республика Саха (Якутия)');
INSERT INTO city_states (id, state_name) VALUES (8, 'Краснодарский край');
INSERT INTO city_states (id, state_name) VALUES (9, 'Амурская область');
INSERT INTO city_states (id, state_name) VALUES (10, 'Волгоградская область');


INSERT INTO cities (city_name,city_state_id) VALUES ('Балашиха', 1);
INSERT INTO cities (city_name,city_state_id) VALUES ('Москва', 2);
INSERT INTO cities (city_name,city_state_id) VALUES ('Самара', 3);
INSERT INTO cities (city_name,city_state_id) VALUES ('Екатеринбург', 4);
INSERT INTO cities (city_name,city_state_id) VALUES ('Казань', 5);
INSERT INTO cities (city_name,city_state_id) VALUES ('Майкоп', 6);
INSERT INTO cities (city_name,city_state_id) VALUES ('Якутск', 7);
INSERT INTO cities (city_name,city_state_id) VALUES ('Краснодар', 8);
INSERT INTO cities (city_name,city_state_id) VALUES ('Благовещенск', 9);
INSERT INTO cities (city_name,city_state_id) VALUES ('Волгоград', 10);


INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (5,10,6155,'Ut inventore ad enim nulla unde velit impedit. Quia sapiente suscipit impedit deserunt rerum quos ip','Ipsam facere autem voluptas iste. Dolor corporis tempora libero.',3,'{"photo0": "photo0.jpg"}','2007-11-01 18:24:13','2022-04-24 13:22:14');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (5,1,7910,'Nesciunt tempore hic ab et. Aut vero blanditiis qui pariatur qui dolore suscipit. Quo porro omnis re','Sunt sint voluptas quaerat repellendus temporibus est ea. Laboriosam est aperiam ea voluptas. Similique ipsa necessitatibus et tenetur odio est.',9,'{"photo0": "photo0.jpg"}','2001-06-27 03:00:37','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (8,4,3807,'Nostrum veritatis culpa est temporibus ab facere ea. Dolore sapiente porro atque sit magni. Non numq','Mollitia ab modi ut at libero ut sed. Doloremque fugiat non nisi itaque doloremque aut. Aut ut voluptas earum ipsam quasi laborum.',8,'{"photo0": "photo0.jpg"}','1975-09-03 06:03:33','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (8,6,92,'Omnis aut nulla a facilis aut explicabo. Optio quo et qui itaque sunt suscipit praesentium. Sit quo ','Nesciunt tempore hic ab et. Aut vero blanditiis qui pariatur qui dolore suscipit. Quo porro omnis rerum velit.',1,'{"photo0": "photo0.jpg"}','1985-06-24 21:41:03','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (2,9,8206,'Iste veritatis ducimus minima nihil neque recusandae optio eos. Laboriosam est totam recusandae eum.','Sapiente alias laborum iusto voluptates et ipsum dignissimos. Ex quos et molestias ut provident. Et corrupti illo explicabo inventore qui. Reprehenderit nemo fuga at aliquid non porro ad. Nesciunt animi autem in necessitatibus.',7,'{"photo0": "photo0.jpg"}','1999-05-02 19:35:48','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (1,8,6667,'Eum explicabo inventore sapiente sit unde esse accusamus. Qui consectetur dolore dolor impedit. Ut e','Sunt sint voluptas quaerat repellendus temporibus est ea. Laboriosam est aperiam ea voluptas. Similique ipsa necessitatibus et tenetur odio est.',2,'{"photo0": "photo0.jpg"}','2006-05-24 06:50:45','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (6,2,7077,'Eos delectus aut maiores velit ab. Ab soluta sint non. Deleniti qui assumenda hic. Eum necessitatibu','Aperiam earum voluptatem dolores animi. Ullam veniam dolor dolorem quia iure.',5,'{"photo0": "photo0.jpg"}','2013-02-14 16:52:49','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (6,5,8266,'Nisi voluptates blanditiis velit non aliquam velit. Expedita laborum quis accusamus et adipisci mini','Earum quod atque est deleniti consequatur minus qui. Et et consequatur eligendi odit.',9,'{"photo0": "photo0.jpg"}','1998-06-11 16:27:39','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (10,1,4245,'Sint rerum impedit sit quos. Vero eum voluptates sed repellendus. Vitae vitae rerum magnam facere ex','Qui mollitia ducimus et quia sit et facere ducimus. Error enim eveniet animi sit explicabo officiis quis. Voluptas et cupiditate nostrum.',10,'{"photo0": "photo0.jpg"}','1973-01-10 03:02:33','2022-04-24 13:22:15');
INSERT INTO adverts (category_id,user_id,price,header,body,city_id,photos,created_at,updated_at) VALUES (10,6,9,'Eius odit vel modi culpa. Aut animi quas aut vel et non natus architecto. Voluptas cumque quia exped','Omnis velit optio ea blanditiis sunt. Voluptatem accusamus nostrum qui odit aut ipsum. Magnam repudiandae vitae sunt et quas sint dolorem dicta. In molestias est maiores iure aut.',8,'{"photo0": "photo0.jpg"}','2007-11-19 10:01:36','2022-04-24 13:22:15');


INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (1,3,'1988-04-17 09:18:20','1976-09-24 21:02:01');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (4,1,'2012-01-23 18:17:27','1976-07-12 20:33:59');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (4,10,'2015-06-28 05:33:28','2016-02-16 13:26:51');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (3,1,'2020-08-25 22:54:40','1976-03-27 06:14:21');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (7,7,'1971-08-16 13:13:09','2022-02-09 07:49:54');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (8,1,'1989-07-09 10:49:18','1977-05-20 03:07:36');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (9,3,'1974-11-23 06:45:51','2011-10-23 02:17:49');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (9,10,'1983-06-26 05:20:55','2003-06-15 19:51:50');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (3,8,'1980-07-26 07:17:27','2009-03-08 08:26:06');
INSERT INTO favorite_ads (user_id,ad_id,created_at,updated_at) VALUES (1,6,'1986-04-28 13:57:08','1993-12-31 09:18:47');


INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (3,6,'2007-05-23 21:52:23','2002-09-27 15:22:31');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (2,10,'2003-09-11 14:14:50','2002-01-05 19:59:13');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (5,10,'1978-11-16 06:05:44','2020-07-06 20:32:59');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (8,4,'1982-04-16 03:22:45','2013-10-08 07:55:45');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (10,10,'1984-11-27 00:54:59','2015-02-12 19:34:54');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (2,8,'2017-01-17 22:24:23','2012-02-14 17:48:31');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (10,7,'1981-02-27 19:15:42','2017-07-08 22:01:25');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (9,8,'1998-09-05 18:16:47','1996-02-11 02:16:27');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (10,4,'1970-01-22 10:15:26','1992-04-02 01:14:54');
INSERT INTO favorite_users (user_id,favorite_user_id,created_at,updated_at) VALUES (4,4,'1977-01-30 20:00:08','2001-02-19 04:53:57');


INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (1,2,'Laudantium tempore alias et laudantium. Sed omnis sunt aperiam accusantium magnam ut mollitia. Harum repellendus expedita tenetur sunt et esse vel ut.','2011-11-29 13:09:50','readed');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (1,3,'Doloremque voluptate blanditiis nostrum nam. Explicabo molestiae aperiam a. Ratione fugiat dolores asperiores dolorem. Est molestiae est id et omnis.','2007-08-22 10:39:42','sended');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (1,3,'Sint pariatur ex ea et doloremque quis reprehenderit. Excepturi distinctio et ut excepturi voluptatibus alias.','1979-04-10 08:37:50','readed');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (2,4,'Nesciunt eum molestiae qui consequatur molestiae deserunt iusto. Et eum non officia. Veniam hic quo atque labore minus quam fugit beatae.','2000-06-10 07:21:53','sended');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (4,5,'Eos delectus aut maiores velit ab. Ab soluta sint non. Deleniti qui assumenda hic. Eum necessitatibus commodi repudiandae libero aut fugit aut et.','2019-03-24 13:54:03','sended');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (2,6,'Ut et repellendus asperiores culpa aut et. Pariatur et rerum aliquam harum explicabo. Et et quaerat repellendus porro sint. Excepturi nisi omnis eos soluta quam odit enim assumenda.','2003-07-04 11:42:23','sended');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (1,7,'Iste veritatis ducimus minima nihil neque recusandae optio eos. Laboriosam est totam recusandae eum. Est impedit ipsum tempore error maiores dolor.','2011-11-25 05:46:26','readed');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (5,8,'Dolorem ut consequuntur porro deserunt. Deserunt qui iste voluptas atque quaerat porro. Et facere velit id non modi facilis. Aut facilis et vel vel perferendis.','1979-04-20 13:49:55','readed');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (7,9,'Aperiam earum voluptatem dolores animi. Ullam veniam dolor dolorem quia iure.','1981-10-12 05:32:12','readed');
INSERT INTO messages (from_user_id,to_user_id,body,created_at,status) VALUES (1,4,'Laudantium tempore alias et laudantium. Sed omnis sunt aperiam accusantium magnam ut mollitia. Harum repellendus expedita tenetur sunt et esse vel ut.','2011-11-29 13:09:50','readed');
