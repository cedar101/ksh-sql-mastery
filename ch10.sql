
-------------------------------------------------
-- 10장

CREATE TABLE car
(
	car VARCHAR(30) NOT NULL,		-- 이름
	capacity INT NOT NULL,			-- 배기량
	price INT NOT NULL,			-- 가격
	maker VARCHAR(30) NOT NULL		-- 제조사
);

INSERT INTO car (car, capacity, price, maker) VALUES ('소나타', 2000, 2500, '현대');
INSERT INTO car (car, capacity, price, maker) VALUES ('티볼리', 1600, 2300, '쌍용');
INSERT INTO car (car, capacity, price, maker) VALUES ('A8', 3000, 4800, 'Audi');
INSERT INTO car (car, capacity, price, maker) VALUES ('SM5', 2000, 2600, '삼성');

CREATE TABLE maker
(
	maker VARCHAR(30) NOT NULL,		-- 회사
	factory CHAR(10) NOT NULL,	    	-- 공장
	domestic CHAR(1) NOT NULL		-- 국산 여부. Y/N
);

INSERT INTO maker (maker, factory, domestic) VALUES ('현대', '부산', 'y');
INSERT INTO maker (maker, factory, domestic) VALUES ('쌍용', '청주', 'y');
INSERT INTO maker (maker, factory, domestic) VALUES ('Audi', '독일', 'n');
INSERT INTO maker (maker, factory, domestic) VALUES ('기아', '서울', 'y');

SELECT * FROM car, maker;

SELECT * FROM car CROSS JOIN maker;

SELECT * FROM car, maker WHERE car.maker = maker.maker;

SELECT car.car, car.price, maker.maker, maker.factory FROM car, maker 
WHERE car.maker = maker.maker;

SELECT car.*, maker.factory FROM car, maker WHERE car.maker = maker.maker;

SELECT car, price, maker.maker, factory FROM car, maker WHERE car.maker = maker.maker;

SELECT car, price, maker, factory FROM car, maker WHERE car.maker = maker.maker;

SELECT C.car, C.price, M.maker, M.factory FROM car C, maker M WHERE C.maker = M.maker;

SELECT A.car, A.price, B.maker, B.factory FROM car A, maker B WHERE A.maker = B.maker;

SELECT C.car, C.price, M.maker, M.factory FROM car C INNER JOIN maker M 
ON C.maker = M.maker;

SELECT C.car, C.price, M.maker, M.factory FROM maker M INNER JOIN car C 
ON M.maker = C.maker;

SELECT C.car, C.price, maker, M.factory FROM car C INNER JOIN maker M USING(maker);

SELECT C.car, C.price, M.maker, M.factory FROM car C LEFT OUTER JOIN maker M 
ON C.maker = M.maker;

SELECT C.car, C.price, M.maker, M.factory FROM car C RIGHT OUTER JOIN maker M 
ON C.maker = M.maker;

SELECT C.car, C.price, M.maker, M.factory FROM maker M LEFT OUTER JOIN car C 
ON C.maker = M.maker;

SELECT C.car, C.price, M.maker, M.factory FROM car C FULL OUTER JOIN maker M 
ON C.maker = M.maker;

SELECT * FROM car C 
INNER JOIN maker M ON C.maker = M.maker 
INNER JOIN city T ON M.factory = T."name";

SELECT C.car, M.factory, T.area FROM car C 
INNER JOIN maker M ON C.maker = M.maker 
INNER JOIN city T ON M.factory = T."name";

SELECT * FROM car C 
LEFT OUTER JOIN maker M ON C.maker = M.maker 
LEFT OUTER JOIN city T ON M.factory = T."name";

SELECT * FROM maker M 
INNER JOIN city T ON M.factory = T."name" 
INNER JOIN car C ON M.maker = C.maker;

SELECT * FROM maker M 
LEFT OUTER JOIN city T ON M.factory = T."name" 
LEFT OUTER JOIN car C ON M.maker = C.maker;

SELECT maker FROM car WHERE car = '티볼리';
SELECT factory FROM maker WHERE maker = '쌍용';

SELECT factory FROM maker WHERE maker = 
(SELECT maker FROM car WHERE car = '티볼리');

