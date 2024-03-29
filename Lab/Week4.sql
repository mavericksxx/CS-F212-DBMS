use 20220276db;

CREATE TABLE SUPPLIER 
(SNO int NOT NULL PRIMARY KEY,
SNAME VARCHAR (50) NOT NULL,
CITY VARCHAR (20) NOT NULL);


INSERT INTO SUPPLIER (SNO, SNAME, CITY) VALUES
(1, 'Smith', 'London'),
(2, 'Jones', 'Paris'),
(3, 'Adams', 'Vienna'),
(4, 'Blake', 'Rome');

CREATE TABLE PART
(PNO int NOT NULL PRIMARY KEY,
PNAME VARCHAR (50) NOT NULL,
PRICE int NOT NULL);

INSERT INTO PART (PNO, PNAME, PRICE) VALUES
(1, 'Screw', 10),
(2, 'Nut', 8),
(3, 'Bolt', 15),
(4, 'Cam', 25);

CREATE TABLE SELLS
(SNO int NOT NULL,
PNO int NOT NULL,
Foreign key (SNO) references SUPPLIER (SNO),
Foreign key (PNO) references PART (PNO));

INSERT INTO SELLS (SNO, PNO) VALUES
(1,1),
(1,2),
(2,4),
(3,1),
(3,3),
(4,2),
(4,3),
(4,4);

--1
SELECT *
FROM PART
WHERE PRICE>10;

--2
SELECT PNAME, PRICE
FROM PART
WHERE PRICE > 10;

--3
SELECT PNAME, PRICE
FROM PART
WHERE PNAME = "Bolt" AND (PRICE = '0' OR PRICE <= '15') ;

--4
SELECT PNAME, PRICE * 2 AS 'DOUBLE'
FROM PART
WHERE PRICE * 2 < 50;

--5
SELECT S.SNAME, P.PNAME
FROM SUPPLIER S, PART P, SELLS SE
WHERE S.SNO = SE.SNO AND
P.PNO = SE.PNO;

--6
SELECT AVG(PRICE) AS 'AVG_PRICE'
FROM PART;

--7
SELECT COUNT(PNO)
FROM PART;

--8
SELECT S.SNO, S.SNAME, COUNT(SE.PNO)
FROM SUPPLIER S, SELLS SE
WHERE S.SNO = SE.SNO
GROUP BY S.SNO, S.SNAME;

--9
SELECT S.SNO, S.SNAME, COUNT(SE.PNO)
FROM SUPPLIER S, SELLS SE
WHERE S.SNO = SE.SNO
GROUP BY S.SNO, S.SNAME
HAVING COUNT(SE.PNO) > 1;

--10
SELECT *
FROM PART
WHERE PRICE > (SELECT PRICE FROM PART
WHERE PNAME = "Screw");

--11
SELECT *
FROM SUPPLIER S
WHERE NOT EXISTS
(SELECT * FROM SELLS SE
WHERE SE.SNO = S.SNO);

--12
SELECT S.SNO, S.SNAME, S.CITY
FROM SUPPLIER S
WHERE S.SNAME = "Jones"
UNION
SELECT S.SNO, S.SNAME, S.CITY
FROM SUPPLIER S
WHERE S.SNAME = "Adams";

--13
CREATE INDEX I
ON SUPPLIER (SNAME);

--14
CREATE VIEW London_Suppliers
AS SELECT S.SNAME, P.PNAME
FROM SUPPLIER S, PART P, SELLS SE
WHERE S.SNO = SE.SNO AND
P.PNO = SE.PNO AND
S.CITY = "London";

--15
SELECT *
FROM London_Suppliers
WHERE PART.PNAME = "Screw";

--16
UPDATE PART
SET PRICE = 15
WHERE PNAME = "Screw";
