/*=====================================================
SQL(structured query language)함수
1. 단일행함수 : 행 하나당 하나의 결과를 출력한다
              (문자함수, 숫자함수, 날짜함수, 변환함수, 일반함수)
2. 복수행함수 : 행 여러개당 하나의 결과를 출력한다
               (합계, 평균, 최대, 최소, 갯수)  
======================================================*/

SELECT 3 + 1;
SELECT 3+1;

SELECT sysdate(), now();


/*
데이터 형식 변환함수 : cast()와 convert()는 형식만 다를뿐 거의 비슷하다.
cast(expression AS 데이터형식 [(길이)])
convert( expression, 데이터형식 [(길이)])
데이터 형식 중에서 가능한 것은 binary, char, date, datetime, decimal, json, 
signed integer, time, unsigned integer등이다.
*/

SELECT cast('253' AS UNSIGNED INTEGER) + cast('12' AS UNSIGNED INTEGER); -- 265
SELECT convert('253', UNSIGNED INTEGER) + convert('12', UNSIGNED INTEGER); -- 265
SELECT concat(cast(253 AS char(3)), cast(12 AS char(3))); -- 25312
SELECT cast('2024/02/13' AS date); -- 2024-02-13
SELECT cast('2024$02$13' AS date); -- 2024-02-13
SELECT cast('2024%02%13' AS date); -- 2024-02-13

-- cast()나 convert()함수를 사용하지 않고도 형이 변환되는 경우
SELECT '100'+'200'; -- 300
SELECT concat('100', '200'); -- 100200
SELECT concat(100, '200'); -- 100200
SELECT concat('100', '200'); -- 100200
SELECT 1 > '2mega'; -- 정수인 2로 변환해서 비교한 결과 0을 리턴
SELECT 3 > '2mega'; -- 정수인 2로 변환해서 비교한 결과 1을 리턴
SELECT 0 = 'mega2'; -- 문자는 0으로 변환되어 비교한 결과 1을 리턴


/*-----------------------------------
문자함수
https://dev.mysql.com/doc/refman/8.0/en/string-functions.html
-------------------------------------*/
-- 모든 문자를 대문자로 변경해주는 함수이다.
SELECT upper('korea');  -- KOREA
SELECT ucase('korea');  -- KOREA

SELECT first_name, upper(first_name), last_name, upper(last_name)
from employees; 

-- 모든 문자를 소문자로 변경해주는 함수이다.
SELECT lower('KOREA');  -- korea
SELECT lcase('KOREA'); -- korea

SELECT first_name, lower(first_name), last_name, lower(last_name)
from employees;

-- employees테이블 first_name에서 대소문자 구분없이
-- 'Ja'가 포함이 된 first_name, salary를 출력하라.
SELECT first_name, salary
from employees 
where upper(first_name) like upper('%Ja%');

-- 문자의 길이를 리턴해주는 함수이다.
SELECT bit_length('korea'); -- 40(bit)
SELECT char_length('korea');  -- 5 글자길이
SELECT length('korea'); -- 5(byte) 


SELECT char_length('한국'); -- 2
SELECT length('한국'); -- 6(byte)
SELECT bit_length('한국'); -- 48(bit)

CREATE TABLE user1( -- table 만들기
   nation varchar(5)
);

select nation, CHAR_LENGTH(nation), length(nation)
from user1;

insert into user1(nation)
values('korea');

select nation, CHAR_LENGTH(nation), length(nation)
from user1;

insert into user1(nation) -- table에 내용 넣기
values('대한민국');

select nation, CHAR_LENGTH(nation), length(nation)
from user1;

-- Error Code: 1406. Data too long for column 'nation' at row 1	0
insert into user1(nation)
values('south korea'); -- varchar(5)를 넘어가는 글자는 들어가지 않는다(위에 그리 설정해놨다)

-- 특정문자의 인덱스를 추출해주는 함수이다.
select instr('korea', 'or'); -- 2 -- 인덱스 셀 떄는 1부터 시작한다.
select instr('한국자바', '자바'); -- 3

-- 주어진 문자열에서 왼쪽으로  특정문자를 채우는 함수이다.
select lpad('korea', 8, '*'); -- ***korea --lpad: left에 뭘 붙여라

-- 주어진 문자열에서 오른쪽으로  특정문자를 채우는 함수이다.
select rpad('korea', 8, '*'); -- korea*** -- rpad: right에 뭘 붙여라.

