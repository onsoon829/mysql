/*
인덱스란 데이터베이스 테이블에 대한 검색 성능의 속도를 높여주는 자료 구조이다.

[인덱스의 장단점]
1. 장점
  - 검색 속도가 무척 빨라질 수 있음 (항상 그런 것은 아님)
  - 쿼리의 부하가 줄어들어 시스템 전체의 성능 향상

2. 단점
  - 인덱스가 데이터베이스 공간을 차지해서 추가적인 공간 필요
  - 대략 데이터베이스 크기의 10% 정도의 추가 공간 필요
  - 처음 인덱스 생성하는데 시간 소요 
  - 데이터의 변경 작업 (Insert, Update, Delete)이 자주 일어나는 경우 성능이 나빠질 수도 있음

[인덱스의 종류]
1. 클러스터형 인덱스 (Clustered Index)
 - ‘영어 사전’과 같은 책
 - 테이블 당 한 개만 지정 가능
 - 행 데이터를 인덱스로 지정한 열에 맞춰 자동 정렬

2. 보조 인덱스 (Secondary Index)
 - 책 뒤에 <찾아보기>가 있는 일반 책
 - 테이블당 여러 개도 생성 가능
 
 [인덱스 설정후  특징] 
 - PRIMARY KEY로 지정한 열은 클러스트형 인덱스가 생성된다.
 - UNIQUE NOT NULL로 지정한 열은 클러스터형 인덱스가 생성된다.
 - UNIQUE로 지정한 열은 보조 인덱스가 생성된다. 
 - PRIMARY KEY와 UNIQUE NOT NULL이 있으면 PRIMARY KEY로 지정한 열에 우선 클러스터형 인덱스가 생성된다. 
 - PRIMARY KEY로 지정한 열로 데이터가 오름차순 정렬된다.
*/ 

use mywork;
-- 
create table tbl1 
(     a int primary key,
	  b int,
      c int
);

show index from tbl1;

/*
Key_name :  PRIMARY로 된 것은  클러스터형 인덱스를 의미하고 열이름 또는 index_name이면 보조인덱스를 의미한다.
Non_unique : 0이면 Unique인덱스를, 1이면 Nonunique 인덱스를 의미한다.
Seq_in_index :  해당 열에 여러개의 인덱스가 설정되었을 때의 순서를 나타낸다. 대부분 1로 써져 있다.
Null : NUll의 값은 허용 여부인데 비어 있으면 No를 의미한다.
Cardinality : 중복되지 않은 데이터 개수가 들어 있다. 이 값은 데이터를 입력하거나, ANALIZE TABLE문을 수행할때 변경된다.
Index_type: 어떤 형태로 인덱스가 구성되었는지 나타내는데 MySQL은 기본적으로 B-Tree의구조를 갖는다.
*/
-- unoque는 null값은 허용하지만 중복은 허용 안한다.
create table tbl2 
(     a int primary key,
	  b int unique,
      c int unique,
      d int
);

show index from tbl2;

-- -----------------------------------------
-- unique 제약 조건으로 설정하면 보조 인덱스가 저동으로 생성된다.
-- 보조 인덱스는 테이블당 여러 개 생성할 수 있다.
create table tbl3 
(     a int primary key,
	  b int unique,
      c int unique,
      d int
);

show index from tbl3;

-- -----------------------------------------
-- unique에 not null이 포하모디면 클러스터형 인덱스로 지정된다.

create table tbl4 
(     a int unique not null,
	  b int unique,
      c int unique,
      d int
);

show index from tbl4;

-- -----------------------------------------
-- unique + not null과 primary key가 함께 사용되면
-- primary key가 설정된 열에 우선 클러스터형 인덱스가 생성된다.

create table tbl5 
(     a int unique not null,
	  b int unique,
      c int unique,
      d int primary key
);

show index from tbl5;
-- d열에 클러스터형 인덱스가 생성되고, a열에는 보조 인덱스가 생성된다. 
-- 즉, 클러스터형 인덱스는 테이블당 하나밖에 지정되지 않으므로 
-- Primary Key로 설정한 열에 우선 클러스터형 인덱스가 생성된다.
-- index 설정으로 처리가 늦어질 수도 있다?
create table tbl6
(     a int ,
	  b int ,
      c int 
      
);

show index from tbl6;

insert into tbl6
values(10,10,10);

insert into tbl6
values(30,30,30);

insert into tbl6
values(20,20,20);

select * from tbl6;

create table tbl7
(     a int primary key, -- primary key를 가지고 있는 게 있으면 오름차순 정렬
	  b int ,
      c int 
      
);

show index from tbl7;

insert into tbl7
values(10,10,10);

insert into tbl7
values(30,30,30);

insert into tbl7
values(20,20,20);

select * from tbl7;
/*order by a;*/