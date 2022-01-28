
-------------------------------------------------
-- 17장

DECLARE
    CURSOR v_cursor IS SELECT "name" FROM city;
    v_name CHAR(10);
BEGIN
    OPEN v_cursor;
    LOOP
        FETCH v_cursor INTO v_name;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
    CLOSE v_cursor;
END;

DECLARE
    CURSOR v_cursor IS SELECT * FROM city;
    v_city city%ROWTYPE;
BEGIN
    OPEN v_cursor;
    LOOP
        FETCH v_cursor INTO v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_city.region || v_city."name" || v_city.area);
    END LOOP;
    CLOSE v_cursor;
END;

DECLARE
BEGIN
    FOR v_cursor IN (SELECT "name" FROM city)
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_cursor."name");
    END LOOP;
END;

BEGIN
    UPDATE city SET population = population WHERE region = '강원';
    IF SQL%FOUND THEN DBMS_OUTPUT.PUT_LINE('결과셋이 있음'); END IF;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || '개의 행이 바뀜');
END;

DECLARE
    v_cursor SYS_REFCURSOR;
    v_name CHAR(10);
BEGIN
    OPEN v_cursor FOR SELECT "name" FROM city;
    LOOP
        FETCH v_cursor INTO v_name;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
    CLOSE v_cursor;
END;

CREATE OR REPLACE PROCEDURE SP_Oucityname(p_region IN CHAR, o_cursor OUT SYS_REFCURSOR)
AS
BEGIN
    OPEN o_cursor FOR SELECT "name" FROM city WHERE region = p_region;
END;

DECLARE
    v_cursor SYS_REFCURSOR;
    v_name CHAR(10);
BEGIN
    SP_Oucityname('전라', v_cursor);
    LOOP
        FETCH v_cursor INTO v_name;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;
END;

DECLARE
    CURSOR v_cursor IS SELECT * FROM city FOR UPDATE;
    v_city city%ROWTYPE;
BEGIN
    OPEN v_cursor;
    LOOP
        FETCH v_cursor INTO v_city;
        EXIT WHEN v_cursor%NOTFOUND;
        IF v_city.metro = 'y' THEN
            UPDATE city SET area = area + 10 WHERE CURRENT OF v_cursor;
        END IF;
    END LOOP;
    CLOSE v_cursor;
END;

DECLARE @"name" CHAR(10)
DECLARE testcursor CURSOR FOR SELECT "name" FROM city
OPEN testcursor
FETCH NEXT FROM testcursor INTO @"name"
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @"name"
	FETCH NEXT FROM testcursor INTO @"name"
END
CLOSE testcursor
DEALLOCATE testcursor

START:
FETCH NEXT FROM testcursor INTO @"name"
IF @@FETCH_STATUS = 0
BEGIN
	PRINT @"name"
	GOTO START
END

DECLARE @"name" CHAR(10)
DECLARE @varCur CURSOR
SET @varCur = CURSOR FOR SELECT "name" FROM city;
OPEN @varCur
FETCH NEXT FROM @varCur INTO @"name"
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @"name"
	FETCH NEXT FROM @varCur INTO @"name"
END
CLOSE @varCur
DEALLOCATE @VarCur

DECLARE testcursor CURSOR LOCAL SCROLL FOR SELECT "name" FROM city;
OPEN testcursor;

FETCH NEXT FROM testcursor;
FETCH NEXT FROM testcursor;
FETCH PRIOR FROM testcursor;
FETCH LAST FROM testcursor;

DECLARE testcursor CURSOR LOCAL FOR SELECT * FROM city;
OPEN testcursor;

FETCH NEXT FROM testcursor;
UPDATE city SET population=1234 WHERE CURRENT OF testcursor;

CLOSE testcursor;
DEALLOCATE testcursor;

DECLARE testcursor CURSOR LOCAL STATIC FOR SELECT "name", population FROM city;
OPEN testcursor;

DECLARE @"name" CHAR(10);
DECLARE @population INT;
FETCH NEXT FROM testcursor INTO @"name", @population;
PRINT @"name" + ':' + CONVERT(VARCHAR(12), @population);
WAITFOR DELAY '00:00:10';
FETCH NEXT FROM testcursor INTO @"name", @population;
PRINT @"name" + ':' + CONVERT(VARCHAR(12), @population);

UPDATE city SET population = 500 WHERE "name" = '부산';

DECLARE testcursor CURSOR LOCAL DYNAMIC FOR SELECT "name", population FROM city;
OPEN testcursor;

