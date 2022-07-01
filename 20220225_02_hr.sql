SELECT USER
FROM DUAL;
--==>> HR


--�� �� �� �̻��� ���̺� ����(JOIN)

-- ���� 1. (SQL 1992 CODE)
SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1
  AND ���̺��2.�÷���2 = ���̺��3.�÷���2;

  
  
-- 1992 CODE�� ����
-- JOIN TABLE�� 2���ų�, 3���ų� ũ�� �����Ǵ� �� ����
-- BUT,
-- 1999 CODE ���� ��쿡�� ���� �ٸ�
-- 1992 CODE �� ��� �� ������, 1999 CODE �� �����ؼ� �� ����

-- ���� 2. (SQL 1999 CODE) : 2�� ���� ����� ������ 1���� ���� ����
-- ���� 2���� ���̺� JOIN
SELECT ���̺��1.�÷���, ���̺��2.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���2;

-- ������ 1�� ���̺� JOIN                
SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���2;
               JOIN ���̺��3
               ON ���̺��2.�÷���2 = ���̺��3.�÷���2;        
               
               
--�� HR ���� ������ ���̺� �Ǵ� �� ��� ��ȸ;
SELECT *
FROM TAB;
--==>>
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	-- VIEW �ϱ� ũ�� �Ű� �� �ʿ� ����
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/


--�� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� �������
--   �������� �����͸�
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸����� ��ȸ�Ѵ�.
-- ��
--�� ���� �м�
SELECT *
FROM JOBS;
--> [JOB_TITLE] JOB_ID
SELECT *
FROM HR.EMPLOYEES;
--> [FIRST_NAME, LAST_NAME] JOB_ID(JOBS), DEPARTMENT_ID(DEPARTMENTS)
-- Ư�̻��� : DEPARTMENT_ID �� NULL �� KGRANT ����
SELECT *
FROM DEPARTMENTS;
--> [DEPARTMENT_NAME] DEPARTMENT_ID


--�� ���� �ۼ�
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
            JOIN DEPARTMENTS D
            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> �̷��� �ϸ� KGRANT ������ ����


SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J JOIN EMPLOYEES E
ON J.JOB_ID = E.JOB_ID
            LEFT JOIN DEPARTMENTS D
            ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> LEFT JOIN ����� KGRANT ����
/*
    :
    :
Kimberely	Grant	Sales Representative	(null)
*/


-- ��
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- �ϴ� ��� ������ �� ������ Ȯ���غ�
SELECT COUNT(*)
FROM EMPLOYEES E JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 106

SELECT COUNT(*)
FROM EMPLOYEES;
--==>> 107
-- �ϳ� ������ �� Ȯ���� �� ����
-- Kimberely ������. DEPARTMENT_ID �� NULL �̶�
-- �� OUTER JOIN ���� ������� �Ѵ�.

-- ��� COUNT() �ٸ��ٰ� �ؼ�, ������ ũ�� ����� �Ǵ� �� �ƴ�
-- ������ ���� ��Ȯ�ϰ� ���յǾ� �ִ� �͸� ������ ���� ����
-- ���� ������� ������ �Ⱥ��̰� �ؾ��� ���� ����
-- BUT,
-- ���� ��쿡�� �׷��� ����
-- �� ��쿡���� �μ���ȣ�� �����Ǿ� �ִ� ��� 1�� ��ȸ�ǰ� �ؾ��Ѵ�.

-- LEFT JOIN �ϸ� ��� ����� �������� Ȯ���غ���
SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
--==>> 107


SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;
      
        
-- ��ȸ�غ����� COUNT �غ���
SELECT COUNT(*)
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;
--==>> 107

-- COUNT() ������, �������
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;



--�� EMPLOYEES, DEPARTMENTS, JOBS, LOCAIONS, COUNTRIES, REGIONS ���̺��� �������
--   �������� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME
--   1992 CODE, 1999 CODE �� ������ Ǯ���
--   ���� ���ڵ� ���� 107������ �Ѵ�.

-- ��
--�� ���� �м�
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
--��: �� 107��
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--��: �� 107��
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID;

--��-1: �� 106�� (DEPARTMENT_ID �� NULL�� ��� �־)
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
        JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID;
        
--��-2: �� 107�� 
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
        JOIN JOBS J
        ON E.JOB_ID = J.JOB_ID
        LEFT JOIN LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID;
        

--��: �� 107�� (����� ���� ������ LEFT JOIN ó��)
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
        
--��(����): �� 107�� [[1999 CODE]]
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
        
        
-- [[1992 CODE]] : �� 107��
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
     , L.CITY, C.COUNTRY_NAME, R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C, REGIONS R 
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND E.JOB_ID = J.JOB_ID
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);


-- SCOTT ���� ���� ��ũ��Ʈ ���� ����   

