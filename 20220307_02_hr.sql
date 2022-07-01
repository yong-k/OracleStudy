SELECT USER
FROM DUAL;
--==>> HR




--○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다.
--   단, 부서명이 'IT' 인 직원들만 한정한다.
--   (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행한다!!!)

-- 나
DESC EMPLOYEES;
--==>>
/*
이름             널?       유형           
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    
*/
--> EMPLOYEES 테이블에 DEPARTMENT_NAME 없음
--> DEPARTMENT_ID 통해서 DEPARTMENTS 테이블로 가야한다.

-- IT 부서의 DEPARTMENT_ID 조회 
SELECT DEPARTMENT_NAME, DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60


-- 원하는 결과 조회
SELECT DEPARTMENT_ID "부서번호"
     , SALARY "원래급여"
     , SALARY * 1.1 "10%인상급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
60	9000	9900
60	6000	6600
60	4800	5280
60	4800	5280
60	4200	4620
*/



-- UPDATE 문 실행
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5개 행 이(가) 업데이트되었습니다.


-- 변경 후 결과 조회
SELECT DEPARTMENT_ID "부서번호"
     , SALARY "10%인상급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
60	9900
60	6600
60	5280
60	5280
60	4620
*/

-- 결과 확인 후 ROLLBACK
ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 JOB_TITLE 이 『Sales Manager』인 사원들의
--   SALARY 를 해당 직무(직종)의 최고급여(MAX_SALARY)로 수정한다.
--   단, 입사일이 2006년 이전(해당 년도 제외) 입사자에 한해 적용할 수 있도록 처리한다.
--   (또한, 변경에 대한 결과를 확인 후 ROLLBACK 수행한다~!!!)

-- 원하는 결과 조회
SELECT EMPLOYEE_ID "사원번호", HIRE_DATE "입사일"
     , SALARY "급여"
     , (SELECT MAX_SALARY
        FROM JOBS
        WHERE JOB_TITLE = 'Sales Manager') "최고급여로수정"
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>>
/*
145	2004-10-01	14000	20080
146	2005-01-05	13500	20080
147	2005-03-10	12000	20080
*/
    

-- UPDATE 문 실행
UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>> 3개 행 이(가) 업데이트되었습니다.  


-- 변경 후, 결과 조회
SELECT EMPLOYEE_ID "사원번호", HIRE_DATE "입사일"
     , SALARY "최고급여로수정"
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;                
--==>>
/*
145	2004-10-01	20080
146	2005-01-05	20080
147	2005-03-10	20080
*/


-- 다른 데이터들은 변화 없는지 한 번 확인
SELECT *
FROM EMPLOYEES;
     
                
-- 결과 확인 후, 롤백
ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 SALARY 를 
--   각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다. 
--   (하나의 쿼리문으로 작성하기)
--   Finance → 10% 인상
--   Executive → 15% 인상
--   Accounting → 20% 인상
--   (또한, 변경에 대한 결과를 확인 후 ROLLBACK 수행한다~!!!)

-- 원하는 결과 조회  
SELECT DEPARTMENT_ID "부서번호", SALARY "기존급여"
     , CASE WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                  FROM DEPARTMENTS
                                  WHERE DEPARTMENT_NAME = 'Finance') THEN SALARY * 1.1
            WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                  FROM DEPARTMENTS
                                  WHERE DEPARTMENT_NAME = 'Executive') THEN SALARY * 1.15
            WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                  FROM DEPARTMENTS
                                  WHERE DEPARTMENT_NAME = 'Accounting') THEN SALARY * 1.2
       END "인상급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>>
/*
90	24000	27600
90	17000	19550
90	17000	19550
100	12008	13208.8
100	9000	9900
100	8200	9020
100	7700	8470
100	7800	8580
100	6900	7590
110	12008	14409.6
110	8300	9960
*/


-- UPDATE 문 실행
UPDATE EMPLOYEES
SET SALARY = ( CASE WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                          FROM DEPARTMENTS
                                          WHERE DEPARTMENT_NAME = 'Finance') THEN SALARY * 1.1
                    WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                          FROM DEPARTMENTS
                                          WHERE DEPARTMENT_NAME = 'Executive') THEN SALARY * 1.15
                    WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                          FROM DEPARTMENTS
                                          WHERE DEPARTMENT_NAME = 'Accounting') THEN SALARY * 1.2
                    ELSE SALARY                                          
               END)                                  
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>> 11개 행 이(가) 업데이트되었습니다.
-- 그냥 WHERE 절 없애도 똑같은 UPDATE 를 수행하게 됨
-- 하지만 WHERE 절 까지 쓰는게 메모리 덜 쓰고, 모래시계 덜 돌아감
-- WHERE 절 없으면 107 개 행을 업데이트 해야 하는거


-- 실행 후, 결과 조회
SELECT DEPARTMENT_ID "부서번호", SALARY "인상급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Finance', 'Executive', 'Accounting'));
--==>>
/*
90	27600
90	19550
90	19550
100	13208.8
100	9900
100	9020
100	8470
100	8580
100	7590
110	14409.6
110	9960
*/

