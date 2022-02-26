-------------------------------------------------
-- 5장

SELECT COUNT(*) FROM staff;

SELECT COUNT(*) AS "총 직원수" FROM staff;

SELECT COUNT(*) FROM staff WHERE salary >= 400;

SELECT COUNT(*) FROM staff WHERE salary >= 10000;

SELECT "name" FROM staff WHERE salary >= 400;

SELECT COUNT("name") FROM staff;
SELECT COUNT(depart) FROM staff;

SELECT COUNT(DISTINCT depart) FROM staff;

SELECT COUNT(score) FROM staff;

SELECT COUNT(*) - COUNT(score) FROM staff;
SELECT COUNT(*) FROM staff WHERE score IS NULL;

SELECT SUM(population), AVG(population) FROM city;

SELECT MIN(area), MAX(area) FROM city;

SELECT SUM(score), AVG(score) FROM staff WHERE depart = '인사과';
SELECT MIN(salary), MAX(salary) FROM staff WHERE depart = '영업부';

SELECT SUM("name") FROM staff;		-- 에러

SELECT MIN("name") FROM staff;

SELECT MAX(population), "name" FROM city;

SELECT AVG(salary) FROM staff;
SELECT SUM(salary)/COUNT(*) FROM staff;

SELECT AVG(score) FROM staff;
SELECT SUM(score)/COUNT(*) FROM staff;

SELECT COUNT(*) FROM staff WHERE depart = '비서실';
SELECT MAX(salary) FROM staff WHERE depart = '비서실';

SELECT '영업부', AVG(salary) FROM staff WHERE depart='영업부';
SELECT '총무부', AVG(salary) FROM staff WHERE depart='총무부';
SELECT '인사과', AVG(salary) FROM staff WHERE depart='인사과';

SELECT depart, AVG(salary) FROM staff GROUP BY depart;

SELECT depart, COUNT(*), MAX(joindate), AVG(score) FROM staff GROUP BY depart; 

SELECT gender, AVG(salary) FROM staff GROUP BY gender;

SELECT "name", SUM(salary) FROM staff GROUP BY "name";
SELECT "name", salary FROM staff; -- GROUP BY "name";

SELECT depart, gender, COUNT(*) FROM staff GROUP BY depart, gender ORDER BY depart, gender;

SELECT gender, depart, COUNT(*) FROM staff GROUP BY gender, depart ORDER BY gender, depart;

SELECT depart, gender, COUNT(*) FROM staff GROUP BY depart, gender 
ORDER BY depart, gender;

SELECT depart, salary FROM staff GROUP BY depart;

SELECT SUM(salary) FROM staff GROUP BY depart;

SELECT depart, SUM(salary) FROM staff;

SELECT depart, SUM(salary) FROM staff GROUP BY depart;
SELECT SUM(salary) FROM staff;

SELECT depart, AVG(salary) FROM staff GROUP BY depart HAVING AVG(salary) >= 340;

SELECT depart, AVG(salary) FROM staff GROUP BY depart HAVING AVG(salary) >= 340 
ORDER BY AVG(salary);

SELECT depart, AVG(salary) FROM staff WHERE salary > 300 GROUP BY depart ;

SELECT depart, AVG(salary) FROM staff WHERE salary > 300 
GROUP BY depart HAVING AVG(salary) >= 360 ORDER BY depart;

SELECT depart, MAX(salary) FROM staff WHERE depart IN ('인사과', '영업부') GROUP BY depart;
SELECT depart, MAX(salary) FROM staff GROUP BY depart HAVING depart IN ('인사과', '영업부');