-- 주어진 문자열에서 왼쪽의 특정문자를 삭제하는 함수이다.
select ltrim('korea'); -- korea

-- 주어진 문자열에서 오른쪽의 특정문자를 삭제하는 함수이다.
select rtrim('korea'); -- korea

-- 주어진 문자열에서 양쪽 특정문자를 삭제하는 함수이다.
select length(trim('  korea  ')); -- 5

select trim(leading '*' from'**korea**'); -- korea** -- leading: 왼쪽만 지우기
select trim(trailing '*' from'**korea**'); -- **korea -- trailing: 오른쪽만 지우기
select trim(both '*' from'**korea**'); -- korea -- both: 양쪽 다 지우기

-- 주어진 문자열에서 왼쪽의 공백제거
-- '     korea', '10', 'korea', '5'
SELECT '     korea', length('     korea'), ltrim('     korea'), length(ltrim('     korea'));


-- 주어진 문자열에서 오른쪽의 공백제거
-- 'korea     ', '10', 'korea', '5'
SELECT 'korea     ', length('korea     '), rtrim('korea     '), length(rtrim('korea     '));

-- 주어진 문자열에서 양쪽의 공백제거
-- 'korea', '5'
SELECT trim(' ' from '  korea  '), length(trim(' ' from '  korea  '));

-- 주어진 문자의 아스키 코드값을 구하는 함수이다.
select ascii('A'); -- 65

-- 주어진 아스키 코드값의 문자를 구하는 함수이다.
select char(65); -- A

-- 주어진 문자를 연결하는 함수이다.
-- concat(문자열1, 문자열2,...)
select concat('java', 'jsp'); -- javajsp

-- concat_ws(구분자, 문자열1, 문자열2,..)
select concat_ws('/', '2024', '01', '01'); -- 2024/01/01

-- 위치 번재에 해당하는 문자여 반환
-- elt(위치, 문자열1, 문자열2,...)
select elt(2, '하나', '둘', '셋'); -- 둘

-- 찾을 문자열의 위치를 찾아서 반환하고 매치되는 문자열이 없으면 0을 반환
-- field(찾을 문자열, 문자열1, 문자열2,...)
select field('둘', '하나', '둘', '셋'); -- 2

-- 문자열을 문자열 리스트에서 찾아서 위치를 반환하면 문자열 리스트는 콤마(,)로 구분되어야 하고 공백이 없어야 한다.
-- find_in_set(찾을 문자열, 문자열 리스트)
select find_in_set('둘', '하나,둘,셋'); -- 2

-- 기준 문자열에서 부분 문자열을 찾아서 그 시작위치를 반환
-- instr(기준 문자열, 부분 문자열)
select instr('하나둘셋', '둘'); -- 3

-- locate( )은 instr() 와 동일하지만 파라미터의 순서가 반대이다.
-- locate(부분 문자열, 기준 문자열)
select locate('둘', '하나둘셋'); -- 3

-- 숫자를 소수점 아래 자릿수까지 표현한다. 또한 1000단위마다 콤마(,)를 표시해 준다.
-- format(숫자, 소수점 자릿수)
select format(1253.535, 2); -- 1,253,54
select format(1253.535, 0); -- 1,254
select format(1253.535, -1); -- 마이너스는 사용 안함 

-- 2진수, 16진수, 8진수의 값을 반환
-- bin(숫자)., hex(숫자), oct(숫자)
select bin(31), hex(31), oct(31); -- 11111, 1F, 37

-- 기준 문자열의 위치부터 길이만큼을 지우고 삽입할 문자열을 끼워 넣는다.
-- insert(기준 문자열, 위치, 길이, 삽입할 문자열)
select insert('abcdefghi', 3, 4, '@@@@'); -- ab@@@@ghi;
select insert('abcdefghi', 3, 2, '@@@@'); -- ab@@@@efghi

-- 왼쪽 또는 오른쪽에서 문자열의 길이만큼 반환한다.
-- left(문자열, 길이), right(문자열, 길이)
select left('abcdefghi', 3), right('abcdefghi', 3); -- abc  ghi

-- 문자열의 횟수만큼 반복한다
-- repeat(문자열, 횟수)
select repeat('korea', '2'); -- koreakorea

-- 문자열에서 원래 문자열을 찾아서 바꿀 문자열로 바꾼다.
-- replace(문자열, 원래문자열, 바꿀 문자열)
select replace('database mysql', 'database', '데이터베이스'); -- 데이터베이스 mysql

