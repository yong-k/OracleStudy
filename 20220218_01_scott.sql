SELECT USER
FROM DUAL;
--==>> SCOTT


--○ EMP 테이블에서 직종이 CLERK 인 사원들의 데이터를 모두 조회한다.
SELECT *
FROM EMP
WHERE JOB = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17	800		    20
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	950		    30
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

SELECT *
FROM EMP
WHERE JOB IN 'CLERK';
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17	800		    20
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	950		    30
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

select *
from emp
where job = 'clerk';
--==>> 조회 결과 없음

select *
from emp
where job = 'CLERK';
--==>>
/*
7369	SMITH	CLERK	7902	1980-12-17	800		    20
7876	ADAMS	CLERK	7788	1987-07-13	1100		20
7900	JAMES	CLERK	7698	1981-12-03	950		    30
7934	MILLER	CLERK	7782	1982-01-23	1300		10
*/

-- ※ 오라클에서... 입력된 데이터의 값 만큼은...
--    반.드.시. 대소문자 구분을 한다 !!!


--○ EMP 테이블에서 직종이 CLERK 인 사원들 중
--   20번 부서에 근무하는 사원들의 
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL "급  여", DEPTNO 부서번호
FROM EMP
WHERE JOB = 'CLERK' AND DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	800	    20
7876	ADAMS	CLERK	1100	20
*/


--○ EMP 테이블의 구조와 데이터를 확인하여
--   이와 똑같은 데이터가 들어있는 테이블의 구조를 생성한다. (TBL_EMP)

-- 방법 1)
--① 먼저 EMP 테이블의 구조 확인하기
-- DESCRIBE = DESC
DESCRIBE EMP;
DESC EMP;
--==>>
/*
이름       널?       유형           
-------- -------- ------------ 
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)  
*/

/*
--② EMP 테이블 구조와 같게 TBL_EMP 테이블 생성
CREATE TABLE TBL_EMP
( EMPNO     IS NOT NULL, NUMBER(4)
, ENAME     VARCHAR2(10)
, JOB       VARCHAR2(9)
, MGR       NUMBER(4)
, HIREDATE  DATE    
, SAL       NUMBER(7, 2)
, COMM      NUMBER(7, 2)
, DEPTNO    NUMBER(2)
);

--③ EMP 테이블에 있는 14개의 레코드 확인 후 넣어줘야 함(INSERT)
SELECT * 
FROM EMP;

INSERT INTO ... * 14;
*/

-- 방법 2)
-- TBL_EMP 테이블 만드는데 EMP 테이블 따라 만들어라' 라는 의미
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.


--○ 복사한 테이블 확인
SELECT *
FROM TBL_EMP;
--==>> EMP 테이블 조회한 결과와 동일함

DESC TBL_EMP;
--==>>
-- 널? 만 빼고 EMP 테이블과 동일함
/*
이름     널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2) 
*/


--○ 테이블 복사(DEPT → TBL_DEPT)
CREATE TABLE TBL_DEPT
AS
SELECT *
FROM DEPT;
--==>> Table TBL_DEPT이(가) 생성되었습니다.


--○ 복사한 테이블 확인
SELECT *
FROM TBL_DEPT;
--==>> DEPT 테이블 조회한 결과와 동일함

DESC TBL_DEPT;
--==>>
-- 널? 만 빼고 EMP 테이블과 동일함
/*
이름     널? 유형           
------ -- ------------ 
DEPTNO    NUMBER(2)    
DNAME     VARCHAR2(14) 
LOC       VARCHAR2(13) 
*/


--○ 테이블의 커멘트 정보 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
DEPT	        TABLE	
EMP	            TABLE	
BONUS	        TABLE	
SALGRADE	    TABLE	
TBL_EXAMPLE1	TABLE	
TBL_EXAMPLE2	TABLE	
TBL_EMP	        TABLE	
TBL_DEPT	    TABLE	
*/


--○ 테이블 레벨의 커멘트 정보 입력
COMMENT ON TABLE TBL_EMP IS '사원 정보';
--==>> Comment이(가) 생성되었습니다.


--○ 커멘트 정보 입력 후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	
TBL_EMP	        TABLE	사원 정보
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--○ TBL_DEPT 테이블을 대상으로 테이블 레벨의 커멘트 데이터 입력
--   → 부서 정보
COMMENT ON TABLE TBL_DEPT IS '부서 정보';
--==>> Comment이(가) 생성되었습니다.


--○ 커멘트 정보 입력 후 다시 확인
SELECT *
FROM USER_TAB_COMMENTS;
--==>>
/*
TBL_DEPT	    TABLE	부서 정보
TBL_EMP	        TABLE	사원 정보
TBL_EXAMPLE2	TABLE	
TBL_EXAMPLE1	TABLE	
SALGRADE	    TABLE	
BONUS	        TABLE	
EMP	            TABLE	
DEPT	        TABLE	
*/


