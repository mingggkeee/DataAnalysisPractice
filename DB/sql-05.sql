-- 1. 작업 데이터베이스 선택
use sqldb;

-- 2. 테이블 제거 : DROP TABLE 테이블이름
drop table testtbl2;

-- 3. 테이블 생성 : CREATE TABLE 테이블이름 ( 컬럼1, 컬럼2, ... )
CREATE TABLE testtbl2 (
  id 		INT 		PRIMARY KEY AUTO_INCREMENT,
  username  VARCHAR(50) NOT NULL,
  regdate	DATETIME 	DEFAULT CURRENT_TIMESTAMP,
  age 		INT 		NOT NULL);
  
  
-- 4. 데이터 생성

insert into testtbl2 (id, username, regdate, age)
values (NULL, '홍길동', current_timestamp, 30);

select * from testtbl2;

insert into testtbl2
values (NULL, '장동건', current_timestamp, 40);

select * from testtbl2;

insert into testtbl2 (username, age)
values ('송강호', 40);

select * from testtbl2;


-- 5. 데이터 수정

select * from testtbl2;

update testtbl2
set age = 50
where id = 3;

select * from testtbl2;

update testtbl2
set username = '주민기', age = 25
where id = 1;

select * from testtbl2;

-- 데이터 삭제

delete from testtbl2
where id = 2;

select * from testtbl2;

insert into testtbl2
values (null, '한석규', current_timestamp, 57);

select * from testtbl2;

truncate table testtbl2;  -- delete from testtbl2; 와 비슷하다.

select * from testtbl2;


-- 7. 다중 행 생성

insert into testtbl2 (username, age)
values ('주민기', 25),
	   ('김윤석', 53),
	   ('송강호', 40);
       
select * from testtbl2;

-- 8. 

CREATE TABLE testtbl3 (
  id 		INT 		PRIMARY KEY AUTO_INCREMENT,
  username  VARCHAR(50) NOT NULL,
  regdate	DATETIME 	DEFAULT CURRENT_TIMESTAMP,
  age 		INT 		NOT NULL);
  
select * from testtbl3;

insert into testtbl3
select id, username, age, regdate from testtlb2;

select * from testtbl3;
