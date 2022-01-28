-------------------------------------------------
-- 18장

CREATE OR REPLACE TRIGGER TR_Message
AFTER UPDATE ON city
BEGIN
    DBMS_OUTPUT.PUT_LINE('도시 정보를 갱신하였습니다.');
END;

UPDATE city SET population = population + 1 WHERE "name" = '서울';


CREATE OR REPLACE TRIGGER TR_Message
AFTER INSERT OR UPDATE OR DELETE ON city
BEGIN
    IF INSERTING THEN
        DBMS_OUTPUT.PUT_LINE('새로운 도시를 삽입하였습니다.');
    END IF;
    IF UPDATING THEN
        DBMS_OUTPUT.PUT_LINE('도시 정보를 갱신하였습니다.');
    END IF;
    IF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('도시를 삭제하였습니다.');
    END IF;
END;

INSERT INTO city VALUES ('여주',608,11,'n','경기');
UPDATE city SET population = 12 WHERE "name" = '여주';
DELETE FROM city WHERE "name" = '여주';

UPDATE city SET population = population + 1 WHERE region = '경기';

CREATE OR REPLACE TRIGGER TR_Message
AFTER UPDATE ON city
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD."name" || ':' || :OLD.population || '->' || :NEW.population);
END;

REFERENCING OLD AS pre_rec NEW AS post_rec

UPDATE city SET area = area + 1 WHERE "name" = '서울';

CREATE OR REPLACE TRIGGER TR_Message
AFTER UPDATE OF population ON city 
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD."name" || ':' || :OLD.population || '->' || :NEW.population);
END;

CREATE OR REPLACE TRIGGER TR_Message
AFTER UPDATE ON city 
FOR EACH ROW
WHEN (NEW.population > 10)
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD."name" || ':' || :OLD.population || '->' || :NEW.population);
END;

UPDATE city SET population = population + 1 WHERE region = '강원';

CREATE OR REPLACE TRIGGER TR_Message
AFTER UPDATE ON city
FOR EACH ROW
BEGIN
    IF :NEW.population > 10000 THEN
        RAISE_APPLICATION_ERROR(-20000, '인구가 1억을 넘을 수는 없습니다.');
    END IF;
    DBMS_OUTPUT.PUT_LINE(:OLD."name" || ':' || :OLD.population || '->' || :NEW.population);
END;

UPDATE city SET population = 12345 WHERE "name" = '서울';

CREATE OR REPLACE TRIGGER TR_PreventChoi
AFTER INSERT ON staff
FOR EACH ROW
BEGIN
    IF SUBSTR(:NEW."name",1,1) = '최' THEN
        RAISE_APPLICATION_ERROR(-20000, '최가는 안되!');
    END IF;
END;

INSERT INTO staff VALUES ('최무선','총무부','남','2021-6-25','사원',280,0);

CREATE OR REPLACE TRIGGER TR_PreventChoi
BEFORE INSERT ON staff
FOR EACH ROW
BEGIN
    IF SUBSTR(:NEW."name",1,1) = '최' THEN
        DBMS_OUTPUT.PUT_LINE('최가는 안되');
        :NEW."name" := '김' || SUBSTR(:NEW."name", 2);
    END IF;
END;

CREATE OR REPLACE TRIGGER TR_DoubleMoney
BEFORE INSERT ON "member"
FOR EACH ROW
BEGIN
    IF :NEW.age = 18 THEN
        :NEW.money := :NEW.money * 2;
    END IF;
END;

INSERT INTO "member" ("member", age, email, addr, money) VALUES 
('신입생', 18, 'fresher@kyunghee.ac.kr', '서울 회기동', 8000);

CREATE VIEW vCarMaker AS
SELECT car.*, factory, domestic FROM car INNER JOIN maker ON
car.maker = maker.maker;

INSERT INTO vCarMaker VALUES('티코', 800, 900, '대우', '울릉', 'y');

CREATE OR REPLACE TRIGGER TR_AddNewCar
INSTEAD OF INSERT ON vCarMaker
FOR EACH ROW
BEGIN
	INSERT INTO car (car, capacity, price, maker) VALUES 
        (:NEW.car, :NEW.capacity, :NEW.price, :NEW.maker);
	INSERT INTO maker (maker, factory, domestic) VALUES 
        (:NEW.maker, :NEW.factory, :NEW.domestic);
END;

CREATE OR REPLACE TRIGGER TR_Message2
AFTER UPDATE ON city
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD."name" || '면적:' || :OLD.area || '->' || :NEW.area);
END;

CREATE OR REPLACE TRIGGER TR_Message3
AFTER UPDATE ON city
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD."name" || '지역:' || :OLD.region || '->' || :NEW.region);
END;

CREATE OR REPLACE TRIGGER TR_Message3
AFTER UPDATE ON city
FOR EACH ROW
FOLLOWS TR_Message
BEGIN
    DBMS_OUTPUT.PUT_LINE(:OLD."name" || '지역:' || :OLD.region || '->' || :NEW.region);
END;

UPDATE city SET area = 1000, population = 12345 WHERE "name" = '서울';

