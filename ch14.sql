-------------------------------------------------
-- 14장

ALTER TABLE city ADD mayor CHAR(12) NULL;

UPDATE city SET mayor = '오륙도' WHERE "name" = '부산';

ALTER TABLE city ADD mayor CHAR(12) NOT NULL;

ALTER TABLE city DROP COLUMN mayor;

DROP TABLE project;
CREATE TABLE project
(
	projectID INT,
	employee CHAR(10),
	project VARCHAR(30),
	cost INT
);

INSERT INTO project VALUES (1, '김상형', '홍콩 수출건', 800);
INSERT INTO project VALUES (1, '김상형', 'TV 광고건', 3400);

TRUNCATE TABLE project;
ALTER TABLE project ADD CONSTRAINT PK_projectID PRIMARY KEY(projectID);

/* 오라클, MSSQL :*/ ALTER TABLE project DROP CONSTRAINT PK_projectID;
/* 오라클, 마리아 :*/ ALTER TABLE project DROP PRIMARY KEY;

DELETE FROM project WHERE employee='바이든';
ALTER TABLE project ADD CONSTRAINT FK_Project_Employee 
FOREIGN KEY(employee) REFERENCES employee("name");

ALTER TABLE project DROP CONSTRAINT FK_Project_Employee;

/* 오라클, 마리아 :*/ ALTER TABLE city MODIFY region CHAR(30);
-- MSSQL : ALTER TABLE city ALTER COLUMN region CHAR(30);

INSERT INTO city VALUES ('제주',1849,67,'y','제주특별자치도');

/* 오라클, 마리아 : */ ALTER TABLE city MODIFY region CHAR(1);
-- MSSQL : ALTER TABLE city ALTER COLUMN region CHAR(1);

/* 오라클, 마리아 : */ ALTER TABLE city MODIFY population DECIMAL(10,2);
-- MSSQL : ALTER TABLE city ALTER COLUMN population DECIMAL(10,2);

UPDATE city SET population = 21.2389 WHERE "name" = '오산';

CREATE TABLE cityBackup AS SELECT * FROM city;		-- 백업
TRUNCATE TABLE city;					-- 원본 비움
ALTER TABLE city MODIFY population DECIMAL(10,2);		-- 필드 타입 변경
INSERT INTO city SELECT * FROM cityBackup;		-- 백업 복원
UPDATE city SET population = 21.2389 WHERE "name" = '오산';		-- 필드값 변경
COMMIT;									-- 확정
DROP TABLE cityBackup;					-- 백업 삭제

DELETE FROM project WHERE employee='트럼프';
/* 오라클, 마리아 : */ ALTER TABLE project MODIFY project VARCHAR(30) NOT NULL;	
-- MSSQL : ALTER TABLE project ALTER COLUMN project VARCHAR(30) NOT NULL;

/* 오라클 : */ ALTER TABLE project MODIFY cost DEFAULT 100;
-- 마리아 : ALTER TABLE project MODIFY cost VARCHAR(30) DEFAULT 100;
-- MSSQL : ALTER TABLE project ALTER COLUMN project VARCHAR(30) DEFAULT 100 NOT NULL;

INSERT INTO project (projectid, employee, project) VALUES (4, '오바마', '기후 변화 회의 참석');

INSERT INTO project VALUES (5, '클린턴', '북핵 제거', -100);

DELETE FROM project WHERE employee='클린턴';
ALTER TABLE project ADD CONSTRAINT cost_check CHECK(cost > 0);

CREATE TABLE cityBackup AS SELECT * FROM city;
DROP TABLE city;
CREATE TABLE city
(
	"name" CHAR(10) PRIMARY KEY,
	region CHAR(6) NOT NULL,
	area INT NULL ,
	population INT NULL ,
	metro CHAR(1) NOT NULL
);
INSERT INTO city ("name", region, area, population, metro) 
    SELECT "name", region, area, population, metro FROM cityBackup;
COMMIT;
DROP TABLE cityBackup;

/* 오라클 : */ ALTER TABLE city RENAME COLUMN population TO ingu;
-- MSSQL : sp_rename 'city.population', 'ingu';
-- 마리아 : ALTER TABLE city CHANGE population ingu INT NULL; 

/* 오라클, 마리아 : */ ALTER TABLE city RENAME TO dosi;
-- MSSQL : sp_rename 'city', 'dosi';

COMMENT ON TABLE city IS '도시 목록';
COMMENT ON COLUMN city.population IS '인구';

SELECT COMMENTS FROM user_tab_comments where table_"name" = 'city';
SELECT * FROM user_col_comments where table_"name" = 'city';

sp_addextendedproperty 'MS_Description', '도시목록', 'USER', DBO, 'TABLE', city;
sp_addextendedproperty 'MS_Description', '인구', 'USER', DBO, 'TABLE', city, 'COLUMN', population;
