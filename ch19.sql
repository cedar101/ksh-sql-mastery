-------------------------------------------------
-- 19장

INSERT INTO city VALUES ('평택',453,51,'n','경기');
SELECT * FROM city;

SELECT * FROM v$transaction;

DELETE FROM city WHERE metro = 'n';
SELECT * FROM city;

UPDATE "member" SET money = money + 100 WHERE "member"='춘향';
UPDATE "member" SET money = money - 100 WHERE "member"='이도령';

UPDATE "member" SET money = money + 100 WHERE "member"='춘향';
UPDATE "member"2 SET money = money - 100 WHERE "member"='이도령';

BEGIN TRANSACTION
UPDATE "member" SET money = money + 100 WHERE "member"='춘향';
UPDATE "member" SET money = money - 100 WHERE "member"='이도령';
ROLLBACK;

BEGIN TRAN
UPDATE "member" SET money = money + 10000 WHERE "member" = '춘향';
DECLARE @remain INT
SELECT @remain = money FROM "member" WHERE "member" = '이도령';
IF @remain < 10000 
BEGIN
	ROLLBACK
END
ELSE
BEGIN
	UPDATE "member" SET money = money - 10000 WHERE "member" = '이도령';
	COMMIT
END
SELECT * FROM "member" WHERE "member" IN ('춘향', '이도령');

UPDATE city SET population = 1000 WHERE "name" = '서울';
SAVEPOINT p1000;
UPDATE city SET population = 1100 WHERE "name" = '서울';
SAVEPOINT p1100;
UPDATE city SET population = 1200 WHERE "name" = '서울';
SAVEPOINT p1200;
ROLLBACK TO SAVEPOINT p1100;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

/* 오라클 :*/ ALTER PROFILE DEFAULT LIMIT IDLE_TIME 1;
-- MSSQL : SET LOCK_TIMEOUT 60000

UPDATE "member" SET age=25 WHERE "member"='향단';
UPDATE item SET num=10 WHERE item='두부';
COMMIT

UPDATE item SET num=5 WHERE item='두부';
UPDATE "member" SET age=18 WHERE "member"='향단';
COMMIT
