-------------------------------------------------
-- 9장

SELECT MAX(population), "name" FROM city;

SELECT "name" FROM city WHERE population = MAX(population);

SELECT MAX(population) FROM city;

SELECT "name" FROM city WHERE population = 974;

SELECT "name" FROM city WHERE population = (SELECT MAX(population) FROM city);

SELECT MAX(num) FROM item;

SELECT item FROM item WHERE num = 80;

SELECT item FROM item WHERE num = (SELECT MAX(num) FROM item);

SELECT category FROM item WHERE item= '청바지';

SELECT delivery FROM category WHERE category = '패션';

SELECT delivery FROM category WHERE category = (SELECT category FROM item 
WHERE item = '청바지');

SELECT item FROM item WHERE price = 70000;

SELECT "member" FROM "order" WHERE item = 
(SELECT item FROM item WHERE price = 70000);

SELECT age FROM "member" WHERE "member" = 
(SELECT "member" FROM "order" WHERE item = 
(SELECT item FROM item WHERE price = 70000));

SELECT price FROM item WHERE item = 
(SELECT item FROM "order" WHERE "member" = '향단');

SELECT price FROM item WHERE item = 
(SELECT item FROM "order" WHERE "member" = '향단' 
ORDER BY item OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY);

SELECT item, price FROM item WHERE item IN 
(SELECT item FROM "order" WHERE "member" = '향단');

SELECT item, price FROM item WHERE item IN ('대추', '사과');

SELECT price FROM item WHERE item = (SELECT item FROM "order" WHERE "member" = '이도령');

SELECT depart, gender FROM staff WHERE "name" = '윤봉길';

SELECT * FROM staff WHERE depart = '영업부' AND gender = '남';

SELECT * FROM staff WHERE depart = 
(SELECT depart FROM staff WHERE "name" = '안중근')
AND gender = (SELECT gender FROM staff WHERE "name" = '안중근');

SELECT * FROM staff WHERE (depart, gender) = 
(SELECT depart, gender FROM staff WHERE "name" = '안중근');

SELECT * FROM staff WHERE (depart, salary) IN 
(SELECT depart, MAX(salary) FROM staff GROUP BY depart);

SELECT * FROM staff S WHERE salary = 
(SELECT MAX(salary) FROM staff WHERE depart = S.depart);

SELECT T.* FROM staff T
INNER JOIN (SELECT depart, MAX(salary) ms FROM staff GROUP BY depart) M
ON T.depart = M.depart AND T.salary = M.ms;

UPDATE city SET (area, population) = (SELECT area, population FROM city WHERE "name"='부산') 
WHERE "name" = '서울';

SELECT "name" FROM staff WHERE salary > ANY 
(SELECT salary FROM staff WHERE depart = '영업부');
SELECT "name" FROM staff WHERE salary > ALL 
(SELECT salary FROM staff WHERE depart = '영업부');

SELECT "name" FROM staff WHERE salary > 
(SELECT MIN(salary) FROM staff WHERE depart = '영업부');
SELECT "name" FROM staff WHERE salary > 
(SELECT MAX(salary) FROM staff WHERE depart = '영업부');

SELECT item, price FROM item WHERE item = ANY 
(SELECT item FROM "order" WHERE "member" = '향단');

SELECT "member", item, (SELECT price FROM item WHERE item.item = order.item) price 
FROM "order";

SELECT O."member", O.item, (SELECT price FROM item I WHERE I.item = O.item) price 
FROM "order" O;

SELECT O."member", O.item, I.price FROM "order" O JOIN item I ON I.item = O.item; 

EXISTS (SELECT * FROM city WHERE area > 1000)

SELECT "name" FROM city WHERE EXISTS (SELECT * FROM city WHERE area > 1000);

SELECT "name" FROM city C WHERE EXISTS (SELECT * FROM city WHERE C.area > 1000);