--○ 컬럼 레벨의 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS;
--==>>
/*
BONUS	        ENAME	
DEPT	        LOC	
TBL_DEPT	    DNAME	
EMP	            ENAME	
SALGRADE	    LOSAL	
BONUS	        JOB	
TBL_EXAMPLE2	NO	
TBL_EMP	        SAL	
TBL_EMP	        EMPNO	
DEPT	        DEPTNO	
TBL_EMP	        ENAME	
SALGRADE	    GRADE	
TBL_EMP	        JOB	
SALGRADE	    HISAL	
TBL_EXAMPLE1	ADDR	
EMP	            EMPNO	
EMP	            COMM	
BONUS	        SAL	
TBL_EXAMPLE1	NO	
TBL_DEPT	    DEPTNO	
BONUS	        COMM	
TBL_EXAMPLE2	ADDR	
TBL_DEPT	    LOC	
EMP	            SAL	
EMP	            HIREDATE	
DEPT	        DNAME	
TBL_EMP	        DEPTNO	
TBL_EMP	        MGR	
EMP         	MGR	
TBL_EXAMPLE2	NAME	
EMP	            JOB	
TBL_EXAMPLE1	NAME	
EMP	DEPT        NO	
TBL_EMP	        HIREDATE	
TBL_EMP	        COMM	
*/


--○ 컬럼 레벨의 커멘트 데이터 확인(TBL_DEPT 테이블 소속의 컬럼들만 확인)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	
TBL_DEPT	DNAME	
TBL_DEPT	LOC	
*/


--○ 테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 설정
-- 자바에서 System.in   Array.num  이렇게 썼을 때,
-- 『.』 : ~에 포함되어 있는, ~에 소속되어 있는 의미로 쓰임
-- ORACLE 에서도 마찬가지임!
COMMENT ON COLUMN TBL_DEPT.DEPTNO IS '부서 번호';
--==>> Comment이(가) 생성되었습니다.

COMMENT ON COLUMN TBL_DEPT.DNAME IS '부서명';
--==>> Comment이(가) 생성되었습니다.

COMMENT ON COLUMN TBL_DEPT.LOC IS '부서 위치';
--==>> Comment이(가) 생성되었습니다.


--○ 커멘트 데이터가 입력된 테이블의 컬럼 레벨 커멘트 데이터 확인
--   (TBL_DEPT 테이블 소속의 컬럼들만 조회)
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_DEPT';
--==>>
/*
TBL_DEPT	DEPTNO	부서 번호
TBL_DEPT	DNAME	부서명
TBL_DEPT	LOC	    부서 위치
*/


--○ TBL_EMP 테이블을 대상으로
--   테이블에 소속된(포함된) 컬럼에 대한 커멘트 데이터 설정

--① 테이블 컬럼 조회
DESC TBL_EMP;
--==>>
/*
이름     널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2) 
*/


--② 컬럼 커멘트 데이터 설정
COMMENT ON COLUMN TBL_EMP.EMPNO IS '사원 번호';
COMMENT ON COLUMN TBL_EMP.ENAME IS '사원명';
COMMENT ON COLUMN TBL_EMP.JOB IS '직종명';
COMMENT ON COLUMN TBL_EMP.MGR IS '관리자 사원번호';
COMMENT ON COLUMN TBL_EMP.HIREDATE IS '입사일';
COMMENT ON COLUMN TBL_EMP.SAL IS '급여';
COMMENT ON COLUMN TBL_EMP.COMM IS '수당';
COMMENT ON COLUMN TBL_EMP.DEPTNO IS '부서 번호';


--③ 컬럼 레벨 커멘트 데이터 확인
SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'TBL_EMP';
--==>>
/*
TBL_EMP	EMPNO	    사원 번호
TBL_EMP	ENAME	    사원명
TBL_EMP	JOB	        직종명
TBL_EMP	MGR	        관리자 사원번호
TBL_EMP	HIREDATE	입사일
TBL_EMP	SAL	        급여
TBL_EMP	COMM	    수당
TBL_EMP	DEPTNO	    부서 번호
*/



--■■■ 컬럼 구조의 추가 및 제거 ■■■--

SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		        20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	 300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500	30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	  0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	950		        30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/


--○ TBL_EMP 테이블에 주민등록번호 데이터를 담을 수 있는 컬럼 추가
--   → 컬럼이름   : SSN (숫자로만 13자리 넣을거임 → 그렇다고 숫자로 취급하면 NO)
--   → 데이터타입 : CHAR(13) → 주민번호는 누구나 13자리이므로 고정형쓰는게 유리
--   데이터 추가한다고 INSERT 아님!
--   EX) 8층짜리 건물을 9층으로 구조적으로 변경해주는 거임
--   구조적인 변경이기 때문에 → 『ALTER』
ALTER TABLE TBL_EMP
ADD SSN CHAR(13);
--==>> Table TBL_EMP이(가) 변경되었습니다.

-- 0으로 시작하는 거 숫자로 하면 0 탈락됨
SELECT 01012341234
FROM DUAL;
--==>> 1012341234

SELECT '01012341234'
FROM DUAL;
--==>> 01012341234


--○ 확인
SELECT *
FROM TBL_EMP;

-- 처음 컬럼 추가되면, 데이터는 NULL 로 되어 있다.

SELECT EMPNO, SSN
FROM TBL_EMP;

DESC TBL_EMP;

-- 사원명 뒤에 보통 주민번호 있어야 편하지 않을까? 
-- 테이블 안에서의 컬럼 순서는 아무 의미 없다.
-- BECUASE, 조회할 때, 그 순서대로 출력해주면 되기 때문에
-- 아래 구문 쓴 것처럼
SELECT EMPNO, ENAME, SSN, JOB
FROM TBL_EMP;