-- 문자열의 순서를 거꾸로 만든다.
-- reverse(문자열)
select reverse('mysql'); -- lqsym 그렇군

-- 길이만큼의 공백을 반환한다.
-- space(길이)
select concat('database', space(3), 'Mysql'); -- database Mysql

-- 특정범위의 문자를 추출해 주는 함수이다.
-- substr('문자', 시작위치, 갯수)
-- substr = substring = mid
SELECT substr('oracle test', 1, 4);     -- orac 
SELECT substring('oracle test', 1, 4);  -- orac 
SELECT mid('oracle test', 1, 4);        -- orac

SELECT substr('oracle test', -3, 4);   -- est

SELECT substr('오라클 테스트', 3, 4);  -- 클 테스

SELECT substr('오라클 테스트', -3, 4);  -- 테스트 

-- 문자열에서 구분자가 왼쪽부터 횟수 번째 나오면 그 이휴의 오른쪽은 버린다. 횟수가 음수면 오른쪽부터 세고 왼쪽을 버린다.
--  substring_index(문자열, 구분자, 횟수)
select substring_index('cafe.naver.com', '.', 2); -- cafe.naver
select substring_index('cafe.naver.com', '.', -2); -- naver.com 

/*----------------------------
https://dev.mysql.com/doc/refman/8.0/en/numeric-functions.html
 숫자함수
-------------------------------*/
-- 3.55을 소수점 1의 자리까지 구하시오(반올림)
select round(3.55, 1); -- 3.6
select round(42523.55, -1); -- 42520
select round(42523.55, 0); -- 42524

-- ceil = ceiling
-- 256.78을 무조건 올림한다.(올림)
select ceil(256.78); -- 257
select ceiling(256.78); -- 257

-- 289.78에서 소수이하는 무조건 버린다(버림)
select floor(289.78); -- 289

-- 2의 3제곱(거듭제곱)
select power(2,3); -- 8

-- 25의 제곱근
select sqrt(25); -- 

-- 숫자를 원래 진수에서 변환할 진수로 계산한다.
-- conv(숫자, 원래 진수, 변환할 진수)
select conv('AA', 16, 2), conv(100, 10, 8); -- 10101010 144

-- mod(숫자1, 숫자2): 숫자1을 숫자2로 나눈 나머지
-- mod(숫자1, 숫자2) = 숫자1 % 숫자2 = 숫자1 mod 숫자2
select mod(16, 5), 16%5, 16 mod 5; -- 1 1 1

