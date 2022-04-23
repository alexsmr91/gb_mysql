DROP TABLE IF EXISTS applications;
CREATE TABLE applications (
	id SERIAL,
	app_name varchar(100),
    media_id BIGINT UNSIGNED NOT NULL,

    INDEX app_name_idx(app_name),
    PRIMARY KEY (id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS favorite_applications;
CREATE TABLE favorite_applications (
	app_id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (app_id) REFERENCES applications(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS music;
CREATE TABLE music (
	id SERIAL,
	artist varchar(100),
	track_name varchar(100),
    media_id BIGINT UNSIGNED NOT NULL,

    INDEX artist_track_name_idx(artist , track_name),
    PRIMARY KEY (id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS favorite_music;
CREATE TABLE favorite_music (
	track_id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,

    FOREIGN KEY (track_id) REFERENCES music(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);