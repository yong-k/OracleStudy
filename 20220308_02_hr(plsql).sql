SELECT USER
FROM DUAL;
--==>> HR


--○ %TYPE

-- 1. 특정 테이블에 포함되어 있는 컬럼의 데이터타입(자료형)을 참조하는 데이터타입

-- 2. 형식 및 구조
-- 변수명 테이블명.컬럼명%TYPE [:= 초기값];


-- HR.EMPLOYEES 테이블의 특정 데이터를 변수에 저장
-- 20220308_03_hr.sql 파일로 잠깐 go
-- EMPLOYEE_ID 가 103 인 사원의 FIRST_NAME 을
-- 어떤 변수에 담아서 출력하려고 함

SET SERVEROUTPUT ON;

DECLARE
    V_NAME  VARCHAR2(20);
    -- EMPLOYEES 테이블의 FIRST_NAME 의 컬럼 타입을 그대로 작성하면,
    -- 그 안에 있는 건 다 담을 수 있음
    -- 03_hr.sql 에서 DESC EMPLOYEES; 해서 보니까,
    -- FIRST_NAME → VARCHAR2(20)로 되어 있음
BEGIN
    -- 쿼리로 얻어낸 내용을 INTO V_NAME → V_NAME 안에 담겠다.
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>> Alexander


-- 이렇게 워크시트 왔다갔다 하면서 DESC 로 확인해서
-- 데이터 타입 입력하는 거 대신 쓸 수 있는게
-- 『%TYPE』
DECLARE
    V_NAME  EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>> Alexander


--○ EMPLOYEES 테이블을 대상으로 108번 사원(Nancy)의
--   SALARY 를 변수에 담아 출력하는 PL/SQL 구문을 작성한다.
DECLARE
    V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 108;
    
    DBMS_OUTPUT.PUT_LINE(V_SALARY);
END;
--==>> 12008


--○ EMPLOYEES 테이블의 특정 레코드 항목 여러개를 변수에 저장
--   103번 사원의 FIRST_NAME, PHONE_NUMBER, EMAIL 항목을 변수에 저장하여 출력
DECLARE
    V_FIRST_NAME    EMPLOYEES.FIRST_NAME%TYPE;
    V_PHONE_NUMBER  EMPLOYEES.PHONE_NUMBER%TYPE;
    V_EMAIL         EMPLOYEES.EMAIL%TYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
           INTO V_FIRST_NAME, V_PHONE_NUMBER, V_EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME || ', ' || V_PHONE_NUMBER || ', ' || V_EMAIL);
END;
--==>> Alexander, 590.423.4567, AHUNOLD


--○ %ROWTYPE

-- 1. 테이블의 레코드와 같은 구조의 구조체 변수를 선언(여러 개의 컬럼)

-- 2. 형식 및 구조
-- 변수명 테이블명%ROWTYPE;
DECLARE
    --V_FIRST_NAME    EMPLOYEES.FIRST_NAME%TYPE;
    --V_PHONE_NUMBER  EMPLOYEES.PHONE_NUMBER%TYPE;
    --V_EMAIL         EMPLOYEES.EMAIL%TYPE;
    
    V_EMP   EMPLOYEES%ROWTYPE;

BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
           INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    --DBMS_OUTPUT.PUT_LINE(V_FIRST_NAME || ', ' || V_PHONE_NUMBER || ', ' || V_EMAIL);
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' 
        || V_EMP.PHONE_NUMBER || ', ' || V_EMP.EMAIL);
END;
--==>> Alexander, 590.423.4567, AHUNOLD


--○ EMPLOYEES 테이블의 전체 레코드 항목 여러개를 변수에 저장
--   모든 사원의 FIRST_NAME, PHONE_NUMBER, EMAIL 항목을 변수에 저장하여 출력
DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
           INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' 
        || V_EMP.PHONE_NUMBER || ', ' || V_EMP.EMAIL);
END;
--==>> 에러 발생
--     (ORA-01422: exact fetch returns more than requested number of rows)
-- 이렇게 하면 될 것 같지만, 이렇게는 처리되지 않는다.
-- 우리가 선언한 변수는 단일값을 받아서 처리해야 하는데,
-- FIRST_NAME 에 단일값이 들어가는 게 아니라, 
-- 여러 개의 데이터를 하나의 변수 안에 담겠다는 것이 됨

--> 여러 개의 행(ROWS) 정보를 얻어와 담으려고 하면
--  변수에 저장하는 것 자체가 불가능해진다.

-- 크게 두 가지 방법이 있다.
--① 커서 이용 (커서는 PL/SQL 마지막에 배울거)
--② 단순한 반복문 활용


-- 20220308_04_scott 으로 잠시 이동