DECLARE @"name" CHAR(10);
DECLARE @population INT;
FETCH NEXT FROM testcursor INTO @"name", @population;
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @"name" + ':' + CONVERT(NVARCHAR(12), @population);
	WAITFOR DELAY '00:00:01';
	FETCH NEXT FROM testcursor INTO @"name", @population;
END

INSERT INTO city VALUES ('평택',453,51,'n','경기');

DECLARE 
    v_orderID INT := 1;
    v_sql VARCHAR(100);
    v_member CHAR(20);
BEGIN
    v_sql := 'SELECT "member" FROM "order" WHERE orderID = ' || v_orderID;
    EXECUTE IMMEDIATE v_sql INTO v_member;
    DBMS_OUTPUT.PUT_LINE(v_member);
END;

DECLARE
    v_area INT := 0;
    v_op CHAR(10) := '크다';
    v_sql VARCHAR(100);
    v_name CHAR(10);
BEGIN
    v_sql := 'SELECT "name" FROM city WHERE ';
    IF v_area != 0 THEN
        v_sql := v_sql || 'area ';
        IF v_op = '같다' THEN v_sql := v_sql || '= '; END IF;
        IF v_op = '크다' THEN v_sql := v_sql || '> '; END IF;
        IF v_op = '작다' THEN v_sql := v_sql || '< '; END IF;
        v_sql := v_sql || v_area || ' AND ';
    END IF;
    v_sql := v_sql || ' rownum = 1';
    EXECUTE IMMEDIATE v_sql INTO v_name;
    DBMS_OUTPUT.PUT_LINE(v_name);
END;

SELECT "member" INTO v_member FROM "order" WHERE orderID = v_orderID;

v_table VARCHAR(10) := 'city';
SELECT "name" INTO v_name FROM v_table WHERE rownum = 1;

DECLARE 
    v_table VARCHAR(10) := 'city';
    v_sql VARCHAR(100);
    v_name CHAR(20);
BEGIN
    v_sql := 'SELECT "name" FROM ' || v_table || ' WHERE rownum = 1';
    EXECUTE IMMEDIATE v_sql INTO v_name;
    DBMS_OUTPUT.PUT_LINE(v_name);
END;

DECLARE @area INT = 1000;
DECLARE @op CHAR(10) = '크다';
DECLARE @sql VARCHAR(100);

SET @sql = 'SELECT TOP 1 "name" FROM city';
IF @area != 0
BEGIN
	SET @sql += ' WHERE area ';
	IF @op = '같다' SET @sql += '=';
	IF @op = '크다' SET @sql += '>';
	IF @op = '작다' SET @sql += '<';
	SET @sql = @sql + CAST(@area AS VARCHAR(10));
END
EXECUTE(@sql);

DECLARE 
    hour_begin INT := 1;
    hour_end INT := 2;
    hour_now INT := hour_begin;
    v_sql VARCHAR(1000);
    v_cursor SYS_REFCURSOR;
    TYPE linecar IS RECORD(line VARCHAR(100), car VARCHAR(100), t1 VARCHAR(100), t2 VARCHAR(100));
    v_lc linecar;
BEGIN
    v_sql := 'SELECT * FROM traffic PIVOT (SUM(traffic) FOR hour IN (';
    WHILE hour_now <= hour_end
    LOOP
        v_sql := v_sql || hour_now;
        IF hour_now != hour_end THEN v_sql := v_sql || ', '; END IF;
        hour_now := hour_now + 1;
    END LOOP;
    v_sql := v_sql || '))'; 
    
    OPEN v_cursor FOR v_sql;
    LOOP
        -- INTO 절에 레코드 타입을 적으면 되는데 타입을 미리 결정할 수 없다.
        FETCH v_cursor INTO v_lc;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_lc.line || v_lc.car || v_lc.t1 || ',' || v_lc.t2);
    END LOOP;
END;

DECLARE @hour_begin INT = 1;
DECLARE @hour_end INT = 2;
DECLARE @hour INT = @hour_begin;
DECLARE @sql VARCHAR(1000);

SET @sql = 'SELECT * FROM traffic PIVOT (SUM(traffic) FOR hour IN (';
WHILE @hour <= @hour_end
BEGIN
	SET @sql += '[' + CAST(@hour AS VARCHAR) + ']';
	IF @hour != @hour_end SET @sql += ', ';
	SET @hour += 1;
END
SET @sql += ')) as pvt';

EXEC(@sql);