SELECT USER
FROM DUAL;
--==>> HR




--�� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--   ��, �μ����� 'IT' �� �����鸸 �����Ѵ�.
--   (����, ���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�!!!)

-- ��
DESC EMPLOYEES;
--==>>
/*
�̸�             ��?       ����           
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
--> EMPLOYEES ���̺� DEPARTMENT_NAME ����
--> DEPARTMENT_ID ���ؼ� DEPARTMENTS ���̺�� �����Ѵ�.

-- IT �μ��� DEPARTMENT_ID ��ȸ 
SELECT DEPARTMENT_NAME, DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'IT';
--==>> 60


-- ���ϴ� ��� ��ȸ
SELECT DEPARTMENT_ID "�μ���ȣ"
     , SALARY "�����޿�"
     , SALARY * 1.1 "10%�λ�޿�"
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



-- UPDATE �� ����
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- ���� �� ��� ��ȸ
SELECT DEPARTMENT_ID "�μ���ȣ"
     , SALARY "10%�λ�޿�"
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

-- ��� Ȯ�� �� ROLLBACK
ROLLBACK;
--==>> �ѹ� �Ϸ�.


--�� EMPLOYEES ���̺��� JOB_TITLE �� ��Sales Manager���� �������
--   SALARY �� �ش� ����(����)�� �ְ�޿�(MAX_SALARY)�� �����Ѵ�.
--   ��, �Ի����� 2006�� ����(�ش� �⵵ ����) �Ի��ڿ� ���� ������ �� �ֵ��� ó���Ѵ�.
--   (����, ���濡 ���� ����� Ȯ�� �� ROLLBACK �����Ѵ�~!!!)

-- ���ϴ� ��� ��ȸ
SELECT EMPLOYEE_ID "�����ȣ", HIRE_DATE "�Ի���"
     , SALARY "�޿�"
     , (SELECT MAX_SALARY
        FROM JOBS
        WHERE JOB_TITLE = 'Sales Manager') "�ְ�޿��μ���"
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
    

-- UPDATE �� ����
UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager')
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager')
  AND EXTRACT(YEAR FROM HIRE_DATE) < 2006;
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.  


-- ���� ��, ��� ��ȸ
SELECT EMPLOYEE_ID "�����ȣ", HIRE_DATE "�Ի���"
     , SALARY "�ְ�޿��μ���"
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


-- �ٸ� �����͵��� ��ȭ ������ �� �� Ȯ��
SELECT *
FROM EMPLOYEES;
     
                
-- ��� Ȯ�� ��, �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.


--�� EMPLOYEES ���̺��� SALARY �� 
--   �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�. 
--   (�ϳ��� ���������� �ۼ��ϱ�)
--   Finance �� 10% �λ�
--   Executive �� 15% �λ�
--   Accounting �� 20% �λ�
--   (����, ���濡 ���� ����� Ȯ�� �� ROLLBACK �����Ѵ�~!!!)

-- ���ϴ� ��� ��ȸ  
SELECT DEPARTMENT_ID "�μ���ȣ", SALARY "�����޿�"
     , CASE WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                  FROM DEPARTMENTS
                                  WHERE DEPARTMENT_NAME = 'Finance') THEN SALARY * 1.1
            WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                  FROM DEPARTMENTS
                                  WHERE DEPARTMENT_NAME = 'Executive') THEN SALARY * 1.15
            WHEN DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                                  FROM DEPARTMENTS
                                  WHERE DEPARTMENT_NAME = 'Accounting') THEN SALARY * 1.2
       END "�λ�޿�"
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


-- UPDATE �� ����
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
--==>> 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
-- �׳� WHERE �� ���ֵ� �Ȱ��� UPDATE �� �����ϰ� ��
-- ������ WHERE �� ���� ���°� �޸� �� ����, �𷡽ð� �� ���ư�
-- WHERE �� ������ 107 �� ���� ������Ʈ �ؾ� �ϴ°�


-- ���� ��, ��� ��ȸ
SELECT DEPARTMENT_ID "�μ���ȣ", SALARY "�λ�޿�"
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

-- ��� Ȯ�� ��, �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.


--------------------------------------------------------------------------------

--���� DELETE ����--

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴµ� ����ϴ� ����

-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];


-- ���̺� ����(������ ����)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==>> Table TBL_EMPLOYEES��(��) �����Ǿ����ϴ�.


-- DELETE ���� ����,
--�� SELECT �� �� ���� ������ �� �����Ͱ� �´��� Ȯ���ϱ�!!
SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50

--�� ������ Ȯ�� ��, ��SELECT *�� �� ��DELETE�� �� �ٲ㼭 ����
DELETE
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-- �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.


--�� EMPLOYEES ���̺��� �������� �����͸� �����Ѵ�.
--   ��, �μ����� 'IT'�� ���� �����Ѵ�.
--   �������� �����صα�

--�� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ��� ������)
--   �ٸ� ���ڵ忡 ���� �������ϰ� �ִ� ���
--   �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
--   �׿� ���� ������ �˾ƾ� �Ѵ�.

-- ������ ������ ��ȸ
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


-- ��ȸ ��, ����                       
DELETE
FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                       FROM DEPARTMENTS
                       WHERE DEPARTMENT_NAME = 'IT');
--==>> ���� �߻�
--     (ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found)
--     �����ް� �ִ� ���ڵ尡 �־ �������� �ʴ´�.


--------------------------------------------------------------------------------

--���� ��(VIEW) ����--

-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ� 
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
--    ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸�� ��Ƽ�
--    �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.
--                                         ====
--                                          ��

-- ���, ���̺��� ���������� �������� �ʱ� ���ؼ�
-- �並 ����ϴ� ��쵵 ����.
-- ���̿��� �Խù� ��ȣ ���� �����ϴ� �� ������ ���輺 �ִٰ� ���� �� ����
-- ����������, ���̺��� �̸����� ~ ���̺� ���� �÷� �̸� ��� 
-- ����ڿ��� ��� �����ϴ� ���� �ƴ϶�,
-- ����ڿ��� �����ؾ� �ϴ� �κи� ���� �並 ����� ����
-- �׸��� �� �丸 ����ڿ��� ������� ������
-- �� ����ڴ� ���̺��� ���� UPDATE, DELETE �� �� ����
-- �츮�� �������� SCOTT �� VIEW_SAWON ����
-- HIREDATE�� '�Ի���' �̶�� �˻��� �Ǵϱ�, 
-- '�Ի���' �÷��� ���� �̸��� ���� ����ڴ� �� �� ����!!


--    ������ ���̺��̶�... �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
--    �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̶�� �ǹ��̸�,
--    �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

-- ���̺��� �����ʹ� �ϵ��ũ �������� ��򰡿� ������, ���� �����ʹ� �ƴϴ�.
-- ���� �並 ������� �ϴ� ���̺��� �� �����Ͱ� ���� �� ����,
-- �� ��ü�� �����ʹ� �ϵ��ũ�� ������� �ʴ´�.
-- �� ���� ���Ŀ���, ���̺� UPDATE �Ǿ��� �ÿ�, �װ� �信�� ����ȴ�.


-- 2. ���� �� ����
-- CREATE [OR REPLACE] VIEW ���̸�
-- [(ALIAS[, ALIAS, ...])]              �� ���� ��Ī ������ ���� �ִ�
-- AS
-- ��������(SUBQUERY)
-- [WITH CHECK OPTION]  
-- [WITH READ ONLY]

-- WITH CHECK OPTION, WITH READ ONLY ��
-- �� ������ �ɼ� �߰��ؼ� �� ������ �� ������ ADMIN ��Ʈ�� �Ϻζ�
--    ũ�� �Ű� �Ƚᵵ �ȴ�.


--�� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY
     , C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.


--�� ��(VIEW) ��ȸ �� �Ϲ� ���̺� ��ȸ ����� ����
SELECT *
FROM VIEW_EMPLOYEES;


--�� ��(VIEW)�� ���� ��ȸ  �� �Ϲ� ���̺� ���� ��ȸ ����� ����
DESC VIEW_EMPLOYEES;
--==>>
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25) 
*/


-- [������ ����]
-- ADMIN ��Ʈ�� �ش������ ����صθ� ����!!
--�� **��(VIEW) �ҽ� Ȯ��**       CHECK~!!
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
-- VIEW_NAME �̾� �츮�� �˻��ϴϱ� ����� ������,
-- TEXT �κп��� VIEW ���� �� �Է��ߴ� ���� �״�� ����
-- VIEW ���������� ��� ���ư����� �� �� �ְ� ���ش�!!


-- SCOTT ���� �̵�

