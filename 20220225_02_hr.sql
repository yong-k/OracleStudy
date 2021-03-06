SELECT USER
FROM DUAL;
--==>> HR


--○ 세 개 이상의 테이블 조인(JOIN)

-- 형식 1. (SQL 1992 CODE)
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
  AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;

  
  
-- 1992 CODE로 보면
-- JOIN TABLE이 2개거나, 3개거나 크게 문제되는 건 없음
-- BUT,
-- 1999 CODE 같은 경우에는 조금 다름
-- 1992 CODE 는 흘려 들어도 되지만, 1999 CODE 는 집중해서 잘 보자

-- 형식 2. (SQL 1999 CODE) : 2개 묶은 결과로 나머지 1개와 묶는 형식
-- 먼저 2개의 테이블 JOIN
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명2;

-- 나머지 1개 테이블도 JOIN                
SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명2;
               JOIN 테이블명3
               ON 테이블명2.컬럼명2 = 테이블명3.컬럼명2;        
               
               
--○ HR 계정 소유의 테이블 또는 뷰 목록 조회;
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	-- VIEW 니까 크게 신경 쓸 필요 없음
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/


--○ HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS 테이블을 대상으로
--   직원들의 데이터를
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME 항목으로 조회한다.
-- 나
--① 문제 분석
SELECT *
FROM JOBS;
--> [JOB_TITLE] JOB_ID
SELECT *
FROM HR.EMPLOYEES;
--> [FIRST_NAME, LAST_NAME] JOB_ID(JOBS), DEPARTMENT_ID(DEPARTMENTS)
-- 특이사항 : DEPARTMENT_ID 가 NULL 인 KGRANT 있음
SELECT *
FROM DEPARTMENTS;
--> [DEPARTMENT_NAME] DEPARTMENT_ID


--② 쿼리 작성
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
            JOIN DEPARTMENTS D
            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 이렇게 하면 KGRANT 나오지 않음


SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
            LEFT JOIN DEPARTMENTS D
            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> LEFT JOIN 해줘야 KGRANT 나옴
/*
    :
    :
Kimberely	Grant	Sales Representative	(null)
*/


-- 쌤
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 일단 결과 누락된 거 없는지 확인해봄
SELECT COUNT(*)
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 106

SELECT COUNT(*)
FROM EMPLOYEES;
--==>> 107
-- 하나 누락된 거 확인할 수 있음
-- Kimberely 누락됨. DEPARTMENT_ID 가 NULL 이라서
-- → OUTER JOIN 으로 묶어줘야 한다.

-- 결과 COUNT() 다르다고 해서, 무조건 크게 맞춰야 되는 건 아님
-- 업무에 따라서 정확하게 결합되어 있는 것만 봐야할 수도 있음
-- 서로 연결되지 않은거 안보이게 해야할 수도 있음
-- BUT,
-- 많은 경우에는 그렇지 않음
-- 이 경우에서도 부서번호가 누락되어 있는 사원 1명도 조회되게 해야한다.

-- LEFT JOIN 하면 결과 제대로 나오는지 확인해보기
SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 107


SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;
      
        
-- 조회해봤으면 COUNT 해보기
SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;
--==>> 107

-- COUNT() 맞으니, 최종결과
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;



--○ EMPLOYEES, DEPARTMENTS, JOBS, LOCAIONS, COUNTRIES, REGIONS 테이블을 대상으로
--   직원들의 데이터를 다음과 같이 조회할 수 있도록 쿼리문을 구성한다.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
--   1992 CODE, 1999 CODE 두 가지로 풀어보기
--   최종 레코드 수는 107개여야 한다.

-- 나
--① 문제 분석
SELECT *
FROM EMPLOYEES;
--> [FIRST_NAME, LAST_NAME], DEPARTMENT_ID(DEPARTMENTS), JOB_ID(JOBS)
SELECT *
FROM DEPARTMENTS;
--> [DEPARTMENT_NAME], LOCATION_ID(LOCATIONS), DEPARTMENT_ID
SELECT *
FROM JOBS;
--> [JOB_TITLE], JOB_ID
SELECT *
FROM LOCATIONS;
--> [CITY], COUNTRY_ID(COUNTRIES), LOCATION_ID
SELECT *
FROM COUNTRIES;
--> [COUNTRY_NAME], REGION_ID(REGIONS), COUNTRY_ID
SELECT *
FROM REGIONS;
--> [REGION_NAME], REGION_ID

-- [[1999 CODE]]
--①: 행 107개
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--②: 행 107개
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;

--③-1: 행 106개 (DEPARTMENT_ID 가 NULL인 사원 있어서)
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
        JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID;
        
--③-2: 행 107개 
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID;
        

--④: 행 107개 (③번과 같은 이유로 LEFT JOIN 처리)
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID
        LEFT JOIN COUNTRIES C
        ON L.COUNTRY_ID = C.COUNTRY_ID;
        
--⑤(최종): 행 107개 [[1999 CODE]]
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
            LEFT JOIN LOCATIONS L
            ON D.LOCATION_ID = L.LOCATION_ID
                LEFT JOIN COUNTRIES C
                ON L.COUNTRY_ID = C.COUNTRY_ID 
                    LEFT JOIN REGIONS R
                    ON C.REGION_ID = R.REGION_ID;
        
        
-- [[1992 CODE]] : 행 107개
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R 
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND E.JOB_ID = J.JOB_ID
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);


-- SCOTT 으로 새로 워크시트 만들어서 접속   

