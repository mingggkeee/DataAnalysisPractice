-- 1. 사용자 테이블의 데이터 조회

-- DESC usertbl; 

SELECT *
FROM usertbl; 

-- 2. 이름이 '조용필'인 사용자 조회

select *
from usertbl
where name='조용필'; -- 문자열과 날짜 -> ' 사용

-- 3. addr '서울'인 사용자 조회
select *
from usertbl
where addr = '서울';

-- 4. birthyear가 1970 이후인 사용자 조회
select *
from usertbl
where birthYear >= 1970;

-- 5. addr은 '서울'이고 birthyear가 1970 이후인 사용자 조회
select *
from usertbl
where addr = '서울' and birthYear >= 1970;

-- 6. addr은 '서울'이거나 '경기'인 사용자 조회
select *
from usertbl
where addr = '서울' or addr = '경기';

select *
from usertbl
where addr in('서울', '경기');

-- 7. birthyear가 1970년대인 사용자 조회
select *
from usertbl
where birthyear >= 1970 and birthyear < 1980;

select *
from usertbl
where birthyear between 1970 and 1980;

-- 8. 임씨 성을 가진 사용자 조회
select *
from usertbl
where name like '임%';

-- 8. 이름이 '재범'인 사용자 조회
select *
from usertbl
where name LIKE '_재범';

-- 9. 이름과 날짜를 날짜순으로 정렬해서 조회
select name, mDate
from usertbl
order by mDate;

-- 10. 이름과 키를 키순으로 조회
select name, height
from usertbl
order by height desc, name asc;

-- 11. addr 조회 ( 사용자의 출신 지역 조회 )
select distinct addr  -- DISTINCT : 중복된 데이터는 결과에 한 개만 포함하도록
from usertbl;

-- 작업 데이터베이스 변경 (employees)
use employees;

-- 12. 입사일자가 빠른 10명의 사원 조회
select emp_no, first_name, last_name, hire_date
from employees
order by hire_date desc
limit 10;

-- 12-2. 입사일자가 순위기 11번째 부터 20번째까지의 사원 조회
select emp_no, first_name, last_name, hire_date
from employees
order by hire_date asc
limit 10, 10; -- 시작 위치, 갯수 : 11 ~ 20

-- 작업 데이터베이스 변경 (sqldb)
use sqldb;

-- 13. 테이블 복사 (존재하는 테이블의 데이터를 복사해서 새 테이블에 저장)
create table buytbl2 (select * from buytbl);

select * from buytbl2;

create table buytbl3 (select num, userid from buytbl);
select * from buytbl3;

-- 14. 구매 가격 평균과, 수량 평균
select avg(price), min(price), max(price), count(price)
from buytbl;

select avg(price) as '가격평균',
	   min(price) as '최소가격',
       max(price) as '최대가격',
       count(price) as '개수'
from buytbl;

-- 15. 고객별 거래 실적 평균

select userid, avg(price) '평균거래액', count(price) '거래건수'
from buytbl
group by userid;

select userid, avg(price) '평균거래액', count(price) '거래건수'
from buytbl
-- where avg(price) > 100
group by userid
having avg(price) > 100; -- having : group by 결과에 대한 조건 검사

-- 16.
select num, groupname, sum(price * amount) as '합계'
from buytbl
group by groupname, num
with rollup;

