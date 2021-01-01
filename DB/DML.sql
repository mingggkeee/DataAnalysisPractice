use hr;

-- 1. 사원정보(EMPLOYEES) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원 번호를 출력하시오. 이름은 성과 이름을 연결하여 Name이라는 별칭으로 출력하시오
desc employees;

select EMPLOYEE_ID , concat(first_name,' ', last_name) 'name', salary , JOB_ID , HIRE_DATE , MANAGER_ID
from employees;

-- 2. 사원정보(EMPLOYEES) 테이블에서 
-- 		사원의 성과 이름은 Name, 
-- 		업무는 Job, 
-- 		급여는 Salary, 
-- 		연봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary, 
-- 		급여에 $100 보너스를 추가하여 계산한 연봉은 “Increased Salary”
--    	라는 별칭으로 출력하시오

select 
	concat(first_name, last_name) '이름',
    JOB_ID 'Job', SALARY 'Salary',
    salary * 12 + 100 'Increased Ann_Salary',
	(salary + 100) * 12 'Increased Salary'
from employees;

-- 3. 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과 연봉을 
-- “이름: 1Year Salary = $연봉” 형식으로 출력하고, “1 Year Salary”라는 별칭을 붙이시오

select concat(last_name, ': 1Year Salary = $ ', salary*12) '1 Year Salary'
from employees;

-- 4. 부서별로 담당하는 업무를 한 번씩만 출력하시오

select distinct DEPARTMENT_ID, job_id from employees;

-- 데이터 제한 및 정렬 : where, order by

-- 5. HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다. 
--    사원정보(EMPLOYEES) 테이블에서 급여가 $7,000~$10,000 범위 이외인 사람의 
--    성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오

select concat(first_name, ' ', last_name) name, salary
from employees
where salary not between 7000 and 10000
order by salary asc;

-- 6. 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오. 
--    이때 머리글은 ‘e and o Name’라고 출력하시오

select last_name as 'e and o name'
from employees
where last_name like '%e%' and last_name like '%o%';

-- 7. 현재 날짜 타입을 날짜 함수를 통해 확인하고, 
--    1995년 05월 20일부터 1996년 05월 20일 사이에 고용된 사원들의 
--    성과 이름(Name으로 별칭), 사원번호, 고용일자를 입사일이 빠른 순으로 정렬해서 출력하시오. 

select sysdate();

select concat(first_name, ' ',last_name) name, employee_id, hire_date
from employees
where hire_date between '1995-05-20' and '1996-05-20'
order by hire_date asc;

-- 8. HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다. 
--    이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오. 
--    이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오

select concat(first_name, ' ', last_name) Name, salary, job_id, COMMISSION_PCT
from employees
where commission_pct is not null
order by salary desc, COMMISSION_PCT desc;

----------------------------------------
-- 단일 행 함수 및 변환 함수

-- 9. 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하여 해당 부서의 사원 급여를 12.3% 인상하기로 하였다. 
--    60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만(반올림) 표시하는 보고서를 작성하시오. 
--    출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭)순으로 출력한다

select
	employee_id, concat(first_name, ' ', last_name) Name,
    salary, round(salary * 1.123, 0) 'increased salary'
from employees
where department_id = 60;

-- 10. 각 이름이 ‘s’로 끝나는 사원들의 이름과 업무를 아래의 예와 같이 출력하고자 한다. 
-- 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs.로 표시하시오

-- 	예) Sigal Tobias is a PU_CLERK

select concat(first_name,' ', last_name ,'is a ', upper(job_id)) as 'Employee JOBs'
from employees
where lower(first_name) like '%s';

-- 11. 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다. 
-- 	보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오. 
-- 	수당여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다. 
-- 	또한 출력 시 연봉이 높은 순으로 정렬한다

select
	employee_id, concat(first_name, ' ', last_name) Name,
    salary,
    (salary * 12) + (salary * 12 * ifnull(COMMISSION_PCT, 0)) 'annual salary',
    if(COMMISSION_PCT is null, 'salary only', 'salary + commission') 'annual salary type'
--     case
-- 		when commission_pct is null then 'salary only'
--         else 'salary + commission'
-- 	end 'annual salary type'
from employees
order by salary desc;

-- 12. 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오. 
-- 	이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오

select employee_id, concat(first_name, ' ', last_name) Name, hire_date, date_format(hire_date, '%W') 'day of week'
from employees
order by date_format(hire_date, '%w');
--------------------------------------------
-- 집계된 데이터 보고 : 집계 함수

-- 13. 모든 사원은 직속 상사 및 직속 직원을 갖는다. 단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다. 
-- 	소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오

select count(distinct manager_id) 'count of manager'
from employees
where manager_id is not null;

