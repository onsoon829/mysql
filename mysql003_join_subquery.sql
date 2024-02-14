/*=======================================================
join : 여러개의 테이블에서 원하는 테이블을 추출해주는 쿼리문이다.
모든 제품에서 공통적으로 사용되는 표준(ANSI) join이 있다.
========================================================*/
-- inner join
-- outer join?
-- carteian product(카티션 곱) 조인:
-- 테이블 행의 갯수만큼 출력해주는 조인이다.

select count(*) from employees; -- 107
select count(*)  departements; -- 27
select 107 * 27; -- 2889

select d.department_id, d.department_name, e.first_name
from employees e cross join departments d;

/*
 2. inner join
    가장 많이 사용되는 조인방법으로 조인 대상이 되는 두 테이블에서 공통적으로 존재하는 컬럼의 값이
    일치되는 행을 연결하여 결과를 생성하는 방법이다.
 */
 
 select e.department_id, e.first_name,  e.job_id, j.job_title
 from employees e inner join jobs j
 on e.job_id = j.job_id;
 
 select count(job_id)from employees;
 
 select e.department_id, e.first_name, d.department_name
 from employees e inner join departments d
 on e.department_id = d.department_id;
 
 select count(department_id) from employees;
 
  select e.department_id, e.first_name,  e.job_id, j.job_title
 from employees e, jobs j
 where e.job_id = j.job_id;
 
 -- employees와 departments테이블에서 사원번호(employee_id),
-- 부서번호(department_id), 부서명(department_name)을 검색하시오.
select e.employee_id, d.department_id, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id;
-- 위 아래 결과값이 똑같다.
select e.employee_id, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id;

-- employees와 jobs테이블에서 사원번호(employee_id),
-- 업무번호(job_id), 업무명(job_title)을 검색하시오.
select e.employee_id, j.job_id, j.job_title
from employees e inner join jobs j
on e.job_id = j.job_id;

-- job_id가 'FI_MGR'인 사원이 속한
 -- 급여(salary)의 최소값(min_salary), 최대값(max_salary)을 출력하시오.
 select e.salary, j.min_salary, j.max_salary
 from employees e inner join jobs j
 on e.job_id = j.job_id
 where j.job_id = 'FI_MGR';
 
 select e.salary, j.min_salary, j.max_salary
 from employees e inner join jobs j
 where e.job_id = j.job_id
 and j.job_id = 'FI_MGR';
 
 -- 부서가 'Seattle'에 있는 부서에서 근무하는
-- 직원들의  first_name, hire_date, department_name, city
-- 출력하는 SELECT을 작성하시오.
select e.first_name, e.hire_date, d.department_name,l.city
from employees e inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
where l.city = 'Seattle'; -- 건너건너 연결

select e.first_name, e.hire_date, d.department_name,l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city = 'Seattle'; -- 일단 뭔 소린지는 알겠다 

-- 20번 부서의 이름과 그 부서에 근무하는 사원의 이름(first_name)을 출력하시오.
select d.department_name, e.first_name
from departments d inner join employees e
on d.department_id = e.department_id
where d.department_id = 20;

-- 1400, 1500번 위치의 도시이름과 그 곳에 있는 부서의 이름을 출력하시오.
select l.city, d.department_name
from locations l inner join departments d
on l.location_id = d.location_id
where d.location_id in(1400, 1500);

/*=================================================================
3. outer join
  한 테이블에는 데이터가 있고 다른 반대쪽에는 데이터가 없는 경우에
  데이터가 있는 테이블의 내용을 모두 가져오는 조건이다.
  ===============================================================*/
select*
from employees e left outer join departments d
on e.department_id = d.department_id;

select e.first_name, e.salary, d.department_name
from employees e left outer join departments d -- 부서가 배정돼있지 않은 사원 정보도 가져와라.
on e.department_id = d.department_id;

select e.first_name, e.salary, d.department_name
from employees e right outer join departments d -- 부서가 배정돼있지 않은 사원 정보도 가져와라.
on e.department_id = d.department_id;

select e.first_name, e.salary, d.department_name
from employees e full outer join departments d -- 오류 뜬다.
on e.department_id = d.department_id;

/*=================================================
4. self join
 하나의 테이블을 두개의 테이블로 설정해서 사용하는 조인방법이다.
 하나의 테이블에 같은데이터가 두개의 컬럼에 다른 목적으로 저장되여 있는 경우
 employees, employee_id, manager_id
====================================================*/

-- 사원번호   사원명     관리자번호
-- 10       홍길동     null
-- 20       임꺽정      10
-- 30       고길동      10
-- 40       이옥순      20 

select employee_id, first_name, manager_id
from employees
where employee_id = 200;

select employee_id, first_name, manager_id
from employees
where employes_id = 108;

select employee_id, first_name, manager_id
from employees
where employes_id = 101;