-- rand()는 0이상 1미만의 실수를 구한다.
-- 만약 'm <= 임의의 정수 < n'을 구하고 싶다면 floor(m+(rand() * (n-m))을 사용한다.
select rand();
select floor(1 + rand() * (7-1)); -- 1 이상 7 미만의 정수를 찾아라.alter

-- pi() 원주율
select PI(); -- 3.141593

-- 숫자가 양수, 0, 음수인지를 구한다. 결과는 1, 0, -1 셋중에 하나를 반환한다.
-- sign(숫자)
select sign(10), sign(0), sign(-10); -- 1 0 -1

-- 숫자를 소수점을 기준으로 정수 위치까지 구하고 나머지는 버린다.
-- truncate(숫자, 정수)
select truncate(12345.52545, 2), truncate(12345.52345, -2); -- '12345.52', '12300'

/*---------------------------
https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html
날짜함수
------------------------------*/

-- 현재 시스템에서 제공해주는 오늘의 날짜 구하는 함수
-- 2024-02-13 17:20:44	2024-02-13 17:20:44	2024-02-13	17:20:44
select sysdate(), now(), curdate(), curtime();

-- 2024-02-13	17:38:15	17:38:15
select curdate(), current_time(), current_time();

-- 2024-02-13 17:41:17	2024-02-13 17:41:17	2024-02-13 17:41:17	2024-02-13 17:41:17	2024-02-13 17:41:17
select now(), localtime, localtime(), localtimestamp, localtimestamp();

-- 날짜를 기준으로 차이를 더하거나 뺀 날짜를 구한다
-- adddate(날짜, 차이), subdate(날짜, 차이)
select adddate('2024-03-01', interval 31 day); -- 2024-04-01
select adddate('2024-03-01', interval 1 month); -- 2024-04-01

select subdate('2024-04-01', interval 31 day); -- 2024-03-01
select subdate('2024-04-01', interval 1 month); -- 2024-03-01

-- 날짜/시간을 기준으로 더하거나 뺀 결과를 구한다.
-- addtime(날짜/시간, 시간), subtime(날짜/시간, 시간)
select addtime('2024-04-01 10:10:10', '1:1:1'); -- 2024-04-01 11:11:11
select addtime('10:10:10', '1:1:1'); -- 11:11:11

select subtime('2024-04-01 11:11:11', '1:1:1'); -- 2024-04-01 10:10:10
select subtime('11:11:11', '1:1:1'); -- 10:10:10

-- 날짜 또는 시간에서 연, 월, 일ㅇ, 시, 분, 초, 밀리초를 구한다.
-- year(날짜), month(날짜), day(날짜)
-- hour(시간), minute(시간), second(시간), microsecond(시간)
-- day() = dayofmonth()
select year(curdate()), month(curdate()), day(curdate()); -- 2024	2	13
select hour(curtime()), minute(curtime()), second(curtime()), microsecond(curtime()); -- 17	55	43	0

-- 날짜와 시간을 구한다.
-- date(), time()
select date(now()), time(now()); -- 2024-02-13	17:57:47

-- 날짜와 시간 차이를 구할때 사용한다.
-- datediff(날짜1, 날짜2), timediff(날짜1 또는 시간1, 날짜2 또는 시간2)
--  날짜1에서 날짜2을 뺀다.
SELECT datediff('2024-03-02', '2024-03-01');  -- 1
SELECT TIMEDIFF('10:10:10', '10:10:9');  -- 00:00:01

-- 현재 요일과 월이름 그리고 일년 중 몇 일이 지났는지를 반환한다.
-- dayofweek(날짜), monthname(날짜), dayofyear(날짜)
-- 요일(1:일, 2:월 ~ 7:토)
-- 3	February	44
SELECT dayofweek(curdate()), monthname(curdate()), dayofyear(curdate());
select substr(_utf8'일월화수목금토', dayofweek(curdate()), 1); -- 화

-- 주어진 날짜의 마지막 날짜를 구한다. 즉 월의 마지막일이다.
-- last_day(날짜)
SELECT last_day(curdate());  -- 2024-02-29

-- 연도에서 정수만큼 지난 날짜를 구한다.
-- makedate(연도, 정수)
SELECT makedate(2024, 10);  -- 2024-01-10

-- 시,분,초를 이용해서 '시:분:초'의  Time형식을 만든다.
-- maketime(10,15,1)
SELECT maketime(10,15,1);  -- 10:15:01

-- period_add() 는 연월에서 개월만큼의 개월이 지난 연월을 구한다.
-- 연월은 YYYY 또는 YYYYMM 형식을 사용한다.
-- period_diff( )는 연월1-연월2의 개월수를 구한다.
SELECT period_add(202401, 11), period_diff(202401, 202312); -- 202412	1

-- 날짜가 4분기 중에서 몇 분기인지를 구한다.
-- quarter(날짜)
SELECT quarter(curdate());  --  1

-- 시간을 초 단위로 구한다.
-- time_to_sec(시간)
SELECT time_to_sec('0:1:10');  -- 70

-- =======================================
-- 특수 변환 작업
-- =======================================

-- 1. 숫자 -> 문자
-- 첫번째 인자값을 두번째 인자값의 형식으로 변환해주는 함수
select format(2532, 2); -- 2,532.00

select lpad(format(2532, 2), 10, '0'); -- 002,532.00

-- 통화 기호를 붙인다.
select concat('￦', format(2532, 2)); -- $2,532.00

 -- 2. 날짜 -> 문자
 select date_format(now(), '%y-%m-%d %h:%i:%s %W'); -- 24-02-14 09:41:05 Wednesday
 select date_format(now(), '%y-%m-%d %H:%i:%s %a'); -- 24-02-14 09:41:14 Wed
 
 -- 3. 문자 -> 날짜
 -- str_to_date(문자열, format)
 select str_to_date('05/09/28', '%m/%d/%y'); -- 2028-05-09
 
 -- --------------------------------
 select first_name, hire_date
 from employees;
 
 -- hire_date(입사일)을 이용해서
 -- '홍길동님은 2003년 1월 3일에 입사했습니다 로 
 -- 출력하는 quary를 작성하시오.
select concat(first_name, '님은', date_format(hire_date, '%y년 %c월 %e일에 입사했습니다'))
from employees;

/*====================================================================
일반함수
ifnull(컬럼, 대체값) : 첫번째 인자값이 null이면 0으로 대체해서 출력한다. 
if(컬럼, 대체1, 대체2) : 컬럼의 값이 null아니면 대체1로, null이면 대체2로 출력한다. 
nullif(표현식1, 표현식2 ) : 표현식1과 표현식2가 같으면 NULL, 다르면 표현식1로 출력한다.

--대체할 값이 숫자이면 두번째 인자값에 숫자를 지정한다.
--대체할 값이 문자이면 두번째 인자값에 문자를 지정한다.
--대체할 값이 날짜이면 두번째 인자값에 날짜를 지정한다. 
=======================================================================*/
select commission_pct, ifnull(commission_pct, 0)
from employees;

select first_name, manager_id, ifnull(cast(manager_id AS char(3)), 'CEO')
from employees;

select commission_pct, if(commission_pct, 1, 0)
from employees;

select commission_pct, nullif(commission_pct , 0.4)
from employees;

/*================================
case when 조건1 then 결과1
     when 조건2 then 결과2
     when 조건3 then 결과3
     else 결과n
end AS alias;
자바에서 if-else와 비슷한 의미
==================================*/
-- department_id이 10이면 'ACCOUNTING', 20이면 'RESEARCH', 
--                30이면 'SALES', 40이면 'OPERATIONS', 'OTHERS'

select first_name, department_id, 
                   case department_id
                     when 10 then 'ACCOUNTING'
                     when 20 then 'research'
                     when 30 then 'sales'
                     when 40 then 'operations'
                     else 'OTHERS'
                   end as 'deptname'
from employees;

-- 입사일을 이용해서 한글로 요일을 출력하시오.
select first_name, hire_date,
      case dayofweek(hire_date)
          when 1 then '일'
          when 2 then '월'
          when 3 then '화'
          when 4 then '수'
          when 5 then '목'
          when 6 then '금'
          when 7 then '토'
      end as '요일'
from employees;

-- 직급이 'PR_REP' 인 사원은 5%, 'SA_MAN'인 사원은 10%, 
-- 'AC_MGR'인 사원은 15%, 'PU_CLERK' 인 사원은 20% 를 인상 
SELECT job_id, salary,
       CASE job_id
           WHEN 'PR_REP' THEN salary * 1.05
           WHEN 'SA_MAN' THEN salary * 1.1
           WHEN 'AC_MGR' THEN salary * 1.15
           WHEN 'PU_CLERK' THEN salary * 1.2
           ELSE salary
       END AS newsal
FROM employees;

-- 입사일에서 월이 1-3이면 '1사분기', 4-6이면 '2사분기', 
--              7-9이면 '3사분기', 10-12이면 '4사분기'
-- 로 처리를 하고 사원명(first_name), 
-- 입사일(hire_date), 분기로 출력하시오.

SELECT first_name, hire_date,
       CASE
           WHEN MONTH(hire_date) <= 3 THEN '1사분기'
           WHEN MONTH(hire_date) <= 6 THEN '2사분기'
           WHEN MONTH(hire_date) <= 9 THEN '3사분기'
		   WHEN MONTH(hire_date) <= 12 THEN '4사분기'
           ELSE '분기'
       END AS '분기'
FROM employees;

/*=================================================
집계함수(Aggregate Function), 그룹함수(Group Function)
===================================================*/
-- max(컬럼): 최대값
select max(salary)
from employees;

-- min(컬럼): 최소값
select min(salary)
from employees;

-- count(컬럼): 개수
select count(salary)
from employees;

select count(commission_pct)
from employees;

select count(*) -- *: 전체 다 가져오겠다
from employees;

-- sum(컬럼): 합계
select sum(salary)
from employees;

-- avg(컬럼): 평균
select avg(salary)
from employees;
-- 0	41	10:55:10	select first_name, count(*)

 
 -- 집계함수와 단순컬럼은 출력되는 레코드수가 다르기 때문에 함께 사용할 수 없다.
-- Error Code: 1140. In aggregated query without GROUP BY, expression #1 of SELECT list contains nonaggregated column 'myxedb.employees.FIRST_NAME'; this is incompatible with sql_mode=only_full_group_by
select first_name, count(*)
from employees;

-- 집계함수와 단순컬럼을 사용하기 위해서는 단순컬럼을 그룹화 해야 한다(GROUP BY)
select department_id, count(*)
from employees
GROUP BY department_id;

-- 50이하면 부서에 대해서 null이 아닌 부서별의 직원수를 출력하시오.
select department_id
from employees
where department_id <= 50
group by department_id;

select department_id, count(*)
from employees
group by department_id
having department_id <=50;

-- 업무별(job_id) 급여합계를 출력하시오.
select job_id, sum(salary)
from employees
group by job_id;

-- 부서별 최소급여, 최대급여가 같지 않을때만 부서, 부서 최소급여, 부서 최대급여를 부서별 오름차순으로 출력하시오.
select department_id, min(salary), max(salary)
from employees
group by department_id
having min(salary) != max(salary)
order by department ASC;

-- --------------------------
-- 시스템 함수
-- -------------------------
-- 현재 사용자와 현재 선택된 데이터베이스
 -- user() = current_user() = dsession_user()
 -- datebase() = schema()
select user(), database()

-- select문에서 조회된 행의 개수를 구함
-- found_rows( )
select * from employees
select found_rows();

-- 바로 앞의 INSERT, UPDATE, DELETE문에서 입력, 수정, 삭제된 행의 갯수를 구함
 -- CREATE, DROP문은 0을 반환하고, SELECT문은 -1을 반환한다.
 -- row_count()
delete from employees
where 1 = 0;
select row_count();

-- 현재 MySQL의 버전을 구한다.
select version();

-- 쿼리의 실행을 잠깐 멈춘다.
-- sleep(초)
-- select sleep(5);
-- select '5초후에 이게 보임';

 
/*------------------------------------------------------------
문제
-------------------------------------------------------------*/
-- 1) 모든사원에게는 상관(Manager)이 있다. 하지만 employees테이블에 유일하게 상관이
--   없는 로우가 있는데 그 사원(CEO)의 manager_id컬럼값이 NULL이다. 상관이 없는 사원을
--   출력하되 manager_id컬럼값 NULL 대신 CEO로 출력하시오.
select first_name, manager_id, ifnull(cast(manager_id AS char(3)), 'CEO')
from employees;