-- 결과 확인 후, 롤백
ROLLBACK;
--==>> 롤백 완료.


--------------------------------------------------------------------------------

--■■■ DELETE ■■■--

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는데 사용하는 구문

-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];


-- 테이블 복사(데이터 위주)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES이(가) 생성되었습니다.


-- DELETE 실행 전에,
--① SELECT 로 → 내가 지워야 할 데이터가 맞는지 확인하기!!
SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50

--② 데이터 확인 후, 『SELECT *』 → 『DELETE』 로 바꿔서 실행
DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.

-- 롤백
ROLLBACK;
--==>> 롤백 완료.


--○ EMPLOYEES 테이블에서 직원들의 데이터를 삭제한다.
--   단, 부서명이 'IT'인 경우로 한정한다.
--   쿼리문만 구성해두기

--※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상 데이터)
--   다른 레코드에 의해 참조당하고 있는 경우
--   삭제되지 않을 수 있다는 사실을 염두해야 하며...
--   그에 대한 이유도 알아야 한다.

-- 삭제할 데이터 조회
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>>
/*
103	Alexander	Hunold	    AHUNOLD	    590.423.4567	2006-01-03	IT_PROG	9000		102	60
104	Bruce	    Ernst	    BERNST	    590.423.4568	2007-05-21	IT_PROG	6000		103	60
105	David	    Austin	    DAUSTIN	    590.423.4569	2005-06-25	IT_PROG	4800		103	60
106	Valli	    Pataballa	VPATABAL	590.423.4560	2006-02-05	IT_PROG	4800		103	60
107	Diana	    Lorentz	    DLORENTZ	590.423.5567	2007-02-07	IT_PROG	4200		103	60
*/


-- 조회 후, 삭제                       
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 에러 발생
--     (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)
--     참조받고 있는 레코드가 있어서 지워지지 않는다.


--------------------------------------------------------------------------------

--■■■ 뷰(VIEW) ■■■--

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는 
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--    정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만을 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.
--                                         ====
--                                          ↓

-- 사실, 테이블을 직접적으로 노출하지 않기 위해서
-- 뷰를 사용하는 경우도 많다.
-- 싸이월드 게시물 번호 직접 노출하는 게 보안의 위험성 있다고 말한 적 있음
-- 마찬가지로, 테이블의 이름부터 ~ 테이블 구성 컬럼 이름 등등 
-- 사용자에게 모두 노출하는 것이 아니라,
-- 사용자에게 노출해야 하는 부분만 따로 뷰를 만들어 놓음
-- 그리고 그 뷰만 사용자에게 노출시켜 놓으면
-- → 사용자는 테이블을 직접 UPDATE, DELETE 할 수 없음
-- 우리가 만들어놓은 SCOTT 의 VIEW_SAWON 보면
-- HIREDATE가 '입사일' 이라고 검색이 되니까, 
-- '입사일' 컬럼의 실제 이름이 뭔지 사용자는 알 수 없음!!


--    가상의 테이블이란... 뷰가 실제로 존재하는 테이블(객체)이 아니라
--    하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이라는 의미이며,
--    그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 테이블의 데이터는 하드디스크 뒤져보면 어딘가에 있지만, 뷰의 데이터는 아니다.
-- 물론 뷰를 대상으로 하는 테이블에는 그 데이터가 있을 지 몰라도,
-- 뷰 자체의 데이터는 하드디스크에 저장되지 않는다.
-- 뷰 생성 이후에도, 테이블 UPDATE 되었을 시에, 그게 뷰에도 적용된다.


-- 2. 형식 및 구조
-- CREATE [OR REPLACE] VIEW 뷰이름
-- [(ALIAS[, ALIAS, ...])]              → 직접 별칭 지정할 수도 있다
-- AS
-- 서브쿼리(SUBQUERY)
-- [WITH CHECK OPTION]  
-- [WITH READ ONLY]

-- WITH CHECK OPTION, WITH READ ONLY 는
-- → 별도의 옵션 추가해서 뷰 생성할 수 있지만 ADMIN 파트의 일부라
--    크게 신경 안써도 된다.


--○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.


--○ 뷰(VIEW) 조회 → 일반 테이블 조회 방법과 동일
SELECT *
FROM VIEW_EMPLOYEES;


--○ 뷰(VIEW)의 구조 조회  → 일반 테이블 구조 조회 방법과 동일
DESC VIEW_EMPLOYEES;
--==>>
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


-- [유용한 내용]
-- ADMIN 파트에 해당되지만 기억해두면 편함!!
--○ **뷰(VIEW) 소스 확인**       CHECK~!!
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>>
/*
VIEW_EMPLOYEES	

"SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID"
*/
-- VIEW_NAME 이야 우리가 검색하니까 놀랍지 않지만,
-- TEXT 부분에는 VIEW 만들 때 입력했던 쿼리 그대로 나옴
-- VIEW 내부적으로 어떻게 돌아가는지 알 수 있게 해준다!!


-- SCOTT 으로 이동

