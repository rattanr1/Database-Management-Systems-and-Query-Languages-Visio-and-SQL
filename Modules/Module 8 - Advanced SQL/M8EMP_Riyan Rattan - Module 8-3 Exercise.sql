CREATE DATABASE M8EMP_RiyanRattan;

USE M8EMP_RiyanRattan;


CREATE TABLE REGION  (
	REGION_CODE  		int				NOT NULL,
	REGION_DESCRIPT		varchar(30) 	NOT NULL,
	
CONSTRAINT		REGION_PK		PRIMARY KEY (REGION_CODE)
);

CREATE TABLE STORE  (
	STORE_CODE  		int				NOT NULL,
	STORE_NAME			char(15) 		NOT NULL,
	STORE_YTD_SALES		decimal(7,2) 	NOT NULL,
	REGION_CODE 		int				NOT NULL,
CONSTRAINT	    STORE_PK	    PRIMARY KEY (STORE_CODE),
CONSTRAINT		STORE_FK		FOREIGN KEY (REGION_CODE)   REFERENCES REGION(REGION_CODE)
		ON UPDATE CASCADE   
		ON DELETE NO ACTION

);

CREATE TABLE EMPLOYEE  (
	EMP_CODE  			int				NOT NULL,
	EMP_LNAME			char(15) 		NOT NULL,
	EMP_FNAME			char(15) 		NOT NULL,
	EMP_EXT 			char(4) 		NOT NULL,
	STORE_CODE			int				NOT NULL,
CONSTRAINT		EMPLOYEE_PK		PRIMARY KEY (EMP_CODE),
CONSTRAINT		EMPLOYEE_FK		FOREIGN KEY (STORE_CODE)   REFERENCES STORE(STORE_CODE)
		ON UPDATE CASCADE   
		ON DELETE NO ACTION
);

INSERT INTO REGION VALUES (1234, 'NORTH');
INSERT INTO REGION VALUES (9638, 'SOUTH');
INSERT INTO REGION VALUES (4561, 'WEST');

INSERT INTO STORE VALUES (200, 'TARGET', 5.25, 1234);
INSERT INTO STORE VALUES (210, 'WALMART', 7.19, 9638);
INSERT INTO STORE VALUES (220, 'HEB', 7.26, 4561);

INSERT INTO EMPLOYEE VALUES (003, 'SEACREST', 'RYAN', 7222, 200);
INSERT INTO EMPLOYEE VALUES (002, 'REYNOLDS', 'RYAN', 7222, 210);
INSERT INTO EMPLOYEE VALUES (001, 'RATTAN', 'RIYAN', 7222, 220);




