-- 1. 작업 데이터베이스 선택

use sqldb;

-- 2. join이 필요한 상황 검토 -- 하나의 테이블에서 정보를 충분히 조회 할 수 없는 경우

select * from orders;

select * from book where bookid = 7;

select * from customer where custid = 4;

-- 3-1 inner join
select * from buytbl;

select * from usertbl where userid = 'kbs';

select 
	buytbl.num, buytbl.userid, usertbl.name,
    buytbl.prodname,buytbl.price, buytbl.amount
from buytbl
inner join usertbl
on buytbl.userid = usertbl.userid; 		-- 조건

select 
	buytbl.*, usertbl.name
from buytbl
inner join usertbl
on buytbl.userid = usertbl.userid; 		-- 조건


select
	b.*, u.name
from buytbl b  -- 테이블에 별명 부여
inner join usertbl u  -- 테이블에 별명 부여
on b.userid = u.userid;  -- 표준 구문



-- 3-2 . inner join

select * from orders;

select o.*, b.bookname, c.name
from orders o
inner join book b
on o.bookid = b.bookid
inner join customer c
on o.custid = c.custid;

select o.orderid, o.saleprice, o.orderdate, b.bookname, c.name
from orders o, book b, customer c
where o.bookid = b.bookid and o.custid = c.custid;


-- 연습용 테이블 만들기

USE sqldb;
CREATE TABLE stdtbl 
( stdName    VARCHAR(10) NOT NULL PRIMARY KEY,
  addr	  CHAR(4) NOT NULL
);
CREATE TABLE clubtbl 
( clubName    VARCHAR(10) NOT NULL PRIMARY KEY,
  roomNo    CHAR(4) NOT NULL
);
CREATE TABLE stdclubtbl
(  num int AUTO_INCREMENT NOT NULL PRIMARY KEY, 
   stdName    VARCHAR(10) NOT NULL,
   clubName    VARCHAR(10) NOT NULL,
FOREIGN KEY(stdName) REFERENCES stdtbl(stdName),
FOREIGN KEY(clubName) REFERENCES clubtbl(clubName)
);
INSERT INTO stdtbl VALUES ('김범수','경남'), ('성시경','서울'), ('조용필','경기'), ('은지원','경북'),('바비킴','서울');
INSERT INTO clubtbl VALUES ('수영','101호'), ('바둑','102호'), ('축구','103호'), ('봉사','104호');
INSERT INTO stdclubtbl VALUES (NULL, '김범수','바둑'), (NULL,'김범수','축구'), (NULL,'조용필','축구'), (NULL,'은지원','축구'), (NULL,'은지원','봉사'), (NULL,'바비킴','봉사');

select * from clubtbl;
select * from stdtbl;
select * from stdclubtbl;

-- 3-3 inner join

select sc.*, s.addr, c.roomno
from stdclubtbl sc
inner join stdtbl s
on sc.stdname = s.stdname
inner join clubtbl c
on sc.clubname = c.clubname;

select sc.*, s.addr, c.roomno
from stdclubtbl sc, stdtbl s, clubtbl c
where sc.stdname = s.stdname and sc.clubname = c.clubname;

-- 4. outer join

select * from usertbl;
select * from buytbl;

select distinct userid
from buytbl;

-- 고객별 주문 통계 
select u.userid, u.name, sum(b.price * b.amount) as '주문총액'
from usertbl u
-- inner join buytbl b
left outer join buytbl b
on u.userid = b.userid
group by u.userid
order by 주문총액 desc;

-- 고객별 주문 통계 2
select c.custid, c.name, sum(o.saleprice)
from orders o
right outer join customer c
on o.custid = c.custid
group by c.custid;

select distinct custid from customer;

USE sqldb;
CREATE TABLE empTbl (emp CHAR(3), manager CHAR(3), empTel VARCHAR(8));

INSERT INTO empTbl VALUES('나사장',NULL,'0000');
INSERT INTO empTbl VALUES('김재무','나사장','2222');
INSERT INTO empTbl VALUES('김부장','김재무','2222-1');
INSERT INTO empTbl VALUES('이부장','김재무','2222-2');
INSERT INTO empTbl VALUES('우대리','이부장','2222-2-1');
INSERT INTO empTbl VALUES('지사원','이부장','2222-2-2');
INSERT INTO empTbl VALUES('이영업','나사장','1111');
INSERT INTO empTbl VALUES('한과장','이영업','1111-1');
INSERT INTO empTbl VALUES('최정보','나사장','3333');
INSERT INTO empTbl VALUES('윤차장','최정보','3333-1');
INSERT INTO empTbl VALUES('이주임','윤차장','3333-1-1');


select * from empTbl;
-- 5.  self join

-- 사원이름, 상위직급자이름, 내전화번호, 상위직급자 전화번호

SELECT ec.emp, ec.manager, ec.emptel, ep.emptel
FROM empTbl ec
-- INNER JOIN empTbl ep
LEFT OUTER JOIN empTbl ep
ON ec.manager = ep.emp;
