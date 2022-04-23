DROP DATABASE IF EXISTS example;
CREATE DATABASE example;

USE example;

DROP TABLE IF EXISTS users;
CREATE TABLE Users (
	Id SERIAL PRIMARY KEY,
	Name varchar(100) NULL
);