/*===============================================
뷰 : 
  1)물리적인 테이블을 근거한 논리적인 가상 테이블을 의미한다  
  2) 기본테이블에서 파생된 객체로서 기본테이블에 대한 하나의 
     쿼리문이다.
  3) 사용자에게 주어진 뷰를 통해서 기본 테이블을 제한적으로 
     사용하게 한다
  4) 뷰를 생성하기 위해 실제적으로 데이터를 저장하고 있는 
      물리적인 테이블이 존재해야 하는데 이를 기본 테이블이라한다.
  
 뷰를 사용하는 이유
 1) 복잡하고 긴 쿼리문을 뷰로 정의하면 접근을 단순화 시킬수있다
 2) 보안에 유리하다.
  
뷰의 종류
  : 뷰를 정의하기 위해 사용된 기본 테이블의 갯수에 따라 단순뷰
    (simple view)와 복합뷰(Complex View)로 구분한다.

 단순 뷰(Simple View)
   1) 뷰를 정의하기 위해 기본데이블이 하나만 사용
   2) 그룹함수의 사용 불가능
   3) DISTINCT의 사용 불가능
   4) DML 실행 가능
   
 복합 뷰(Complex View)
  1) 뷰 생성시 두개 이상의 기본테이블로 생성  
  2) 그룹함수의 사용이 가능
  3) DISTINCT의 사용이 가능
  4) DML 실행 불가능
  
 단순 뷰(Simple View)인 경우에도 DML을 실행할 수 없다.
 1) DELETE : GROUP BY절, DISTINCT키워드
 2) UPDATE : GROUP BY절, DISTINCT키워드
 3) INSERT : 기본 테이블에 NOT NULL 제약 조건이 있는 경우  
      
======================================================*/
-- views
select * from information_schema.views;

select * from emp2;

-- 단순뷰(simple view)
create view emp_view1(id, name, loc, salary, code, gen, bs)
as
select id, name, loc, salary, code, gen, bs
from emp2;

-- views
select * from information_schema.views
where table_schema= 'mywork';

desc emp_view1;

insert into emp_view1
values('a008', '보라', '파주', 3500, 'p001', 'w', 'en');

select * from emp_view1;
select * from emp2;

-- view를 이용하여 데이터 수정
update emp_view1
set name = '그린'
where id = 'a008';

select * from emp_view1;
select * from emp2;

-- view를 이용한 데이터 삭제
delete from emp_view1
where id = 'a008';

drop view emp_view2;

-- view 생성
create view emp_view2
as
select code, sum(salary)
from emp2
group by code;

-- views
select * from information_schema.views
where table_schema= 'mywork';

select* from emp_view2;

-- view 생성
create view emp_view3(code, total)
as
select code, sum(salary)
from emp2
group by code;

-- views
select * from information_schema.views
where table_schema= 'mywork';

select* from emp_view3;

-- Error Code: 1471. The target table emp_view3 of the INSERT is not insertable-into	0.000 sec
insert into emp_view3
values('p001', '3500');

select * from emp2;

-- 복합 뷰(complex view)
select * from emp2 e, dept1 d
where e.code = d.code;

create view emp_view4(id, name, loc, salary, ecode, bs, dcode)
as 
select e.code, e.name, e.loc, e.salary, e.code, e.bs, d.code
from emp2 e, dept1 d
where e.code = d.code;

select * from emp_view4;

create view emp_view5(id, name, loc, salary, code, bs)
as 
select e.code, e.name, e.loc, e.salary, e.code, e.bs 
from emp2 e, dept1 d
where e.code = d.code;

select*from emp_view5;

-- 뷰 삭제
drop view emp_view5;

select *from emp_view5;

-- views
select * from information_schema.views
where table_schema= 'mywork';

create view emp_view6
as
select id, name, salary
from emp2
where salary >= 3000;

select*from emp_view6;

insert into emp_view6
values('a010', '강아지', 2000);

select*from emp_view6;

-- salary컬럼에 값을 3000이상만 변경할 수 있도록 with check option을 설정함
create view emp_view7
as
select id, name, salary
from emp2
where salary >= 3000 with check option;

select * from emp_view7;

insert into emp_view7
values('a011', '야옹이', 1000);

insert into emp_view7
values('a012', '기동이', 4000);

update emp_view7
set salary = 2000
where id = 'a006';

update emp_view7
set salary = 8000
where id = 'a006';

select * from emp_view7;