-- 14. 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다. 
-- 	계산된 출력값은 부서번호의 오름차순 정렬해서 $ 표시와 함께 출력하시오.  
-- 	단, 부서에 소속되지 않은 사원에 대한 정보는 제외하시요

select
	department_id,
	concat('$', format(sum(salary),0)) '총급여',	
    concat('$', format(avg(salary),0)) '평균급여',
    concat('$', format(max(salary),0)) '최대급여',
    concat('$', format(min(salary),0)) '최소급여'
from employees
where department_id is not null
group by department_id;

-- 15. 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오.
-- 	단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오

select 
	job_id,
    concat('$', format(avg(salary),0))  'avg'
from employees
where job_id not like '%clerk%' 
group by job_id
having avg(salary) > 10000
order by avg(salary) desc;

----------------------------------------------
-- 여러 테이블의 데이터 표시 : JOIN

-- 16. HR 데이터베이스에 존재하는 Employees, Departments, Locations 테이블의 구조를 파악한 후
-- 	Oxford에 근무하는 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 도시명을 출력하시오. 
-- 	이때 첫 번째 열은 회사명인 ‘SSAC’이라는 상수값이 출력되도록 하시오

select 'ssac' as 'company', concat(employees.FIRST_NAME, ' ',employees.last_name) name, employees.job_id, departments.department_name, locations.city
from employees
	inner join departments
    on employees.department_id = departments.department_id
		inner join locations
        on departments.LOCATION_ID = locations.location_id
where locations.city = 'oxford';

-- 17. HR 데이터베이스에 있는 Employees, Departments 테이블의 구조를 파악한 후 
-- 	사원수가 5명 이상인 부서의 부서명과 사원수를 사원수가 많은 순으로 정렬해서 출력하시오.
select departments.DEPARTMENT_NAME, count(employees.EMPLOYEE_ID)
from employees
	inner join departments
    on employees.department_id = departments.department_id
group by departments.department_name
having count(employees.employee_id) > 4
order by count(employees.employee_id) desc;

-- 18. 각 사원의 급여에 따른 급여 등급을 보고하려고 한다. 
-- 	급여 등급은 JOB_GRADES 테이블에 표시된다. 
-- 	해당 테이블의 구조를 살펴본 후 사원의 성과 이름(Name으로 별칭), 업무, 부서명, 입사일, 급여, 급여등급을 출력하시오

select
	concat(e.FIRST_NAME, ' ',e.last_name) name, e.job_id,
    d.department_name, e.HIRE_DATE, e.salary, j.grade_level
from employees e
	inner join departments d
    on e.DEPARTMENT_ID = d.DEPARTMENT_ID
		cross join job_grades j
where e.salary between j.lowest_sal and j.HIGHEST_SAL;

-- 19. 각 사원과 직속 상사와의 관계를 이용하여 다음과 같은 형식의 보고서를 작성하고자 한다.

-- 	예) 홍길동은 허균에게 보고한다 → Eleni Zlotkey report to Steven King
-- 	어떤 사원이 어떤 사원에서 보고하는지를 위 예를 참고하여 출력하시오. 
-- 	단, 보고할 상사가 없는 사원이 있다면 그 정보도 포함하여 출력하고, 상사의 이름은 대문자로 출력하시오

select
-- 	e2.EMPLOYEE_ID,
--     concat(e2.first_name, ' ', e2.last_name) 'employee name',
--     e1.EMPLOYEE_ID,
--     concat(e1.first_name, ' ', e1.last_name) 'manager name'
    concat(e2.first_name, ' ', e2.last_name, ' report to ' , e1.first_name, ' ', e1.last_name) 'report'
from employees e1
	right outer join employees e2
    on e1.EMPLOYEE_ID = e2.manager_id;
    
----------------------------------------
-- 부속질의를 사용하여 복잡한 질의 해결

-- 20. HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. 
-- 	Tucker 사원(last_name)보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오

select concat(first_name, ' ', last_name) 'name', job_id, salary
from employees
where salary > (select salary from employees where last_name = 'Tucker');

-- 21. 사원의 급여 정보 중 업무별 최소 급여를 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여, 입사일을 출력하시오

select concat(e1.first_name, ' ', e1.last_name) 'name', e1.job_id, e1.salary, e1.hire_date
from employees e1
where e1.salary = (select min(salary) from employees e2 where e2.job_id = e1.job_id);

-- 22. 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오

select concat(e1.first_name, ' ', e1.last_name) 'name', e1.DEPARTMENT_ID, e1.job_id, e1.salary
from employees e1
where e1.salary > (select avg(salary) from employees e2 where e2.DEPARTMENT_ID = e1.DEPARTMENT_ID);

