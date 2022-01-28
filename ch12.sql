
-------------------------------------------------
-- 12장

SELECT "member", age, addr FROM "member";

CREATE VIEW "member" AS
SELECT "member", age, addr FROM "member";

SELECT * FROM "member";

SELECT "member", age FROM "member";
SELECT * FROM "member" WHERE addr LIKE '%서울%';
SELECT * FROM "member" ORDER BY "member";

SELECT "name", email FROM "member";

DROP VIEW "member";

CREATE VIEW "member" AS SELECT "member", age, addr, email FROM "member";

/* 오라클, 마리아 : */ CREATE OR REPLACE VIEW "member" AS SELECT "member", age, addr, email FROM "member";
-- MSSQL : ALTER VIEW "member" AS SELECT "member", age, addr, email FROM "member";

CREATE VIEW "member"Mirror AS SELECT * FROM "member";

CREATE VIEW StaffVirt AS SELECT depart, salary, "name" FROM staff;

CREATE VIEW StaffHorz AS SELECT * FROM staff WHERE depart = '총무부';

CREATE VIEW StaffPart AS SELECT "name", salary FROM staff WHERE depart = '총무부';

CREATE VIEW StaffAlias(n, d, s) AS SELECT "name", depart, salary FROM staff;

CREATE OR REPLACE VIEW StaffAlias AS SELECT "name" n, depart d , salary s FROM staff;

SELECT * FROM StaffAlias ORDER BY s;           -- 맞음
SELECT * FROM StaffAlias ORDER BY salary;      -- 에러

CREATE VIEW StaffBonus AS SELECT "name", salary * score / 100 AS bonus FROM staff;

SELECT * FROM StaffBonus WHERE bonus > 300;

CREATE VIEW Shopping AS
SELECT M."member", M.addr, O.item, O.num, O.orderDate FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member";

CREATE VIEW vUnion AS
SELECT "name", salary FROM staff WHERE depart = '인사과'
UNION
SELECT "name", salary FROM employee;

CREATE VIEW StaffHorz AS
SELECT "name", joindate, salary FROM StaffHorz;

CREATE VIEW Original AS SELECT a, b, c FROM tOriginal;

CREATE VIEW Original(a, b, c) AS SELECT x, y, c FROM tOriginal;

UPDATE "member" SET addr = '서울 신사동' WHERE "member" = '춘향';

UPDATE StaffBonus SET bonus = 500 WHERE "name" = '유관순';

INSERT INTO StaffHorz VALUES ('김한슬', '총무부', '여', '2022/08/14', '사원', 520, 55);

INSERT INTO StaffHorz VALUES ('김한결', '영업부', '남', '2023/05/13', '사원', 490, 35);

CREATE VIEW StaffHorzCheck AS 
SELECT * FROM staff WHERE depart = '총무부' WITH CHECK OPTION;

DELETE FROM staff WHERE "name" IN ('김한슬','김한결');
INSERT INTO StaffHorzCheck VALUES ('김한결', '영업부', '남', '2023/05/13', '사원', 490, 35);

UPDATE StaffHorzCheck SET depart = '기획팀' WHERE "name" = '김유신';

INSERT INTO StaffVirt ("name", depart, salary) VALUES ('이완용', '영업부', 99);

CREATE VIEW vNotExist AS SELECT * FROM tNotExist;		-- 에러
CREATE FORCE VIEW vNotExist AS SELECT * FROM tNotExist;	-- 가능

CREATE VIEW staff_read_only AS SELECT * FROM staff 
WHERE depart = '인사과' WITH READ ONLY;

CREATE VIEW "member"Enc WITH ENCRYPTION AS
SELECT "member", age, addr FROM "member";

CREATE GLOBAL TEMPORARY TABLE gtt (
	"name" VARCHAR(20) PRIMARY KEY,
	score INT
);

INSERT INTO gtt VALUES ('김한슬', 95);
INSERT INTO gtt VALUES ('김한결', 80);
SELECT * FROM gtt;

DROP TABLE gtt;
CREATE GLOBAL TEMPORARY TABLE gtt (
	"name" VARCHAR(20) PRIMARY KEY,
	score INT
) ON COMMIT PRESERVE ROWS;

INSERT INTO gtt VALUES ('김규민', 70);
SELECT * FROM gtt;

CREATE TABLE #temp (
	"name" VARCHAR(20) PRIMARY KEY,
	score INT
);

INSERT INTO #temp VALUES ('김한슬', 95);
INSERT INTO #temp VALUES ('김한결', 80);
INSERT INTO #temp VALUES ('김규민', 70);
SELECT * FROM #temp;

CREATE TEMPORARY TABLE temp (
	"name" VARCHAR(20) PRIMARY KEY,
	score INT
);

INSERT INTO temp VALUES ('김한슬', 95);
INSERT INTO temp VALUES ('김한결', 80);
INSERT INTO temp VALUES ('김규민', 70);
SELECT * FROM temp;

CREATE GLOBAL TEMPORARY TABLE task_force AS SELECT * FROM staff;

