CREATE DATABASE DB_RiyanRattan;

USE DB_RiyanRattan;

CREATE TABLE VENDOR  (
	V_CODE  	int				NOT NULL,
	V_NAME		varchar(30) 	NOT NULL,
	V_CONTACT	varchar(50) 	NOT NULL,
	V_AREACODE 	char(3) 		NOT NULL,
	V_PHONE		char(8) 		NOT NULL,
	V_STATE		char(2) 		NOT NULL,
	V_ORDER 	char(1) 		NOT NULL,
	CONSTRAINT	VENDOR_PK		PRIMARY KEY (V_CODE)
);
