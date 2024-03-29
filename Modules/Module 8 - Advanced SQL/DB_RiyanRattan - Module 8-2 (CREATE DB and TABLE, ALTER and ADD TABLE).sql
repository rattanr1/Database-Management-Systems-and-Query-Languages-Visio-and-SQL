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

CREATE TABLE PRODUCT (
	P_CODE		varchar(10) 	NOT NULL,
	P_DESCRIPT	varchar(35)		NOT NULL,
	P_INDATE	datetime		NOT NULL,
	P_QOH		smallint 		NOT NULL,
	P_MIN		smallint		NOT NULL,
	P_PRICE		decimal(8,2)	NOT NULL,
	P_DISCOUNT	decimal(5,2)	NOT NULL,
	V_CODE		int				NOT NULL,
	CONSTRAINT	PRODUCT_PK	PRIMARY KEY (P_CODE),
	CONSTRAINT	PRODUCT_FK 	FOREIGN KEY (V_CODE)		REFERENCES	VENDOR(V_CODE)
		ON UPDATE CASCADE   
		ON DELETE NO ACTION
        
);

CREATE TABLE CUSTOMER (
	CUS_CODE		int 			NOT NULL,
	CUS_LNAME		varchar(15)		NOT NULL,
	CUS_FNAME		varchar(15)		NOT NULL,
	CUS_INITIAL		char(1)			NOT NULL,
	CUS_AREACODE	char(3)			DEFAULT '615'		CHECK(CUS_AREACODE IN ('615', '713', '931')),
	CUS_PHONE		char(8)			NOT NULL,
	CUS_BALANCE		decimal(9,2)	DEFAULT 0.00,
	CONSTRAINT	  CUSTOMER_PK	PRIMARY KEY (CUS_CODE),
	CONSTRAINT	  CUS_UNI 		UNIQUE	(CUS_LNAME, CUS_FNAME, CUS_INITIAL)
);

CREATE TABLE INVOICE (
	INV_NUMBER		int 					NOT NULL,
	CUS_CODE		int						NOT NULL,
	INV_DATE		date					NOT NULL	CHECK (INV_DATE> '2018-01-01'),
	INV_TOTAL		decimal(10,2)			NOT NULL,
	CONSTRAINT	 INVOICE_PK	  PRIMARY KEY (INV_NUMBER),
	CONSTRAINT	 INVOICE_FK   FOREIGN KEY (CUS_CODE)   REFERENCES  CUSTOMER(CUS_CODE) 
		ON UPDATE CASCADE
		ON DELETE NO ACTION
);

CREATE TABLE LINE (
	INV_NUMBER		int 					NOT NULL,
	LINE_NUMBER		int						NOT NULL,
	P_CODE			varchar(10)				NOT NULL,
	LINE_UNITS		decimal(9,2)			NOT NULL,
	LINE_PRICE	 	decimal(9,2)	  		NOT NULL,
	CONSTRAINT	 LINE_PK    PRIMARY KEY  (INV_NUMBER, LINE_NUMBER), 
	CONSTRAINT	 LINE_FK1	FOREIGN KEY  (INV_NUMBER)	REFERENCES  INVOICE(INV_NUMBER)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT   LINE_FK2	FOREIGN KEY  (P_CODE)		REFERENCES   PRODUCT (P_CODE)
		ON UPDATE CASCADE
		ON DELETE NO ACTION
);



ALTER TABLE PRODUCT
	MODIFY COLUMN P_INDATE    date;
    
ALTER TABLE PRODUCT
	ADD (P_SALECODE CHAR(1));
    
ALTER TABLE INVOICE
	DROP COLUMN INV_TOTAL;

