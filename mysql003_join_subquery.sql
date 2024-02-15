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


/*-----------------------------------------------------------------------------------------
서브쿼리(subquery)
 하나의 SQL문안에 포함되어 있는 또 다른 SQL문을 말한다.
 서브쿼리는 알려지지 않은 기준을 이용한 검색을 위해 사용한다.
 서브쿼리는 메인쿼리가 서브쿼리를 포함하는 종속적인 관계이다.
 서브쿼리는 메인쿼리의 컬럼을 모두 사용할 수 있지만 메인쿼리는 서브쿼리의 컬럼을 사용할 수 없다. 
 질의 결과에 서브쿼리 컬럼을 표시해야 한다면 조인방식으로 
    변환하거나 함수, 스칼라 서브쿼리(scarar subquery)등을 사용해야 한다. 
    정확한 값이 안주어졌을 때 사용
 조인은 집합간의 곱(Product)의 관계이다. 
 
외부 쿼리 (메인쿼리)
 :일반 쿼리를 의미합니다.
스칼라 서브쿼리
 :SELECT 절에 쿼리가 사용되는 경우로, 함수처럼 레코드당 정확히 하나의 값만을 반환하는 서브쿼리입니다.
인라인 뷰
 :FROM 절에 사용되는 쿼리로, 원하는 데이터를 조회하여 가상의 집합을 만들어 조인을 수행하거나 가상의 집합을 다시 조회할 때 사용합니다.



서브쿼리를 사용할 때 다음 사항에 주의
  서브쿼리를 괄호로 감싸서 사용한다. 
  서브쿼리는 단일 행(Single Row) 또는 복수 행(Multiple Row) 비교 연산자와 함께 사용 가능하다. 
  단일 행 비교 연산자는 서브쿼리의 결과가 반드시 1건 이하이어야 하고 복수 행 비교 연산자는 서브쿼리의 결과 건수와 상관 없다. 
  서브쿼리에서는 ORDER BY를 사용하지 못한다. 
  ORDER BY절은 SELECT절에서 오직 한 개만 올 수 있기 때문에 ORDER BY절은 메인쿼리의 마지막 문장에 위치해야 한다.
  

서브 쿼리 사용가능한 위치
SELECT, FROM, WHERE, HAVING,ORDER BY 
INSERT문의 VALUES,
UPDATE문의 SET, 
CREATE문

서브쿼리의 종류는 동작하는 방식이나 반환되는 데이터의 형태에 따라 분류할 수 있다.
1 동작하는 방식에 따른 서브쿼리 분류
  Un-Correlated(비연관) : 서브쿼리가 메인쿼리 컬럼을 가지고 있지 않는 형태의 서브쿼리이다.
          메인쿼리에 값(서브쿼리가 실행된 결과)를 제공하기 위한 목적으로  주로 사용한다.
  Correlated(연관) : 서브쿼리가 메인쿼리 칼럼을 가지고 있는 형태의 서브쿼리이다.
          일반적으로 메인쿼리가 먼저 수행되어 읽혀진 데이터를 서브쿼리에서 조건이 맞는지 확인
	  하고자 할 때 주로 사용된다.  (EXISTS서브쿼리는 항상 연관 서브쿼리로 사용된다. 조건을 만족하는 1건만 찾으면
	  추가 검색을 하지 않는다.)
2 반환되는 데이터의 형태에 따른 서브쿼리 종류
  Single Row(단일행 서브쿼리) : 서브쿼리의 실행결과가 항상 1건 이하인 서브쿼리를 의미한다. 
          단일행 서브쿼리는 단일 행 비교 연산자와 함께 사용된다.
	  단일 행 비교 연산자는 =, <, <=, >, >=, <>이 있다.
  Multi Row(다중행 서브쿼리) : 서브쿼리의 실행 결과가 여러 건인 서브쿼리를 의미한다. 
          다중 행 서브쿼리는 다중 행 비교 연산자와 함께 사용된다. 
	  다중 행 비교 연산자에는 in, all, any, some, exists가 있다.
	      in : 메인쿼리의 비교조건('='연산자로 비교할 경우)이 서브쿼리의 결과 중에서
               하나라도 일치하면 참이다.
           any,some : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 하나 이상이 일치하면
                참이다.
           all : 메인 쿼리의 비교 조건이 서브 쿼리의 검색 결과와 모든 값이 일치하면 참이다.
           exists : 메인 쿼리의 비교 조건이 서브 쿼리의 결과 중에서 만족하는 값이 하나라도
               존재하면 참이다.
  Multi Column(다중칼럼 서브쿼리) : 서브쿼리의 실행 결과로 여러 컬럼을 반환한다.
          메인쿼리의 조건절에 여러 컬럼을 동시에 비교할 수 있다. 
	  서브쿼리와 메인쿼리에서 비교하고자 하는 컬럼 갯수와 컬럼의 위치가 동일해야 한다.
--------------------------------------------------------------------------------- */ 
-- 90번 부서에 근무하는 Lex의 부서명을 출력하시오.
select department_name
from departments
where department_id = 90;

