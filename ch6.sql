-------------------------------------------------
-- 6장

INSERT INTO city ("name", area, population, metro, region) 
VALUES ('서울', 605, 974, 'y', '경기');

INSERT INTO city VALUES ('서울', 605, 974, 'y', '경기');

INSERT INTO city VALUES ('평택', 453, 51, 'n', '경기');

INSERT INTO city VALUES ('평택', 51, 453, 'n', '경기');		// area와 population가 바뀜
INSERT INTO city VALUES ('평택', 453, 'n', 51, '경기');		// population와 metro 순서가 바뀜
INSERT INTO city VALUES ('평택', 453, 'n', '경기');		// population 필드값 누락

INSERT INTO city (area, population, metro, region, "name") 
VALUES (453, 51, 'n', '경기', '평택');

TRUNCATE TABLE city;

INSERT INTO city ("name", area, population, metro, region) VALUES 
('서울',605,974,'y','경기'), 
('부산',765,342,'y','경상'),
('오산',42,21,'n','경기'),
('청주',940,83,'n','충청'),
('전주',205,65,'n','전라'),
('순천',910,27,'n','전라'),
('춘천',1116,27,'n','강원'),
('홍천',1819,7,'n','강원');

INSERT INTO staff("name", depart, gender, joindate, grade, salary, score)
SELECT "name", region, metro, '20210629', '신입', area, population FROM city WHERE region = '경기';

INSERT INTO staff("name", depart, gender, joindate, grade, salary, score)
SELECT "name", 지원부서, gender, 오늘, '수습', 230, score * 0.1 FROM tCandidate 
WHERE result = '합격';

CREATE TABLE tSudo AS SELECT "name", area, population FROM city WHERE region = '경기';
SELECT * FROM tSudo;

SELECT * INTO cityCopy FROM city;

CREATE TABLE staff_8월20일 AS SELECT * FROM staff;

DELETE FROM city WHERE "name" = '부산';

DELETE FROM city WHERE region = '경기';

DELETE FROM city;

SELECT * FROM city WHERE population > 50;

-- DELETE
-- SELECT *
FROM staff WHERE grade = '과장';

UPDATE city SET population = 1000, region = '충청' WHERE "name" = '서울';

UPDATE city SET population = 1000, region = '충청';

UPDATE city SET population = population * 2 WHERE "name" = '오산';
