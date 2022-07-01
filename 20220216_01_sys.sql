
--1줄 주석문 처리(단일행 주석문 처리)

/*
여러줄
(다중행)
주석문
처리
*/


--○ 현재 오라클 서버에 접속한 자신의 계정 조회
show user
--==>> USER이(가) "SYS"입니다.
--> sqlplus 상태일 때 사용하는 명령어


--○ 데이터 값을 제외하고는 대소문자 구분 X
--『from dual』: 의미 없는 구문임
--               어느 테이블에 접근할 필요 없을 때,
--               SQL 에서는 from 구문 써야해서 사용
select user
from dual;
--==>> SYS

SELECT USER
FROM DUAL;
--==>> SYS

select 1 + 2
from dual;
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

-- 띄어쓰기, 공백써도 에러 x
SELECT                    2 + 4
FROM            DUAL;
--==>> 6

-- BUT, 붙여쓰기 하면 에러남
SELECT 1+5
FROMDUAL;
--==>> 에러 발생
--(ORA-00923: FROM keyword not found where expected)

SELECT 쌍용강북교육센터 F강의장
FROM DUAL;
--==>> 에러 발생
--(ORA-00904: "쌍용강북교육센터": invalid identifier)
--SELECT절의 데이터가 유효하지 않아서 발생

--자바에서는 "" 하면 문자열로 취급했지만, ORACLE은 x
SELECT "쌍용강북교육센터 F강의장"
FROM DUAL;
--==>> 에러 발생
--(ORA-00972: identifier is too long)

--ORACLE 에서는 문자열 '' 로 취급함
SELECT '쌍용강북교육센터 F강의장'
FROM DUAL;
--==>> 쌍용강북교육센터 F강의장

SELECT '한 발 한 발 힘겨운 오라클 수업'
FROM DUAL;
--==>> 한 발 한 발 힘겨운 오라클 수업


-- 자바는 연산에 실수 있으면, 실수 기반으로 연산되었지만,
-- ORACLE은 어떤지 관찰해보기
SELECT 3.14 + 3.14
FROM DUAL;
--==>> 6.28

SELECT 10 * 5
FROM DUAL;
--==>> 50

SELECT 10 * 5.0
FROM DUAL;
--==>> 50

SELECT 4 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2.0
FROM DUAL;
--==>> 2

SELECT 5 / 2
FROM DUAL;
--==>> 2.5
-- 정수끼리 나눴는데, 결과가 실수

SELECT 100 - 23
FROM DUAL;
--==>> 77

