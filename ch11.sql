-------------------------------------------------
-- 11장

SELECT AVG(score) FROM staff WHERE depart = '영업부';

SELECT ROUND(AVG(score), 2) FROM staff WHERE depart = '영업부';

SELECT "name", REPLACE(depart, '부', '팀') FROM staff;

SELECT "name", grade, salary FROM staff WHERE depart='인사과';

SELECT TRIM("name") || ' ' || grade, salary FROM staff WHERE depart='인사과';

-- MSSQL : SELECT TRIM("name") + ' ' + grade, salary FROM staff WHERE depart='인사과';
-- 마리아 : SELECT CONCAT("name", ' ', grade), salary FROM staff WHERE depart='인사과';

SELECT ROUND(1234.5678, 0) FROM dual;	-- 1235
SELECT ROUND(1234.5678, 1) FROM dual;	-- 1234.6
SELECT ROUND(1234.5678, 2) FROM dual; 	-- 1234.57

SELECT "name", area, ROUND(area, -2) FROM city;

SELECT LENGTH('korea대한민국') FROM dual;		-- 9
SELECT LENGTHB('korea대한민국') FROM dual;		-- 17

SELECT * FROM item WHERE LENGTH(item) = 2;

SELECT CONCAT(region, "name") FROM city;

/* 오라클 : */ SELECT region || "name" FROM city;
-- MSSQL : SELECT region + "name" FROM city;

SELECT region || '도의 ' || "name" FROM city;

SELECT CONCAT(CONCAT(region, '도의 '), "name") FROM city;
-- MSSQL, 마리아 : SELECT CONCAT(region, '도의 ' , "name") FROM city;

SELECT INSTR('우리나라 대한민국', '나라') FROM dual;      -- 3
SELECT INSTR('우리나라 대한민국', '민족') FROM dual;      -- 0

SELECT INSTR('국민에 의한 국민을 위한 국민의 국민당', '국민', 3) FROM dual;     -- 8
SELECT INSTR('국민에 의한 국민을 위한 국민의 국민당', '국민', 1, 3) FROM dual;  -- 15
SELECT INSTR('국민에 의한 국민을 위한 국민의 국민당', '국민', -1) FROM dual;    -- 19

-- MSSQL : SELECT CHARINDEX('국민', '국민에 의한 국민을 위한 국민의 국민당', 3);     -- 8
-- 마리아 : SELECT POSITION('국민' IN '국민에 의한 국민을 위한 국민의 국민당');     -- 1

SELECT SUBSTR('아름다운 대한민국 금수강산', 6, 4) FROM dual;    -- 대한민국
SELECT SUBSTR('아름다운 대한민국 금수강산', -4, 2) FROM dual;   -- 금수

SELECT SUBSTR("name",1,1), COUNT(*) FROM staff GROUP BY SUBSTR("name",1,1) 
ORDER BY COUNT(*) DESC;

SELECT SUBSTR('...이름:홍길동,...', INSTR('...이름:홍길동,...','이름') + 3, 3) FROM dual;

SELECT LOWER('wonderful SQL') FROM dual; -- wonderful sql
SELECT UPPER('wonderful SQL') FROM dual; -- WONDERFUL SQL
SELECT INITCAP('wonderful SQL') FROM dual; -- Wonderful Sql

SELECT * FROM city WHERE metro = 'y';

SELECT * FROM city WHERE UPPER(metro) = 'Y';
SELECT * FROM city WHERE LOWER(metro) = 'y';

SELECT CONCAT("name", ' 사원님') FROM staff;

SELECT CONCAT(TRIM("name"), ' 사원님') FROM staff;

SELECT LPAD('SQL', 10, '>') FROM dual;  -- >>>>>>>SQL
SELECT RPAD('SQL', 10, '<') FROM dual;  -- SQL<<<<<<<

SELECT LPAD(RPAD('SQL', 10, '<'), 17, '>') FROM dual;	-- >>>>>>>SQL<<<<<<<

SELECT "name", LPAD(area, 4, '0') FROM city;

SELECT REPLACE('독도는 일본땅이다', '일본', '한국') FROM dual;

SELECT REPLACE('구글에서 구글링한다.', '구글', '네이버') FROM dual; 	
-- 네이버에서 네이버링한다.

SELECT REPLACE('Get_Total_Score', '_', '') FROM dual;   -- GetTotalScore

SELECT REPLACE('독도는 일본땅이다. 대마도는 일본땅이다.', '일본', '한국') FROM dual;

SELECT STUFF('독도는 일본땅이다. 대마도는 일본땅이다.', 5, 2, '한국');

SELECT SUBSTR('독도는 일본땅이다. 대마도는 일본땅이다.', 1, 
INSTR('독도는 일본땅이다. 대마도는 일본땅이다.', '일본') - 1) || '한국' ||
SUBSTR('독도는 일본땅이다. 대마도는 일본땅이다.', 
INSTR('독도는 일본땅이다. 대마도는 일본땅이다.', '일본') + 2) FROM dual;

SELECT SUBSTR(str, 1 , INSTR(str, '일본') - 1) || '한국' || SUBSTR(str, INSTR(str, '일본') + 2) 
FROM tTable;

pos = INSTR(str, '일본');
SELECT SUBSTR(str, 1 , pos - 1) || '한국' || SUBSTR(str, pos + 2) FROM tTable;

INSERT INTO tDate VALUES (TO_DATE('2021/12/25 12:34:56', 'yyyy/mm/dd hh24:mi:ss'));

SELECT AVG(population) FROM city;

/* 오라클 : */ SELECT CAST(AVG(population) AS INT) FROM city;		-- 193
-- MSSQL : SELECT AVG(CAST(population AS DECIMAL)) FROM city;	-- 193.25