SELECT * FROM "member" M WHERE EXISTS 
(SELECT * FROM "order" O WHERE O."member" = M."member");

SELECT * FROM "member" M WHERE NOT EXISTS 
(SELECT * FROM "order" O WHERE O."member" = M."member");

SELECT * FROM "member" WHERE "member" IN (SELECT DISTINCT "member" FROM "order");

....EXISTS (SELECT item FROM "order" O WHERE O."member" = M."member");
....EXISTS (SELECT "member" FROM "order" O WHERE O."member" = M."member");
....EXISTS (SELECT '얼씨구' FROM "order" O WHERE O."member" = M."member");

SELECT * FROM (SELECT * FROM city) A;

SELECT * FROM (SELECT "name", population, area FROM city) A;
SELECT * FROM (SELECT * FROM city WHERE metro = 'y') B;

SELECT "member", addr FROM (SELECT * FROM "member" WHERE age < 19) A 
WHERE A.money >= 100000;

SELECT "member", addr FROM "member" WHERE age < 19 AND money >= 100000;

SELECT * FROM (SELECT * FROM staff WHERE grade = '과장' OR grade = '부장') A 
WHERE A.score >= 70;

SELECT * FROM staff WHERE grade = '과장' OR grade = '부장' AND score >= 70;

SELECT "member", addr FROM (SELECT * FROM "member" WHERE age < 19) A 
WHERE A.money >= 100000;

SELECT * FROM (SELECT * FROM city WHERE metro = 'y') A;

SELECT * FROM (SELECT * FROM city WHERE metro = 'y') AS A;

SELECT "name", population * 10000 AS ingu FROM city;

SELECT "name", population * 10000 AS ingu FROM city WHERE ingu > 1000000;

SELECT * FROM (
	SELECT "name", population * 10000 AS ingu FROM city
) A
WHERE A.ingu > 1000000;

SELECT * FROM (
	SELECT "name", population * 10000 AS ingu FROM city
)
WHERE ingu > 1000000;

SELECT "name", (population * 10000 / area) AS dens FROM city;

SELECT "name", (population * 10000 / area) AS dens 
	,CASE 
		WHEN (population * 10000 / area) > 1000 THEN '고밀도'
		WHEN (population * 10000 / area) > 100 THEN '중밀도'
		ELSE '저밀도'
	END densgrade
FROM city;

SELECT "name", (population * 10000 / area) AS dens 
	,CASE 
		WHEN dens > 1000 THEN '고밀도'
		WHEN dens > 100 THEN '중밀도'
		ELSE '저밀도'
	END densgrade
FROM city;

SELECT "name", dens 
	,CASE 
		WHEN dens > 1000 THEN '고밀도'
		WHEN dens > 100 THEN '중밀도'
		ELSE '저밀도'
	END densgrade
FROM
(
	SELECT "name", (population * 10000 / area) AS dens FROM city
) CD;

SELECT "name", dens 
	,CASE 
		WHEN dens > 1000 THEN '고밀도'
		WHEN dens > 100 THEN '중밀도'
		ELSE '저밀도'
	END densgrade
	,
    CASE
    WHEN
        CASE 
            WHEN dens > 1000 THEN '고밀도'
            WHEN dens > 100 THEN '중밀도'
            ELSE '저밀도'
        END = '고밀도' THEN '8차로'
    WHEN
        CASE 
            WHEN dens > 1000 THEN '고밀도'
            WHEN dens > 100 THEN '중밀도'
            ELSE '저밀도'
        END = '중밀도' THEN '4차로'
    ELSE '2차로' 
    END roadplan
FROM
(
	SELECT "name", (population * 10000 / area) AS dens FROM city
) CD;

SELECT "name", dens, densgrade,
CASE
    WHEN densgrade = '고밀도' THEN '8차로'
    WHEN densgrade = '중밀도' THEN '4차로'
    ELSE '2차로' 