-- Lex가 근무하는 부서명을 출력하시오.
select department_id
from employees
where first_name = 'Lex';

select department_name
from departments
where department_id = 90;


select d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
where e.first_name = 'Lex';

select department_name
from departments
where department_id = (select department_id
                       from employees 
                       where first_name = 'Lex');
                       
-- 'Lex'와 동일한 업무(job_id)를 가진 사원의 이름(first_name), 
 -- 업무명(job_title), 입사일(hire_date)을 출력하시오.
 select e.first_name, j.job_title, e.hire_date
 from employees e inner join jobs j
 on e.job_id = j.job_id
 and e.job_id = (select job_id
				from employees
				where first_name = 'Lex'); -- 고유값이 저장돼 있는 컬럼은 뽑아오기 가능
                
--                 select job_id
-- 				from employees
-- 				where first_name = 'Lex';
-- select first_name
-- from employees
-- where job_id = 'AD_VP'; -- 확인용

-- 'IT'에 근무하는 사원이름(first_name), 부서번호을 출력하시오.
select first_name, department_id
from employees
where department_id = (select department_id
					   from departments
                       where department_name = 'IT');        
 
 -- 'Bruce'보다 급여를 많이 받은 사원이름(first_name), 부서명, 급여를 출력하시오.
 select e.first_name, d.department_name, e.salary
 from employees e inner join departments d
 on e.department_id = d.department_id
 where salary> (select salary
                from employees
				where first_name = 'Bruce')
order by salary;                

-- Steven와 같은 부서에서 근무하는 사원의 이름, 급여, 입사일을 출력하시오.(in)
select first_name, salary, hire_date
from employees
where department_id in (select department_id
                        from employees
					    where first_name = 'steven');
 
 -- 부서별로 가장 급여를 많이 받는 사원이름, 부서번호, 급여를 출력하시오.(in)
 select department_id, max(salary)
 from employees
 group by department_id;
 
 select first_name, department_id, salary
 from employees
 where (department_id, salary) in ( select department_id, max(salary) -- where 에는 그룹변수, 함수 사용 안된다.
										 from employees
										 group by department_id)
 order by department_id asc;
 
 -- 30소속된 사원들 중에서 급여를 가장 받은 사원보다 더 많은 급여를 받는
-- 사원이름, 급여, 입사일을 출력하시오. (ALL)
-- (서브쿼리에서 max()함수를 사용하지 않는다); all: and의 의미, max 사용법
select salary
from employees
where department_id = 30;

select first_name, salary, hire_date
from employees
where salary > all (select salary
				from employees
				where department_id = 30);
-- where salary > (select max(salary)
-- 				from employees
-- 				where department_id = 30); -- 이것도 가능하다.               

-- 30소속된 사원들이 받은 급여보다  높은 급여를 받는 
-- 사원이름, 급여, 입사일을 출력하시오. (ANY)
-- (서브쿼리에서 min()함수를 사용하지 않는다); any: or의 의미
select salary
from employees
where department_id = 30;

select first_name, salary, hire_date
from employees
where salary > any(select salary
					from employees
					where department_id = 30);
                    
-- 사원이 있는 부서만 출력하시오
select department_id, department_name
from departments;  /* 27 row*/

select distinct department_id -- distinct: 중복된 결과를 제거하고 가져오기, select에 붙여서 쓴다
from employees; /* 12 row*/

select department_id, department_name
from departments
where department_id in(select distinct department_id 
                       from employees); /* 11 row*/   
                       
/*-----------------------------------------------------
 상관관계 서브쿼리
 : 서브쿼리에서 메인쿼리의 컬럼을 참조한다.(메인쿼리를 먼저수행한다.)
   서브쿼리는 메인쿼리 각각의 행에 대해서 순서적으로 한번씩 실행한다.
 <아래 쿼리 처리순서>
 1st : 바깥쪽 쿼리의 첫째 row에 대하여 
 2nd : 안쪽 쿼리에서 자신의 속해있는 부서의 MAX salary과
       비교하여 true 이면 바깥의 컬럼값을 반환하고 , 
       false 이면 값을 버린다. 
 3rd : 바깥쪽 쿼리의 두 번째 row에 대하여 마찬가지로 실행하며, 
       이렇게 바깥쪽 쿼리의 마지막 row까지 실행한다. 
	   
https://www.w3resource.com/sql/subqueries/correlated-subqueries-using-aliases.php	   
----------------------------------------------------*/
-- 부서별 최고 급여를 받는 사원을 출력하시오.
select department_id, max(salary)
from employees
group by department_id;

