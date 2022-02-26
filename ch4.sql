-------------------------------------------------
-- 4장

SELECT "name", area, population10k, metro, region FROM city;
SELECT * FROM city;

SELECT "name" AS 도시명, area AS "면적(제곱Km)", population10k AS "인구(만명)" FROM city;

SELECT 도시명 = "name", area '면적(제곱Km)', population10k [인구(만명)] FROM city; -- MS-SQL

SELECT "name", population10k * 10000 AS "인구(명)" FROM city;

SELECT "name", area, population10k, population10k * 10000 / area AS "인구밀도" FROM city;

SELECT 60 * 60 * 24 AS "하루" FROM dual;

SELECT 60 * 60 * 24;

SELECT * FROM city WHERE area > 1000;

SELECT "name", area FROM city WHERE area > 1000;

SELECT * FROM city WHERE "name" = '서울'			-- 맞음
SELECT * FROM city WHERE "name" = 서울		    -- 틀림
SELECT * FROM city WHERE "name" = "서울"			-- 틀림. 단, 마리아는 인정한다.

SELECT * FROM staff WHERE score = NULL;

SELECT * FROM staff WHERE score IS NULL;

SELECT * FROM staff WHERE score IS NOT NULL;

SELECT * FROM city WHERE population10k >= 100 AND area >= 700;

SELECT * FROM city WHERE region = '경기' AND population10k >= 50 OR area >= 500;
SELECT * FROM city WHERE region = '경기' AND (population10k >= 50 OR area >= 500);

SELECT * FROM city WHERE region != '경기';
SELECT * FROM city WHERE NOT(region = '경기');

SELECT * FROM city WHERE region = '전라' OR metro = 1;

SELECT * FROM city WHERE region != '전라' AND metro != 1;

SELECT * FROM city WHERE NOT(region = '전라' OR metro = 1);

SELECT * FROM city WHERE "name" LIKE '%천%';

SELECT * FROM city WHERE "name" NOT LIKE '%천%';

SELECT * FROM city WHERE "name" LIKE '천%';
SELECT * FROM city WHERE "name" LIKE '%천';

SELECT * FROM city WHERE TRIM("name") LIKE '%천';

SELECT * FROM city WHERE population10k BETWEEN 50 AND 100;

SELECT * FROM city WHERE population10k >= 50 AND population10k <= 100;

SELECT * FROM staff WHERE "name" BETWEEN '가' AND '사';
SELECT * FROM staff WHERE joindate BETWEEN '20150101' AND '20180101';

SELECT * FROM city WHERE region IN ('경상', '전라');

SELECT * FROM city WHERE region = '경상' OR region = '전라';

SELECT * FROM city WHERE region NOT IN ('경상', '전라');

SELECT * FROM staff WHERE "name" LIKE IN ('이%', '안%');  -- error

SELECT * FROM staff WHERE "name" LIKE '이%' OR "name" LIKE '안%';

SELECT * FROM city ORDER BY population10k;
SELECT * FROM city ORDER BY population10k DESC;

SELECT region, "name", area, population10k FROM city ORDER BY region, "name" DESC;

SELECT * FROM city ORDER BY area;
SELECT * FROM city ORDER BY 2;

SELECT "name" FROM city ORDER BY population10k;

SELECT "name", population10k * 10000 / area FROM city ORDER BY population10k * 10000 / area;

SELECT * FROM city WHERE region = '경기' ORDER BY area;

SELECT * FROM city ORDER BY area WHERE region = '경기';

SELECT region FROM city;
SELECT DISTINCT region FROM city;
SELECT DISTINCT region FROM city ORDER BY region;

SELECT ALL depart FROM staff;
SELECT DISTINCT depart FROM staff;

SELECT "name", rowid, rownum FROM city;

SELECT * FROM city WHERE rownum <= 4;

SELECT * FROM city ORDER BY area DESC WHERE rownum <= 4;

SELECT * FROM city WHERE rownum <= 4 ORDER BY area DESC;

SELECT * FROM (SELECT * FROM city ORDER BY area DESC) WHERE rownum <= 4;

SELECT TOP 4 * FROM city ORDER BY area DESC;

SELECT TOP 20 PERCENT * FROM city ORDER BY population10k DESC;

SELECT * FROM exam ORDER BY score DESC;

SELECT TOP 100 * FROM exam ORDER BY score DESC;

SELECT TOP 1 PERCENT WITH TIES * FROM exam ORDER BY score DESC;

SELECT * FROM city ORDER BY area DESC LIMIT 4;

SELECT * FROM city ORDER BY area DESC LIMIT 2, 3;

SELECT * FROM city ORDER BY area DESC OFFSET 0 ROWS FETCH NEXT 4 ROWS ONLY;

SELECT * FROM city ORDER BY area DESC OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;

SELECT * FROM city WHERE metro = 'n' ORDER BY area DESC OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;
