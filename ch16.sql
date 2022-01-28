-------------------------------------------------
-- 16장

CREATE PROCEDURE SP_GetPopulation
AS
    v_population INT;
BEGIN
    SELECT population INTO v_population FROM city WHERE "name" = '서울';
    DBMS_OUTPUT.PUT_LINE(v_population);
END;

EXECUTE SP_GetPopulation();

SELECT * FROM user_objects WHERE object_type = 'PROCEDURE';

SELECT * FROM user_source WHERE "name" = 'SP_GetPopulation';

CREATE PROCEDURE SP_GetPopulation
...
    SELECT population INTO v_population FROM city WHERE "name" = '부산';

DROP PROCEDURE SP_GetPopulation;

CREATE OR REPLACE PROCEDURE SP_GetPopulation
AS
    v_population INT;
BEGIN
    SELECT population INTO v_population FROM city WHERE "name" = '부산';
    DBMS_OUTPUT.PUT_LINE(v_population);
END;

CREATE OR REPLACE PROCEDURE SP_GetPopulation
AS
    v_population INT;
BEGIN
    SELECT populationlation INTO v_population FROM city WHERE "name" = '부산';
    DBMS_OUTPUT.PUT_LINE(v_population);
END;

DROP TABLE city;

CREATE OR REPLACE PROCEDURE SP_GetCityPopulation(p_name IN CHAR)
AS
    v_population INT;
BEGIN
    SELECT population INTO v_population FROM city WHERE "name" = p_name;
    DBMS_OUTPUT.PUT_LINE(p_name || '의 인구는 ' || v_population || '만명입니다.');
END;

EXEC SP_GetCityPopulation('오산');		-- 오산의 인구는 21만명입니다.
EXEC SP_GetCityPopulation('청주');		-- 청주의 인구는 83만명입니다.

EXEC SP_GetCityPopulation();      		-- 에러
EXEC SP_GetCityPopulation('서울', '부산');    	-- 에러

CREATE OR REPLACE PROCEDURE SP_GetCityPopulation(p_name IN city."name"%TYPE := '서울')
....

CREATE OR REPLACE PROCEDURE SP_GrantBonus(p_member CHAR, p_bonus INT)
AS
BEGIN
    UPDATE "member" SET money = money + p_bonus WHERE "member" = p_member;
    COMMIT;
END;

EXEC SP_GrantBonus('춘향', 123);

EXEC SP_GrantBonus(p_member=>'춘향', p_bonus=>123);
EXEC SP_GrantBonus(p_bonus=>123, p_member=>'춘향');

CREATE OR REPLACE PROCEDURE SP_OutCityPopulation(p_name IN CHAR, o_population OUT INT)
AS
BEGIN
    SELECT population INTO o_population FROM city WHERE "name" = p_name;
END;

DECLARE 
    v_population INT;
BEGIN
    SP_OutCityPopulation('서울', v_population);
    DBMS_OUTPUT.PUT_LINE(v_population);
END; 

CREATE OR REPLACE PROCEDURE SP_OutCityAreaPopulation(p_name IN CHAR, o_area OUT INT, o_population OUT INT)
AS
BEGIN
    SELECT area, population INTO o_area, o_population FROM city WHERE "name" = p_name;
END;

DECLARE 
    v_area INT;
    v_population INT;
BEGIN
    SP_OutCityAreaPopulation('부산', v_area, v_population);
    DBMS_OUTPUT.PUT_LINE(v_area || ' ,' || v_population);
END;

CREATE OR REPLACE PROCEDURE SP_GetCityPopulation(p_name IN city."name"%TYPE := '서울')
AS
    v_population INT;
BEGIN
    SP_Oucitypopulation(p_name, v_population);
    DBMS_OUTPUT.PUT_LINE(p_name || '의 인구는 ' || v_population || '만명입니다.');
END;

EXECUTE SP_GetCityPopulation('평양');

CREATE OR REPLACE PROCEDURE SP_GetCityPopulation(p_name IN city."name"%TYPE := '서울')
AS
    v_population INT;
