-------------------------------------------------
-- 2장
DROP TABLE city;


CREATE TABLE city
(
	"name" VARCHAR2(30) PRIMARY KEY,
	area INT NULL ,
	population10k INT NULL ,
	metro NUMBER(1,0) NULL,
	region VARCHAR2(30) NOT NULL
);

INSERT INTO city VALUES ('서울',605,974,1,'서울');
INSERT INTO city VALUES ('부산',765,342,1,'부산');
INSERT INTO city VALUES ('오산',42,21,0,'경기');
INSERT INTO city VALUES ('청주',940,83,0,'충청');
INSERT INTO city VALUES ('전주',205,65,0,'전라');
INSERT INTO city VALUES ('순천',910,27,0,'전라');
INSERT INTO city VALUES ('춘천',1116,27,0,'강원');
INSERT INTO city VALUES ('홍천',1819,7,0,'강원');

SELECT * FROM city;

CREATE TABLE staff
(
	"name" CHAR (15) PRIMARY KEY,
	depart VARCHAR2 (30) NOT NULL,
	gender CHAR(3) NOT NULL,
	joindate DATE NOT NULL,
	grade CHAR(12) NOT NULL,
	salary INT NOT NULL,
	score DECIMAL(5,2) NULL
);

DELETE staff;

INSERT INTO staff VALUES ('김유신','총무부','남',TO_DATE('2000-02-03', 'YYYY-MM-DD'),'이사',420,88.8);
INSERT INTO staff VALUES ('유관순','영업부','여',TO_DATE('2009-03-01', 'YYYY-MM-DD'),'과장',380,NULL);
INSERT INTO staff VALUES ('안중근','인사과','남',TO_DATE('2012-05-05', 'YYYY-MM-DD'),'대리',256,76.5);
INSERT INTO staff VALUES ('윤봉길','영업부','남',TO_DATE('2015-08-15', 'YYYY-MM-DD'),'과장',350,71.25);
INSERT INTO staff VALUES ('강감찬','영업부','남',TO_DATE('2018-10-09', 'YYYY-MM-DD'),'사원',320,56.0);
INSERT INTO staff VALUES ('정몽주','총무부','남',TO_DATE('2010-09-16', 'YYYY-MM-DD'),'대리',370,89.5);
INSERT INTO staff VALUES ('허난설헌','인사과','여',TO_DATE('2020-01-05', 'YYYY-MM-DD'),'사원',285,44.5);
INSERT INTO staff VALUES ('신사임당','영업부','여',TO_DATE('2013-06-19', 'YYYY-MM-DD'),'부장',400,92.0);
INSERT INTO staff VALUES ('성삼문','영업부','남',TO_DATE('2014-06-08', 'YYYY-MM-DD'),'대리',285,87.75);
INSERT INTO staff VALUES ('논개','인사과','여',TO_DATE('2010-09-16', 'YYYY-MM-DD'),'대리',340,46.2);
INSERT INTO staff VALUES ('황진이','인사과','여',TO_DATE('2012-05-05', 'YYYY-MM-DD'),'사원',275,52.5);
INSERT INTO staff VALUES ('이율곡','총무부','남',TO_DATE('2016-03-08', 'YYYY-MM-DD'),'과장',385,65.4);
INSERT INTO staff VALUES ('이사부','총무부','남',TO_DATE('2000-02-03', 'YYYY-MM-DD'),'대리',375,50);
INSERT INTO staff VALUES ('안창호','영업부','남',TO_DATE('2015-08-15', 'YYYY-MM-DD'),'사원',370,74.2);
INSERT INTO staff VALUES ('을지문덕','영업부','남',TO_DATE('2019-06-29', 'YYYY-MM-DD'),'사원',330,NULL);
INSERT INTO staff VALUES ('정약용','총무부','남',TO_DATE('2020-03-14', 'YYYY-MM-DD'),'과장',380,69.8);
INSERT INTO staff VALUES ('홍길동','인사과','남',TO_DATE('2019-08-08', 'YYYY-MM-DD'),'차장',380,77.7);
INSERT INTO staff VALUES ('대조영','총무부','남',TO_DATE('2020-07-07', 'YYYY-MM-DD'),'차장',290,49.9);
INSERT INTO staff VALUES ('장보고','인사과','남',TO_DATE('2005-04-01', 'YYYY-MM-DD'),'부장',440,58.3);
INSERT INTO staff VALUES ('선덕여왕','인사과','여',TO_DATE('2017-08-03', 'YYYY-MM-DD'),'사원',315,45.1);

SELECT * FROM staff;
