/*
스토어드 프로시저(Stored procedure): 여러 쿼리문을 일괄 처리하기 위한 용도로 사용하는 기능이다.
*/
-- 너무 졸리다

CREATE TABLE usertbl -- 회원 테이블
( userID  	CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  name    	VARCHAR(10) NOT NULL, -- 이름
  birthYear   INT NOT NULL,  -- 출생년도
  addr	  	CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  mobile1	CHAR(3), -- 휴대폰의 국번(011, 016, 017, 018, 019, 010 등)
  mobile2	CHAR(8), -- 휴대폰의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 키
  mDate    	DATE  -- 회원 가입일
);
CREATE TABLE buytbl -- 회원 구매 테이블(Buy Table의 약자)
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   userID  	CHAR(8) NOT NULL, -- 아이디(FK)
   prodName 	CHAR(6) NOT NULL, --  물품명
   groupName 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 단가
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (userID) REFERENCES usertbl(userID)
);

INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울', '011', '1111111', 182, '2008-8-8');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남', '011', '2222222', 173, '2012-4-4');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남', '019', '3333333', 177, '2007-7-7');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기', '011', '4444444', 166, '2009-4-4');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울', NULL  , NULL      , 186, '2013-12-12');
INSERT INTO usertbl VALUES('LJB', '임재범', 1963, '서울', '016', '6666666', 182, '2009-9-9');
INSERT INTO usertbl VALUES('YJS', '윤종신', 1969, '경남', NULL  , NULL      , 170, '2005-5-5');
INSERT INTO usertbl VALUES('EJW', '은지원', 1972, '경북', '011', '8888888', 174, '2014-3-3');
INSERT INTO usertbl VALUES('JKW', '조관우', 1965, '경기', '018', '9999999', 172, '2010-10-10');
INSERT INTO usertbl VALUES('BBK', '바비킴', 1973, '서울', '010', '0000000', 176, '2013-5-5');
INSERT INTO buytbl VALUES(NULL, 'KBS', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buytbl VALUES(NULL, 'JYP', '모니터', '전자', 200,  1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '모니터', '전자', 200,  5);
INSERT INTO buytbl VALUES(NULL, 'KBS', '청바지', '의류', 50,   3);
INSERT INTO buytbl VALUES(NULL, 'BBK', '메모리', '전자', 80,  10);
INSERT INTO buytbl VALUES(NULL, 'SSK', '책'    , '서적', 15,   5);
INSERT INTO buytbl 
VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '청바지', '의류', 50,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   1);
INSERT INTO buytbl VALUES(NULL, 'BBK', '운동화', NULL   , 30,   2);

SELECT * FROM usertbl;
SELECT * FROM buytbl;

/*
변수의 사용
SQL도 다른 일반적인 프로그래밍 언어처럼 변수를 선언하고 사용할 수 있다. 

SET @변수이름 = 값;    -- 변수의 선언 및 대입
SELECT @변수이름      -- 변수의 값 출력
*/

set @myVar1 = 5;
set @myVar2 = 3;
set @myVar3 = 4.25;
set @myVar4 = '가수 이름 ==> ';

select @myVar1;
select @myVar2 + @myVar3;

select name
from usertbl
where height > 180;

-- 변수명을 커리문에서 쓰는 방법
select @myVar4, name
from usertbl
where height>180;

-- 나중에 적용하는 업데이트
-- LIMIT에는 원칙적으로 변수를 사용할 수 없으나  PREPARE와 EXECUTE문을 활용해서 
-- 변수의 활용이 가능하다.
set @myVar3 = 3;

prepare myQuery
from
'select name, height
from usertbl
order by height
limit ?';
execute myQuery using @myVar3;

/*--------------------------------------------------------------------
스토어드 프로시저
DELIMITER $$
CREATE PROCEDURE 스토포어드_프로시저이름( )
BEGIN
      이 부분에 SQL 프로그래밍 구현
END $$
DELIMITER ;$$-- 기호 바꾸기임
CALL 스토어드_프로시저이름()
-- ----------------------------------------------------------------*/
drop procedure if exists ifproc; -- 기존에 만든적이 있다면 삭제

delimiter $$
create procedure ifproc()
begin 
  declare var1 int; -- var1 변수 선언
  set var1 = 100; -- var1변수에 값 할당

  if var1 = 100 then
     select '100입니다';
  else 
     select '100이 아닙니다';
  end if;
  
end $$
delimiter ;

call ifproc();

-- --------------------------------------------------------------------
-- if ~ else ~ end if

use myxedb;
drop procedure if exists ifproc2;

delimiter $$
create procedure ifproc2()
begin
    declare hireDATE date; -- 입사일
    declare curDATE date; -- 오늘
    declare days int;      -- 근무일수
    
    select hire_date into hireDATE
    from employees
    where employee_id = 100;
    
    set curDATE = current_date(); -- 현재날짜
    set days = datediff(curDATE, hireDATE); -- 날짜의 차이, 일단위
    
    if(days/365) > = 5 then -- 5년 이상이면
       select concat('입사한지 ', days, '일이 지났습니다. 축하합니다!');
    else
	   select concat('입사한지 ', days, '일입니다.');
    end if;
    
end $$
delimiter ;

call ifProc2();

-- -----------------------------------------------
-- if ~ else end if
drop procedure if exists ifproc3;

delimiter $$
create procedure ifproc3()
begin
   declare jumsu int;
   declare credit char(1);
   
   set point = 77;
   
   if point >= 90 then
     set credit = 'A';
   elseif point >= 80 then
     set credit = 'B';
   elseif point >= 70 then
     set credit = 'C';
   elseif point >= 60 then
     set credit = 'D';
   else 
     set credit = 'F';
   end if;
   
   select concat('취득점수=>', point), concat('학점=>', credit);
   
end $$
delimiter ;

call ifproc3();

-- --------------------------------------------------------------------
-- case ~ when ~ end case
drop procedure if exists caseproc;

begin
   declare jumsu int;
   declare credit char(1);
   
   set point = 77;
   case
	   when point >= 90 then
		 set credit = 'A';
	   when point >= 80 then
		 set credit = 'B';
	   when point >= 70 then
		 set credit = 'C';
	   when point >= 60 then
		 set credit = 'D';
	   else 
		 set credit = 'F';
   end case;
   
   select concat('취득점수=>', point), concat('학점=>', credit);
   
end $$
delimiter ;

call caseproc3();

-- ------------------------------------------------------
-- while ~ do~ end while
drop procedure if exists whileproc;

delimiter $$
create procedure whileproc()
begin
   declare i int;  -- 1에서부터 100까지 증가할 변수
   declare hap int; -- 누적 변수
   set i = 1;
   set hap = 0;
   
   while i<= 100 do
      set hap = hap + i;
      set i = i + 1;
   end while;
   select hap;
end $$
delimiter ;

call whileproc();

-- --------------------------------------------------------
-- while ~ do ~ end while

drop procedure if exists whileproc;

delimiter $$
create procedure whileproc2()
begin
   declare i int;  -- 1에서부터 100까지 증가할 변수
   declare hap int; -- 누적 변수
   set i = 1;
   set hap = 0;
   
   while i<= 100 do
      if i%7=0 then
        set i = i + 1;
        iterate mywhile; -- 지정한 label문으로 가서 계속 진행
      end if;
      
      set hap = hap + i;
      
      if hap > 1000 then
         leave mywhile; -- 지정한 label문을 빠져나감(누적된 값이 1000보다 커지면)
      end if;
      
      set i = i + 1;
   end while;
   select hap;
end $$
delimiter ;

call whileproc2();

/*=====Java001_plsql ======*/

-- 테이블생성
CREATE TABLE pltest(
  num int,
  message varchar(50)
);

-- 프로시저 생성
DROP PROCEDURE IF EXISTS pro_pltest; 

DELIMITER $$
CREATE PROCEDURE projdbc
(IN msg  varchar(20))

