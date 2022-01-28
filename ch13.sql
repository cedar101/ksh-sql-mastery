-------------------------------------------------
-- 13장

CREATE TABLE month_sale
(
	year INT,
	month INT,
	sales	INT
);

INSERT INTO month_sale VALUES(2021, 9, 3650);
INSERT INTO month_sale VALUES(2021, 10, 4120);
INSERT INTO month_sale VALUES(2021, 11, 5000);
INSERT INTO month_sale VALUES(2021, 12, 4420);
INSERT INTO month_sale VALUES(2022, 1, 3800);
INSERT INTO month_sale VALUES(2022, 2, 4200);
INSERT INTO month_sale VALUES(2022, 3, 4150);

SELECT gender, SUM(salary) FROM staff GROUP BY gender;
SELECT depart, SUM(salary) FROM staff GROUP BY depart;
SELECT depart, gender, SUM(salary) FROM staff GROUP BY depart, gender;

SELECT depart, SUM(salary) FROM staff GROUP BY ROLLUP(depart);

SELECT depart, gender, SUM(salary) FROM staff GROUP BY ROLLUP(depart, gender);

SELECT gender, depart, SUM(salary) FROM staff GROUP BY ROLLUP(gender, depart);

SELECT depart, gender, SUM(salary) FROM staff GROUP BY depart, ROLLUP(gender);
SELECT gender, depart, SUM(salary) FROM staff GROUP BY gender, ROLLUP(depart);

SELECT depart, gender, SUM(salary) FROM staff GROUP BY CUBE(depart, gender);

SELECT depart, gender, SUM(salary) FROM staff GROUP BY ROLLUP(depart, gender)
UNION
SELECT depart, gender, SUM(salary) FROM staff GROUP BY ROLLUP(gender, depart);

SELECT depart, gender, SUM(salary) FROM staff GROUP BY CUBE(gender, depart);

SELECT depart, gender, SUM(salary) FROM staff GROUP BY GROUPING SETS(depart, gender);

SELECT GROUPING(depart), depart, SUM(salary) FROM staff GROUP BY ROLLUP(depart);

SELECT CASE GROUPING(depart) WHEN 1 THEN '전체부서' ELSE depart END AS depart, 
SUM(salary) FROM staff GROUP BY ROLLUP(depart);

SELECT CASE GROUPING(depart) WHEN 1 THEN '전체부서' ELSE depart END AS depart,
	CASE GROUPING(gender) WHEN 1 THEN '전체성별' ELSE gender END AS gender, 
	SUM(salary) FROM staff GROUP BY CUBE(depart, gender)
	ORDER BY /*GROUPING(depart), GROUPING(gender),*/ depart, gender;

SELECT "name", depart, salary, SUM(salary) FROM staff;

SELECT depart, SUM(salary) FROM staff GROUP BY depart;

SELECT "name", depart, salary, (SELECT SUM(salary) FROM staff) AS 월급총합 FROM staff;

SELECT "name", depart, salary, SUM(salary) OVER() AS 월급총합 FROM staff;

SELECT "name", depart, salary, ROUND(salary * 100.0 / SUM(salary) OVER(), 2) 
AS 월급비율 FROM staff;

SELECT "name", depart, salary, (SELECT SUM(salary) FROM staff GROUP BY depart) 
AS 부서월급총합 FROM staff;

SELECT "name", depart, salary, (SELECT SUM(salary) FROM staff WHERE depart = A.depart) 
AS 부서월급총합 FROM staff A ORDER BY depart;

SELECT "name", depart, salary, SUM(salary) OVER(PARTITION BY depart) 
AS 부서월급총합 FROM staff;

SELECT "name", depart, salary, SUM(salary) OVER(ORDER BY "name") 
AS 누적월급 FROM staff;

SELECT "name", depart, salary, SUM(salary) OVER(PARTITION BY depart ORDER BY "name") 
AS 부서누적월급 FROM staff;

