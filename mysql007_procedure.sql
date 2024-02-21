/*
스토어드 프로시저(Stored Procedure) : 여러 쿼리문을 일괄 처리하기 위한 용도로 사용하는 
    기능이다.
*/

use mywork;

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
INSERT INTO buytbl VALUES(NULL, 'EJW', '책'    , '서적', 15,   2);
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

SET @myVar1= 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25 ;
SET @myVar4 = '가수 이름==> ' ;

SELECT @myVar1;
SELECT @myVar2 + @myVar3;

SELECT @myVar4, name
FROM usertbl
WHERE height>180;

-- LIMIT에는 원칙적으로 변수를 사용할 수 없으나  PREPARE와 EXECUTE문을 활용해서 
-- 변수의 활용이 가능하다.
SET @myVar3=3;

PREPARE myQuery
FROM
	'SELECT name, height 
    FROM usertbl 
    ORDER BY height 
    LIMIT ?';
EXECUTE  myQuery USING  @myVar3;

/*--------------------------------------------------------------------
스토어드 프로시저
DELIMITER $$
CREATE PROCEDURE 스토어드_프로시저이름( )
BEGIN
      이 부분에 SQL 프로그래밍 구현
END $$
DELIMITER ;
CALL 스토어드_프로시저이름()
-- ----------------------------------------------------------------*/
-- if ~ else ~ end if
DROP PROCEDURE IF EXISTS ifProc; -- 기존에 만든적이 있다면 삭제

DELIMITER $$
CREATE PROCEDURE ifProc()
BEGIN
  DECLARE var1 int;  -- var1 변수 선언 
  SET var1 = 100;    -- var1변수에 값 할당
  
  if var1 = 100 then
    SELECT '100입니다';
  else
    SELECT '100이 아닙니다';
  end if; 
  
ENd $$
DELIMITER ;

call ifProc();

--  -------------------------------------
-- if ~ else ~ end if

use myxedb;

DROP PROCEDURE IF EXISTS ifProc2;

DELIMITER $$
CREATE PROCEDURE ifProc2()
BEGIN
    DECLARE hireDATE date; -- 입사일
    DECLARE curDATE date; -- 오늘
    DECLARE days int;      -- 근무일수
    
    SELECT hire_date INTO hireDATE
	FROM employees
    WHERE employee_id=100;
    
    SET curDATE = current_date();  -- 현재날짜
    SET days = datediff(curDATE, hireDATE);   -- 날짜의 차이, 일단위
    
    if (days/365) >=5 then -- 5년 이상이면
       SELECT CONCAT('입사한지 ', days, '일이 지났습니다. 축하합니다!');
	else
       SELECT CONCAT('입사한지 ', days, '일입니다.');
	 end if;
    
END $$
DELIMITER ;

call ifProc2();

-- --------------------------------------------------------------------------
-- if ~ else ~ end if
DROP PROCEDURE IF EXISTS ifProc3;

DELIMITER $$
CREATE PROCEDURE ifProc3()
BEGIN
   DECLARE point int;
   DECLARE credit char(1);
   
   SET point = 77;
   
   if point>= 90 then
      SET credit = 'A';
   elseif point>=80 then
      SET credit = 'B';
	elseif point>=70 then
      SET credit = 'C';
	elseif point>=60 then
      SET credit = 'D';
	 else
       SET credit='F';
   end if;
   
   SELECT concat('취득점수=>', point), concat('학점=>', credit);
END $$
DELIMITER ;

call ifProc3();

-- -----------------------------------------------------------
--  case~ when~end
DROP PROCEDURE IF EXISTS caseProc;

DELIMITER $$
CREATE PROCEDURE caseProc()
BEGIN
   DECLARE point int;
   DECLARE credit char(1);
   
   SET point = 77;
   case 
		when point>= 90 then
		  SET credit = 'A';
	    when point>=80 then
		  SET credit = 'B';
		when point>=70 then
		  SET credit = 'C';
		when point>=60 then
		  SET credit = 'D';
		 else
		   SET credit='F';
   end case;
   
   SELECT concat('취득점수=>', point), concat('학점=>', credit);
END $$
DELIMITER ;

call caseProc();

-- -------------------------------------------------------------------
-- while ~ do ~ end while

DROP PROCEDURE IF EXISTS whileProc;

DELIMITER $$
CREATE PROCEDURE whileProc()
BEGIN
    DECLARE i int;   -- 1에서 100까지 증가할 변수
    DECLARE hap int;   -- 누적 변수
    SET i = 1;
    SET hap = 0;
    
    while i<=100 do
       SET hap = hap + i;
       SET i = i + 1;
    end while;
    SELECT hap;
END $$
DELIMITER ;

call whileProc();

--  -----------------------------------------------
-- while ~ do ~ end while

DROP PROCEDURE IF EXISTS whileProc2;

DELIMITER $$
CREATE PROCEDURE whileProc2()
BEGIN
    DECLARE i int;   -- 1에서 100까지 증가할 변수
    DECLARE hap int;   -- 누적 변수
    SET i = 1;
    SET hap = 0;
    
   myWhile: while i<=100 do
       if i%7=0 then
         set i = i +1;
         ITERATE myWhile;     -- 지정한 label문으로 가서 계속 진행
       end if;
       
       SET hap = hap + i;
       
       if hap  > 1000 then
          LEAVE myWhile;       -- 지정한 label문을 빠져나감
       end if;
       
       SET i = i + 1;
    end while;
    SELECT i, hap;
END $$
DELIMITER ;

call whileProc2();

/*============================================
java - pl/sql 연동
===============================================*/

/*=====Java001_plsql ======*/
use mywork;

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

drop procedure pro_mem_inmode;
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
  SELECT first_name,salary  INTO v_name,v_salary
  FROM employees
  WHERE employee_id=v_empid;
END $$
DELIMITER ;

CALL my_select(100, @my_name, @my_salary);
SELECT CONCAT('name:', @my_name),CONCAT('salary:', @my_salary);