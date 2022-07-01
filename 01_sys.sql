-- TABLESPACE 생성
CREATE TABLESPACE TBS_TEAM1
DATAFILE 'C:\TESTDATA\TBS_TEAM1.DBF'
SIZE 4M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;
--==>> TABLESPACE TBS_TEAM1이(가) 생성되었습니다.


-- 계정생성
CREATE USER team1 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM1;
--==>> User TEAM1이(가) 생성되었습니다.


-- create session 권한 부여
GRANT CREATE SESSION TO team1;
--==>> Grant을(를) 성공했습니다.


-- team1 접속개체 생성
/*
name : local_team1
사용자이름: team1
비밀번호 : java006$
롤: 기본값
*/


-- create table 권한 부여
GRANT CREATE TABLE TO team1;
--==>> Grant을(를) 성공했습니다.


-- 각자 생성한 오라클 사용자 계정에 할당량 부여
ALTER USER team1
QUOTA UNLIMITED ON TBS_TEAM1;
--==>> User TEAM1이(가) 변경되었습니다.


-- create sequence 권한 부여
GRANT CREATE SEQUENCE TO team1;
--==>> Grant을(를) 성공했습니다.


-- create view 권한 부여
GRANT CREATE VIEW TO team1;
--==>> Grant을(를) 성공했습니다.


-- resource 권한 부여
GRANT RESOURCE TO team1;
--==>> Grant을(를) 성공했습니다.


-- create procedure 권한 부여
GRANT CREATE PROCEDURE TO team1;
--==>> Grant을(를) 성공했습니다.