SELECT '12' + 34 FROM dual;	-- 46
SELECT '12' || 34 FROM dual;	-- 1234

SELECT '12' + 34;					-- 46
SELECT '12' + CAST(34 AS VARCHAR(10));	-- 1234

SELECT '응답하라 ' + 1989;				-- 에러
SELECT '응답하라 ' + CAST(1989 AS VARCHAR(10));	-- 응답하라 1989

SELECT '응답하라 ' || 1989 FROM dual;

SELECT TO_CHAR(12345) FROM dual;		-- 12345
SELECT TO_CHAR(12345, '999,999') FROM dual;	--  12,345
SELECT TO_CHAR(12345, 'FM999,999') FROM dual; 	-- 12,345
SELECT TO_CHAR(12345, '000,999') FROM dual; 	-- 012,345

SELECT TO_NUMBER('12345') FROM dual;		-- 12345
SELECT TO_NUMBER('12,345') FROM dual;		-- 에러
SELECT TO_NUMBER('12,345', '999,999') FROM dual;	-- 12345

SELECT '응답하라 ' + CONVERT(VARCHAR(10), 1989);		-- 응답하라 1989

/* 오라클 :*/ SELECT "name", NVL(score, 10) FROM staff;
-- MSSQL : SELECT "name", ISNULL(score, 10) FROM staff;
-- 마리아 : SELECT "name", IFNULL(score, 10) FROM staff;

SELECT "name", NULLIF(score, 0) FROM staff;

SELECT "name", NVL(NULLIF(score, 0), 60) FROM staff;

SELECT "name", NVL2(score, salary * score / 100, 50) FROM staff;

SELECT "name", DECODE(gender, '남', '멋쟁이', '여', '예쁜이', '몬난이') FROM staff;

SELECT SYSDATE FROM dual;  -- 20/10/17 12:21:42

INSERT INTO staff VALUES ('김한슬', '기획실', '여', SYSDATE, '수습', 480, 50);

SELECT SYSDATE + 12 FROM dual;

SELECT SYSDATE + 5/24 FROM dual;
SELECT SYSDATE - 30/1440 FROM dual;
SELECT SYSDATE - 80/86400 FROM dual;

SELECT "name", sysdate - joindate FROM staff;

SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd hh24:mi:ss') FROM dual;	  -- 2020/10/17 12:18:51
SELECT TO_CHAR(SYSDATE, 'yyyy/mm/dd AM hh:mi:ss') FROM dual; -- 2020/10/17 오후 12:20:35

SELECT TO_CHAR(SYSDATE, 'yyyy"년" mm"월" dd"일" hh24"시" mi"분" ss"초"') FROM dual;
-- 2020년 10월 17일 12시 24분 44초

SELECT "name", TO_CHAR(joindate, 'yyyy') FROM staff;

SELECT TO_CHAR(joindate, 'yyyy') AS 년, TO_CHAR(joindate, 'mm') AS 월, 
TO_CHAR(joindate, 'dd') AS 일 FROM staff;

SELECT TO_DATE('1919/3/1', 'yyyy/mm/dd') FROM dual;

SELECT TO_DATE('1919-3-1', 'yyyy-mm-dd') FROM dual;
SELECT TO_DATE('19190301', 'yyyymmdd') FROM dual;

SELECT TO_DATE('1919/3/1') FROM dual;
SELECT TO_DATE('1919-3-1') FROM dual;
SELECT TO_DATE('19190301') FROM dual;

SELECT sysdate - '1919/3/1' FROM dual;	-- 에러

SELECT sysdate - TO_DATE('1919/3/1') FROM dual;

SELECT TO_CHAR(TO_DATE('2023/3/8', 'yyyy/mm/dd') + 99, 'yyyy"년" mm"월" dd"일"') FROM dual;

SELECT GETDATE();

SELECT "name", YEAR(joindate) AS 년, MONTH(joindate) AS 월, DAY(joindate) AS 일 FROM staff;

SELECT YEAR(joindate), count(*) FROM staff GROUP BY YEAR(joindate) 
ORDER BY YEAR(joindate);

SELECT DATEPART(dw, GETDATE());
SELECT DATENAME(dw, GETDATE());

SELECT "name", DATEDIFF(day,joindate,GETDATE()) FROM staff;

SELECT DATEDIFF(day, '1919/3/1', GETDATE());

SELECT CONVERT(VARCHAR(20), GETDATE(),0);		-- 06 29 2021 10:43PM
SELECT CONVERT(VARCHAR(20), GETDATE(),11);		-- 21/06/29
SELECT CONVERT(VARCHAR(20), GETDATE(),111); 		-- 2021/06/29
SELECT CONVERT(VARCHAR(20), GETDATE(),101); 		-- 06/29/2021
SELECT CONVERT(VARCHAR(20), GETDATE(),103); 		-- 29/06/2021

SELECT NOW();

SELECT DATE_FORMAT(NOW(), '%Y/%m/%d %H:%i:%s');

SELECT DATE_FORMAT(joindate, '%Y'), count(*) FROM staff 
GROUP BY DATE_FORMAT(joindate, '%Y') ORDER BY DATE_FORMAT(joindate, '%Y');

SELECT DATE_ADD(NOW(), INTERVAL 12 DAY);		-- 12일 후
SELECT DATE_ADD(NOW(), INTERVAL 5 HOUR);		-- 5시간 후
SELECT DATE_SUB(NOW(), INTERVAL 30 MINUTE);		-- 30분 전

SELECT "name", DATEDIFF(NOW(), joindate) FROM staff;
