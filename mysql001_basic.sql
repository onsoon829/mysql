/*
VARCHAR, TEXT타입의 데이터 대소문자 구문을 안한다.
대소문자를 구분하려면 VARBINARY타입을 사용해야 한다.
*/

-- SELECT 입력순서  -- 한 라인 주석 처리할 땐 --, 여러줄 주석 처리할 땐 /*~ */
/*
SELECT column_name, column_name, column_name
FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
ORDER BY column_name ASC(DESC);
*/

-- SELECT 해석순서
/*
FROM table_name
WHERE column_name='value'
GROUP BY column_name
HAVING column_name='value'
SELECT column_name, column_name, column_name
ORDER BY column_name ASC(DESC);
*/

-- employees테이블에서 salary가 3000미만일때
-- first_name, salary를 출력하라.
SELECT first_name, salary
from employees
where salary < 3000; -- 명령문 마무리할 땐 ;를 쓴다.

-- employees테이블에서 first_name컬럼의 값이 'David'일때
-- first_name, salary를 출력하라.
select first_name, salary
from employees
where first_name = 'David'; -- 문자열 표현할 때 ' '로 불러온다. 불러올 땐 문자 정확히 기입.


select first_name, salary
from employees
where first_name != 'David';-- !=: 같지 않다는 뜻


select first_name, salary 
from employees
where first_name <> 'David'; -- <>: 같지 않다는 뜻. !=와 의미가 같다.


-- &&(and), ||(or)
-- employees테이블에서 satary가 3000, 9000, 17000일때
-- first_name, hire_date, salary를 출력하라.
select first_name, hire_date, salary
from employees
where salary=3000 or salary=9000 or salary=17000; -- where: 조건문같은 건가?

select first_name, hire_date, salary
from employees
where salary in(3000,9000,17000); -- 불러오는 대상이 한 곳에서 나올 때 in 사용할 수 있다

-- employees테이블에서 satary가 3000이상 5000이하일때
-- first_name, hire_date, salary를 출력하라.
select first_name, hire_date, salary
from employees
where salary >= 3000 and salary <= 5000;


select first_name, hire_date, salary
from employees
where salary between 3000 and 5000; -- 비교대상의 값이 포함될 때 사용 가능?

-- employees테이블에서 joob)id가 'IT_PROG'이 아닐때
-- job_id를 출력하라
select first_name, hire_date, salary, job_id
from employees
where job_id != 'IT_PROG';

select first_name, hire_date, salary, job_id
from employees
where job_id <> 'IT_PROG';

select first_name, hire_date, salary, job_id
from employees
where job_id = 'IT_PROG';

select first_name, hire_date, salary, job_id
from employees
where not(job_id = 'IT_PROG'); -- !=, <>와 같은 의미이다.



-- employees테이블에서 salary이 3000, 9000, 17000아닐때
-- first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE not(salary=3000 OR salary=9000 OR salary=17000);

SELECT first_name, hire_date, salary
FROM employees
WHERE salary not IN(3000, 9000, 17000);

-- employees테이블에서 salary이 3000이상 5000이하가 아닐때
-- first_name, hire_date, salary을 출력하라.
SELECT first_name, hire_date, salary
FROM employees
WHERE not(salary >= 3000 AND salary <= 5000);

SELECT first_name, hire_date, salary
FROM employees
WHERE salary not BETWEEN 3000 AND 5000;

-- employees테이블에서 commission_pct이 null일때
-- first_name, salary, commission_pct를 출력하라
select first_name, salary, commission_pct
from employees
where commission_pct is null;

-- employees테이블에서 commission_pct이 null이 아닐때
-- first_name, salary, commission_pct를 출력하라
select first_name, salary, commission_pct
from employees
where commission_pct is not null;

-- employees테이블에서 first_name에 'der'이 포함될때
-- first_name, salary, email을 출력하라.
select first_name, salary, email
from employees
where first_name like '%der%'; -- like % %: ~포함이 된. %단어: 뒤에 단어가 포함된. 단어%: 앞에 단어가 포함된.

-- employees테이블에서 first_name의 값중 'A'로 시작하고
-- 두번째 문자는 임의의 문자이며 'exander'로 끝날때
-- first_name, salary, email을 출력하라.
select first_name, salary, email
from employees
where first_name like 'A_exander'; -- 임의문자 하나를 얘기할 때 언더바로 표시한다.

/*
 WHERE절에서 사용된 연산자 3가지 종류
 1 비교연산자 : = > >= < <= != <> 
 2 SQL연산자 : BETWEEN a AND b,  IN, LIKE, IS NULL
 3 논리연산자 : AND, OR, NOT
 
 우선순위
 1 괄호()
 2 NOT연산자
 3 비교연산자, SQL연산자
 4 AND
 5 OR
  */
  
