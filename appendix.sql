-------------------------------------------------
-- 부록

SET @score = 123;
SELECT @score;

SELECT @maxnum := MAX(num) FROM item;
SELECT item FROM item WHERE num = @maxnum;

DELIMITER $$
CREATE [OR REPLACE] PROCEDURE 프로시저 이름()
BEGIN
	여기에 코드를 작성한다.
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_proc()
BEGIN
	DECLARE score INT DEFAULT 123;
	SELECT score;
	SET score = score + 1;
	SELECT score;
END $$
DELIMITER ;

CALL SP_proc();

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_proc()
BEGIN
	DECLARE score INT;
	SET score = 12;
	IF score = 12 THEN
		SELECT '12입니다';
	ELSE
		SELECT '12가 아닙니다.';
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_proc()
BEGIN
	DECLARE score INT DEFAULT 86;
	CASE
		WHEN score > 95 THEN SELECT 'A+';
		WHEN score > 90 THEN SELECT 'A';
		WHEN score > 85 THEN SELECT 'B+';
		WHEN score > 80 THEN SELECT 'B';
		ELSE SELECT 'C';
	END CASE;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_proc()
BEGIN
	DECLARE score INT DEFAULT 86;
	DECLARE grade CHAR(2);
	SET grade = CASE
		WHEN score > 95 THEN 'A+'
		WHEN score > 90 THEN 'A'
		WHEN score > 85 THEN 'B+'
		WHEN score > 80 THEN 'B'
		ELSE 'C'
	END;
	SELECT grade;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_proc()
BEGIN
	DECLARE num INT DEFAULT 1;
	DECLARE sum INT DEFAULT 0;
	WHILE (num <= 100) DO
		SET sum = sum + num;
		SET num = num + 1;
	END WHILE;

	SELECT sum;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_proc()
BEGIN
	DECLARE num INT DEFAULT 1;
	DECLARE sum INT DEFAULT 0;
	REPEAT
		SET sum = sum + num;
		SET num = num + 1;
		UNTIL num > 100
	END REPEAT;

	SELECT sum;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_proc()
BEGIN
	DECLARE num INT DEFAULT 1;
	DECLARE sum INT DEFAULT 0;
	sumloop: LOOP
		SET sum = sum + num;
		SET num = num + 1;
		IF num > 100 THEN
			LEAVE sumloop;
		END IF;
	END LOOP;

	SELECT sum;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_GrantBonus(IN p_"member" CHAR(20))
BEGIN
	UPDATE "member" SET money = money + 1000 WHERE "member" = p_member;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_GetMemberNum(OUT o_member_num INT)
BEGIN
	SELECT COUNT(*) INTO o_member_num FROM "member";
END $$
DELIMITER ;

CALL SP_GetMemberNum(@num);
SELECT @num;

DELIMITER $$
CREATE OR REPLACE FUNCTION FN_AddInt(a INT, b INT) RETURNS INT
BEGIN
	RETURN a + b;
END $$
DELIMITER ;

SELECT FN_AddInt(2, 3);

DELIMITER $$
CREATE OR REPLACE PROCEDURE SP_dumpCity()
BEGIN
	DECLARE city_name CHAR(10);
	DECLARE eof INT DEFAULT 0;

	DECLARE testcursor CURSOR FOR SELECT "name" FROM city;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET eof = 1; 
	OPEN testcursor;

	fetch_loop: LOOP
		FETCH testcursor INTO city_name;
		IF eof THEN 
			LEAVE fetch_loop;
		END IF;
		SELECT city_name;
	END LOOP;
	CLOSE testcursor;
END $$
DELIMITER ;

DELIMITER $$
CREATE OR REPLACE TRIGGER TR_Message
AFTER UPDATE ON city
FOR EACH ROW
BEGIN
	SET @result = CONCAT(OLD.population, '->', NEW.population);
END $$
DELIMITER ;

UPDATE city SET population = population + 1 WHERE "name" = '서울';

SELECT @result;