--> SSN(주민등록번호) 컬럼이 정상적으로 포함(추가)된 사항을 확인

--※ 테이블 내에서 컬럼의 순서는 구조적으로 의미 없음


--○ TBL_EMP 테이블에 추가한 SSN(주민등록번호) 컬럼 구조적으로 제거
--   '구조적으로 제거'한다고 DROP 아님!
--   EX) 9층짜리 건물을 8층으로 구조적으로 변경해주는 거임
--   구조적인 변경이기 때문에 → 『ALTER』
ALTER TABLE TBL_EMP
DROP COLUMN SSN;
--==>> Table TBL_EMP이(가) 변경되었습니다.

SELECT *
FROM TBL_EMP;

DESC TBL_EMP;

--> SSN(주민등록번호) 컬럼이 정상적으로 삭제되었음을 확인


DELETE TBL_EMP;
--==>> 14개 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--> 에러 발생 안함
--  데이터는 없음
--  테이블의 구조(뼈대, 틀)는 그대로 남아있는 상태에서
--  데이터만 모두 소실(삭제)된 상황임을 확인

DESC TBL_EMP;
--==>>
/*
이름       널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2) 
*/
-- DELETE 수행해도 틀은 남아있기 때문에, DESC로 뼈대 확인 가능

DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.

SELECT *
FROM TBL_EMP;
--==>> 에러 발생
--     (ORA-00942: table or view does not exist)

DESC TBL_EMP;
--==>> 에러 발생
--     (ORA-04043: TBL_EMP 객체가 존재하지 않습니다.)


--○ 테이블 다시 복사(생성)
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.


--○ NULL 의 처리
SELECT 2, 10+2, 10-2, 10*2, 10/2
FROM DUAL;
--==>> 2	12	8	20	5

SELECT NULL, NULL+2, 10-NULL, NULL*2, 2/NULL
FROM DUAL;
--==>> (null) (null)  (null) (null)  (null) 

--※ 관찰의 결과
--   NULL 은 상태의 값을 의미하며,물리적으로는 실제 존재하지 않는 값이기 때문에
--   이 NULL 이 연산에 포함될 경우...
--   그 결과는 무조건 NULL 이다.


--○ TBL_EMP 테이블에서 커미션(COMM, 수당)이 NULL 인 직원의
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.
SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = NULL;
--==>> 에러 발생하지 않음
--     조회 결과 없음
--     BUT,TBL_EMP 테이블에 COMM이 NULL 인 직원 있음..

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = 'NULL';
--==>> 에러 발생
--     (ORA-01722: invalid number)
--     → COMM 은 NUMBER 넣는 곳인데, 너 왜 문자를 찾고 있니?

SELECT ENAME, JOB, SAL, COMM
FROM TBL_EMP
WHERE COMM = (NULL);
--==>> 에러 발생하지 않음
--     조회 결과 없음

-- 『=』은 산술적인 연산을 수행하는 것이기 때문에, NULL을 비교할 수 없음
--  NULL은 물리적으로 실제로 존재하지 않기 때문에...
--  그래서 NULL 은 『IS』 키워드 이용해야 한다.

SELECT ENAME 사원명, JOB 직종명, SAL 급여, COMM 커미션
FROM TBL_EMP
WHERE COMM IS NULL;
--==>>
/*
SMITH	CLERK	     800	(null)
JONES	MANAGER	    2975	(null)
BLAKE	MANAGER	    2850	(null)
CLARK	MANAGER	    2450	(null)
SCOTT	ANALYST	    3000	(null)
KING	PRESIDENT	5000	(null)
ADAMS	CLERK	    1100	(null)
JAMES	CLERK	     950	(null)
FORD	ANALYST	    3000	(null)
MILLER	CLERK	    1300	(null)
*/

--※ NULL 은 실제 존재하는 값이 아니기 때문에
--   일반적인 연산자를 활용하여 비교할 수 없다.
--   NULL 을 대상으로 사용할 수 없는 연산자들...
--   >=, <=, =, >, <, ( !=, ^=, <> ) → '같지 않다'


--○ TBL_EMP 테이블에서 20번 부서에 근무하지 않는 직원들의
--   사원명, 직종명, 부서번호 항목을 조회한다.
SELECT ENAME 사원명, JOB 직종명, DEPTNO 부서번호
FROM TBL_EMP
WHERE DEPTNO != 20;
--==>>
/*
ALLEN	SALESMAN	30
WARD	SALESMAN	30
MARTIN	SALESMAN	30
BLAKE	MANAGER	    30
CLARK	MANAGER	    10
KING	PRESIDENT	10
TURNER	SALESMAN	30
JAMES	CLERK	    30
MILLER	CLERK	    10
*/


--○ TBL_EMP 테이블에서 커미션이 NULL 이 아닌 직원들의 
--   사원명, 직종명, 급여, 커미션 항목을 조회한다.
-- 『IS NOT』『NOT』 사용한 두 가지 방법 모두 알아둬야 함!
SELECT ENAME 사원명, JOB 직종명, SAL 급여, COMM 커미션
FROM TBL_EMP
WHERE COMM IS NOT NULL;
--==>>
/*
ALLEN	SALESMAN	1600	 300
WARD	SALESMAN	1250	 500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	   0
*/

