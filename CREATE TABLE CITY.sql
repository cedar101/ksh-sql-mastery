CREATE TABLE CITY (
    id INTEGER GENERATED BY DEFAULT AS IDENTITY,
    NAME VARCHAR2(30) NOT NULL,
    AREA FLOAT,
    POPULATION INT,
    METRO NUMBER(1,0),
    REGION VARCHAR2(30),
    PRIMARY KEY (id)
);