select department_id, salary, first_name, hire_date
from employees
where (department_id, salary) in (select department_id, max(salary)
                                       from employees
										group by department_id);
                                        
select department_id, salary, first_name, hire_date
from employees e
where salary =(select max(salary)
               from employees
			   where department_id = e .department_id)
order by department_id                                ;

-- 사원이 있는 부서만 출력하시오.
select department_id, department_name
from departments d
where exists(select 1 -- exists: 서브쿼리 결과가 비어있는지 여부를 확인하는 조건 연산자.
             from employees e
             where e.department_id = d.department_id);
     
-- 사원이 없는 부서만 출력하시오.
select department_id, department_name
from departments d
where not exists(select 1
             from employees e
             where e.department_id = d.department_id);
             
-- 부서가 없는 사원의 정보을 출력하시오.
select e.employee_id, e.first_name, e.department_id
from employees e
where not exists(select 1
             from departments d
             where e.department_id = d.department_id);             

-- 관리자가 있는 사원의 정보를 출력하시오.
select e.employee_id, e.first_name, e.department_id, manager_id
from employees e
where exists(select 1
             from employees m
             where m.employee_id = e.manager_id);
             
-- 관리자가 없는 사원의 정보를 출력하시오.
select e.employee_id, e.first_name, e.department_id, manager_id
from employees e
where not exists(select 1
             from employees m
             where m.employee_id = e.manager_id);       
		
/*-----------------------------------------------------------
       문제
 -------------------------------------------------------------*/
-- 1) department_id가 60인 부서의 도시명을 알아내는 SELECT문장을 기술하시오
select city
from locations
where location_id = (select location_id
					 from departments
					 where department_id = 60);
                    
-- 2)사번이 107인 사원과 부서가같고,167번의 급여보다 많은 사원들의 사번,이름(first_name),급여를 출력하시오.
select employee_id, department_id
from employees
where employee_id = 107; -- 부서: 60

select employee_id, salary
from employees
where employee_id = 167; -- 급여: 6200

select employee_id, first_name, salary -- department_id
from employees
where department_id = (select department_id -- where에서 select 쓸 때 컬럼은 하나씩밖에 못가져온다.
						from employees
						where employee_id = 107)
and salary > (select salary
				from employees
				where employee_id = 167);                        


              
-- 3) 급여평균보다 급여를 적게받는 사원들중 커미션을 받는 사원들의 사번,이름(first_name),급여,커미션 퍼센트를 출력하시오.
 select avg(salary)
 from employees; -- 6461.831776
 
 select employee_id, first_name, salary, commission_pct
 from employees
 where salary < (select avg(salary)
				from employees) 
and commission_pct is not null
order by salary desc;
  
-- 4)각 부서의 최소급여가 20번 부서의 최소급여보다 많은 부서의 번호와 그부서의 최소급여를 출력하시오.
select department_id, min(salary)
from employees
group by department_id
order by min(salary) asc; -- 부서: 20, 최소급여: 6000

select department_id, min(salary)
from employees
group by department_id
having min(salary) > (select min(salary)
                      from employees
					  where department_id = 20)
order by min(salary) asc;                      
-- 5) 사원번호가 177인 사원과 담당 업무가 같은 사원의 사원이름(first_name)과 담당업무(job_id)하시오.   
select employee_id, first_name, job_id
from employees
where employee_id = 177; -- SA_REP

select first_name, job_id
from employees
where job_id = (select job_id
				from employees
				where employee_id = 177);
                
-- 6) 최소 급여를 받는 사원의 이름(first_name), 담당 업무(job_id) 및 급여(salary)를 표시하시오(그룹함수 사용).
select min(salary)
from employees;

select first_name, job_id, salary
from employees
where salary = (select min(salary)
				from employees);


-- 7) 각 부서의 최소 급여를 받는 사원의 이름(first_name), 급여(salary), 부서번호(department_id)를 표시하시오.
select department_id, min(salary)
from employees
group by department_id;

select first_name, salary, department_id
from employees
where (department_id, salary) in (select department_id, min(salary)
									from employees
									group by department_id);    

-- 8)담당 업무가 프로그래머(IT_PROG)인 모든 사원보다 급여가 적으면서 
-- 업무가 프로그래머(IT_PROG)가 아닌  사원들의 사원번호(employee_id), 이름(first_name), 
-- 담당 업무(job_id), 급여(salary))를 출력하시오.
select salary
from employees
where job_id = 'IT_PROG'
order by salary asc; -- 4200