SELECT ENAME 사원명, JOB 직종명, SAL 급여, COMM 커미션
FROM TBL_EMP
WHERE NOT COMM IS NULL;     -- NOT 키워드 사용
--==>>
/*
ALLEN	SALESMAN	1600	 300
WARD	SALESMAN	1250	 500
MARTIN	SALESMAN	1250	1400
TURNER	SALESMAN	1500	   0
*/


--○ TBL_EMP 테이블에서 모든 사원들의
--   사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--   단, 급여(SAL)는 매월 지급한다.
--   또한, 수당(COMM)은 연 1회 지급하며(매년 지급), 연봉 내역에 포함된다.
SELECT EMPNO 사원번호, ENAME 사원명, SAL 급여, COMM 커미션, (SAL*12+COMM) 연봉
FROM TBL_EMP;
--==>>
/*
7369	SMITH	 800    (null)	(null)
7499	ALLEN	1600	 300	19500
7521	WARD	1250	 500	15500
7566	JONES	2975    (null)	(null)		
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850    (null)	(null)		
7782	CLARK	2450    (null)	(null)		
7788	SCOTT	3000    (null)	(null)		
7839	KING	5000    (null)	(null)		
7844	TURNER	1500	   0	18000
7876	ADAMS	1100    (null)	(null)		
7900	JAMES	 950    (null)	(null)		
7902	FORD	3000    (null)	(null)		
7934	MILLER	1300    (null)	(null)		
*/
-- COMM 에 NULL 값이 있다보니까, 더해지면 연봉 자체가 NULL 로 되어버림,,
-- NULL 을 일관적으로 처리해서, NULL 계산해도  NULL 이 아니게 만들어줘야함
--   ↓
--   ↓
--○ NVL()
SELECT NULL "COL1", NVL(NULL, 10) "COL2", NVL(5, 10) "COL3"
FROM DUAL;
--       COL1   COL2   COL3
--==>> 	(null)    10      5
-- 첫 번째 파라미터 값이 NULL 이면,      두 번재 파라미터 값을 반환한다.
-- 첫 번재 파라미터 값이 NULL 이 아니면, 그 값을 그대로 반환한다.

SELECT ENAME 사원명, NVL(COMM, 1234) 수당
FROM TBL_EMP;
--==>>
/*
SMITH	1234
ALLEN	300
WARD	500
JONES	1234
MARTIN	1400
BLAKE	1234
CLARK	1234
SCOTT	1234
KING	1234
TURNER	0
ADAMS	1234
JAMES	1234
FORD	1234
MILLER	1234
*/

-- NVL() 사용해서 아래 문제 다시 풀어보기
-- TBL_EMP 테이블에서 모든 사원들의
-- 사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
-- 단, 급여(SAL)는 매월 지급한다.
-- 또한, 수당(COMM)은 연 1회 지급하며(매년 지급), 연봉 내역에 포함된다.
SELECT EMPNO 사원번호, ENAME 사원명, SAL 급여, COMM 커미션, 
             (SAL * 12 + NVL(COMM, 0)) 연봉
FROM TBL_EMP;
--==>>
/*
7369	SMITH	 800  (null)     9600
7499	ALLEN	1600	 300	19500
7521	WARD	1250	 500	15500
7566	JONES	2975  (null)	35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850  (null)	34200
7782	CLARK	2450  (null)	29400
7788	SCOTT	3000  (null)	36000
7839	KING	5000  (null)	60000
7844	TURNER	1500	   0	18000
7876	ADAMS	1100  (null)	13200
7900	JAMES	 950  (null)	11400
7902	FORD	3000  (null)	36000
7934	MILLER	1300  (null)	15600
*/


--○ NVL2()
-->  첫 번재 파라미터 값이 NULL 이 아닌 경우, 두 번째 파라미터 값을 반환하고
--   첫 번째 파라미터 값이 NULL 인 경우     , 세 번째 파라미터 값을 반환한다.
SELECT ENAME "사원명", NVL2(COMM, '수당O', '수당X') "수당확인"
FROM TBL_EMP;
--==>>
/*
SMITH	수당X
ALLEN	수당O
WARD	수당O
JONES	수당X
MARTIN	수당O
BLAKE	수당X
CLARK	수당X
SCOTT	수당X
KING	수당X
TURNER	수당O
ADAMS	수당X
JAMES	수당X
FORD	수당X
MILLER	수당X
*/

SELECT EMPNO 사원번호, ENAME 사원명, SAL 급여, COMM 커미션, 
       (SAL * 12 + NVL2(COMM, COMM, 0)) 연봉
FROM TBL_EMP;


SELECT EMPNO 사원번호, ENAME 사원명, SAL 급여, COMM 커미션, 
       NVL2(COMM, SAL*12+COMM, SAL*12) 연봉
FROM TBL_EMP;


--○ COALESCE()
--> 매개변수 제한이 없는 형태로 인지하고 활용한다.
--  맨 앞에 있는 매개변수부터 차례로 NULL 인지 아닌지 확인하여
--  NULL 이 아닐 경우 반환하고,
--  NULL 인 경우에는 그 다음 매개변수의 값을 반환한다.
--  모~~~든 경우의 수를 고려할 수 있다는 특징을 갖는다.