-- employees테이블에서 job_id를 오름차순으로
-- first_name, email, job_id를 출력하라.
 select first_name, email, job_id
from employees 
order by job_id; -- 오름차순

select first_name, email, job_id
from employees 
order by job_id ASC; -- ASC: 오름차순

-- employees테이블에서 가장 최근 입사 순으로
-- first_name, salary, hire_date를 출력하시오.
select first_name, salary, hire_date
from employees
order by hire_date desc; -- desc: 내림차순

-- employees테이블에서 업무(job_id)이 'FI_ACCOUNT'인 사원들의 
-- 급여(salary)가 높은순으로 first_name, job_id, salary을 출력하시오.
select first_name, job_id, salary
from employees
where job_id = 'FI_ACCOUNT'
order by salary desc;

/* /////////////////////////////////////
////--문제--
////////////////////////////////////// */
-- 1) employees테이블에서 급여가 17000이하인 사원의 사원번호, 사원명(first_name), 급여를 출력하시오.
select employee_id, first_name, salary
from employees
where salary <= 17000;

-- 2) employees테이블에서 2005년 1월 1일 이후에 입사한 사원을 출력하시오.
select * -- *: 모든 컬럼을 가져와라
from employees
where hire_date >= '2005-01-01';

-- 3) employees테이블에서 급여가 5000이상이고 업무(job_id)이 'IT_PROG'이 사원의 사원명(first_name), 급여, 
--   업무을 출력하시오.
 select first_name, salary, job_id
 from employees
 where salary >= 5000 and job_id = 'IT_PROG';

-- 4) employees테이블에서 부서번호가 10, 40, 50 인 사원의 사원명(first_name), 부서번호, 이메일(email)을 출력하시오.
 select first_name, phone_number, email
 from employees
 where department_id = 10 or department_id = 40 or department_id = 50;
-- where department_id in(10, 40, 50)

-- 5) employees테이블에서 사원명(first_name)이 even이 포함된 사원명, 급여, 입사일을 출력하시오.
 select first_name, salary, hire_date
 from employees
 where first_name like '%even%'; -- 문자일 때만 like 사용 가능

-- 6) employees테이블에서 사원명(first_name)이 teve앞뒤에 문자가 하나씩 있는 사원명, 급여, 입사일을 출력하시오.
 select first_name, salary, hire_date
 from employees
 where first_name like '_teve_';

-- 7) employees테이블에서 급여가 17000이하이고 커미션이 null이 아닐때의 사원명(first_name), 급여, 
--  커미션을 출력하시오.
  select first_name, salary, commission_pct
  from employees
  where salary <= 17000 and commission_pct != 'null';
  
-- 8) 2005년도에 입사한 사원의 사원명(first_name),입사일을 출력하시오.
 select first_name, hire_date
 from employees
 where hire_date >= '2005-01-01'  or hire_date <='2005-12-31';

-- 9) 커미션 지급 대상인 사원의 사원명(first_name), 커미션을 출력하시오.
 select first_name, commission_pct
 from employees
 where commission_pct != 'null';

-- 10) 사번이 206인 사원의 이름(first_name)과 급여를 출력하시오.
 select first_name, salary
 from employees
 where job_id = '206';

-- 11) 급여가 3000이 넘는 업무(job_id),급여(salary)를 출력하시오.
 select job_id, salary
 from employees
 where salary > 3000;

-- 12)'ST_MAN'업무을 제외한 사원들의 사원명(first_name)과 업무(job_id)을 출력하시오.
-- !=, <>,  not
  



-- 13) 업무이 'PU_CLERK' 인 사원 중에서 급여가 2800 이상인 사원명(first_name),업무(job_id),급여(salary)을 출력하시오.
select first_name, job_id, salary
from employees
where job_id = 'PU_CLERK' and salary >= 2800;

-- 14) commission을 받는 사원명(first_name)을 출력하시오.


-- 15) 20번 부서와 30번 부서에 속한 사원의 사원명(fist_name), 부서를 출력하시오.
select first_name, department_id
from employees
where department_id = 20 and department_id = 30;
   

 
-- 16) 급여가 많은 사원부터 출력하되 급여가 같은 경우 사원명(first_name) 순서대로 출력하시오.
select first_name, salary
from employees
order by salary desc;

-- 17) 업무이 'MAN' 끝나는 사원의 사원명(first_name), 급여(salary), 업무(job_id)을 출력하시오.