BEGIN
  DECLARE i int;
  SET i = 1;
  while i<=5 do
    INSERT INTO pltest VALUES(i,concat(msg,'_', i));
   SET i = i + 1;
  end while;
  commit;
END $$
DELIMITER ;

CALL pro_pltest('korea');

/*=====Java001_plsql ======*/

-- 테이블생성
CREATE TABLE pltest(
  num int,
  message varchar(50)
);

-- 프로시저 생성
DROP PROCEDURE IF EXISTS pro_pltest; 

DELIMITER $$
CREATE PROCEDURE projdbc
(IN msg  varchar(20))

BEGIN
  DECLARE i int;
  SET i = 1;
  while i<=5 do
    INSERT INTO pltest VALUES(i,concat(msg,'_', i));
   SET i = i + 1;
  end while;
  commit;
END $$
DELIMITER ;

CALL pro_pltest('korea');

*/
/*=====Java001_plsql ======*/

-- 테이블생성
CREATE TABLE pltest(
  num int,
  message varchar(50)
);

-- 프로시저 생성
DROP PROCEDURE IF EXISTS pro_pltest; 

DELIMITER $$
CREATE PROCEDURE projdbc
(IN msg  varchar(20))

BEGIN
  DECLARE i int;
  SET i = 1;
  while i<=5 do
    INSERT INTO pltest VALUES(i,concat(msg,'_', i));
   SET i = i + 1;
  end while;
  commit;
END $$
DELIMITER ;

CALL pro_pltest('korea');

-- ==================================================

/*=====Java001_plsql ======*/

-- 테이블생성
CREATE TABLE pltest(
  num int,
  message varchar(50)
);

-- 프로시저 생성
DROP PROCEDURE IF EXISTS pro_pltest; 

DELIMITER $$
CREATE PROCEDURE pro_pltest
(IN msg  varchar(20))

BEGIN
  DECLARE i int;
  SET i = 1;
  while i<=5 do
    INSERT INTO pltest VALUES(i,concat(msg,'_', i));
   SET i = i + 1;
  end while;
  commit;
END $$
DELIMITER ;

CALL pro_pltest('korea');

SELECT * FROM pltest;

/*============Java002_plsql=========================*/
use mywork;
DROP PROCEDURE IF EXISTS pro_mem_inmode; 


CREATE TABLE mem(
	 num int primary key auto_increment,
	 name varchar(10) not null,
	 age int default 1,
	 loc varchar(50)
	);
	
	
DELIMITER $$
CREATE PROCEDURE pro_mem_inmode(
    IN v_name VARCHAR(20),
    IN v_age int,
    IN v_loc VARCHAR(50)    
)
BEGIN
    IF v_name IS NULL THEN
        SET v_name = '홍길동';
    END IF;
    
    IF v_age IS NULL THEN
       SET v_age = 1;
	END IF;

    IF v_loc IS NULL THEN
        SET v_loc = '서울';
    END IF;

    INSERT INTO mem(name, age, loc)
    VALUES(v_name, v_age, v_loc);
END $$
DELIMITER ;

CALL pro_mem_inmode('김민재', 40, '춘천');


SELECT * FROM mem;

/*============Java003_plsql=========================*/
use myxedb;

DROP PROCEDURE IF EXISTS pl_emplist; 

DELIMITER $$

CREATE PROCEDURE pl_emplist(IN v_deptno INT)
BEGIN
    SELECT employee_id, first_name, salary, department_id
    FROM employees
    WHERE department_id = v_deptno;  
END $$

DELIMITER ;

CALL pl_emplist(20);

/*============Java004_plsql=========================*/
use myxedb;

DROP PROCEDURE IF EXISTS my_select; 

DELIMITER $$
CREATE PROCEDURE  my_select
  (IN v_empid  int,
  OUT v_name  varchar(20) ,
  OUT v_salary  int)

BEGIN 
  SELECT first_name,salary 
  INTO v_name,v_salary
  FROM employees
  WHERE employee_id=v_empid;
END $$
DELIMITER ;

CALL my_select(100, @my_name, @my_salary);
SELECT CONCAT('name:', @my_name),CONCAT('salary:', @my_salary);