SELECT NULL "COL1"
    , COALESCE(NULL, NULL, NULL, 30) "COL2"
        -- 쭉 가다가 30만나고 반환
    , COALESCE(NULL, NULL, NULL, NULL, NULL, NULL, 100) "COL3"
        -- 쭉~ 계속 NULL 이다가 100 만나고 100 반환
    , COALESCE(10, NULL, NULL, NULL, NULL, NULL, NULL) "COL4"
        -- NULL 이 아닌 10 먼저 봤으니 10 반환
    , COALESCE(NULL, NULL, NULL, 50, NULL, NULL, NULL, 100) "COL5"    
        -- NULL 지나가다 50 먼저 봤으니 50 반환
FROM DUAL;
--==>> 	(null) 30	100	 10	 50


--○ 실습을 위한 데이터 추가 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO)
VALUES(8000, '호석이', 'SALESMAN', 7369, SYSDATE, 10);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8001, '문정이', 'SALESMAN', 7369, SYSDATE, 10, 10);
--==>> 1 행 이(가) 삽입되었습니다

SELECT *
FROM TBL_EMP;
--호석이, 문정이 잘 들어가 있는지 확인 완료

COMMIT;
--==>> 커밋 완료.


--○ 데이터가 추가된 현재 상태의 TBL_EMP 테이블에서 모든 사원의
--   사원번호, 사원명, 급여, 커미션, 연봉 항목을 조회한다.
--   연봉 산출 기준은 위와 같다.
----- 내가 한 거 
SELECT EMPNO 사원번호, ENAME 사원명, SAL 급여, COMM 커미션, 
    (NVL(SAL, 0) * 12 + NVL(COMM, 0)) 연봉
FROM TBL_EMP;
--==>>
/*
7369	SMITH	 800  (null)	 9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975  (null)	35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850  (null)  	34200
7782	CLARK	2450  (null)	29400
7788	SCOTT	3000  (null)	36000
7839	KING	5000  (null)	60000
7844	TURNER	1500	   0	18000
7876	ADAMS	1100  (null)	13200
7900	JAMES	 950  (null) 	11400
7902	FORD	3000  (null)	36000
7934	MILLER	1300  (null)	15600
8000	호석이 (null) (null)		    0
8001	문정이 (null)	  10	   10
*/
----- 쌤이 한 거
SELECT EMPNO "사원번호", ENAME "사원명", SAL "급여", COMM "커미션", 
    COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "연봉"
FROM TBL_EMP;
--  SAL*12+COMM 이 NULL 이면, (COMM NULL 의심되니까) SAL*12
--  SAL*12 가 NULL 이면,      (SAL NULL 의심되니까) COMM
--  COMM 이 NULL 이면,        0으로 처리해라.
--==>>
/*
7369	SMITH	 800  (null)	 9600
7499	ALLEN	1600	300	    19500
7521	WARD	1250	500	    15500
7566	JONES	2975  (null)	35700
7654	MARTIN	1250	1400	16400
7698	BLAKE	2850  (null)  	34200
7782	CLARK	2450  (null)	29400
7788	SCOTT	3000  (null)	36000
7839	KING	5000  (null)	60000
7844	TURNER	1500	   0	18000
7876	ADAMS	1100  (null)	13200
7900	JAMES	 950  (null) 	11400
7902	FORD	3000  (null)	36000
7934	MILLER	1300  (null)	15600
8000	호석이 (null) (null)		    0
8001	문정이 (null)	  10	   10
*/


--○ 컬럼과 컬럼의 연결(결합)
SELECT 1, 2
FROM DUAL;
--==>> 1	2

-- 자바 같으면 그냥 『+』연산자 사용해서 결합하겠지만, ORACLE은 계산됨
SELECT 1 + 2
FROM DUAL;
--==>> 3

SELECT '민지', '정용이'
FROM DUAL;
--==>> 민지	정용이

SELECT '민지' + '정용이'
FROM DUAL;
--==>> 에러 발생
--     (ORA-01722: invalid number)


-- 『||』 : PIPE
-- ORACLE 에서는 PIPE라고 부름 (자바에서는 OR 연산자)
-- 단순한 결합만 하는게 아니라, 컬럼끼리도, 데이터타입도 결합
SELECT '민지' || '정용이'
FROM DUAL;
--==>> 민지정용이

SELECT ENAME || JOB
FROM TBL_EMP;
--==>
/*
SMITHCLERK
ALLENSALESMAN
WARDSALESMAN
JONESMANAGER
MARTINSALESMAN
BLAKEMANAGER
CLARKMANAGER
SCOTTANALYST
KINGPRESIDENT
TURNERSALESMAN
ADAMSCLERK
JAMESCLERK
FORDANALYST
MILLERCLERK
호석이SALESMAN
문정이SALESMAN
*/

SELECT '수정이는 ', SYSDATE, '에 연봉 ', 500, '억을 원한다.'
FROM DUAL;
--==>> 수정이는   2022-02-18	    에 연봉 	    500	    억을 원한다.
--     --------  -----------    --------    ---     ------------
--     문자타입     문자타입     문자타입   숫자타입    문자타입