SELECT * FROM car C INNER JOIN maker M ON M.maker = C.maker;

SELECT * FROM car C INNER JOIN maker M ON M.maker = C.maker AND C.car = '티볼리';

SELECT M.factory FROM car C INNER JOIN maker M 
ON M.maker = C.maker AND C.car = '티볼리';

SELECT M.factory, C.price FROM car C INNER JOIN maker M 
ON M.maker = C.maker AND C.car = '티볼리';

SELECT factory, price FROM maker WHERE maker = 
(SELECT maker FROM car WHERE car = '티볼리');

SELECT factory, (SELECT price FROM car WHERE car = '티볼리') AS price 
FROM maker WHERE maker = (SELECT maker FROM car WHERE car = '티볼리');

SELECT C.*, M.factory, M.domestic FROM car C INNER JOIN maker M 
ON M.maker = C.maker AND C.car = '티볼리';

INSERT INTO car (car, capacity, price, maker) VALUES ('티볼리', 1800, 2600, '쌍용');

SELECT C.*, M.factory, M.domestic FROM car C LEFT OUTER JOIN maker M 
ON C.maker = M.maker;

INSERT INTO car (car, capacity, price, maker) VALUES ('소나타', 2400, 2900, '현대');
INSERT INTO maker (maker, factory, domestic) VALUES ('현대', '울산', 'y');
INSERT INTO maker (maker, factory, domestic) VALUES ('현대', '마산', 'y');

SELECT * FROM car C INNER JOIN maker M ON C.maker = M.maker;

SELECT * FROM car C INNER JOIN maker M ON C.maker = M.maker WHERE C.capacity = 2000;

SELECT * FROM car C INNER JOIN maker M ON C.maker = M.maker AND C.capacity = 2000;

SELECT * FROM car C LEFT OUTER JOIN maker M ON C.maker = M.maker 
WHERE C.capacity = 2000;

SELECT * FROM car C LEFT OUTER JOIN maker M 
ON C.maker = M.maker AND C.capacity = 2000;

SELECT * FROM car C LEFT OUTER JOIN maker M 
ON C.maker = M.maker AND C.capacity = 2000 WHERE C.price > 2800 ORDER BY price DESC;

SELECT * FROM car WHERE capacity > 2000 C LEFT JOIN maker M ON C.maker = M.maker;

SELECT * FROM (SELECT * FROM car WHERE capacity > 2000) C 
LEFT JOIN maker M ON C.maker = M.maker;

SELECT * FROM car C LEFT JOIN maker M ON C.maker = M.maker WHERE C.capacity > 2000;

SELECT * FROM (SELECT * FROM car WHERE capacity > 2000) C LEFT JOIN 
(SELECT * FROM maker WHERE factory = '울산') M ON C.maker = M.maker;

SELECT * FROM (SELECT * FROM car WHERE capacity > 2000) C LEFT JOIN 
maker M ON C.maker = M.maker WHERE M.factory = '울산';

SELECT * FROM "member", order;

SELECT * FROM "member" M, order O WHERE M."member" = O."member";
SELECT * FROM "member" M INNER JOIN "order" O ON M."member" = O."member";

SELECT M.addr, M."member", O.item, O.num, O.orderDate FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member";

SELECT M.addr, M."member", O.item, O.num, O.orderDate FROM "member" M 
LEFT OUTER JOIN "order" O ON M."member" = O."member";

SELECT M.addr, O."member", O.item, O.num, O.orderDate FROM "member" M 
RIGHT OUTER JOIN "order" O ON M."member" = O."member";

SELECT M.addr, M."member", O."member", O.item, O.num, O.orderDate FROM "member" M 
FULL OUTER JOIN "order" O ON M."member" = O."member";

SELECT item, price FROM item WHERE item = 
(SELECT item FROM "order" WHERE "member"='춘향');

SELECT * FROM item I INNER JOIN "order" O ON O.item = I.item;

SELECT * FROM item I INNER JOIN "order" O ON O.item = I.item WHERE O."member" = '춘향';
SELECT * FROM item I INNER JOIN "order" O ON O.item = I.item AND O."member" = '춘향';

