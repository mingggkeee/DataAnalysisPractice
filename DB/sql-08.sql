-- 작업 데이터베이스 변경

use employees;

desc employees;

select emp_no, concat(first_name, ' ', last_name) emp_name -- concat 함수 : 문자열 더해주기
from employees;

desc salaries;

select * from salaries limit 10;

desc departments;

select * from departments limit 10;

desc dept_emp;

select * from dept_emp limit 10;

desc titles;
select * from titles limit 10;