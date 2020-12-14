-- 1. 작업 데이터베이스 선택

use mysql;

show tables;

desc user;

select user, host, authentication_string
from user;

-- DBMS가 실행되고 있는 컴퓨터에서 접속하는 사용자 계정 만들기 + 권한 부여
create user ssac@localhost identified with mysql_native_password by 'ssac';
grant all privileges on sqldb.* to ssac@localhost;

-- 외부에서 접속하는 사용자 계정 만들기 + 권한 부여
create user ssac@'%' identified with mysql_native_password by 'ssac';
grant all privileges on sqldb.* to ssac@localhost;

select user, host, authentication_string
from user;

-- 권한 조정 작업 확정
flush privileges;