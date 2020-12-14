-- 1. 작업 데이터베이스 선택

use sqldb;

show tables;

desc book;
desc customer;
desc orders;

select * from book;
select * from customer;
select * from orders;

-- 2 도서의 총 개수
desc book;
select count(bookid) as '도서 총개수'
from book;

-- 3 도서를 출고하는 출판사의 총 개수
select count(distinct publisher)
from book;

-- 4. 고객의 이름 주소
desc customer;
select name as '이름', address as '주소'
from customer;

-- 5. 2014 7월 4일 ~ 7월 7일 사이에 주문받은 도서의 주문번호
select *
from orders;

select orderid as '주문번호'
from orders
where orderdate between '2014-07-04' and '2014-07-07';

-- 6. 2014 7월 4일 ~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
select orderid as '주문번호'
from orders
where orderdate not between '2014-07-04' and '2014-07-07';

-- 7. 성이 '김' 씨인 고객의 이름과 주소
select name, address
from customer
where name like '김%';

-- 8. 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소alter
select name, address
from customer
where name like '김%아';

-- 9. 주문 금액의 총액과 주문의 평균 금액
select sum(saleprice) as '총액', avg(saleprice) as '평균 금액'
from orders;

-- 10. 고객별 구매액 합계
select sum(saleprice) as '구매액 합계'
from orders
group by custid;