select employee_id, first_name, manager_id, m.first_name
from employees m inner join employees m
where e.employee_id = 108;
/*
select employee_id as 사원번호, first_name as 사원명, manager_id as  관리자번호, m.first_name as 관리자명
from employees m inner join employees m
on e.manager_id = m.employee_id
where e.employee_id = 108;
*/


/*------------------------------------------------------
 4. Nature Join
 반드시 두 테이블 간의 동일한 이름, 타입을 가진 컬럼이 필요하다.
조인에 이용되는 컬럼은 명시하지 않아도 자동으로 조인해 사용된다.
동일한 이름을 갖는 컬럼이 있지만 데이터 타입이 다르면 에러가 발생한다.
조인하는 테이블 간의 동일 컬럼이 SELECT절에 기술되도 테이블 이름을 생략해야 한다.
--------------------------------------------------------*/
-- 두 테이블에서 일치하는 컬럼이 하나이므로 정상적으로 처리를 한다. - 107
select e.first_name, j.job_id, j.job_title
from employees e natural join jobs j;

-- 두 테이블에서 일치하는 컬럼이 두개이므로 비정상적으로 처리를 한다. - 32
select e.first_name, d.department_id, d.department_name 
from employees e natural join departments d;

-- 두 테이블 컬럼명이 같으면 using을 이용해서 사옹할 수도 있다. but 권장은 하지 않는다.
select e.first_name, d.department_id, d.department_name 
from employees e inner join departments d
-- on e.department_id = d.department_id;
using(department_id);

/*----------------------------------------------
 문제
 ----------------------------------------------   */
-- 1) EMPLOYEES 테이블에서 입사한 달(hire_date) 별로 인원수를 조회하시오 . 
--  <출력: 월        직원수   >
 select sum(month(hire_date)= 1) AS '1월',
		sum(month(hire_date)= 2) AS '2월',
        sum(month(hire_date)= 3) AS '3월',
        sum(month(hire_date)= 4) AS '4월',
        sum(month(hire_date)= 5) AS '5월',
        sum(month(hire_date)= 6) AS '6월',
        sum(month(hire_date)= 7) AS '7월',
        sum(month(hire_date)= 8) AS '8월',
        sum(month(hire_date)= 9) AS '9월',
        sum(month(hire_date)= 10) AS '10월',
        sum(month(hire_date)= 11) AS '11월',
        sum(month(hire_date)= 12) AS '12월'
	from employees;

select month(hire_date) as 월, count(*) as 직원수
from employees
group by month(hire_date)
order by month(hire_date);

select date_format(hire_date, '%m') as 월, count(*) as 직원수
 from employees
 group by date_format(hire_date, '%m')
 order by date_format(hire_date, '%m');

 -- 2)각 부서에서 근무하는 직원수를 조회하는 SQL 명령어를 작성하시오. 
-- 단, 직원수가 5명 이하인 부서 정보만 출력되어야 하며 부서정보가 없는 직원이 있다면 
-- 부서명에 “<미배치인원>” 이라는 문자가 출력되도록 하시오. 
-- 그리고 출력결과는 직원수가 많은 부서먼저 출력되어야 합니다.
 select ifnull(d.department_name, '<미배치인원>') as 부서명, count(*) as 직원수
 from employees e left join departments d
 on e.department_id = d.department_id
 group by d.department_name
 having count(*) <= 5;
 

-- 3)각 부서 이름 별로 2005년 이전에 입사한 직원들의 인원수를 조회하시오.
-- <출력 :    부서명		입사년도	인원수  >
select year(hire_date), count(*)
from employees
where year(hire_date) <= 2005
group by year(hire_date);

 select d.department_name as 부서명, year(e.hire_date) as 입사년도, count(*) as 인원수
 from employees e inner join departments d
 on e.department_id = d.department_id
 where year(e.hire_date) <= 2005
 group by d.department_name, year(e.hire_date);
 
 
-- 4)직책(job_title)에서 'Manager'가 포함이된 사원의 이름(first_name), 직책(job_title),
--  부서명(department_name)을 조회하시오.
 select j.job_title, e.first_name, j.job_title, d.department_name
 from jobs j, employees e, departments d
 where j.job_title = 'Manager';
 
 select e.first_name, j.job_title, d.department_name
 from employees e inner join jobs j on e.job_id = j.job_id
                  inner join departments d on e.department_id = d.department_id
 where j.job_title like '%Manager%';      
 
-- 5)'Executive' 부서에 속에 있는 직원들의 관리자 이름을 조회하시오. 
-- 단, 관리자가 없는 직원이 있다면 그 직원 정보도 출력결과에 포함시켜야 합니다.
-- <출력 : 부서번호 직원명  관리자명  >
select d.department_id, e.first_name, e.manager_id
from departments d inner join employees e
group by department_id;

-- where department_id = 'Executive';
-- self join 이용
select e.department_id, e.first_name, m.first_name, d.department_name
from employees e left join employees m on e.manager_id = m.employee_id
			     inner join departments d on e.department_id = d.department_id
where d.department_name like '%Executive%';                 