-- 2) 가장최근에 입사한 사원의 입사일과 가장오래된 사원의 입사일을 구하시오.
   select max(hire_date), min(hire_date)
   from employees;
 
-- 3) 부서별로 커미션을 받는 사원의 수를 구하시오.
select department_id, count(*)
from employees
where commission_pct is not null
group by department_id;

    
   
-- 4) 부서별 최대급여가 10000이상인 부서만 출력하시오.   
 select department_id, max(salary)
 from employees
 group by department_id
 having max(salary) >= 10000;
-- 5) employees 테이블에서 직종이 'IT_PROG'인 사원들의 급여평균을 구하는 SELECT문장을 기술하시오.
  select job_id, avg(salary)
  from employees
  where job_id = 'IT_PROG'
  group by job_id;
  
  select job_id, avg(salary)
  from employees
  group by job_id
  having job_id = 'IT_PROG';
-- 6) employees 테이블에서 직종이 'FI_ACCOUNT' 또는 'AC_ACCOUNT' 인 사원들 중 최대급여를 구하는 SELECT문장을 기술하시오.   
  select job_id, max(salary)
  from employees
  where job_id in('FI_ACCOUNT', 'AC_ACCOUNT')
  group by job_id;


-- 7) employees 테이블에서 50부서의 최소급여를 출력하는 SELECT문장을 기술하시오.
select min(salary)
from employees
where department_id <= 50;   
    
select department_id, min(salary)
from employees
group by department_id
having department_id = 50;
    
-- 8) employees 테이블에서 아래의 결과처럼 입사인원을 출력하는 SELECT문장을 기술하시오.
--   <출력:  2001		   2002		       2003
 --  	     4              0                4   >
  select sum(year(hire_date)= 2001) AS '2001',
  sum(year(hire_date)= 2002) AS '2002',
  sum(year(hire_date)= 2003) AS '2003'
  from employees;

-- 9) employees 테이블에서 각 부서별 인원이 10명 이상인 부서의 부서코드,
--  인원수, 급여의 합을 구하는 SELECT문장을 기술하시오.
   select department_id, count(*), sum(salary)
   from employees
   group by department_id
   having count(*) >= 10;
  
-- 10) employees 테이블에서 이름(first_name)의 세번째 자리가 'e'인 직원을 검색하시오.
  select first_name
  from employees
  where first_name like '__e%';
  
  select first_name
  from employees
  where substr(first_name, 3, 1)='e';

  select first_name, instr(first_name, 'e')
  from employees
  where instr(first_name, 'e') = 3;
  
  
  