CREATE OR REPLACE TRIGGER TR_OnNewCar
AFTER INSERT ON car
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('신차가 출시되었습니다.');
END;

INSERT INTO vCarMaker VALUES('티코', 800, 900, '대우', '울릉', 'y');

CREATE OR REPLACE TRIGGER TR_Change
AFTER DDL ON DATABASE
BEGIN
    DBMS_OUTPUT.PUT_LINE('명령 : ' || ora_sysevent);
    DBMS_OUTPUT.PUT_LINE('타입 : ' || ora_dict_obj_type);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ora_dict_obj_"name");
END;

CREATE TABLE temp ( id INT );
DROP TABLE temp;

CREATE TABLE cityHistory
(
    dt DATE,
    suser VARCHAR(20),
    ip VARCHAR(20),
    action VARCHAR(10),
    "name" CHAR(10),
    area VARCHAR(30) NULL,
    population VARCHAR(30) NULL
);

CREATE OR REPLACE TRIGGER TR_History
AFTER INSERT OR UPDATE OR DELETE ON city
FOR EACH ROW
DECLARE
    areaChange VARCHAR(30);
    populationChange VARCHAR(30);
    suser VARCHAR(20);
    ip VARCHAR(20);
BEGIN
    SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') INTO suser FROM DUAL;
    SELECT SYS_CONTEXT('USERENV', 'IP_ADDRESS') INTO ip FROM DUAL;
    
    IF INSERTING THEN
        INSERT INTO cityHistory VALUES 
            (SYSDATE, suser, ip, 'INSERT', :NEW."name", :NEW.area, :NEW.population);
    END IF;
    IF UPDATING THEN
        IF :OLD.area = :NEW.area THEN
            areaChange := :OLD.area;
        ELSE
            areaChange := :OLD.area || '->' || :NEW.area;
        END IF;
        IF :OLD.population = :NEW.population THEN
            populationChange := :OLD.population;
        ELSE
            populationChange := :OLD.population || '->' || :NEW.population;
        END IF;
        INSERT INTO cityHistory VALUES 
            (SYSDATE, suser, ip, 'UPDATE', :NEW."name", areaChange, populationChange);
    END IF;
    IF DELETING THEN
        INSERT INTO cityHistory VALUES 
            (SYSDATE, suser, ip, 'DELETE', :OLD."name", :OLD.area, :OLD.population);
    END IF;
END;

CREATE TRIGGER TR_Message
ON city AFTER UPDATE 
AS
BEGIN
    PRINT('도시 정보를 갱신하였습니다.');
END;

UPDATE city SET population = population + 1 WHERE "name" = '서울';
UPDATE city SET population = population + 1 WHERE region = '경기';

ALTER TRIGGER TR_Message
ON city AFTER UPDATE 
AS
BEGIN
	SELECT * FROM deleted;
	SELECT * FROM inserted;
END;

ALTER TRIGGER TR_Message
ON city AFTER UPDATE 
AS
BEGIN
	SELECT "name", population, ' => ', (SELECT population FROM inserted WHERE "name" = D."name") FROM deleted D;
END;

ALTER TABLE city DISABLE TRIGGER TR_Message;

ALTER TRIGGER TR_Message
ON city AFTER UPDATE 
AS
BEGIN
	IF (SELECT population FROM inserted) > 10000
	BEGIN
		PRINT('인구가 1억을 넘을 수는 없습니다.');
		ROLLBACK;
	END
END;

CREATE TRIGGER TR_PreventChoi
ON staff AFTER INSERT
AS
IF EXISTS (SELECT * FROM inserted WHERE "name" LIKE '최%')
BEGIN
	PRINT '최가는 안되!';
	ROLLBACK TRANSACTION;
END

CREATE TRIGGER TR_AddNewCar
ON vCarMaker INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO car (car, capacity, price, maker) SELECT car, capacity, price, maker FROM inserted;
	INSERT INTO maker (maker, factory, domestic) SELECT maker, factory, domestic FROM inserted;
END

CREATE TRIGGER TR_DoubleMoney
ON "member" AFTER INSERT
AS
DECLARE @"name" CHAR(20)
DECLARE @age INT
SELECT @"name" = "member", @age = age FROM inserted;
IF @age = 18
	UPDATE "member" SET money = money * 2 WHERE "member" = @"name";

CREATE TRIGGER TR_MoneyChange
ON "member"
AFTER UPDATE
AS
DECLARE @"name" CHAR(20)
IF UPDATE(money)
BEGIN
	SELECT @"name" = "member" FROM inserted;
	PRINT @"name" + '의 예치금이 갱신되었습니다. 부정이 아닌지 확인해 보십시오';
END;

CREATE TRIGGER NewDataBase
ON ALL SERVER
AFTER CREATE_DATABASE, DROP_DATABASE
AS
PRINT '새로운 DB가 생성 또는 파괴되었습니다.';

CREATE DATABASE NewDB
DROP DATABASE NewDB

DROP TRIGGER NewDataBase ON ALL SERVER