SELECT O.item, I.price FROM item I 
INNER JOIN "order" O ON O.item = I.item WHERE O."member" = '춘향';

SELECT O.item, I.price, O.num FROM item I 
INNER JOIN "order" O ON O.item = I.item WHERE O."member" = '향단';

SELECT item, price, num FROM item WHERE item IN 
(SELECT item FROM "order" WHERE "member"='향단');

SELECT item, price, (SELECT num FROM "order" O WHERE O.item = I.item) 
FROM item I WHERE item IN (SELECT item FROM "order" WHERE "member"='향단');

SELECT * FROM "member";

SELECT * FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member"; 

SELECT * FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member" 
INNER JOIN item I ON I.item = O.item;

SELECT * FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member" 
INNER JOIN item I ON I.item = O.item
INNER JOIN category C ON I.category = C.category;

SELECT M."member", O.item, O.num, O.orderDate, I.price, C.delivery FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member" 
INNER JOIN item I ON I.item = O.item
INNER JOIN category C ON I.category = C.category;

SELECT M."member", O.item, O.num, O.orderDate, I.price, C.delivery 
FROM (SELECT * FROM "member" WHERE age > 19) M 
INNER JOIN "order" O ON M."member" = O."member" 
INNER JOIN item I ON I.item = O.item
LEFT OUTER JOIN category C ON I.category = C.category AND C.category != '성인'
WHERE I.price * O.num > 100000 ORDER BY M."member";

SELECT M."member", O.item, O.num, I.price FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member" 
INNER JOIN item I ON I.item = O.item;

SELECT "member", num * price AS total, item FROM
(
    SELECT M."member", O.item, O.num, I.price FROM "member" M 
    INNER JOIN "order" O ON M."member" = O."member" 
    INNER JOIN item I ON I.item = O.item
) A;

SELECT * FROM
(
	SELECT M."member", M.addr, O.item, O.num, O.orderDate, I.price, C.delivery 
	FROM (SELECT * FROM "member" WHERE age > 19) M 
	INNER JOIN "order" O ON M."member" = O."member" 
	INNER JOIN item I ON I.item = O.item
	LEFT OUTER JOIN category C ON I.category = C.category AND C.category != '성인'
	WHERE I.price * O.num > 100000
) A
LEFT OUTER JOIN city T ON TRIM(T."name") = SUBSTR(A.addr, 0, 2);
-- MSSQL : LEFT OUTER JOIN city T ON T."name" = SUBSTRING(A.addr, 0, 4);
-- 마리아 : LEFT OUTER JOIN city T ON T."name" = SUBSTRING(addr, 1, 2);

CREATE TABLE directory
(
	id INT PRIMARY KEY,
	"name" VARCHAR(20) NOT NULL,
	parent INT NOT NULL
);

INSERT INTO directory (id, "name", parent) VALUES (1, 'Root', 0);
INSERT INTO directory (id, "name", parent) VALUES (2, 'Data', 1);
INSERT INTO directory (id, "name", parent) VALUES (3, 'Program', 1);
INSERT INTO directory (id, "name", parent) VALUES (4, 'Sound', 2);
INSERT INTO directory (id, "name", parent) VALUES (5, 'Picture', 2);
INSERT INTO directory (id, "name", parent) VALUES (6, 'Game', 3);
INSERT INTO directory (id, "name", parent) VALUES (7, 'StartCraft', 6);

SELECT A."name" 부모, B."name" 자식 FROM directory A 
INNER JOIN directory B ON A.id = B.parent;

SELECT A."name" 부모, A.id, B."name", B.parent 자식 FROM directory A CROSS JOIN directory B;

SELECT * FROM car, maker WHERE car.maker = maker.maker;

SELECT * FROM car INNER JOIN maker ON car.maker = maker.maker;

SELECT * FROM car LEFT OUTER JOIN maker ON car.maker = maker.maker;

SELECT * FROM car, maker WHERE car.maker = maker.maker(+);
SELECT * FROM car, maker WHERE car.maker(+) = maker.maker;

SELECT * FROM car, maker WHERE car.maker *= maker.maker;