SELECT "name", depart, salary, (SELECT SUM(salary) FROM staff 
WHERE "name" <= A."name") AS 누적월급 FROM staff A ORDER BY "name";
SELECT "name", depart, salary, (SELECT SUM(salary) FROM staff 
WHERE "name" <= A."name" AND depart = A.depart) AS 부서누적월급 
FROM staff A ORDER BY depart, "name";

SELECT "name", depart, salary, SUM(salary) OVER(ORDER BY "name" 
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS 누적월급 FROM staff;

SELECT "name", depart, salary, SUM(salary) OVER(ORDER BY "name" 
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS 누적월급 FROM staff;

SELECT "name", depart, joindate, salary, 
SUM(salary) OVER(PARTITION BY depart ORDER BY joindate 
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS 누적월급 FROM staff;

SELECT "name", depart, salary, SUM(salary) OVER(ORDER BY salary 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 누적월급 FROM staff;

SELECT "name", depart, salary, SUM(salary) OVER(ORDER BY salary 
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 누적월급 FROM staff;

SELECT RANK() OVER (ORDER BY salary DESC), staff.* FROM staff;
MSSQL, 마리아 : SELECT RANK() OVER (ORDER BY salary DESC), * FROM staff;

SELECT RANK() OVER (ORDER BY salary DESC), staff.* FROM staff ORDER BY score;

SELECT RANK() OVER (ORDER BY salary DESC) AS 순위, staff.* FROM staff 
WHERE depart = '영업부';

SELECT RANK() OVER (PARTITION BY depart ORDER BY salary DESC) 
AS 순위, staff.* FROM staff;

SELECT DENSE_RANK() OVER (ORDER BY salary DESC), staff.* FROM staff;

SELECT ROW_NUMBER() OVER (ORDER BY "name"), staff.* FROM staff;

SELECT ROW_NUMBER() OVER (ORDER BY rownum) AS 순서, staff.* FROM staff;

SELECT ROW_NUMBER() OVER (ORDER BY "name") AS 순서, staff.* FROM staff
ORDER BY 순서 OFFSET 2 * 5 ROWS FETCH NEXT 5 ROWS ONLY;

SELECT * FROM
(SELECT ROW_NUMBER() OVER (ORDER BY "name") AS 순서, staff.* FROM staff) S
WHERE S.순서 > 2 * 5 AND rownum <= 5;

SELECT TOP(5) * FROM
(SELECT ROW_NUMBER() OVER (ORDER BY "name") AS 순서, staff.* FROM staff) S
WHERE S.순서 > 2 * 5;

SELECT ROW_NUMBER() OVER (ORDER BY "name") AS 순서, staff.* FROM staff LIMIT 11, 5;

SELECT NTILE(4) OVER (ORDER BY salary DESC) AS 구간, "name", salary FROM staff;
SELECT NTILE(4) OVER (PARTITION BY gender ORDER BY salary DESC) 
AS 구간, "name", gender, salary FROM staff;

SELECT "name", score FROM 
(SELECT NTILE(5) OVER (ORDER BY score DESC) AS 구간, staff.* FROM staff) S 
WHERE S.구간 = 3;

SELECT year, month, sales,
	LAG(sales) OVER (ORDER BY year, month) AS priorMonth,
	LEAD(sales) OVER (ORDER BY year, month) AS nextMonth
FROM month_sale;

SELECT year, month, sales,
	sales - LAG(sales) OVER (ORDER BY year, month) AS incsales
FROM month_sale;

SELECT year, month, sales,
	LAG(sales) OVER (PARTITION BY year ORDER by year, month) AS priorMonth,
	LEAD(sales) OVER (PARTITION BY year ORDER by year, month) AS nextMonth
FROM month_sale;

SELECT year, month, sales,
	ROUND(CUME_DIST() OVER (ORDER BY year, month) * 100, 2) AS cume,
	ROUND(PERCENT_RANK() OVER (ORDER BY year, month) * 100, 2) AS rank
FROM month_sale;

SELECT "name", salary,
	ROUND(CUME_DIST() OVER (ORDER BY salary) * 100, 2) AS cume,
	ROUND(PERCENT_RANK() OVER (ORDER BY salary) * 100, 2) AS rank
FROM staff;

SELECT depart, "name", salary,
	ROUND(CUME_DIST() OVER (PARTITION BY depart ORDER BY salary) * 100, 2) AS cume,
	ROUND(PERCENT_RANK() OVER (PARTITION BY depart ORDER BY salary) * 100, 2) AS rank
FROM staff;

SELECT "name", salary,
	FIRST_VALUE(salary) OVER (ORDER BY salary) AS first,
	LAST_VALUE(salary) OVER (ORDER BY salary) AS midlast,
	LAST_VALUE(salary) OVER (ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last
FROM staff;

SELECT "name", salary,
	salary - FIRST_VALUE(salary) OVER (ORDER BY salary) AS 최저월급기준,
	LAST_VALUE(salary) OVER (ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) - salary AS 최고월급기준
FROM staff ORDER BY "name";

SELECT depart, "name", salary,
	salary - FIRST_VALUE(salary) OVER (PARTITION BY depart ORDER BY salary) AS 최저월급기준,
	LAST_VALUE(salary) OVER (PARTITION BY depart ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) - salary AS 최고월급기준
FROM staff ORDER BY depart, salary;

SELECT year, month, sales,	
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY sales) 
OVER (PARTITION BY year) AS cont,	
PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY sales) 
OVER (PARTITION BY year) AS disc
FROM month_sale;

CREATE TABLE season
(
	item VARCHAR(10),
	season VARCHAR(10),
	sale INT
);

INSERT INTO season VALUES ('냉면', '봄', 20);
INSERT INTO season VALUES ('냉면', '여름', 50);
INSERT INTO season VALUES ('냉면', '가을', 30);
INSERT INTO season VALUES ('냉면', '겨울', 10);
INSERT INTO season VALUES ('짬뽕', '봄', 30);
INSERT INTO season VALUES ('짬뽕', '여름', 10);
INSERT INTO season VALUES ('짬뽕', '가을', 20);
INSERT INTO season VALUES ('짬뽕', '겨울', 40);

SELECT * FROM season
PIVOT (MAX(sale) FOR season IN ('봄', '여름', '가을', '겨울'));

SELECT * FROM season
PIVOT (MAX(sale) FOR season IN ('여름', '봄', '가을'));

SELECT * FROM season
PIVOT (MAX(sale) FOR item IN ('냉면', '짬뽕'))

SELECT * FROM season
PIVOT (sale FOR season IN ('봄', '여름', '가을', '겨울')) pvt;

SELECT * FROM season
PIVOT (SUM(sale) FOR season IN ('봄', '여름', '가을', '겨울')) pvt;

INSERT INTO season2 VALUES ('냉면', '봄', 20);
INSERT INTO season2 VALUES ('냉면', '여름', 50);
INSERT INTO season2 VALUES ('냉면', '가을', 30);
INSERT INTO season2 VALUES ('짬뽕', '봄', 30);
INSERT INTO season2 VALUES ('짬뽕', '가을', 20);
INSERT INTO season2 VALUES ('짬뽕', '겨울', 40);
INSERT INTO season2 VALUES ('짬뽕', '겨울', 30);

SELECT * FROM season2 PIVOT (MAX(sale) FOR season IN ('봄', '여름', '가을', '겨울')) pvt;
SELECT * FROM season2 PIVOT (SUM(sale) FOR season IN ('봄', '여름', '가을', '겨울')) pvt;

CREATE TABLE traffic
(
	line VARCHAR(10),
	hour INT,
	car VARCHAR(20),
	traffic INT
);

INSERT INTO traffic VALUES ('경부', 1, '승용차', 40);
INSERT INTO traffic VALUES ('경부', 2, '승용차', 41);
INSERT INTO traffic VALUES ('경부', 3, '승용차', 42);
INSERT INTO traffic VALUES ('경부', 1, '트럭', 30);
INSERT INTO traffic VALUES ('경부', 3, '트럭', 32);
INSERT INTO traffic VALUES ('호남', 1, '승용차', 20);
INSERT INTO traffic VALUES ('호남', 2, '승용차', 10);
INSERT INTO traffic VALUES ('호남', 2, '승용차', 11);
INSERT INTO traffic VALUES ('호남', 3, '승용차', 22);
INSERT INTO traffic VALUES ('호남', 1, '트럭', 10);
INSERT INTO traffic VALUES ('호남', 2, '트럭', 11);
INSERT INTO traffic VALUES ('호남', 3, '트럭', 12);

SELECT * FROM traffic PIVOT (SUM(traffic) FOR line IN ('경부', '호남')) pvt;
SELECT * FROM traffic PIVOT (SUM(traffic) FOR hour IN ('1', '2', '3')) pvt;

SELECT line, car, traffic FROM traffic 
PIVOT (SUM(traffic) FOR car IN ('승용차', '트럭')) pvt;

SELECT * FROM
(
	SELECT line, car, traffic FROM traffic
) prepvt
PIVOT (SUM(traffic) FOR car IN ('승용차', '트럭')) pvt;

SELECT line, SUM(승용차), SUM(트럭) FROM traffic
PIVOT (SUM(traffic) FOR car IN ('승용차' AS 승용차, '트럭' AS 트럭)) pvt
GROUP BY line;

SELECT * FROM
(
	SELECT hour, car, traffic FROM traffic
) prepvt
PIVOT (SUM(traffic) FOR car IN ('승용차', '트럭')) pvt;

SELECT * FROM
(
	SELECT car, traffic FROM traffic
) prepvt
PIVOT (SUM(traffic) FOR car IN ('승용차', '트럭')) pvt;

SELECT line, 트럭, 승용차 FROM
(
	SELECT line, hour, car, traffic FROM traffic
) prepvt
PIVOT (SUM(traffic) FOR car IN ('승용차' AS 승용차, '트럭' AS 트럭)) pvt;

SELECT line || '선 ' || CAST(hour AS VARCHAR(10)) || '시' AS 구분, 트럭, 승용차 FROM
(
	SELECT line, hour, car, traffic FROM traffic
) prepvt
PIVOT (SUM(traffic) FOR car IN ('승용차' AS 승용차, '트럭' AS 트럭)) pvt
ORDER BY line;

CREATE TABLE cityStat
(
	"name" CHAR(10),
	attr CHAR(10),
	value INT
);

INSERT INTO cityStat VALUES ('서울', 'area', 605);
INSERT INTO cityStat VALUES ('서울', 'population', 974);
INSERT INTO cityStat VALUES ('서울', 'gu', 25);
INSERT INTO cityStat VALUES ('인제', 'area', 1646);
INSERT INTO cityStat VALUES ('인제', 'population', 3);
INSERT INTO cityStat VALUES ('인제', 'home', 15409);
INSERT INTO cityStat VALUES ('홍천', 'area', 1819);

SELECT * FROM cityStat
PIVOT (MAX(value) FOR attr IN ('area' AS area, 'population' AS population)) pvt;

SELECT "name", ROUND(population * 10000 / area, 2) AS 인구밀도 FROM
(
    SELECT * FROM cityStat
    PIVOT (MAX(value) FOR attr IN ('area' AS area, 'population' AS population)) pvt
) A;

WHERE population IS NOT NULL AND area IS NOT NULL

CREATE TABLE seasonPivot AS 
SELECT * FROM season
PIVOT (SUM(sale) FOR season IN ('봄' AS 봄, '여름' AS 여름, '가을' AS 가을, '겨울' AS 겨울));

SELECT * INTO seasonPivot FROM season
PIVOT (SUM(sale) FOR season IN (봄, 여름, 가을, 겨울)) pvt;

SELECT * FROM seasonPivot
UNPIVOT (sale FOR season IN (봄, 여름, 가을, 겨울)) unpvt;

SELECT * FROM
(
    SELECT * FROM season
    PIVOT (SUM(sale) FOR season IN 
    ('봄' AS 봄, '여름' AS 여름, '가을' AS 가을, '겨울' AS 겨울)) pvt
) A
UNPIVOT (sale FOR season IN (봄, 여름, 가을, 겨울)) unpvt;

