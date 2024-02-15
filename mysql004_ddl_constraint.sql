/*===============================
테이블 구조 정의
CREATE TABLE table_name(
  column_name datatype,
  column_name datatype
);

자료형(datatype)
varchar - 가변길이 문자를 저장
char - 고정길이 문자를 저장
int-정수저장
decimal(m,n)- 실수저장
date - 날짜 저장
===============================*/
use mywork;
create table student(
name varchar(20),
age int,
avg decimal(5,2),
hire date
);

select*from student;

-- 테이블 구조 파악(Describe)
desc student; 

-- 데이터 삽입
insert into student(name, age, avg, hire)
values('고길동', 30, 97.85, curdate());

select*from student;
insert into student(name, age, avg, hire)
values('김민재', 28, 80.2, sysdate());

select*from student;

insert into student
values('이수리', 18, 75.3, curdate());
select*from student;

insert into student(name, age)
values('세기둥', 10);
select*from student;

insert into student
values('흰둥이', 15, null, null);
select*from student;

-- Error Code: 1406. Data too long for column 'name'at row 1
insert into student(name, age, avg, hire)
values('박차고 나온 세상에abcdefghijklmnop', 30, 97.2, curdate()); 

-- delete from student -- 테이블 내 값 삭제할 때 사용
-- where avg = 97.20;

-- Error Code: 1264. Out of range value for column 'avg' at row 1	0.016 sec
insert into student(name, age, avg, hire)
values('이정재', 20, 1525.98, curdate());

insert into student(name, age, avg, hire)
values('차영주', 25, 352.9825, curdate());
select*from student;

-- create table , create view, create index

/*====================================
ALTER 
 객체(테이블)의 구조를 변경해주는 명령어이다.
======================================*/
-- 생성 : CREATE TABLE,  CREATE VIEW, CREATE INDEX
-- 수정 : ALTER TABLE, ALTER VIEW, ALTER INDEX, ALTER USER

-- 테이블에 컬럼을 추가한다.
alter table student
add loc varchar(30);

desc student;

select * from student;

-- 테이블의 컬럼명을 수정한다.
alter table student
rename column avg to jumsu;
select * from student; 

-- 입력하는 데이터 양 조절
alter table student
modify name varchar(3);

alter table student
modify name varchar(10);

-- 테이블명을 변경
alter table student
rename to members;

desc student; -- 이름 바꿔서 이제 student는 존재하지 않는다
desc members;

/*=======================================
테이블의 내용을 수정하는 명령어이다.
UPDATE 테이블명 
SET 컬럼1=값1, 컬럼2=값2 
WHERE 컬럼=값;
=========================================*/
-- alter table members
-- modify name constraint mem_name_pk primary key;

update members
set age = 50
where name = '고길동';