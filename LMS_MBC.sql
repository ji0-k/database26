select @@hostname;

-- 이창은 메모장 처럼 사용됨
-- 스크립트를 1줄씩 실행하는 것이 기본인 (ctrl + enter)
-- 만약 더미데이터를 20개 입력한다면 (블럭 설정 ctrl + shift + enter)
-- 스키마는 DB와 table 모여있는 곳
-- 중요한 자료는 sys에 있음 
-- sakila - tables - actor,address 안에 Columns = 더미데이터 표시

use sakila; -- skila라는 DB가서 사용할게
select * from actor; -- actor table에 모든 값 가져와

use world; -- world DB가서 사용할게
select * from city; -- city table에 모든 값 가져와


-- 정의어 (DDL , data definition language)  :  데이터베이스 , 테이블, 사용자,뷰,인덱스,스키마 생성/수정/삭제
-- 	 	 생성    :  CREATE DATABASE, CREATE TABLE , CREAT USER
-- 	     수정    :  ALTER DATABASE, ALTER TABLE, ALTER USER
-- 	     삭제    :  DROP DATABASE, DROP TABLE, DROP USER
-- 	     이름변경 :  RENAME TABLE, RENAME USER
-- 	     보기    :  SELECT

create database initialSQL;
drop database initialsql;
-- db생성
create database initialSQl;
-- db실행
use initialsql;

-- table생성
create table profiles(
id int auto_increment primary key,
uid varchar(50) not null unique,
pw varchar(255) not null,
name varchar(50) not null,
role enum('admin', 'manage', 'user') default 'user',
active boolean default True,
created_at datetime default current_timestamp
);

-- data 삽입
insert into profiles( uid, pw, name, role, active) -- id는 자동입력
values ('ji0','1234', '김지영', 'admin', true);
insert into profiles( uid, pw, name, role, active) 
values ('abc','1234','매니저', 'manage', true);

insert into profiles(uid, pw, name, role, active) 
values('def','1234', '유저1', 'user', true),
	  ('ghi','1234', '유저2', 'user', true),
      ('jkl','1234', '유저3', 'user', true); -- 여러데이터 한번에 삽입 

-- 삽입 데이터 조회 
select * from profiles;

-- 데이터 수정 : update문으로 id 1의 name 변경
update profiles set name = '관리자'
where id = 1;

-- 데이터수정 : update문으로 전체 열에 적용 active-> true/false 처리 
use initialsql;
update profiles set active = false;
update profiles set active = true;

-- error 1175 안전모드 작동중 ,키값 사용하지않고 수정할때 전체 데이터 삭제 방지
-- 안전 모드 비활성화 쿼리
SET SQL_SAFE_UPDATES = 0; -- 안전모드 끄고
SET SQL_SAFE_UPDATES = 1; -- 안전모드 켜고

-- delete문으로 데이터 삭제하기 
/* delete from 테이블이름 where 열 = 조건 , where절 누락시 전체가 삭제됨*/
delete from profiles where id = 4; -- id 4번 회원 정보 삭제

-- delete from profiles : delete문으로 table 전체 삭제
-- truncate table profiles : truncate문으로 대량의 데이터 가장 빠르게 삭제 가능 , but 롤백 불가

-- 되새김문제
-- , /**/
create database doit_exam;
use doit_exam;
create table doit_exam_t1 (
id int auto_increment primary key,
name varchar(50) not null,
create_date datetime
);

insert into doit_exam_t1 (name)
values('강성욱'),
('이지스퍼블리싱'),
('doitmysql'); 

select * from doit_exam_t1;

update doit_exam_t1 set name = '출판사' where id = '1' ;
delete from doit_exam_t1 where id = '5' or id = '6';
drop table doit_exam_t1;
drop database doit_exam;


-- 자주 사용하는 형태의 select 문 
/*  select 열 from 테이블 where 조건 order by 열*/

-- name 열만 조회하는 쿼리
select name from profiles;

-- name과 role 등 두개이상의 열 조회하는 쿼리
select name, role from profiles;

 -- 전체 열 조회하기 : 전체 열 조회는 자원을 많이 소비, cpu,디스크에 무리
 select * from profiles;
 
 -- profiles 테이블의 열 정보를 조회
 -- 테이블의 열이름, 각데이터의 유형 NULL값 허용여부 등 타입,옵션을 확인할 수 있다.
 
 show columns from initialsql.profiles;
 
use initialsql;

-- where 절의 기본형식
/*select [열] from [테이블] where [열] = [조건값] */
-- 연산자로 '=' 특정값 조회
select * from profiles where role = 'user';

 /* 논리 연산자
 ALL : 모든 비교 집합 참일 경우
 AND : AND기준으로 양쪽 부울 표현식이 모두 참일 경우
 ANY : 비교 집합 중 하나라도 참일 경우 
 BETWEEN : 피연산자가 범위내에 있을 경우
 EXISTS : 하위쿼리에 행이 포함되는 경우
 IN : 리스트 중 하나라도 포함되면 데이터 조회
 LIKE : 패턴과 일치하는 경우
 NOT : 부울 연산자를 반대로 실행하여 조회
 OR : 한쪽이 참일 경우
 SOME : 일부가 참인 경우 */
 
 use sakila;
select * From customer where address_id between 5 and 10;
select * from payment where payment_date between '2005-06-17' and '2005-07-19'; 
select * from payment where payment_date = '2005-07-08 07:33:56';
 
 
 
-- ---------------------------------------------------------



-- 내부조인 inner join 
/* 기본 형식
select
	[열]
from [테이블1]
	inner join [테이블2] on [테이블1.열] = [테이블2.열]
where [검색 조건]
*/ 







-- 서브쿼리 
/* 소괄호로 감싼다.
주쿼리 실행전 1번만 실행된다
비교연산자 사용 우측 서브쿼리 위치alter
서브쿼리 내부 order by 사용할 수 없음 */
