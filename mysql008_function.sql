/*
스토어드 프로시저(Stored Procedure) 	
1. 파라미터에 IN, OUT 등을 사용할 수 없음
   - 모두 입력 파라미터로 사용
2. RETURNS문으로 반환할 값의 데이터 형식 지정
   - 본문 안에서는 RETURN문으로 하나의 값 반환
3. SELECT 문장 안에서 호출
4. 함수 안에서 집합 결과 반환하는 SELECT 사용 불가
   - SELECT… INTO… 는 집합 결과 반환하는 것이 아니므로 예외적으로 스토어드 함수에서 사용 가능
5. 어떤 계산 통해서 하나의 값 반환하는데 주로 사용

DELIMITER $$
CREATE FUNCTION 스토어드_함수(파라미터) 
   RETURNS 변환형식 
BEGIN
    프로그램 코딩 
	RETURN 반환값;
END $$ 
DELIMITER ;
SELECT 스토어드_함수( );
*/
use mywork;
--  스토어드 함수를 사용하기 위해  먼저 아래처럼 스토어드 함수 생성 권한을 허용해 줘야 한다.
SET GLOBAL log_bin_trust_function_creators = 1;
-- userFunc()--------------------------------------------------
DROP FUNCTION IF EXISTS userFunc;
DELIMITER $$
CREATE FUNCTION userFunc(value1 INT, value2 INT)
    RETURNS INT
BEGIN
    RETURN value1 + value2;
END $$
DELIMITER ;

SELECT userFunc(100, 200);

-- getAgeFunc()--------------------------------------
DROP FUNCTION IF EXISTS getAgeFunc;
DELIMITER $$
CREATE FUNCTION getAgeFunc(bYear INT)
    RETURNS INT
BEGIN
    DECLARE age INT;
    SET age = YEAR(CURDATE()) - bYear;
    RETURN age;
END $$
DELIMITER ;

SELECT getAgeFunc(1979);

SELECT getAgeFunc(1979) INTO @age1979;
SELECT getAgeFunc(1997) INTO @age1989;
SELECT CONCAT('1997년과 1979년의 나이차 ==> ', (@age1979-@age1989));

SELECT userID, name, getAgeFunc(birthYear) AS '만 나이' FROM userTbl;
-- ---------------------------------------------------
-- 현재 저장돈 스토어드 함수의 이름 및 내용을 확인
SHOW CREATE FUNCTION getAgeFunc;

-- 스토어드 함수 삭제
DROP FUNCTION getAgeFunc;