SELECT '수정이는 ' || SYSDATE || '에 연봉 ' || 500 || '억을 원한다.'
FROM DUAL;
--==>> 수정이는 2022-02-18에 연봉 500억을 원한다.
-- 컬럼 하나에 다 모아져서 나옴 !

--※ 오라클에서는 문자 타입의 형태로 형 변환하는 별도의 과정 없이
--   『||』만 삽입해주면 간단히 컬럼과 컬럼(서로 다른 종류의 데이터)을
--   결합하는 것이 가능하다.
--   cf) MSSQL 에서는 모든 데이터를 문자열로 CONVERT 해야 한다.

SELECT *
FROM TBL_EMP;

--○ TBL_EMP 테이블의 데이터를 활용하여
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다.
--   『SMITH의 현재 연봉은 9600인데 희망 연봉은 19200이다.
--     ALLEN의 현재 연봉은 19500인데 희망 연봉은 39000이다.
--                          :
--     문정이의 현재 연봉은 10인데 희망 연봉은 20이다.』
--   단, 레코드마다 위의 내용이 한 컬럼에 모두 조회될 수 있도록 처리한다.

SELECT ENAME || '의 현재 연봉은 ' 
    || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) || '인데 희망 연봉은 ' 
    || COALESCE(SAL*12+COMM, SAL*12, COMM, 0) * 2 || '이다.'
FROM TBL_EMP;
--==>>
/*
SMITH의 현재 연봉은 9600인데 희망 연봉은 19200이다.
ALLEN의 현재 연봉은 19500인데 희망 연봉은 39000이다.
WARD의 현재 연봉은 15500인데 희망 연봉은 31000이다.
JONES의 현재 연봉은 35700인데 희망 연봉은 71400이다.
MARTIN의 현재 연봉은 16400인데 희망 연봉은 32800이다.
BLAKE의 현재 연봉은 34200인데 희망 연봉은 68400이다.
CLARK의 현재 연봉은 29400인데 희망 연봉은 58800이다.
SCOTT의 현재 연봉은 36000인데 희망 연봉은 72000이다.
KING의 현재 연봉은 60000인데 희망 연봉은 120000이다.
TURNER의 현재 연봉은 18000인데 희망 연봉은 36000이다.
ADAMS의 현재 연봉은 13200인데 희망 연봉은 26400이다.
JAMES의 현재 연봉은 11400인데 희망 연봉은 22800이다.
FORD의 현재 연봉은 36000인데 희망 연봉은 72000이다.
MILLER의 현재 연봉은 15600인데 희망 연봉은 31200이다.
호석이의 현재 연봉은 0인데 희망 연봉은 0이다.
문정이의 현재 연봉은 10인데 희망 연봉은 20이다.
*/


--○ SYSDATE 출력 형식 바꾸기
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2022-02-18 15:36:05

-- 지금은 시,분,초 까지 필요없으니까 연,월,일만 보는 형식으로 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2022-02-18