INSERT INTO task_force SELECT * FROM (SELECT * FROM staff 
WHERE joindate <= '20160101' ORDER BY salary DESC) WHERE rownum <= 10;

-- MSSQL : SELECT TOP 10 * INTO #task_force FROM staff 
-- WHERE joindate <= '20160101' ORDER BY salary DESC;
-- 마리아 : CREATE TEMPORARY TABLE task_force AS SELECT * FROM staff 
-- WHERE joindate <= '20160101' ORDER BY salary DESC LIMIT 10;

DELETE FROM task_force WHERE score < (SELECT AVG(score) FROM task_force 
WHERE gender = '남') AND gender = '남';

DELETE FROM task_force WHERE salary < 
(SELECT AVG(salary) FROM staff) AND gender = '여';

DELETE FROM task_force WHERE salary > 300 AND grade = '대리';
INSERT INTO task_force SELECT * FROM staff WHERE salary > 380 AND grade = '과장';

SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남';

SELECT * FROM 
(
	SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남'
) A
WHERE salary >= (
	SELECT avg(salary) FROM 
	(
		SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남'
	) B
);

CREATE GLOBAL TEMPORARY TABLE tBusiMan AS SELECT "name", salary, score FROM staff;
INSERT INTO tBusiMan SELECT "name", salary, score FROM staff 
WHERE depart = '영업부' AND gender = '남';

-- MSSQL: SELECT "name", salary, score INTO #tBusiMan FROM staff 
-- WHERE depart = '영업부' AND gender = '남';
-- 마리아 : CREATE TEMPORARY TABLE tBusiMan AS 
-- SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남';

SELECT * FROM tBusiMan WHERE salary >= (SELECT avg(salary) FROM tBusiMan);

CREATE VIEW vBusiMan AS SELECT "name", salary, score FROM staff 
WHERE depart = '영업부' AND gender = '남';
SELECT * FROM vBusiMan WHERE salary >= (SELECT avg(salary) FROM vBusiMan);

WITH tBusiMan AS 
(SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남')
SELECT * FROM tBusiMan WHERE salary >= (SELECT avg(salary) FROM tBusiMan);

WITH tBusiMan(이름, 월급, 성취도) AS 
(SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남')
SELECT * FROM tBusiMan WHERE 월급 >= (SELECT avg(월급) FROM tBusiMan);

WITH tBusiMan AS 
(SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남'),
tBusiGirl AS 
(SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '여')
SELECT * FROM tBusiGirl WHERE salary >= (SELECT avg(salary) FROM tBusiMan);

WITH tBusiMan AS 
(SELECT "name", salary, score FROM staff WHERE depart = '영업부' AND gender = '남'),
tBusiManGod AS 
(SELECT "name", salary, score FROM tBusiMan WHERE score > 70)
SELECT * FROM tBusiManGod;

WITH Shopping AS
(SELECT M."member", M.addr, O.item, O.num, O.orderDate FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member")
SELECT * FROM Shopping WHERE num >= (SELECT AVG(num) FROM Shopping);

CREATE VIEW vTemp AS
(SELECT M."member", M.addr, O.item, O.num, O.orderDate FROM "member" M 
INNER JOIN "order" O ON M."member" = O."member");

SELECT * FROM vTemp WHERE num >= (SELECT AVG(num) FROM vTemp);

WITH fact(num, sum) AS (
	SELECT 1 AS num, 1 AS sum FROM dual
	UNION ALL
	SELECT num + 1, sum * (num + 1) FROM fact T WHERE T.num < 10
)
SELECT * FROM fact;

WITH tree(id, "name", parent, depth) AS
(
	SELECT id, "name", parent, 0 FROM directory WHERE parent = 0
	UNION ALL
	SELECT D.id, D."name", D.parent, T.depth + 1 FROM directory D 
	INNER JOIN tree T ON D.parent = T.id
)
SELECT * FROM tree;

WITH tree(id, "name", parent, depth, fullpath) AS
(
	SELECT id, "name", parent, 0, CAST("name" AS VARCHAR(256)) 
	FROM directory WHERE parent = 0
	UNION ALL
	SELECT D.id, D."name", D.parent, T.depth + 1, 
	CAST(CONCAT(CONCAT(T.fullpath, '/'), D."name") AS VARCHAR(256)) 
	FROM directory D 
	INNER JOIN tree T ON D.parent = T.id
)
SELECT * FROM tree;

WITH tree(id, "name", parent, depth, fullpath) AS
(
	SELECT id, "name", parent, 0, CAST("name" AS VARCHAR(256)) 
	FROM directory WHERE parent = 0
	UNION ALL
	SELECT D.id, D."name", D.parent, T.depth + 1, 
	LPAD('L ', (T.depth + 1) * 4) || D."name" 
	FROM directory D 
	INNER JOIN tree T ON D.parent = T.id
)
SELECT fullpath FROM tree;

CAST(SPACE((T.depth + 1) * 4) + 'L ' + D."name" AS VARCHAR(256))