/*===============================================
무결성 제약조건
   무결성이 데이터베이스 내에 있는 데이터의 정확성 유지를 의미한다면
   제약조건은 바람직하지 않는 데이터가 저장되는 것을 방지하는 것을 말한다.
   무결성 제약조건 6종류 : not null, unique, primary key, foreign key, check, default
    not null : null를 허용하지 않는다.
    unique : 중복된 값을 허용하지 않는다. 항상 유일한값이다.
    primary key : not null + unique
    foreign key : 참조되는 테이블의 컬럼의 값이 존재하면 허용된다.
    check : 저장 가능한 데이터값의 범위나 조건을 지정하여 설정한 값만을 허용한다.
	default : 기본값을 설정한다.
    =====================================================*/
create table dept1(
code varchar(10) primary key);

create table emp1(
id varchar(10) primary key,
name varchar(20) not null, 
loc varchar(10), -- 뒤에 null에 대해 안써놓으면 null 허용
salary int default 3000
);

-- mywork 데이터베이스에 생성된 table 확인
select * from information_schema.tables
where table_schema = 'mywork';

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

select*from emp1;

insert into emp1
values('a001', '홍길동', '지역', 5000);
select*from emp1;

insert into emp1(id, name, loc)
values('aoo2', '김민재', '서울');
select*from emp1; -- 위에 default로 salary를 3000으로 설정했기 때문에 자동으로 3000 출력

create table emp2(
id varchar(10),
name varchar(20) not null, 
loc varchar(10), -- 뒤에 null에 대해 안써놓으면 null 허용
salary int default 3000,
code varchar(10),
constraint emp2_id_pk primary key(id),
constraint emp2_code_fk foreign key(code) references dept1(code)
);

-- mywork 데이터베이스에 생성된 constraint 확인
select *from insformation_schema.table_constraints
where table_schema = 'mywork';

insert into dept1
values('p001');

select *from dept1;

select *from emp2;

insert into emp2;
values('a001', '김연아', '서울', 5000, 'p001');

select * from emp2;
insert into emp2(id, name, loc, salary)
values('a002', '이수영', '경기', 8000);

select * from emp2;

-- emp2테이블의 code칼럼은 dept1테이블의 code 칼럼에 저장된 값이나 null만 저장할 수 있다.
insert into emp2(id, name, loc, salary)
values ('a003', '진영구', '제주', 6000, 'k001'); -- 전혀 다른 값을 추가하려고 해서 오류 뜸

-- id칼럼은 primary key 제약조건이 설정되어 있으므로 unique + not null만 사용 가능하다.
insert into emp2(id, name, loc)
values('aoo2', '마이상', '대전');

insert into emp2(id, name, loc)
values('a004', '홍길동', '대구');

-- name 컬럼의 제약조건 not null이기 때문에 중복된 값 입력 가능.
insert into emp2(id, name, loc)
values('a005', '홍길동', '부산');

-- name컬럼의 제약조건은 not null이기 때문에 null 값을 저장할 수 없다.
insert into emp2(id, loc)
values('a006', '전주');

-- emp2테이블에 gen 컬럼을 추가한다.
alter table emp2
add gen char(1) check(gen in('m', 'w'));

select * from emp2;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema_table_constraints
where table_schema = 'mywork';

insert into emp2;
values('aoo6', '전진구', '수원', 5000, 'p001', 'm');

/*=================================================
제약조건 삭제
 ALTER TABLE table_name
  DROP constraint constraint_name
======================================================*/

-- foreign key 제약조건 삭제
alter table emp2
drop constraint emp2_code_fk;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- primary key 제약조건 삭제
alter table emp2
drop primary key;

desc emp2;
-- default제약조건 삭제(salary int default 3000)
alter table emp2
alter salary drop default;

-- salary컬럼에 default 제약조건이 삭제되었는지 확인한다.
desc emp2;

-- name 컬럼에 not null 삭제
alter table emp2
modify column name varchar(20);

desc emp2;

/*=======================================================================
제약조건 추가
  ALTER TABLE table_name
       ADD constraint constraint_name constraint_type(column_name)
=========================================================================*/
-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- emp2테이블의 code컬럼에 foreign key 제약조건 추가
alter table emp2
add constraint emp2_code_fk foreign key(code) references dept1(code);

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- emp2테이블의 gen컬럼에 check 제약조건 추가
alter table emp2
add constraint em2_gen_chk check(gen in('m', 'w');

-- emp2테이블의 id컬럼에 primary key 제약조건 추가
alter table emp2
add constraint emp2_id_pk primary key(id);

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- emp2테이블의 salary컬럼에 default  제약조건 추가
alter table emp2
modify column salary int default 3000;

-- salary컬럼에 default 제약조건 추가한 것 확인
desc emp2;

-- emp2테이블의 name 컬럼에 not null  제약조건 추가
alter table emp2
modify column name varchar(20) not null;

-- name컬럼에 not null 제약조건 추가한 것 확인
desc emp2;

-- emp2테이블에 bs컬럼에 unique제약조건 추가
alter table emp2
add bs varchar(10) unique

insert into emp2
values('a007', '박다영', '광주', 7000, 'p001', 'w', 'ko');

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- emp2테이블의 bs컬럼의 unique 제약조건 삭제
alter table emp2
drop constraint bs;

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- emp2 테이블 bs컬럼의 unique 제약조건 추가
alter table emp2
add constraint emp2_bs_u unique(bs);

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

-- ====================================================
-- dept1(code), emp2(code)

select *from dept1;
select*from emp2;

delete from dept1
where code = 'p001';

update dept1
set code='m001';

insert into dept1
values('p002');

select *from dept1;

-- dept1테이블의 code 컬럼의 'p002'의 값을 다른 테이블에서 참조를 안하고 있기 대문에
-- 수정 또는 삭제가 가능하다.
update dept1
set code ='m001'
where code = 'p002';

select * from dept1;

/*==============================================================
부모키가 수정, 삭제가 되면 참조되는 키도 수정, 삭제가 되도록 cascade을 설정한다,
수정: on update cadcade
삭제: on delete cascade
================================================================*/

create table dept2(
code varchar(10),
dname varchar(20)
);

insert into dept2
values('p001', 'visit');

insert into dept2
values('p002', 'hello');

alter table dept2
add constraint primary key(code);
select * from dept2;

drop table if exists emp3;
create table emp3(
 id varchar(10) primary key,
 name varchar(20) not null,
 code varchar(10),
 constraint emp3_code_fk foreign key(code) references dept2(code)
 on delete cascade
 on update cascade);

-- mywork 데이터베이스에 생성된 constraint 확인
select * from information_schema.table_constraints
where table_schema = 'mywork';

select*from emp3; 

insert into emp3
values('a001', '홍길동', 'p001');

insert into emp3
values('a002', '김민재', null);

select*from emp3; 

insert into emp3
values('a003', '진영구', 'p002');

update dept2 -- code에 있는 p001을 m001로 바꿔라.
set code = 'm001'
where code = 'p001';

select*from dept2; 
select*from emp3;

delete from dept2 -- code값 p002를 삭제해라
where code = 'p002';

select*from dept2; 
select*from emp3;