END roadplan
FROM
(
    SELECT "name", dens 
        ,CASE 
            WHEN dens > 1000 THEN '고밀도'
            WHEN dens > 100 THEN '중밀도'
            ELSE '저밀도'
        END densgrade
    FROM
    (
        SELECT "name", (population * 10000 / area) AS dens FROM city
    ) CD
) CR;

SELECT * FROM item WHERE category = '식품' 
UNION 
SELECT * FROM item WHERE category = '가전';

SELECT DISTINCT depart FROM staff WHERE salary > 400 
UNION ALL
SELECT DISTINCT depart FROM staff WHERE score > 80;

SELECT * FROM item WHERE category = '식품' OR category = '가전';

SELECT * FROM "member" UNION SELECT * FROM item;

SELECT "member" FROM "member" 
UNION
SELECT "name" FROM staff 
UNION
SELECT "name" FROM employee;

SELECT * FROM 부산대리점 UNION SELECT * FROM 서울대리점;

SELECT "name" FROM staff WHERE depart = '영업부'
INTERSECT 
SELECT "name" FROM staff WHERE gender = '여';

SELECT "name" FROM staff
INTERSECT
SELECT "member" FROM "member";

SELECT "name" FROM staff WHERE depart = '영업부'
MINUS 
SELECT "name" FROM staff WHERE gender = '여';

SELECT "name" FROM staff WHERE gender = '여'
MINUS
SELECT "name" FROM staff WHERE depart = '영업부';

/* 오라클, 마리아 : */ CREATE TABLE staff2 AS SELECT * FROM staff;
-- MSSQL : SELECT * INTO staff2 FROM staff;

UPDATE staff2 SET salary = 500 WHERE "name" = '안창호';
UPDATE staff2 SET depart = '인사과' WHERE "name" = '성삼문';
DELETE FROM staff2 WHERE "name" = '홍길동';
INSERT INTO staff2 VALUES ('어우동', '총무부', '여', '20220401', '신입', 450, 0);

SELECT * FROM staff2
MINUS 
SELECT * FROM staff;

/* 오라클, 마리아 : */ CREATE TABLE cityNew AS SELECT * FROM city;
-- MSSQL : SELECT * INTO cityNew FROM city;

UPDATE cityNew SET population = 1000 WHERE "name" = '서울';
UPDATE cityNew SET area = 900 WHERE "name" = '부산';
DELETE FROM cityNew WHERE "name" = '춘천';
INSERT INTO cityNew VALUES ('이천',461,21,'n','경기');

MERGE INTO city T USING cityNew S ON (S."name" = T."name")
WHEN MATCHED THEN
	UPDATE SET T.area = S.area, T.population = S.population
WHEN NOT MATCHED THEN
	INSERT VALUES (S."name", S.area, S.population, S.metro, S.region);

MERGE INTO city T USING (SELECT * FROM cityNew WHERE region = '경기') S ON (S."name" = T."name")
....

MERGE INTO city T USING cityNew S ON (S."name" = T."name" AND S.region = '경기')
....

CREATE TABLE citypopulation
(
	"name" CHAR(10) PRIMARY KEY,
	population INT NULL
);

INSERT INTO citypopulation VALUES ('서울',1000);
INSERT INTO citypopulation VALUES ('부산',500);
INSERT INTO citypopulation VALUES ('춘천',100);

MERGE INTO city C USING citypopulation P ON (C."name" = P."name")
WHEN MATCHED THEN UPDATE SET C.population = P.population;

UPDATE city SET population = citypopulation.population FROM citypopulation WHERE city."name" = citypopulation."name";

UPDATE city SET population = S.population FROM citypopulation AS S WHERE city."name" = S."name";

UPDATE city AS T SET T.population = S.population FROM citypopulation AS S WHERE T."name" = S."name";

UPDATE city SET population = (SELECT population FROM citypopulation P WHERE P."name" = city."name")
WHERE "name" IN (SELECT "name" FROM citypopulation)