BEGIN
    SELECT population INTO v_population FROM city WHERE "name" = p_name;
    DBMS_OUTPUT.PUT_LINE(p_name || '의 인구는 ' || v_population || '만명입니다.');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('없는 도시입니다.');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('도시가 너무 많습니다.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('알 수 없는 예외입니다.');
END;

SELECT population INTO v_population FROM city WHERE "name" = p_name;
IF v_population IS NULL THEN
    DBMS_OUTPUT.PUT_LINE('없는 도시입니다.');
END IF;

CREATE OR REPLACE FUNCTION FN_AddInt(a INT, b INT) 
RETURN INT
AS
BEGIN
	RETURN a + b;
END;

SELECT FN_AddInt(2, 3) FROM dual;
SELECT * FROM city WHERE population > FN_AddInt(10, 20);

DECLARE v_sum INT;
BEGIN
    v_sum := FN_AddInt(2, 3);
    DBMS_OUTPUT.PUT_LINE(v_sum);
END;

CREATE OR REPLACE FUNCTION FN_GetSum(p_upBound INT)
RETURN INT
AS
    v_total INT := 0;
BEGIN
    FOR v_num IN 1 .. p_upBound
    LOOP
        v_total := v_total + v_num;
    END LOOP;
    RETURN v_total;
END;

SELECT FN_GetSum(10) FROM dual;

CREATE OR REPLACE TYPE gu_row AS OBJECT
(
    dan INT, 
    num INT, 
    multi INT
);

CREATE OR REPLACE TYPE gu_table AS TABLE OF gu_row;

CREATE OR REPLACE FUNCTION makeDan(p_dan INT)
RETURN gu_table PIPELINED
AS
    v_row gu_row;
BEGIN
    FOR v_num IN 1..9
    LOOP
        v_row := gu_row(p_dan, v_num, p_dan * v_num);
        PIPE ROW(v_row);
    END LOOP;
    RETURN;
END;

SELECT * FROM TABLE(makeDan(5));
SELECT * FROM TABLE(makeDan(7));

CREATE PROCEDURE PROC_Gecitypopulation
	@p_name CHAR(10)
AS
BEGIN
	SELECT population FROM city WHERE "name" = @p_name;
END

EXEC PROC_Gecitypopulation @p_name = '서울';
EXEC PROC_Gecitypopulation '서울';
PROC_Gecitypopulation '서울';

ALTER PROCEDURE PROC_Gecitypopulation
	@p_name CHAR(10)
AS
DECLARE
	@population INT
BEGIN
	SELECT @population = population FROM city WHERE "name" = @p_name;
	PRINT @population
END

ALTER PROCEDURE PROC_Gecitypopulation
	@p_name CHAR(10)
AS
BEGIN
	SELECT population FROM city2 WHERE "name" = @p_name;
END

CREATE PROCEDURE PROC_GrantBonus
	@p_member CHAR(20),
	@p_bonus INT = 100
AS
BEGIN
    UPDATE "member" SET money = money + @p_bonus WHERE "member" = @p_member;
END;

PROC_GrantBonus '춘향', 2000;
PROC_GrantBonus '춘향';

PROC_GrantBonus @p_member = '춘향', @p_bonus = 2000;
PROC_GrantBonus @p_bonus = 2000, @p_member = '춘향';

CREATE PROCEDURE PROC_OutCityPopulation
	@p_name CHAR(10), 
	@o_population INT OUTPUT
AS
BEGIN
    SELECT @o_population = population FROM city WHERE "name" = @p_name;
END;

DECLARE @population INT;
EXECUTE PROC_OutCityPopulation '서울', @population OUTPUT;
PRINT '서울의 인구는 ' + CAST(@population AS VARCHAR(10)) + '만명입니다.';

CREATE PROCEDURE PROC_ReturnCityPopulation
	@p_name CHAR(10)
AS
DECLARE
	@population INT;
BEGIN
    SELECT @population = population FROM city WHERE "name" = @p_name;
    RETURN @population;
END;

DECLARE @population INT;
EXECUTE @population = PROC_ReturnCityPopulation '서울';
PRINT '서울의 인구는 ' + CAST(@population AS VARCHAR(10)) + '만명입니다.';

PRINT '서울의 인구는 ' + CAST(PROC_ReturnCityPopulation '서울' AS VARCHAR(10)) + '만명입니다';
SELECT PROC_ReturnCityPopulation '서울';

CREATE PROCEDURE PROC_InsertSeoul
AS
BEGIN
	INSERT INTO city VALUES ('서울',605,974,'y','경기');
END

ALTER PROCEDURE PROC_InsertSeoul
AS
BEGIN
	INSERT INTO city VALUES ('서울',605,974,'y','경기');
	IF @@ERROR != 0
	BEGIN
		PRINT('새 레코드를 삽입하지 못했습니다.');
	END
END

ALTER PROCEDURE PROC_InsertSeoul
AS
BEGIN
	BEGIN TRY
		INSERT INTO city VALUES ('서울',605,974,'y','경기');
	END TRY

	BEGIN CATCH
		PRINT '에러 번호 : ' + CAST(ERROR_NUMBER() AS VARCHAR(10));
		PRINT '에러 메시지 : ' + ERROR_MESSAGE();
	END CATCH
END

CREATE FUNCTION FN_AddInt(@a INT, @b INT) RETURNS INT
AS
BEGIN
	RETURN @a + @b;
END

SELECT Study.dbo.FN_AddInt(2, 3);

CREATE FUNCTION FN_GetCity(@region CHAR(10))
RETURNS TABLE
AS
RETURN SELECT * FROM city WHERE region = @region;

SELECT * FROM dbo.FN_GetCity('강원');

SELECT * FROM dbo.FN_GetCity('강원') WHERE population > 10;

CREATE FUNCTION FN_GetCityTable(@region CHAR(10))
RETURNS @result TABLE
	("name" VARCHAR(10),population INT)
AS
BEGIN
	INSERT INTO @result SELECT "name", population FROM city WHERE region = @region;
	RETURN;
END

SELECT * FROM dbo.FN_GetCityTable('경기');
