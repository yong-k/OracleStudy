SELECT USER
FROM DUAL;
--==>> HR


--�� %TYPE

-- 1. Ư�� ���̺� ���ԵǾ� �ִ� �÷��� ������Ÿ��(�ڷ���)�� �����ϴ� ������Ÿ��

-- 2. ���� �� ����
-- ������ ���̺��.�÷���%TYPE [:= �ʱⰪ];


-- HR.EMPLOYEES ���̺��� Ư�� �����͸� ������ ����
-- 20220308_03_hr.sql ���Ϸ� ��� go
-- EMPLOYEE_ID �� 103 �� ����� FIRST_NAME ��
-- � ������ ��Ƽ� ����Ϸ��� ��

SET SERVEROUTPUT ON;

DECLARE
    V_NAME  VARCHAR2(20);
    -- EMPLOYEES ���̺��� FIRST_NAME �� �÷� Ÿ���� �״�� �ۼ��ϸ�,
    -- �� �ȿ� �ִ� �� �� ���� �� ����
    -- 03_hr.sql ���� DESC EMPLOYEES; �ؼ� ���ϱ�,
    -- FIRST_NAME �� VARCHAR2(20)�� �Ǿ� ����
BEGIN
    -- ������ �� ������ INTO V_NAME �� V_NAME �ȿ� ��ڴ�.
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>> Alexander


-- �̷��� ��ũ��Ʈ �Դٰ��� �ϸ鼭 DESC �� Ȯ���ؼ�
-- ������ Ÿ�� �Է��ϴ� �� ��� �� �� �ִ°�
-- ��%TYPE��
DECLARE
    V_NAME  EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
--==>> Alexander


--�� EMPLOYEES ���̺��� ������� 108�� ���(Nancy)��
--   SALARY �� ������ ��� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
DECLARE
    V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 108;
    
    DBMS_OUTPUT.PUT_LINE(V_SALARY);
END;
--==>> 12008


--�� EMPLOYEES ���̺��� Ư�� ���ڵ� �׸� �������� ������ ����
--   103�� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���
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


--�� %ROWTYPE

-- 1. ���̺��� ���ڵ�� ���� ������ ����ü ������ ����(���� ���� �÷�)

-- 2. ���� �� ����
-- ������ ���̺��%ROWTYPE;
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


--�� EMPLOYEES ���̺��� ��ü ���ڵ� �׸� �������� ������ ����
--   ��� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���
DECLARE
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL
           INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES;
    
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME || ', ' 
        || V_EMP.PHONE_NUMBER || ', ' || V_EMP.EMAIL);
END;
--==>> ���� �߻�
--     (ORA-01422: exact fetch returns more than requested number of rows)
-- �̷��� �ϸ� �� �� ������, �̷��Դ� ó������ �ʴ´�.
-- �츮�� ������ ������ ���ϰ��� �޾Ƽ� ó���ؾ� �ϴµ�,
-- FIRST_NAME �� ���ϰ��� ���� �� �ƴ϶�, 
-- ���� ���� �����͸� �ϳ��� ���� �ȿ� ��ڴٴ� ���� ��

--> ���� ���� ��(ROWS) ������ ���� �������� �ϸ�
--  ������ �����ϴ� �� ��ü�� �Ұ���������.

-- ũ�� �� ���� ����� �ִ�.
--�� Ŀ�� �̿� (Ŀ���� PL/SQL �������� ����)
--�� �ܼ��� �ݺ��� Ȱ��


-- 20220308_04_scott ���� ��� �̵�

