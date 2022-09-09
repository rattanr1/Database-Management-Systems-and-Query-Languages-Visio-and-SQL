SELECT * FROM db_m7.product;

/* Q4 */
SELECT P_CODE, P_DESCRIPT, P_PRICE, P_QOH
FROM PRODUCT

/* Q5 */
SELECT P_Code, P_DESCRIPT, P_PRICE, P_QOH, P_PRICE*P_QOH AS TotalValue
FROM PRODUCT

/* Q6 */
SELECT DISTINCT V_CODE
FROM PRODUCT;

/* Q7 */
SELECT P_Code, V_Code, V_Name
FROM PRODUCT JOIN VENDOR USING (V_CODE);

/*Q8*/
SELECT P_Code, PRODUCT.V_Code, V_Name
FROM PRODUCT JOIN VENDOR
	ON PRODUCT.V_Code=VENDOR.V_Code;

/*Q9*/
SELECT P_Code, PRODUCT.V_Code, V_Name
FROM PRODUCT LEFT OUTER JOIN VENDOR
	ON PRODUCT.V_Code=VENDOR.V_Code;
    
/*Q10*/    
SELECT P_Code, PRODUCT.V_Code, V_Name
FROM PRODUCT RIGHT OUTER JOIN VENDOR
	ON PRODUCT.V_Code=VENDOR.V_Code;    
    
/*Q11 - Joining Tables with an Alias: An alias may be used to identify the source table from which the data is taken */
SELECT P_DESCRIPT, P_PRICE, V_NAME, V_AREACODE, V_PHONE
FROM PRODUCT P JOIN VENDOR V ON P.V_CODE = V.V_CODE;   
    
/*Q12 - the contents of the PRODUCT table to be listed by P_PRICE in ascending order */   
SELECT P_CODE, P_DESCRIPT, P_QOH, P_PRICE
FROM PRODUCT
ORDER BY P_PRICE;    

/*Q13 - produce the listing with products sorted in descending order by price*/  
SELECT P_CODE, P_DESCRIPT, P_QOH, P_PRICE
FROM PRODUCT
ORDER BY P_PRICE DESC;

    
/*Q14, NO APOSTRPHE FOR INTEGERS*/
SELECT 	P_Descript, P_QOH, P_Price, V_Code
FROM 	PRODUCT
WHERE 	V_Code=11111;

/*Q15 not equal to*/
SELECT 	P_Descript, P_QOH, P_Price, V_Code
FROM 	PRODUCT
WHERE 	V_Code!=11111;

/*Q16 Greater Than*/
SELECT P_DESCRIPT, P_QOH, P_MIN, P_PRICE
FROM PRODUCT
WHERE P_PRICE > 100;

/*Q17 -  For date/time data type (date format is YYYY-MM-DD). */
SELECT P_DESCRIPT, P_QOH, P_MIN, P_PRICE, P_INDATE
FROM PRODUCT
WHERE P_INDATE >= '2026-01-01';


/*Q18 - The OR operator */
SELECT P_DESCRIPT, P_QOH, P_PRICE, V_CODE
FROM PRODUCT
WHERE V_CODE = 21225  OR V_CODE = 11111;


/*Q19 - The AND operator */
SELECT P_DESCRIPT, P_QOH, P_MIN, P_PRICE
FROM PRODUCT
WHERE P_PRICE > 100
AND P_QOH > 10;


/*Q20*/
SELECT P_Descript, P_QOH, P_Min, P_Price, V_Code
FROM PRODUCT
WHERE (V_Code=21225 OR V_Code=11111) AND P_Price>40;


/*Q22 - The NOT operator*/
SELECT *
FROM PRODUCT
WHERE NOT (V_CODE = 21344);


/* Q23 - Using BETWEEN */
SELECT *
FROM PRODUCT
WHERE P_PRICE BETWEEN 100.00 AND 1000.00; 



/*Q24*/
SELECT *	
FROM PRODUCT
WHERE V_Code IN (21225, 11111);

/*Q25; smith% means everything begins with smith; %smith% means everything include smith; % means any characters; underscore ___
means one character*/
SELECT V_Name, V_Contact, V_AreaCode, V_Phone
FROM VENDOR
WHERE V_Contact LIKE 'smith%';


/* Q26 - Using IS NULL*/
SELECT P_CODE, P_DESCRIPT, V_CODE
FROM PRODUCT
WHERE V_CODE IS NULL;





/**********EXERCISE 7-2***********/

/*Q3 - COUNT */
SELECT COUNT(*) AS NumOfProducts
FROM PRODUCT;



/*Q4*/
SELECT COUNT(*) AS NumOfProducts
FROM PRODUCT
WHERE P_Price > 40;

/*Q5*/
SELECT  COUNT(DISTINCT V_Code) AS NumOfVendor
FROM    PRODUCT;


/*Q6 - MIN and MAX */
/*Q6*/
SELECT  MIN(P_Price)
FROM	PRODUCT;


SELECT MAX(P_PRICE) AS MAXPRICE, MIN(P_PRICE) AS MINPRICE
FROM PRODUCT;


/*Q7 - SUM*/
/* find the total value of all items carried in inventory */
SELECT SUM(P_QOH * P_PRICE) AS TOTVALUE
FROM PRODUCT;



/*Q8*/
SELECT  AVG(P_Price) AS AvgPrice
FROM	PRODUCT;



/*Q9 - GROUP BY*/
/*average price of the products provided by each vendor*/
SELECT V_CODE, AVG(P_PRICE) AS AVGPRICE
FROM PRODUCT
GROUP BY V_CODE;



/*Q10*/
SELECT  VENDOR.V_Code, V_Name, COUNT(P_Code) AS NumOfProduct, AVG(P_Price)
FROM	VENDOR	JOIN	PRODUCT
	ON  VENDOR.V_Code=PRODUCT.V_Code
GROUP BY VENDOR.V_Code;

/*Q10*/
/*List the vendor code, vendor name, the number of products for each vendor, and the average product price for each vendor. */
SELECT  VENDOR.V_Code, V_Name, COUNT(P_Code) AS NumOfProduct, AVG(P_Price)
FROM	VENDOR	JOIN	PRODUCT
	ON  VENDOR.V_Code=PRODUCT.V_Code
GROUP BY VENDOR.V_Code;


/*Q11 - GROUP BY and JOIN*/
/*List the vendor code, vendor name, the total of quantity on hand for each vendor, 
the number of products for each vendor, and the average product price for each vendor. */

SELECT VENDOR.V_Code, V_NAME, SUM(P_QOH) AS TOTALQTY, COUNT(P_Code) AS NumOfProduct, AVG(P_Price)
FROM	VENDOR	JOIN	PRODUCT
	ON  VENDOR.V_Code=PRODUCT.V_Code
GROUP BY VENDOR.V_Code;



/*Q12*/
SELECT  VENDOR.V_Code, V_Name, COUNT(P_Code) AS NumOfProduct, AVG(P_Price)
FROM	VENDOR	JOIN	PRODUCT
	ON  VENDOR.V_Code=PRODUCT.V_Code
GROUP BY VENDOR.V_Code
HAVING AVG(P_Code)>40;

/*Q13*/
SELECT			PRODUCT.V_CODE, V_NAME, SUM(P_QOH*P_PRICE) AS TOTALCOST
FROM			PRODUCT JOIN VENDOR ON PRODUCT.V_CODE=VENDOR.V_CODE
WHERE			P_DISCOUNT=0
GROUP BY		V_CODE
HAVING		SUM(P_QOH*P_PRICE)>1000
ORDER BY	SUM(P_QOH*P_PRICE) DESC;


/*Q14 - WHERE Subqueries*/
/* List the product codes, product names, and prices with a price greater than or equal to the average product price. */
SELECT P_CODE, P_Descript, P_PRICE 
FROM PRODUCT
WHERE P_PRICE >= (SELECT AVG(P_PRICE) FROM PRODUCT);



/*Q15 - IN Subqueries */
/* List the product codes, product names, and prices for the products whose vendor’s area codes are in 615 or 713. */
SELECT		P_Code, P_Descript, P_Price
FROM		PRODUCT
WHERE		V_Code IN  (
SELECT 		V_Code
FROM 		VENDOR
WHERE 		V_Areacode IN ('615','713'));


/*Q15 using Join but same thing, professor like this cause easier lol*/
SELECT		P_Code, P_Descript, P_Price
FROM		PRODUCT JOIN VENDOR USING (V_CODE)
WHERE 		V_Areacode IN ('615','713');



/*Q16 - IN Subqueries*/
/* List the vendor codes and names for the vendors whose product prices are greater than $40. */
SELECT V_CODE, V_NAME
FROM VENDOR
WHERE V_CODE IN ( SELECT V_CODE FROM PRODUCT WHERE P_PRICE > 40);


