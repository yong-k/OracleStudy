SELECT USER
FROM DUAL;
--==>> SCOTT


CREATE TABLE DEPT
( DEPTNO NUMBER(2) CONSTRAINT PK_DEPT PRIMARY KEY
, DNAME VARCHAR2(14)
, LOC VARCHAR2(13) 
) ;
--==>> Table DEPT이(가) 생성되었습니다.


CREATE TABLE EMP
( EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY
, ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, MGR NUMBER(4)
, HIREDATE DATE
, SAL NUMBER(7,2)
, COMM NUMBER(7,2)
, DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT
);
--==>> Table EMP이(가) 생성되었습니다.
/*
NUMBER(정밀도, 배율)
정밀도: 소수점의 오른쪽과 왼쪽에 저장될 수 있는 전체 자릿수의 최댓값
배율  : 소수점의 오른쪽에 저장될 수 있는 최대 자릿수
        기본값은 0 이므로, 0 <= 배율 <= 정밀도 여야 한다.

NUMBER(5, 2) : 최대 정수자리 3자리
                    소수자리 2자리 를 입력받을 수 있는 숫자형 데이터 형식
             : 정수부분이 3자리 이상 넘어갈 수 없다.       
*/


INSERT INTO DEPT VALUES	(10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES	(30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES	(40,'OPERATIONS','BOSTON');
-- 4줄 블록잡고 실행
--==>> 1 행 이(가) 삽입되었습니다. * 4


INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,to_date('9-6-1981','dd-mm-yyyy'),2450,NULL,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,to_date('13-7-1987','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',NULL,to_date('17-11-1981','dd-mm-yyyy'),5000,NULL,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,to_date('13-7-1987','dd-mm-yyyy'),1100,NULL,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,to_date('23-1-1982','dd-mm-yyyy'),1300,NULL,10);
-- 34~61행 블록잡고 실행
--==>> 1 행 이(가) 삽입되었습니다. * 14


CREATE TABLE BONUS
( ENAME VARCHAR2(10)
, JOB VARCHAR2(9)
, SAL NUMBER
, COMM NUMBER
);
--==>> Table BONUS이(가) 생성되었습니다.


CREATE TABLE SALGRADE
( GRADE NUMBER
, LOSAL NUMBER
, HISAL NUMBER 
);
--==>> Table SALGRADE이(가) 생성되었습니다.


INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
-- 5줄 블록잡고 실행
--==>> 1 행 이(가) 삽입되었습니다. * 5


COMMIT;
--==>> 커밋 완료.

-------------------------------------------------------------------------------

--○ SCOTT 계정이 갖고 있는 테이블 조회
SELECT *
FROM TAB;
--==>>
/*
BONUS	    TABLE	
DEPT	    TABLE	
EMP	        TABLE	
SALGRADE	TABLE	
*/

SELECT *
FROM USER_TABLES;
--==>>
/*
DEPT	    USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO		DISABLED	YES		DISABLED	DISABLED		NO	NO	YES	DEFAULT
EMP	        USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO		DISABLED	YES		DISABLED	DISABLED		NO	NO	YES	DEFAULT
BONUS	    USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO		DISABLED	YES		DISABLED	DISABLED		NO	NO	YES	DEFAULT
SALGRADE	USERS			VALID	10		1	255	65536	1048576	1	2147483645				YES	N									         1	         1	    N	ENABLED			NO		N	N	NO	DEFAULT	DEFAULT	DEFAULT	DISABLED	NO	NO		DISABLED	YES		DISABLED	DISABLED		NO	NO	YES	DEFAULT
*/

--○ 위에서 조회한 각각의 테이블들이
--   어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>>
/*
DEPT	    USERS
EMP	        USERS
BONUS	    USERS
SALGRADE	USERS
*/

--○ 테이블 생성(테이블명 : TBL_EXAMPLE1)
-- 테이블 생성구문만 작성
CREATE TABLE TBL_EXAMPLE1
( NO    NUMBER
, NAME  VARCHAR2(10)    -- VARCHAR2 : 문자열 의미
, ADDR  VARCHAR2(20)    -- ADDR : 주소(ADDRESS)
);
--==>> Table TBL_EXAMPLE1이(가) 생성되었습니다.


--○ 테이블 생성(테이블명 : TBL_EXAMPLE2)
-- TABLESPACE 구문 통해서 어떤 TABLESPACE에 만들건지 지정함
CREATE TABLE TBL_EXAMPLE2
( NO    NUMBER
, NAME  VARCHAR(10)
, ADDR  VARCHAR(20)
) TABLESPACE TBS_EDUA;
--==>> Table TBL_EXAMPLE2이(가) 생성되었습니다.


--○ TBL_EXAMPLE1 과 TBL_EXAMPLE2 테이블이
--   각각 어떤 테이블스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>>
/*
DEPT	        USERS
EMP	            USERS
BONUS	        USERS
SALGRADE	    USERS
TBL_EXAMPLE1	USERS
TBL_EXAMPLE2	TBS_EDUA
*/

--------------------------------------------------------------------------------
-- !!!! 지금하는거 ORACLE 통틀어서 가장 중요한 내용 할거임 !!!!

--■■■ 관계형 데이터베이스 ■■■--

-- 각각의 데이터를 테이블의 형태로 연결시켜 저장해 놓은 구조
-- 그리고 이들 각각의 테이블들 간의 관계를 설정하여 연결시켜 놓은 구조

-- **처리 순서대로 암기**
/*=======================================
  ※ SELECT 문의 처리(PARSING) 순서
    
     SELECT 컬럼명      -- ⑤
     FROM 테이블명      -- ①
     WHERE 조건절       -- ②   
     GROUP BY 절        -- ③
     HAVING  조건절     -- ④
     ORDER BY 절        -- ⑥
     
=======================================*/

--○ SCOTT 소유의 테이블 조회
SELECT *
FROM TAB;
--==>>
/*
BONUS	        TABLE   -- 보너스(BONUS)    데이터 테이블
DEPT	        TABLE	-- 부서(DEPARTMENT) 데이터 테이블
EMP	            TABLE	-- 사원(EMPLOYEES)  데이터 테이블
SALGRADE	    TABLE	-- 급여(SAL)        데이터 테이블

TBL_EXAMPLE1	TABLE	 
TBL_EXAMPLE2	TABLE	 
*/


--○ 각 테이블의 데이터 조회
SELECT *
FROM BONUS;
--==>> 조회 데이터 없음(조회 결과 없음)

SELECT *
FROM DEPT;
--==>>
/* 
DEPTNO  DNAME       LOC
-----------------------------
    10	ACCOUNTING	NEW YORK
    20	RESEARCH	DALLAS
    30	SALES	    CHICAGO
    40	OPERATIONS	BOSTON
*/

SELECT *
FROM EMP;
--==>>
/*
EMPNO    ENAME  JOB         MGR     HIREDATE    SAL     COMM    DEPTNO
직원번호 이름   직업        매니저   고용날짜    급여     수당   부서번호
-----------------------------------------------------------------------
7369	SMITH	CLERK	    7902	1980-12-17	 800		    20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	 300 	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500 	30
7566	JONES	MANAGER	    7839	1981-04-02	2975		    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250    1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850		    30
7782	CLARK	MANAGER	    7839	1981-06-09	2450		    10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000		    20
7839	KING	PRESIDENT		    1981-11-17	5000		    10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0	30
7876	ADAMS	CLERK	    7788	1987-07-13	1100		    20
7900	JAMES	CLERK	    7698	1981-12-03	 950		    30
7902	FORD	ANALYST	    7566	1981-12-03	3000		    20
7934	MILLER	CLERK	    7782	1982-01-23	1300		    10
*/
-- 매니저번호 보고 누가 상사인지 알 수 있고,
-- 부서번호 보고,DEPT 테이블 통해 근무지도 어딘지 알 수 있음

SELECT *
FROM SALGRADE;
--==>>
/*
GRADE   LOSAL   HISAL
---------------------
    1	 700	1200
    2	1201	1400
    3	1401	2000
    4	2001	3000
    5	3001	9999
*/


--○ DEPT 테이블에 존재하는 컬럼의 구조 조회 : 『DESCRIBE 테이블명;』
DESCRIBE DEPT;
--==>>
/*
        비워둬도 돼? 물어보는거
        ----
이름     널?       유형 → 데이터타입           
------ -------- ------------ 
DEPTNO NOT NULL NUMBER(2)       -- 부서번호 → 꼭 입력해야함
DNAME           VARCHAR2(14)    -- 부서명 → 입력안해도 됨
LOC             VARCHAR2(13)    -- 부서위치(LOCATION) → 입력안해도 됨
*/

-- DEPTNO       DNAME      LOC
-- 부서번호     부서명     부서위치 
-- ex)
--      10      인사부     서울    → 데이터 입력 가능
--      20                 서울    → 데이터 입력 가능
--      30      개발부             → 데이터 입력 가능
--              인사부     서울    → 데이터 입력 불가~!!!

--------------------------------------------------------------------------------

--■■■ 오라클의 주요 자료형(DATA TYPE) ■■■--
/*
 cf) MSSQL 서버의 정수 표현 타입
     tinyint    0 ~ 255             1byte
     smallint   -32,768 ~ 32,767    2byte
     int        -21억 ~ 21억        4byte
     bigint     엄청 큼             8byte
     
     MSSQL 서버의 실수 표현 타입
     float, real        -- real이 자바에서의 double이라고 생각하면 됨
     
     MSSQL 서버의 숫자 표현 타입
     decimal, numeric
     
     MSSQL 서버의 문자 표현 타입
     char, varchar, Nvarchar  
*/

/*
※ ORACLE 은 숫자 표현 타입이 한 가지로 통일되어 있다.

   1. 숫자형 NUMBER        → -10의 38승-1 ~ 10의 38승
             NUMBER(3)     → -999 ~ 999      (→ 정수 3자리 제공)
             NUMBER(4)     → -9999 ~ 9999    (→ 정수 4자리 제공)
             NUMBER(4, 1)  → -999.9 ~ 999.9  (→ 총 4자리인데, 
                                                  실수에 1자리 떼어준 거)
             
※ ORACLE 의 문자 표현 타입

   2. 문자형   
   
        CHAR         → 고정형 크기
        CHAR(10)     → 무조건 10Byte 소모
        CHAR(10)     ← '강의실' 넣으면,    (--한글 한 자 2Byte)
                        실제 데이터는 6Byte 이지만, 10Byte를 소모
        CHAR(10)     ← '졸린한충희' 넣으면, 그래도 10Byte를 소모  
        CHAR(10)     ← '곧잔다김민성' 넣으면, 10Byte 를 초과하므로 입력 불가(에러)
        
        VARCHAR2     → 가변형 크기
        VARCHAR2(10) → 담긴 데이터에 따라 크기가 변화
        VARCHAR2(10) ← '김정용'       넣으면, 6Byte를 소모
        VARCHAR2(10) ← '멀다김정용'   넣으면, 10Byte를 소모
        VARCHAR2(10) ← '가까이김정용' 넣으면, 10Byte를 초과하므로 입력 불가
                        ** 가변형이지만, 지정해놓은 범위를 초과하지는 않음 !
            
                    
        --데이터타입에 『N』 이 붙어있으면 '유니코드기반'이라고 생각하면 됨  
        
        NCHAR         → 유니코드기반 고정형 크기
                         -----------
                            글자수
        NCHAR(10)     → 10 글자 담을 수 있음 (한글도, 영어도 상관없이 10글자)
        
                     
        NVARCHAR2     → 유니코드기반 고정형 크기
                         -----------
                            글자수
        NVARCHAR2(10) → 10 글자 담을 수 있음 (한글도, 영어도 상관없이 10글자)
        
        
   3. 날짜형 DATE
   
*/
SELECT HIREDATE
FROM EMP;
--==>>
/*
1980-12-17
1981-02-20
1981-02-22
1981-04-02
1981-09-28
1981-05-01
1981-06-09
1987-07-13
1981-11-17
1981-09-08
1987-07-13
1981-12-03
1981-12-03
1982-01-23
*/

DESCRIBE EMP;
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

SELECT ENAME, HIREDATE
FROM EMP;
--==>>
/*
SMITH	1980-12-17
ALLEN	1981-02-20
WARD	1981-02-22
JONES	1981-04-02
MARTIN	1981-09-28
BLAKE	1981-05-01
CLARK	1981-06-09
SCOTT	1987-07-13
KING	1981-11-17
TURNER	1981-09-08
ADAMS	1987-07-13
JAMES	1981-12-03
FORD	1981-12-03
MILLER	1982-01-23
*/

--○ SYSDATE 확인해보기 (FROM DUAL 은 의미 x)
-- 연,월,일,시,분,초 정보 주지만, 지금 형식이 연,월,일로 되어있어서 연,월,일만 나옴
SELECT SYSDATE
FROM DUAL;
--==>> 2022-02-17

--※ 날짜 형식에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE
FROM DUAL;
--==>> 2022-02-17 05:14:27  → ORACLE 서버 설치되어 있는 PC의 시간

--------------------------------------------------------------------------------

--○ EMP 테이블에서 사원번호, 사원명, 급여, 커미션 데이터만 조회한다.

--① 이걸로 먼저 사원번호, 사원명, 급여, 커미션의 컬럼명이 뭘로 되어있는지 확인
SELECT *
FROM EMP;

--② 조회
SELECT EMPNO, ENAME, SAL, COMM
FROM EMP;
--==>> 
/*
7369	SMITH	800	
7499	ALLEN	1600	300
7521	WARD	1250	500
7566	JONES	2975	
7654	MARTIN	1250	1400
7698	BLAKE	2850	
7782	CLARK	2450	
7788	SCOTT	3000	
7839	KING	5000	
7844	TURNER	1500	0
7876	ADAMS	1100	
7900	JAMES	950	
7902	FORD	3000	
7934	MILLER	1300	
*/


--○ EMP 테이블에서 부서번호가 20번인 직원들의 데이터들 중
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.

--① 이걸로 먼저 사원번호, 사원명, 직종명, 급여, 부서번호의 컬럼명 확인
SELECT *
FROM EMP;

--② 조회
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 20;
--==>>
/*
7369	SMITH	CLERK	 800	20
7566	JONES	MANAGER	2975	20
7788	SCOTT	ANALYST	3000	20
7876	ADAMS	CLERK	1100	20
7902	FORD	ANALYST	3000	20
*/

--③ 다른 사람들은 보면 컬럼명 알아보기 힘드니, 별칭 붙여주기!
--   별칭은 '' 아니라 "" 하기로 약속함! 
--   (AS 는 생략가능) 
--   ("" 도 생략가능) → BUT, 별칭 사이에 공백은 추가 불가
SELECT EMPNO AS "사원번호", ENAME "사원명", JOB 직종명, SAL "급   여", DEPTNO "부서번호"
FROM EMP
WHERE DEPTNO = 20;

--※ 테이블을 조회하는 과정에서
--   각 컬럼의 이름에는 별칭(ALIAS)을 부여할 수 있다.
--   기본 구문은 『AS "별칭이름"』의 형태로 작성되며
--   이 때, 『AS』는 생략이 가능하다.
--   또한, 『""』도 생략 가능하다.
--   하지만, 『""』를 생략할 경우 별칭에 공백은 사용할 수 없게 된다.
--   공백은 해당 컬럼의 종결을 의미하므로
--   별칭(ALIAS)의 이름 내부에 공백을 사용해야 할 경우
--   『""』를 사용하여 별칭을 부여할 수 있도록 한다.


--○ EMP 테이블에서 부서번호가 20번과 30번 직원들의 데이터들 중
--   사원번호, 사원명, 직종명, 급여, 부서번호 항목을 조회한다.
--   단, 별칭(ALIAS)을 사용한다.
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL "급  여", DEPTNO 부서번호
FROM EMP
WHERE DEPTNO = 20 OR DEPTNO = 30;
--==>>
/*
7369	SMITH	CLERK	     800	20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER	    2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	     950	30
7902	FORD	ANALYST	    3000	20
*/

--※ 위의 구문은 IN 연산자를 활용하여
--   다음과 같이 처리할 수 있으며
--   위 구문의 처리 결과와 같은 결과를 반환한다.
SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL "급  여", DEPTNO 부서번호
FROM EMP
WHERE DEPTNO IN (20, 30);
--==>>
/*
7369	SMITH	CLERK	     800	20
7499	ALLEN	SALESMAN	1600	30
7521	WARD	SALESMAN	1250	30
7566	JONES	MANAGER	    2975	20
7654	MARTIN	SALESMAN	1250	30
7698	BLAKE	MANAGER	    2850	30
7788	SCOTT	ANALYST	    3000	20
7844	TURNER	SALESMAN	1500	30
7876	ADAMS	CLERK	    1100	20
7900	JAMES	CLERK	     950	30
7902	FORD	ANALYST	    3000	20
*/
