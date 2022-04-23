/*DROP DATABASE IF EXISTS vk;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS friend_requests;
DROP TABLE IF EXISTS communities;
DROP TABLE IF EXISTS users_communities;
DROP TABLE IF EXISTS media_types;
DROP TABLE IF EXISTS media;
DROP TABLE IF EXISTS profiles;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS photo_albums;
DROP TABLE IF EXISTS photos;
DROP TABLE IF EXISTS applications;
DROP TABLE IF EXISTS favorite_applications;
DROP TABLE IF EXISTS music;
DROP TABLE IF EXISTS favorite_music;
*/

CREATE DATABASE IF NOT EXISTS vk;
USE vk;

CREATE TABLE IF NOT EXISTS users (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    firstname VARCHAR(50),
    lastname VARCHAR(50) COMMENT 'Фамилия', -- COMMENT на случай, если имя неочевидное
    email VARCHAR(120) UNIQUE,
 	password_hash VARCHAR(100), 	
	phone BIGINT UNSIGNED UNIQUE, 
	
    INDEX users_firstname_lastname_idx(firstname, lastname)
) COMMENT 'юзеры';

CREATE TABLE IF NOT EXISTS messages (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- можно будет даже не упоминать это поле при вставке

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS friend_requests (
	-- id SERIAL, -- изменили на составной ключ (initiator_user_id, target_user_id)
	initiator_user_id BIGINT UNSIGNED NOT NULL,
    target_user_id BIGINT UNSIGNED NOT NULL,
    `status` ENUM('requested', 'approved', 'declined', 'unfriended'),
    -- `status` TINYINT(1) UNSIGNED, -- в этом случае в коде хранили бы цифирный enum (0, 1, 2, 3...)
	requested_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP, -- можно будет даже не упоминать это поле при обновлении
	
    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id),
    FOREIGN KEY (target_user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS communities(
	id SERIAL,
	name VARCHAR(150),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX communities_name_idx(name), -- индексу можно давать свое имя (communities_name_idx)
	foreign key (admin_user_id) references users(id)
);

CREATE TABLE IF NOT EXISTS users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
  
	PRIMARY KEY (user_id, community_id), -- чтобы не было 2 записей о пользователе и сообществе
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (community_id) REFERENCES communities(id)
);

CREATE TABLE IF NOT EXISTS media_types(
	id SERIAL,
    name VARCHAR(255), -- записей мало, поэтому в индексе нет необходимости
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW()
);

CREATE TABLE IF NOT EXISTS media(
	id SERIAL,
    media_type_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
  	body text,
    filename VARCHAR(255),
    size INT,
	metadata JSON,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE NOW(),

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);

CREATE TABLE IF NOT EXISTS `profiles` (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
    gender CHAR(1),
    birthday DATE,
	photo_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    hometown VARCHAR(100),
    FOREIGN KEY (photo_id) REFERENCES media(id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT -- (значение по умолчанию)
);

CREATE TABLE IF NOT EXISTS likes(
	id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    media_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

CREATE TABLE IF NOT EXISTS `photo_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `photos` (
	id SERIAL,
	`album_id` BIGINT unsigned NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES photo_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

CREATE TABLE IF NOT EXISTS applications (
	id SERIAL,
	app_name varchar(100),
    media_id BIGINT UNSIGNED NOT NULL,

    INDEX app_name_idx(app_name),
    PRIMARY KEY (id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

CREATE TABLE IF NOT EXISTS favorite_applications (
	app_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (app_id) REFERENCES applications(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS music (
	id SERIAL,
	artist varchar(100),
	track_name varchar(100),
    media_id BIGINT UNSIGNED NOT NULL,

    INDEX artist_track_name_idx(artist , track_name),
    PRIMARY KEY (id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

CREATE TABLE IF NOT EXISTS favorite_music (
	track_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (track_id) REFERENCES music(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- ALTER TABLE friend_requests 
-- ADD CONSTRAINT CHECK (initiator_user_id <> target_user_id);

-- ALTER TABLE profiles ADD COLUMN is_active BOOL DEFAULT True;

-- SELECT DISTINCT firstname FROM users ORDER BY firstname ASC

-- UPDATE profiles SET is_active = 0 WHERE DATEDIFF(CURRENT_DATE(),birthday)/365 < 18

-- DELETE FROM messages WHERE DATEDIFF(CURRENT_DATE(),created_at)<0