select employee_id, first_name, job_id, salary
from employees
where salary < all (select salary
				from employees
				where job_id = 'IT_PROG');
-- and job_id <> 'IT_PROG';                
-- 9)부하직원이 없는 모든 사원의 이름을 표시하시오.
select first_name, employee_id, manager_id
from employees e
where exists(select 1
             from employees m
             where m.manager_id = e.employee_id);

select e.employee_id, e.first_name, e.employee_id, manager_id
from employees e
where exists(select 1
             from employees m
             where m.manager_id = e.employee_id);           
             
/*=============================
 WITH ROLLUP
 총합 또는 중간 합계가 필요할때 GROUP by 절과 함께 WITH ROLLUP문을 사용한다.
 ================================*/
 select department_id, job_id, count(*) as count
 from employees
 group by department_id, job_id with rollup
 order by department_id desc, job_id;
 
/*=================================================================================
 그룹내 순위관련함수
 RANK( ) OVER( ) : 특정 컬럼에 대한 순위를 구하는 함수로 동일한 값에 대해서는 동일한 순위를 준다. 
 DENSE_RANK( ) OVER( ) : 동일한 순위를 하나의 건수로 취급한다.
 ROW_NUMBER( ) OVER( ) : 동일한 값이라도 고유한 순위를 부여한다.
 ===================================================================================*/
 /* rank      dense_rank       row_numder
90  1             1              1
90  1             1              2
85  3             2              3
80  4             3              4
89 */

select job_id, first_name, salary, rank() over(order by salary desc)
from employees;

select job_id, first_name, salary, dense_rank() over(order by salary desc)
from employees; 

select job_id, first_name, salary, row_number()over(order by salary desc)
from employees;

select job_id, first_name, salary, row_number()over()
from employees
order by salart desc;

-- 그룹별로 순위를 부여할 때 사용: partition by
select job_id, first_name, salary, rank()over(order by salary desc)
from employees;

-- 그룹별로 순위를 부여할 때 사용: partition
select job_id, first_name, salary, rank()over(partition by job_id order by salary desc)
from employees;
-- 급여가 가장 높은 상위 3맹을 보나

select row_number() over () as rownum, first_name, salary
 from employees
 limit 3; -- 갯수

-- john 14000.00 
select row_number() over(order by salary desc)as rownum, first_name, salary
from employees
limit 3, 5;

select row_number() over(order by salary desc)as rownum, first_name, salary
from employees
limit 5 offset 3;

-- 월 별 입사자 수를 조회하되 입사자수가 가장 많은 상위 3개만 출력되도록 하시오.
--  <출력:   월     입사자수 >
select month(hire_date) as 월, count(*) as 입사자수     -- 교재 225페이지
from employees
group by month(hire_date)
order by count(*) desc
limit 3;

/* ================================================================================
with 절과 cte

with절은 cte(common table expression)을 표현하기 위한 구문으로 Mtsql8.0부터 사용할 수 있다.
cte는 기존의 뷰, 파생테이블, 임시 테이블 등으로 사용되던 것을 대신할 수 있다.
cte는 ANSI-SQL99 표준에서 나온 것이다. 기존의 SQL ANSI-SQL92를 기준으로 한다.
최근의 DBMS(database management system)은 대개 ANSI-SQL99와 호환되므로 다른 DBMS에서도 같거나
비슷한 방식으로 응용한다.
cte는 비재귀적(non-recursive) cte와 재귀적(recursive) cte 두 가지가 있다.

(비재귀적(non recursive) cte>
with 테이블이름(열이름)
as
(
 쿼리문;
)
select 열이름 from cte_테이블 이름;
===================================================================================*/
with abc(f, s)
as
(select first_name, salary 
from employees
where department_id = 90)

select f, s from abc;

/*=========================================
<재귀적(recursive)*/

-- 매니저 -> 사원
with recursive cte (employee_id, manager_id, level, first_name) as(
select employee_id, manager_id, 1, first_name
from employees
where manager_id is null
union all
select e.employee_id, e.manager_id, cte.level + 1, e.first_name
from employees e
inner join cte on e.manager_id = cte.employee_id
)
select employee_id, level, concat(repeat(' ', 3 * (level - 1)), first_name)as name
from cte
order by employee_id;

-- https://mariadb.com/kb/en/recursive-common-table-expressions-overview/

-- 사원 -> 메니저
with recursive cte (employee_id, manager_id, level, first_name) as(
select employee_id, manager_id, 1, first_name
from employees
where manager_id is null
union all
select e.employee_id, e.manager_id, cte.level + 1, e.first_name
from employees e
inner join cte on e.manager_id = cte.employee_id
)
select employee_id, level, concat(repeat(' ', 3 * (level - 1)), first_name)as name
from cte
order by employee_id;