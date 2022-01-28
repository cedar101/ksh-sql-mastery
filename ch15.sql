
-------------------------------------------------
-- 15장

SET SERVEROUTPUT ON;

BEGIN
	DBMS_OUTPUT.PUT_LINE('안녕하세요');
END;

BEGIN
	DBMS_OUTPUT.PUT_LINE('안녕하세요')
END

BEGIN
	DBMS_OUTPUT.PUT_LINE(2 + 3 * 4);
	DBMS_OUTPUT.PUT_LINE(POWER(2, 3));
END;

DECLARE
    v_price INT := 1000;
    v_num INT := 5;
    v_total INT;
BEGIN
    v_total := v_price * v_num;
    DBMS_OUTPUT.PUT_LINE(v_total);
END;

DECLARE v_price INT := 1000;v_num INT := 5;v_total INT;
BEGIN v_total := v_price * v_num;DBMS_OUTPUT.PUT_LINE(v_total);END;

DECLARE
    c_mile CONSTANT NUMBER := 1.609;
    v_kilo INT;
BEGIN
    v_kilo := 400;
    DBMS_OUTPUT.PUT_LINE(v_kilo * c_mile);
END;

DECLARE
    v_price item.price%TYPE := 1000;
    v_num v_price%TYPE := 5;
    v_total v_price%TYPE;
BEGIN
    v_total := v_price * v_num;
    DBMS_OUTPUT.PUT_LINE(v_total);
END;

DECLARE 
    v_isOk BOOLEAN;
BEGIN
    v_isOk := (1 = 1);
    IF v_isOK THEN
        DBMS_OUTPUT.PUT_LINE('OK');
    END IF;
END;

DECLARE 
    v_member order."member"%TYPE;
BEGIN
    SELECT "member" INTO v_member FROM "order" WHERE orderID = 1;
    DBMS_OUTPUT.PUT_LINE(v_member);
END;

DECLARE 
    v_member order."member"%TYPE;
    v_item VARCHAR(20);
BEGIN
    SELECT "member", item INTO v_member, v_item FROM "order" WHERE orderID = 1;
    DBMS_OUTPUT.PUT_LINE(v_member || '의 ' || v_item || ' 주문');
END;

DECLARE
    v_row city%ROWTYPE;
BEGIN
    SELECT * INTO v_row FROM city WHERE "name" = '부산';
    DBMS_OUTPUT.PUT_LINE(TRIM(v_row."name") || ', ' || v_row.area || ', ' || v_row.population);
END;

DECLARE
    v_row city%ROWTYPE;
BEGIN
    SELECT "name", region INTO v_row."name", v_row.region FROM city WHERE "name" = '춘천';
    DBMS_OUTPUT.PUT_LINE(v_row.region || '도의 ' || v_row."name");
END;

DECLARE
    TYPE cap IS RECORD(area INT, population INT);
    city cap;
BEGIN
    SELECT area, population INTO city FROM city WHERE "name" = '부산';
    DBMS_OUTPUT.PUT_LINE(city.area || ',' || city.population);
END;

TYPE cap IS RECORD(area city.area%TYPE, population city.population%TYPE);

DECLARE
    v_maxpopulation INT;
    v_cityname VARCHAR(10);
BEGIN
    SELECT MAX(population) INTO v_maxpopulation FROM city;
    SELECT "name" INTO v_cityname FROM city WHERE population = v_maxpopulation;
    DBMS_OUTPUT.PUT_LINE(v_cityname);
END;

DECLARE
    v_population INT;
BEGIN
    SELECT population INTO v_population FROM city WHERE "name" = '서울';
    v_population := v_population * 2;
    UPDATE city SET population = v_population WHERE "name" = '서울';
END;

DECLARE
    TYPE int_array IS VARRAY(5) OF NUMBER;
    ar int_array;
BEGIN
    ar := int_array(8, 9, 0, 6, 2);
    FOR idx IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(ar(idx));
    END LOOP;
END;

DECLARE
    TYPE int_array IS VARRAY(3) OF NUMBER;
    TYPE int_array2 IS VARRAY(3) OF int_array;
    ar int_array2;
BEGIN
    ar := int_array2(int_array(1, 2, 3), int_array(4, 5, 6), int_array(7, 8, 9));
    DBMS_OUTPUT.PUT_LINE(ar(2)(3));
END;

DECLARE
    TYPE int_table IS TABLE OF NUMBER;
    ar int_table;
BEGIN
    ar := int_table(1, 2, 3, 4, 5, 6);
    DBMS_OUTPUT.PUT_LINE(ar(4));
END;

DECLARE
    TYPE string_int_map IS TABLE OF NUMBER INDEX BY STRING(20);
    score string_int_map;
BEGIN
    score('홍길동') := 80;
    score('황진이') := 90;
    score('어우동') := 90;
    score.DELETE('황진이');
    DBMS_OUTPUT.PUT_LINE(score.COUNT());
    DBMS_OUTPUT.PUT_LINE(score('홍길동'));
