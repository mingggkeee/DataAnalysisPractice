use sqldb;

select * from customer;
select * from orders;
select * from book;

-- 1. 박지성의 총 구매액, 총 도서수 
select c.name, sum(o.saleprice), count(o.saleprice)
from customer c
inner join orders o
on c.custid = o.custid
where c.name = '박지성'
group by c.custid;

-- 2. 박지성이 구매한 도서의 출판사 수
select c.name, count(distinct b.publisher) '출판사 수'
from orders o
inner join customer c
on o.custid = c.custid
inner join book b
on o.bookid = b.bookid
where c.name = '박지성';

-- 3. 박지성이 구매한 도서의 이름, 가격, 정가의 판매가격의 차이
select b.bookname, b.price-o.saleprice as '가격차이'
from orders o
inner join customer c
on o.custid = c.custid
inner join book b
on o.bookid = b.bookid
where c.name = '박지성'
order by b.bookname;

-- 4. 고객의 이름과 고객이 구매한 도서 목록

select c.name, b.bookname, o.saleprice
from book b
inner join orders o
on b.bookid=o.bookid
inner join customer c
on c.custid=o.custid
order by c.name;