--○ TBL_EMP 테이블의 데이터를 활용하여
--   다음과 같은 결과를 얻을 수 있도록 쿼리문을 구성한다.
--   『SMITH's 입사일은 1980-12-17이다. 그리고 급여는 800이다.
--     ALLEN's 입사일은 1981-02-20이다. 그리고 급여는 1600이다.
--                          :
--  
--     문정이's 입사일은 2022-02-18이다. 그리고 급여는 0이다.』
--   단, 레코드마다 위의 내용이 한 컬럼에 모두 조회될 수 있도록 처리한다.
SELECT ENAME || '''s 입사일은 ' || HIREDATE 
    || '이다. 그리고 급여는 ' || NVL(SAL, 0) || '이다.'
FROM TBL_EMP;
--==>>
/*
SMITH's 입사일은 1980-12-17이다. 그리고 급여는 800이다.
ALLEN's 입사일은 1981-02-20이다. 그리고 급여는 1600이다.
WARD's 입사일은 1981-02-22이다. 그리고 급여는 1250이다.
JONES's 입사일은 1981-04-02이다. 그리고 급여는 2975이다.
MARTIN's 입사일은 1981-09-28이다. 그리고 급여는 1250이다.
BLAKE's 입사일은 1981-05-01이다. 그리고 급여는 2850이다.
CLARK's 입사일은 1981-06-09이다. 그리고 급여는 2450이다.
SCOTT's 입사일은 1987-07-13이다. 그리고 급여는 3000이다.
KING's 입사일은 1981-11-17이다. 그리고 급여는 5000이다.
TURNER's 입사일은 1981-09-08이다. 그리고 급여는 1500이다.
ADAMS's 입사일은 1987-07-13이다. 그리고 급여는 1100이다.
JAMES's 입사일은 1981-12-03이다. 그리고 급여는 950이다.
FORD's 입사일은 1981-12-03이다. 그리고 급여는 3000이다.
MILLER's 입사일은 1982-01-23이다. 그리고 급여는 1300이다.
호석이's 입사일은 2022-02-18이다. 그리고 급여는 0이다.
문정이's 입사일은 2022-02-18이다. 그리고 급여는 0이다.
*/

--※ 문자열을 나타내는 홑따옴표 사이에서(시작과 끝)
--   홑따옴표 두 개가 홑따옴표 하나(어퍼스트로피)를 의미한다.
--   홑따옴표 『'』 하나는 문자열의 영역이 시작된다는 것을 나타내고
--   이 문자열 영역 안에서 홑따옴표『''』 두 개는 어퍼스트로피를 나타내며
--   다시 등장하는 홑따옴표 『'』 하나가
--   문자열 영역의 종료를 의미하게 되는 것이다.

SELECT *
FROM TBL_EMP
WHERE JOB = 'SALESMAN';


--○ UPPER(), LOWER(), INITCAP()
SELECT 'oRaCLe' "COL1"
    , UPPER('oRaCLe') "COL2"
    , LOWER('oRaCLe') "COL3"
    , INITCAP('oRaCLe') "COL4"
FROM DUAL;
--==>> oRaCLe	ORACLE	oracle	Oracle
--> UPPER() 는 모두 대문자로 변환
--  LOWER() 는 모두 소문자로 변환
--  INITCAP() 은 첫 글자만 대문자로 하고 나머지는 모두 소문자로 변환하여 반환


--○ TBL_EMP 테이블을 대상으로 검색값이 'sALeSmAN' 인 조건으로
--   해당 직종 사원의 사원번호, 사원명, 직종명을 조회한다.
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명
FROM TBL_EMP
WHERE JOB = UPPER('sALeSmAN');
--==>>
/*
7499	ALLEN	SALESMAN
7521	WARD	SALESMAN
7654	MARTIN	SALESMAN
7844	TURNER	SALESMAN
8000	호석이	SALESMAN
8001	문정이	SALESMAN
*/
-- 이거는 모든 데이터가 대문자여야 한다는 전제가 있어야 가능한 쿼리문이다,,,!


--○ 실습을 위한 추가 데이터 입력
INSERT INTO TBL_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, DEPTNO, COMM)
VALUES(8002, '태형이', 'salesman', 7369, SYSDATE, 20, 100);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_EMP;
--==>> 8002	태형이	salesman	7369	2022-02-18		100	20   잘 들어가있음

COMMIT;
--==>> 커밋 완료.


--○ TBL_EMP 테이블에서 직종이 영업사원(세일즈맨)인 사원들의 
--   사원번호, 사원명, 직종명을 조회한다.
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명
FROM TBL_EMP
WHERE UPPER(JOB) = UPPER('sALeSmAN');
-- 먼저 JOB 의 데이터 다 대문자로 바꾼 다음에,
-- 검색할 데이터도 대문자로 바꾼 후, 검색하면 됨!

-- 아래 방법도 위와 동일함 !
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명
FROM TBL_EMP
WHERE LOWER(JOB) = LOWER('sALeSmAN');

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명
FROM TBL_EMP
WHERE INITCAP(JOB) = INITCAP('sALeSmAN');


--○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 입사한 직원의
--   사원명, 직종명, 입사일 항목을 조회한다.
SELECT ENAME 사원명, JOB 직종명, HIREDATE 입사일
FROM TBL_EMP
WHERE HIREDATE = '1981-09-28';
--    --------    -----------
--    날짜타입      문자타입
--==>> MARTIN	SALESMAN	1981-09-28
-- 이거 됨. 이게 오라클의 자동형변환이다.
-- 근데, 오라클의 자동형변환 믿고 쓰면 안 된다고 했음
-- 그래서, 우리가 꼭 명시적으로 데이터타입 변환해서 써야 함!!

-- 결과는 제대로 나오지만, 
-- 사실상 위의 커리문은 틀린 커리문 !!!!
-- 날짜변환해서 써야 함 → 『TO_DATE()』

DESC TBL_EMP;
--==>>
/*
이름     널? 유형           
-------- -- ------------ 
EMPNO       NUMBER(4)    
ENAME       VARCHAR2(10) 
JOB         VARCHAR2(9)  
MGR         NUMBER(4)    
HIREDATE    DATE            -- CHECK~!!!         
SAL         NUMBER(7,2)  
COMM        NUMBER(7,2)  
DEPTNO      NUMBER(2) 
*/


--○ TO_DATE()
SELECT ENAME 사원명, JOB 직종명, HIREDATE 입사일
FROM TBL_EMP
WHERE HIREDATE = TO_DATE('1981-09-28', 'YYYY-MM-DD');
--                        ----------
--                        1981-9-28 → 숫자타입
--                       -------------
--                       '1981-09-28' → 문자타입
--               ----------------------------------
--                  1981년 9월 28일 → 날짜타입

--==>> MARTIN	SALESMAN	1981-09-28
-- 아까와 결과는 같지만, 쿼리문 정상적으로 써서 실행한거임!


--○ TBL_EMP 테이블에서 입사일이 1981년 9월 28일 이후(해당일 포함)
--   입사한 직원들의 사원명, 직종명, 입사일 항목을 조회한다.
SELECT ENAME 사원명, JOB 직종명, HIREDATE 입사일
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>>
/*
MARTIN	SALESMAN	1981-09-28
SCOTT	ANALYST	    1987-07-13
KING	PRESIDENT	1981-11-17
ADAMS	CLERK	    1987-07-13
JAMES	CLERK	    1981-12-03
FORD	ANALYST	    1981-12-03
MILLER	CLERK	    1982-01-23
호석이	SALESMAN	2022-02-18
문정이	SALESMAN	2022-02-18
태형이	salesman	2022-02-18
*/

--※ 오라클에서는 날짜 데이터에 대한 크기 비교가 가능하다.
--   오라클에서는 날짜 데이터에 대한 크기 비교 시
--   과거보다 미래를 더 큰 값으로 간주한다.


--○ TBL_EMP 테이블에서 입사일이 1981년 4월 2일 부터 
--   1981년 9월 28일 사이에 입사한 직원들의
--   사원명, 직종명, 입사일 항목을 조회한다. (해당일 포함)
SELECT ENAME 사원명, JOB 직종명, HIREDATE 입사일
FROM TBL_EMP
WHERE TO_DATE('1981-04-02', 'YYYY-MM-DD') <= HIREDATE 
    <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==> 에러 발생
--    (ORA-00933: SQL command not properly ended)
-- 1981-04-02 <= 입사일 <= 1981-09-28 
-- 자바에서도 그렇지만, 오라클에서도 이렇게 안 됨


-- 아래와 같은 두 가지 방법으로 가능하다.
--①
SELECT ENAME 사원명, JOB 직종명, HIREDATE 입사일
FROM TBL_EMP
WHERE HIREDATE >= TO_DATE('1981-04-02', 'YYYY-MM-DD')  
  AND HIREDATE <= TO_DATE('1981-09-28', 'YYYY-MM-DD');
    
-- 날짜
-- 이후(이상) → 해당일 포함  cf) 초과
-- 이전(이하) → 해당일 포함  cf) 미만

--○ BETWEEN ⓐ AND ⓑ     
--②
SELECT ENAME 사원명, JOB 직종명, HIREDATE 입사일
FROM TBL_EMP
WHERE HIREDATE BETWEEN TO_DATE('1981-04-02', 'YYYY-MM-DD')
                   AND TO_DATE('1981-09-28', 'YYYY-MM-DD');
--==>> 
/*
JONES	MANAGER	    1981-04-02
MARTIN	SALESMAN	1981-09-28
BLAKE	MANAGER	    1981-05-01
CLARK	MANAGER	    1981-06-09
TURNER	SALESMAN	1981-09-08
*/
    
    
--○ TBL_EMP 테이블에서 급여(SAL)가 2450 에서 3000 사이의 직원들을 모두 조회한다.
SELECT *
FROM TBL_EMP
WHERE SAL BETWEEN 2450 AND 3000;
--==>>
/*
7566	JONES	MANAGER	7839	1981-04-02	2975		20
7698	BLAKE	MANAGER	7839	1981-05-01	2850		30
7782	CLARK	MANAGER	7839	1981-06-09	2450		10
7788	SCOTT	ANALYST	7566	1987-07-13	3000		20
7902	FORD	ANALYST	7566	1981-12-03	3000		20
*/
SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 'S';    -- 사전식 배열이기 때문에 'S' 안나옴
-- 만약 이름이 'S' 한글자 라면 나옴
-- 근데 'S~~' 면 사전으로 봤을 때, 'S'보다 뒤에 있음
-- 그러므로 출력되지 않는 거! 
-- BETWEEN A AND B 가 문자타입에만 이상, 미만 으로 작동하는 거 아님 !!!
--==>>
/*
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7900	JAMES	CLERK	    7698	1981-12-03 	 950		    30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/

--'S'를 소문자 's'로 바꾸면,
SELECT *
FROM TBL_EMP
WHERE ENAME BETWEEN 'C' AND 's';
--> SMITH, SCOTT, WARD, TURNER 다 출력됨

-- 아스키코드에 보면, 대문자가 먼저 나오고, 소문자가 나중에 나옴
-- 뒤에 조건이 소문자면, 대문자로 시작하는 건 다 나옴
--> **사전식 배열이고, 아스키코드 구성을 띄고 있기 때문에 !!


--※ BETWEEN ⓐ AND ⓑ 는 날짜형, 숫자형, 문자형 데이터 모두에 적용된다.
--   단, 문자형일 경우 아스키코드 순서를 따르기 때문에 (사전식 배열)
--   대문자가 앞쪽에 위치하고 소문자가 뒤쪽에 위치한다.
--   또한, BETWEEN ⓐ AND ⓑ 는 해당 구문이 수행되는 시점에서
--   오라클 내부적으로는 부등호 연산자의 형태로 바뀌어 연산 처리된다.

-- BETWEEN ⓐ AND ⓑ 는 사람이 편하려고 쓰는 것이다.
-- 부등호로 코드되어 있는 걸, 보기 좋게 한다고 BETWEEN ⓐ AND ⓑ 로 할 필요 없음
-- 부등호로 되어있는게 더 빠름! (0.0000001초라도 ㅎ)
-- 그렇다고 BETWEEN ⓐ AND ⓑ 를 피하고 부등호만 쓸 필요도 없음 ㅎㅎ


--○ ORACLE에서 내가 원하는 문자의 ASCII 코드 확인방법
SELECT ASCII('A') "COL1", ASCII('B') "COL2", 
    ASCII('a') "COL3", ASCII('b') "COL4"
FROM DUAL;
--==>> 65	66	97	98