-- 23. 사원들의 지역별 근무 현황을 조회하고자 한다. 
-- 	도시 이름이 영문 'O' 로 시작하는 지역에 살고 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오

-- 24. 모든 사원의 소속부서 평균연봉을 계산하여 사원별로 
-- 	성과 이름(Name으로 별칭), 업무, 급여, 부서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오

select
	concat(e1.first_name, ' ', e1.last_name) 'name',
    e1.department_id,
    e1.job_id,
    e1.salary,
    (select round(avg(e2.salary), 0) from employees e2 where e2.department_id = e1.department_id) '부서평균'
from employees e1;

---------------------------------
-- 집합 연산자 사용

-- 25. HR 데이터베이스에 있는 JOB_HISTORY 테이블은 사원들의 업무 변경 이력을 나타내는 테이블이다. 
-- 	이 정보를 이용하여 모든 사원의 현재 및 이전의 업무 이력 정보를 출력하고자 한다. 
-- 	중복된 사원정보가 있을 경우 한 번만 표시하여 출력하시오

SELECT employee_id, job_id FROM employees
UNION -- 중복을 허용하지않는 결과집합 결합
SELECT employee_id, job_id FROM job_history 
ORDER BY employee_id;

-- 26. 위 샘플 문제에서 각 사원의 업무 이력 정보를 확인하였다. 하지만 모든 사원의 업무이력 전체를 보지는 못했다. 
-- 	여기에서는 모든 사원의 업무 이력 변경 정보 및 업무 변경에 따른 부서정보를 사번이 빠른 순서대로 출력하시오

select employee_id, job_id, department_id from employees
union all
select employee_id, job_id, department_id from job_history
order by employee_id;

-- 27. 사원정보(Employees) 테이블의 JOB_ID는 사원의 현재 업무를 뜻하고, JOB_HISTORY의 JOB_ID는 사원의 이전 업무를 뜻한다. 
-- 	이 두 테이블을 교차해보면 업무가 변경된 사원의 정보도 볼 수 있지만 이전에 한번 했던 같은 업무를 그대로 하고 있는 사원의 정보도 볼 수 있다. 
-- 	이전에 한번 했던 같은 업무를 보고 있는 사원의 사번과 업무를 출력하시오

select e.employee_id, e.job_id
from employees e, job_history j
where e.employee_id = j.employee_id and e.job_id = j.job_id;

-- 28. 위 결과를 이용하여 출력된 176번 사원의 업무 이력의 변경 날짜 이력을 조회하시오

select employee_id, job_id, start_date, end_date
from job_history
where employee_id = 176;

-- 29. 우리 회사는 1년에 한 번 업무를 변경하여 전체적인 회사 업무를 사원들이 익히도록 하는 Role change 정책을 시행하고 있다. 
-- 	이번 인사이동 때 아직 업무가 변경된 적이 없는 사원들을 적합한 업무로 이동시키려고 한다. 
-- 	HR 부서의 사원정보 테이블과 업무이력정보 테이블을 이용하여 한 번도 업무가 변경되지 않은 사원의 사번을 출력하시오

-------------------------------------------
-- 조건부 논리 표현식 제어 : CASE

-- 30. HR 부서에서는 신규 프로젝트의 성공으로 해당하는 각 업무 자들에 대한 급여 인상안을 결정하고, 
-- 	다음과 같이 업무 별 급여 인상에 대해 적용하고자 한다.
-- 	현재 107명의 사원은 19개의 업무에 소속되어 근무 중이다(Distinct job_id). 
-- 	이 중 5개의 업무 자들에 대한 급여 인상이 각각 결정되었고, 나머지 업무에 대해서는 인상이 동결되었다. 
-- 	HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)

-- 31. HR 부서에서는 최상위 입사일에 해당하는 2001년부터 2003년까지 입사자들의 급여를 
-- 	각각 5%, 3%, 1% 인상하여 지분에 따른 배당금으로 지급하고자 한다. 
-- 	전체 사원들 중 해당 년도에 입사한 사원들의 급여를 검색하여 적용하고, 입사일자에 따른 오름차순 정렬을 수행하시오

-- 32. 부서별 급여 합계를 구하고, 그 결과를 가지고 다음과 같이 표현하시오.
-- 	
-- 	Sum Salary > 100000 이면, “Excellent"
-- 	Sum Salary > 50000 이면, “Good"
-- 	Sum Salary > 10000 이면, “Medium"
-- 	Sum Salary <= 10000 이면, “Well" 

select
	department_id,
    sum(salary),
    case
		when sum(salary) > 100000 then 'Excellent'
        when sum(salary) > 50000 then 'Good'
        when sum(salary) > 10000 then 'Medium'
        Else 'Well'
	end 'Evaluation'
from employees
group by department_id;