END;

DECLARE v_score INT := 12;
BEGIN
    IF v_score = 12 THEN
        DBMS_OUTPUT.PUT_LINE('12입니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE('12가 아닙니다');
    END IF;
END;

DECLARE v_score INT := 12;
BEGIN
    IF v_score = 12 THEN
        DBMS_OUTPUT.PUT_LINE('12입니다');
        DBMS_OUTPUT.PUT_LINE('참 잘했어요.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('12가 아닙니다');
        DBMS_OUTPUT.PUT_LINE('좀 더 노력하세요.');
    END IF;
END;

DECLARE 
    v_population INT;
    v_message VARCHAR(50);
BEGIN
    SELECT population INTO v_population FROM city WHERE "name" = '부산';
    IF v_population > 100 THEN
        v_message := '100만이 넘습니다';
    ELSE
        v_message := '100만보다 적습니다';
    END IF;    
    DBMS_OUTPUT.PUT_LINE('부산의 인구는 ' || v_message);
END;

DECLARE 
    v_num INT := 1;
    v_total INT := 0;
BEGIN
    WHILE v_num <= 100
    LOOP
        v_total := v_total + v_num;
        v_num := v_num + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~100까지의 합산 결과 = ' || v_total);
END;

DECLARE 
    v_total INT := 0;
BEGIN
    FOR v_num IN 1 .. 100
    LOOP
        v_total := v_total + v_num;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~100까지의 합산 결과 = ' || v_total);
END;

BEGIN
    FOR v_cities IN (SELECT * FROM city WHERE region='경기')
    LOOP
        DBMS_OUTPUT.PUT_LINE(TRIM(v_cities."name") || ' : ' || v_cities.area || ',' || v_cities.population);
    END LOOP;
END;

DECLARE 
    v_num INT := 1;
    v_total INT := 0;
BEGIN
    WHILE 1 = 1
    LOOP
        v_total := v_total + v_num;
        v_num := v_num + 1;
        IF v_num > 100 THEN
            EXIT;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~100까지의 합산 결과 = ' || v_total);
END;

DECLARE 
    v_num INT := 1;
    v_total INT := 0;
BEGIN
    LOOP
        v_total := v_total + v_num;
        v_num := v_num + 1;
        EXIT WHEN v_num > 100;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('1~100까지의 합산 결과 = ' || v_total);
END;

DECLARE 
    v_num INT := 1;
    v_total INT := 0;
BEGIN
    <<HERE>>    
    v_total := v_total + v_num;
    v_num := v_num + 1;
    IF v_num <= 100 THEN
        GOTO HERE;
    END IF;
   	DBMS_OUTPUT.PUT_LINE('1~100까지의 합산 결과 = ' || v_total);
END;

BEGIN
    DBMS_LOCK.SLEEP(5);
    DBMS_OUTPUT.PUT_LINE('대기종료');
END;

DECLARE 
    v_num INT := 2;
    v_numword CHAR(30);
BEGIN
    v_numword := 
    CASE v_num
        WHEN 1 THEN '하나'
        WHEN 2 THEN '둘'
        WHEN 3 THEN '셋'
        WHEN 4 THEN '넷'
        ELSE '그외'
    END;
    DBMS_OUTPUT.PUT_LINE(v_numword);
END;

DECLARE 
    v_num INT := 6;
    v_numword CHAR(30);
BEGIN
    v_numword := 
    CASE 
        WHEN v_num < 0 THEN '음수'
        WHEN v_num IN (1, 2, 3) THEN '하나, 둘, 셋'
        WHEN v_num > 4 THEN '넷보다 더 큼'
        ELSE '그외'
    END;
    DBMS_OUTPUT.PUT_LINE(v_numword);
END;

SELECT item, 
    CASE category 
        WHEN '패션' THEN '받자 마자 빨아서 입으세요.'
        WHEN '가전' THEN '충격을 주지 마세요.'
        WHEN '식품' THEN '냉장 보관하세요.'
        WHEN '성인' THEN '애들은 가라'
    END AS 주의사항
FROM item

SELECT "member", item,
    CASE status
        WHEN 1 THEN '주문'
        WHEN 2 THEN '배송중'
        WHEN 3 THEN '배송완료'
        ELSE '기타'
    END AS 상태
FROM "order";

SELECT "member", item, DECODE(status, 1, '주문', 2, '배송중', 3, '배송완료', '기타') 
AS 상태 FROM "order";

DECLARE 
    v_num INT := 2;
    v_population INT;
BEGIN
    CASE 
        WHEN v_num = 1 THEN SELECT population INTO v_population FROM city WHERE "name" = '서울';
        WHEN v_num = 2 THEN DBMS_OUTPUT.PUT_LINE('둘');
        WHEN v_num = 3 THEN COMMIT;
        WHEN v_num > 4 THEN ROLLBACK;
        ELSE DBMS_OUTPUT.PUT_LINE('알 수 없는 명령');
    END CASE;
END;

DECLARE v_member CHAR(20);
BEGIN
    SELECT "member" INTO v_member FROM "order" WHERE orderID = 100;
    DBMS_OUTPUT.PUT_LINE(v_member);
END;

DECLARE v_member CHAR(20);
BEGIN
    SELECT "member" INTO v_member FROM "order" WHERE orderID = 100;
    DBMS_OUTPUT.PUT_LINE(v_member);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('주문 번호가 없습니다.');
END;

DECLARE v_member CHAR(20);
BEGIN
    SELECT "member" INTO v_member FROM "order" WHERE orderID > 1;
    DBMS_OUTPUT.PUT_LINE(v_member);
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('하나의 주문만 선택하십시오.');
END;

DECLARE 
    v_member CHAR(20);
    v_orderID INT := -1;
    negativeOrder EXCEPTION;
BEGIN
    IF (v_orderID < 0) THEN
        RAISE negativeOrder;
    END IF;
    SELECT "member" INTO v_member FROM "order" WHERE orderID = v_orderID;
    DBMS_OUTPUT.PUT_LINE(v_member);
    EXCEPTION
        WHEN negativeOrder THEN
            DBMS_OUTPUT.PUT_LINE('주문 번호가 음수여서는 안됩니다.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('원인을 알 수 없는 예외가 발생했습니다.');
END;

DECLARE 
    v_member CHAR(20);
    v_orderID INT := -1;
BEGIN
    IF (v_orderID < 0) THEN
        RAISE_APPLICATION_ERROR(-20000, '주문 번호가 음수여서는 안됩니다.');
    END IF;
    SELECT "member" INTO v_member FROM "order" WHERE orderID = v_orderID;
    DBMS_OUTPUT.PUT_LINE(v_member);
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLCODE);
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;

SELECT '안녕하세요';
SELECT 2 + 3 * 4;
SELECT POWER(2, 3);

DECLARE @salary INT;			-- 정수형의 @salary 변수
DECLARE @a INT, @b INT = 100;		-- 두 개의 정수형 변수. b는 100으로 초기화
DECLARE @age INT, @"name" CHAR(5);	-- 정수형 변수와 문자열 변수 선언

DECLARE @price INT;
SET @price = 1000;
SELECT @price;

DECLARE @"name" CHAR(20);
SELECT @"name" = "member" FROM "order" WHERE orderID=1;
SELECT @"name";

SET @"name" = (SELECT "member" FROM "order" WHERE orderID=1);

DECLARE @score INT = 12;
IF @score = 12
	PRINT '12입니다.';
ELSE
	PRINT '12가 아닙니다.';

DECLARE @message VARCHAR(50);
IF (SELECT population FROM city WHERE "name" = '부산') > 100
BEGIN	
	SET @message='100만이 넘습니다';
	PRINT '많이도 낳았네요'
END
ELSE
BEGIN
	SET @message='100만보다 적습니다';
	PRINT '아직 더 많이 낳아야겠네요'
END
PRINT '부산의 인구는 ' + @message;

DECLARE @num INT = 1, @sum INT = 0;

WHILE @num <= 100
BEGIN
	SET @sum = @sum + @num;
	SET @num = @num + 1;
END
PRINT '1~100까지의 합산 결과 = ' + CONVERT(VARCHAR(10), @sum);

WHILE 1=1
BEGIN
	SET @sum = @sum + @num;
	SET @num = @num + 1;
	IF @num > 100
		BREAK;
END

HERE:
SET @sum = @sum + @num;
SET @num = @num + 1;
IF @num <= 100
	GOTO HERE;

WAITFOR DELAY '00:00:05';		-- 5초간 대기
WAITFOR TIME '02:20:00';			-- 2:20분까지 대기

BEGIN TRY
	INSERT INTO city VALUES ('서울',600,1000,'y','경기');
END TRY
BEGIN CATCH
    PRINT '기본키가 같은 레코드를 삽입할 수 없습니다.';
    PRINT '에러 번호 : ' + CAST(ERROR_NUMBER() AS VARCHAR(10))
    PRINT '메시지 : ' + ERROR_MESSAGE()
END CATCH

BEGIN TRY
    SELECT mayor FROM city;
END TRY
BEGIN CATCH
    PRINT '시장님에 대한 정보는 없습니다.'
END CATCH

DECLARE @population INT = 12345;

BEGIN TRY
	IF @population > 10000
		THROW 50001, '도시의 인구가 1억이 넘을 리가 없을텐데...', 1;
	ELSE
		INSERT INTO city VALUES ('광주',600,@population,'y','전라');
END TRY
BEGIN CATCH
    PRINT '에러 번호 : ' + CAST(ERROR_NUMBER() AS VARCHAR(10))
    PRINT '메시지 : ' + ERROR_MESSAGE()
END CATCH