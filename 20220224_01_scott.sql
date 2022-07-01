SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
--==>>
/*
10	2450 ��
10	5000 ���� 8750
10	1300 ��
20	2975 ��
20	3000 ��
20	1100 ���� 10875
20	800  ��
20	3000 ��
30	1250 ��
30	1500 ��
30	1600 ���� 9400
30	950  ��
30	2850 ��
30	1250 ��
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
--==>>
/*
10	 8750
20	10875
30	 9400
*/


SELECT *
FROM EMP;

SELECT *
FROM TBL_EMP;


--�� ������ �����ص� TBL_EMP ���̺� ����
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


--�� �ٽ� EMP ���̺� �����Ͽ� TBL_EMP ���̺� ����
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


SELECT *
FROM TBL_EMP;


--�� �ǽ� ������ �߰� �Է�(TBL_EMP)
INSERT INTO TBL_EMP VALUES
(8001, 'ȫ����', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8002, '����', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8003, '��ȣ��', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8004, '�Ž���', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8005, '������', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	 800  (null)    20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	 300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500	30
7566	JONES	MANAGER 	7839	1981-04-02	2975  (null)    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850  (null)	30
7782	CLARK	MANAGER	    7839	1981-06-09	2450  (null)	10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000  (null)	20
7839	KING	PRESIDENT  (null)	1981-11-17	5000  (null)	10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0	30
7876	ADAMS	CLERK	    7788	1987-07-13	1100  (null)	20
7900	JAMES	CLERK	    7698	1981-12-03	 950  (null)	30
7902	FORD	ANALYST	    7566	1981-12-03	3000  (null)	20
7934	MILLER	CLERK	    7782	1982-01-23	1300  (null)	10
8001	ȫ����	CLERK	    7566	2022-02-24	1500	  10  (null)	    
8002	����	CLERK	    7566	2022-02-24	2000	  10  (null)	
8003	��ȣ��	SALESMAN	7698	2022-02-24	1700  (null)  (null)		
8004	�Ž���	SALESMAN	7698	2022-02-24	2500  (null)  (null)		
8005	������	SALESMAN	7698	2022-02-24	1000  (null)  (null)		
*/


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
--==>>
/*
   20	 800   (null)	
(null)	1700   (null)	
(null)	1000   (null)	
   10	1300   (null)	
   20	2975   (null)	
   30	2850   (null)	
   10	2450   (null)	
   20	3000   (null)	
   10	5000   (null)	
(null)	2500   (null)	
   20	1100   (null)	
   30	 950   (null)	
   20	3000   (null)	
   30	1250	1400
   30	1250	 500
   30	1600	 300
(null)	1500	  10
(null)	2000	  10
   30	1500	   0
*/
--  Ŀ�̼��� �������� �������� �����ߴµ�, NULL �� ���� ���� �ִ�.
--> ORACLE ������ NULL �� ���� ũ�� �����ϰ� �ִ�.

--�� ����Ŭ������ NULL �� ���� ū ���� ���·� �����Ѵ�.
--   (ORACLE 9i ������ NULL �� ���� ���� ���� ���·� �����߾���.)
--   MSSQL �� NULL �� ���� ���� ���� ���·� �����Ѵ�.


--�� TBL_EMP ���̺��� ������� �μ��� �޿��� ��ȸ
--   �μ���ȣ, �޿��� �׸� ��ȸ
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700   -- �μ���ȣ�� NULL �� �������� ���    
                -- �� �������� �޿����� ��ȸ�ߴ�.
*/
-- �μ��� �޿��� ��ȸ �� �ϴ� �μ����� GROUP BY ����� �Ѵ�.


--�� ROLLUP ���
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700   -- �μ���ȣ�� NULL �� �������� �޿��� 
(null)	37725   -- ���μ� �������� �޿���
*/
-- �μ���ȣ�� NULL �� �������� �޿��հ�
-- ���μ� �������� �޿����� �μ���ȣ��
-- �� �� (null)�� ǥ���Ǿ� �ִ�.


-- TBL_EMP ���� �μ���ȣ�� NULL �ΰ� �־ ������ �����°Ŵϱ�
-- �׳� EMP ���̺�� ��ȸ
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	29025   -- ���μ� �������� �޿���
*/
-- ��
/*
---------     -------
 �μ���ȣ      �޿���
---------    --------
      10	     8750
      20	    10875
      30	     9400
���μ�       	29025   -- ���μ� �������� �޿���
---------     -------
*/
-- �� �Ʒ� ���� ������ ǥ
-- �̷��� ��ȸ�� �� �ְ� ������ �����غ���.

-- NVL() Ȱ��
SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10 	 8750
     20	    10875
     30	     9400
���μ�    29025
*/

-- NVL2() Ȱ��
SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10 	 8750
     20	    10875
     30	     9400
���μ�    29025
*/

-- ���� ����� TBL_EMP�� �����غ���.
-- NVL() Ȱ��
SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿�"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10	     8750
     20	    10875
     30	     9400
���μ�	 8700
���μ�	37725
*/

-- NVL2() Ȱ��
SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10	     8750
     20	    10875
     30	     9400
���μ�	 8700
���μ�	37725
*/
-- �̷��� �� �ٿ��� ��Ī �� ���̴°� ����,,,

-- �̰� �������ִ� ����� ����
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
  GROUPING  �μ���ȣ     �޿���
---------- ---------- ----------
         0         10       8750
         0         20      10875
         0         30       9400        -- �Ʒ�ó�� �����ؼ� ǥ���غ���
         0      (null)      8700        -- ����
         1      (null)     37725        -- ���μ�
*/
-- GROUPING LEVEL�� �� �� ����
-- GROUPING LEVEL 1 : �μ����� ��� �޿��� ���Ѱ�
-- GROUPING LEVEL 2 : �� �μ��� �޿����� �� ���ؼ� ���ձ��Ѱ�

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700 
(null)	37725
*/

--�� ������ ��ȸ�� �ش� ������ 
/*
      10	 8750
      20	10875
      30	 9400
    ����	 8700 
���μ�	37725
*/
-- �̿� ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.

--�� ����
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--�� ��Ʈ
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN '���Ϻμ�'
                             ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
���Ϻμ�	     8750
���Ϻμ�	    10875
���Ϻμ�     9400
���Ϻμ�	     8700
���μ�	    37725
*/

-- ��
-- TO_CHAR(DEPTNO) �� �����༭ ��� ����������,,
SELECT NVL(TO_CHAR(DEPTNO), CASE GROUPING(DEPTNO) WHEN 0 THEN '����'
                                                  ELSE '���μ�'
       END) "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����	         8700
���μ�	    37725
*/

-- ��
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO 
            ELSE -1 
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
    10	 8750
    20	10875
    30	 9400
(null)   8700
    -1	37725
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO 
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> �����߻�
--     (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)
--     ��¿ ���� ���� �ְ�, ��¿ ���� ���ڳ������ �ϴϱ� �������� ��


-- ��� ��Ȳ���� �� ���� �ְ� �ٲ�
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
(null)       8700
���μ�    37725
*/
--> (null) �� �������� �ٲ��ָ� ��


-- ��� ��Ȳ���� �� ���� �ְ� �ٲ�
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '���μ�'
       END "�μ���ȣ"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
����         8700
���μ�    37725
*/


--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
-------------------------
    ����        �޿���
-------------------------
    ��          XXXXX
    ��          XXXXX
    �����   XXXXXX
-------------------------
*/
-- �� (GROUPING ó�� ���ϰ� Ǯ��,,)
SELECT NVL(T.����, '�����') "����", SUM(T.�޿�) "�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                ELSE '����Ȯ�κҰ�'
           END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        21900
��	        32100
�����	54000
*/

-- ��
SELECT CASE GROUPING(T.����) WHEN 0 THEN T.����
                             ELSE '�����'
       END "����"
     , SUM(T.�޿�) "�޿���"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��' 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                ELSE '����Ȯ�κҰ�'
           END "����"
         , SAL "�޿�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.����);
--==>>
/*
��	        21900
��	        32100
�����	54000
*/


SELECT *
FROM VIEW_SAWON;

--�� TBL_SAWON ���̺��� �������
--   ������ ���� ��ȸ�� �� �ֵ��� ���ɴ뺰 �ο����� Ȯ���� �� �ִ�
--   �������� �����Ѵ�.
/*
---------------------------------
    ���ɴ�         �ο���
---------------------------------
       10             X
       20             X
       40             X
       50             X
       ��ü          XX
---------------------------------
*/
-- INLINE VIEW 1��, 2�� ��ø���Ѽ� Ǫ�� ��� ����

-- ��
-- INLINE VIEW 2�� ��ø(�����糪�� �迬�ɴ�)
SELECT CASE GROUPING(T2.���ɴ�) WHEN 0 THEN T2.���ɴ�
                                ELSE '��ü'
       END "���ɴ�"
     , COUNT(T2.���ɴ�) "�ο���"
FROM
(
    SELECT CASE TRUNC(T.���糪��, -1) WHEN 10 THEN '10'
                                      WHEN 20 THEN '20'
                                      WHEN 30 THEN '30'
                                      WHEN 40 THEN '40'
                                      WHEN 50 THEN '50'
                                      WHEN 60 THEN '60'
                                      ELSE '10~60�� ��'
           END "���ɴ�"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE -1
               END "���糪��"
        FROM TBL_SAWON
    ) T
) T2
GROUP BY ROLLUP(T2.���ɴ�);
--==>>
/*
���ɴ�      �ο���
-------- ----------
10                2
20               12
40                1
50                3
��ü             18
*/

-- ��
-- INLINE VIEW 1�� ��ø (�׳� ���糪�� ����������, �ٷ� ���ɴ�� ���ع�����)
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN T.���ɴ�
                               ELSE '��ü'
       END "���ɴ�"
     , COUNT(T.���ɴ�) "�ο���"
FROM
(
    SELECT CASE TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                           ELSE -1
                      END, -1)
                WHEN 10 THEN '10'
                WHEN 20 THEN '20'
                WHEN 30 THEN '30'
                WHEN 40 THEN '40'
                WHEN 50 THEN '50'
                WHEN 60 THEN '60'
                ELSE '10~60�� ��'
           END "���ɴ�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);


-- ����ó�� ���ϰ� �Ʒ�ó���� ���൵ ��,,,
-- ������ Ǯ�̺��� ������ ������,,!!
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�)
                               ELSE '��ü'
       END "���ɴ�"
     , COUNT(T.���ɴ�) "�ο���"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                           ELSE -1
                      END, -1) "���ɴ�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);
--==>>
/*
���ɴ�      �ο���
-------- ----------
10                2
20               12
40                1
50                3
��ü             18
*/

-- ��
-- ��� 1. �� INLINE VIEW �� �� �� ��ø
--            NVL() ����ؼ� ���ɴ� ����
SELECT NVL(TO_CHAR(T2.���ɴ�), '��ü') "���ɴ�"  -- �׳� NVL(T2.���ɴ�, '��ü') "���ɴ�"
                                                 -- �̷����ϸ� ���ɴ� �÷��� 
                                                 -- ���� ����Ÿ���ε�, 
                                                 --'��ü'�� ����Ÿ���̱� ������ ������ 
     , COUNT(T2.���ɴ�)
FROM
(
    --�� ���� �̿��ؼ� ���ɴ� ���ϱ�
    SELECT CASE WHEN T1.���� >= 50 THEN 50
                WHEN T1.���� >= 40 THEN 40
                WHEN T1.���� >= 30 THEN 30
                WHEN T1.���� >= 20 THEN 20
                WHEN T1.���� >= 10 THEN 10
                ELSE 0
           END "���ɴ�"
    FROM
    (
        --�� ���� ���� ���ϱ�
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE -1
               END "����"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.���ɴ�);


-- ��� 1. �� INLINE VIEW �� �� �� ��ø
--            CASE, GROUPING() ����ؼ� ���ɴ� ����
SELECT CASE GROUPING(T2.���ɴ�) WHEN 0 THEN TO_CHAR(T2.���ɴ�)
                                ELSE '��ü'
       END "���ɴ�"
     , COUNT(*) "�ο���"
FROM
(
    --�� ���� �̿��ؼ� ���ɴ� ���ϱ�
    SELECT CASE WHEN T1.���� >= 50 THEN 50
                WHEN T1.���� >= 40 THEN 40
                WHEN T1.���� >= 30 THEN 30
                WHEN T1.���� >= 20 THEN 20
                WHEN T1.���� >= 10 THEN 10
                ELSE 0
           END "���ɴ�"
    FROM
    (
        --�� ���� ���� ���ϱ�
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE -1
               END "����"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.���ɴ�);
--==>>
/*
���ɴ�    �ο���
------- ----------
10           2
20          12
40           1
50           3
��ü        18
*/

-- ��� 2. �� INLINE VIEW �� �� �� ��ø
-- �׳� �ٷ� ���� �̿��ؼ� ���ɴ� ����
SELECT CASE GROUPING(T.���ɴ�) WHEN 0 THEN TO_CHAR(T.���ɴ�)
                               ELSE '��ü'
       END "���ɴ�"
     , COUNT(*) "�ο���"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                      ELSE -1
                 END, -1) "���ɴ�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);
--==>>
/*
���ɴ�    �ο���
------- ----------
10           2
20          12
40           1
50           3
��ü        18
*/

-- �� (������ ��)
--��ø2��
SELECT NVL(TO_CHAR(T2.���ɴ�), '��ü'), COUNT(*) "�ο���"
FROM
(
    SELECT TRUNC(T1.����, -1) "���ɴ�"
    FROM
    (
        SELECT 
        CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
             WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
             ELSE -1
        END "����"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.���ɴ�);


--��ø1��
SELECT NVL(TO_CHAR(T.���ɴ�), '��ü'), COUNT(*) "�ο���"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                      ELSE -1
                 END, -1) "���ɴ�"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.���ɴ�);



-- ���ݱ��� �츮�� GROUP BY �� �ϳ��� �����µ�,
-- �ݵ�� �ϳ��� ����� �ϴ� �� �ƴ�
SELECT DEPTNO, JOB, SAL
FROM EMP;

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000

20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975

30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	5600
*/
-- 1���� �μ���ȣ ���� ��� ����,
-- 2���� �� �μ� �ȿ���, �������� ������� ������

-- ����ó�� ������ ������ ROLLUP() �ϴ� �͵� ������
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
    10	CLERK	     1300   -- 10�� �μ� CLERK     ������ �޿���
    10	MANAGER	     2450   -- 10�� �μ� MANAGER   ������ �޿���
    10	PRESIDENT	 5000   -- 10�� �μ� PRESIDENT ������ �޿���
    10	(null)	     8750   -- 10�� �μ� ��� ������ �޿���        -- CHECK~!!!
    
    20	ANALYST	     6000   -- 20�� �μ� ALALYST   ������ �޿���
    20	CLERK	     1900   -- 20�� �μ� CLERK     ������ �޿���
    20	MANAGER	     2975   -- 20�� �μ� MANAGER   ������ �޿���
    20	(null)	    10875   -- 20�� �μ� ��� ������ �޿���        -- CHECK~!!!
    
    30	CLERK	      950   -- 30�� �μ� CLERK     ������ �޿���
    30	MANAGER	     2850   -- 30�� �μ� MANAGER   ������ �޿���
    30	SALESMAN	 5600   -- 30�� �μ� SALESMAN  ������ �޿���
    30	(null)	     9400   -- 30�� �μ� ��� ������ �޿���        -- CHECK~!!!
    
(null)	(null)	    29025   -- ��� �μ� ��� ������ �޿���        -- CHECK~!!!
*/


--�� CUBE() �� ROLLUP() ���� �� �ڼ��� ����� ��ȯ�޴´�.
-- ���� �ߴ� ���������� ROLLUP()�� CUBE()�� �ٲ���
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
    10	CLERK	     1300
    10	MANAGER	     2450
    10	PRESIDENT	 5000
    10	(null)	     8750
    
    20	ANALYST	     6000
    20	CLERK	     1900
    20	MANAGER	     2975
    20	(null)  	10875
    
    30	CLERK	      950
    30	MANAGER	     2850
    30	SALESMAN	 5600
    30	(null)  	 9400
    
(null)	ANALYST 	 6000 �� -- ��� �μ� ALALYST   ������ �޿���
(null)	CLERK	     4150 �� -- ��� �μ� CLERK     ������ �޿���
(null)	MANAGER	     8275 �� -- ��� �μ� MANAGER   ������ �޿���
(null)	PRESIDENT	 5000 �� -- ��� �μ� PRESIDENT ������ �޿���
(null)	SALESMAN	 5600 �� -- ��� �μ� SALESMAN  ������ �޿���

(null)	(null)  	29025
*/
-- '�׳� ���� �ڼ��� �˷��ֳ�����' �� �����ϱ⺸�ٴ�
-- ����ó���ϴ� ����� �ٸ��ٰ� �������ִ°� ����

--�� ROLLUP() �� CUBE() ��
--   �׷��� �����ִ� ����� �ٸ���. (����)

-- ex)
-- ROLLUP(A, B, C)
-- �� (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- �� (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> ������ ����� ��(ROLLUP())�� ���� ����� �ټ� ���ڶ� �� �ְ�,
--     �Ʒ����� ����� ��(CUBE())�� ���� ����� �ټ� ����ĥ �� �ֱ� ������
--     ������ ���� ����� ���� ���¸� �� ���� ����Ѵ�.
--     ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸
--     ��GROUPING SETS���� �̿��Ͽ� �����ִ� ����̴�.

-- ROLLUP()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        ��ü����     8750

20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        ��ü����	10875

30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        ��ü����     9400

����      	CLERK	     3500
����	    SALESMAN	 5200
����	    ��ü����	 8700

��ü�μ�	��ü����	37725
*/

-- CUBE()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	      1300
10	        MANAGER	      2450
10	        PRESIDENT	  5000
10	        ��ü����	  8750

20	        ANALYST	      6000
20	        CLERK	      1900
20	        MANAGER	      2975
20	        ��ü����	 10875

30	        CLERK	       950
30	        MANAGER	      2850
30	        SALESMAN	  5600
30	        ��ü����	  9400

����	    CLERK	      3500
����	    SALESMAN	  5200
����	    ��ü����      8700

��ü�μ�	ANALYST	      6000
��ü�μ�    CLERK	      7650
��ü�μ�    MANAGER	      8275
��ü�μ�	PRESIDENT	  5000
��ü�μ�	SALESMAN	 10800

��ü�μ�	��ü����     37725
*/

-- GROUPING SETS() : ��� GROUP ���� �������� ���� ����ϴ� ��
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())  
ORDER BY 1, 2;
--> CUBE() ����� ����� ���� ��ȸ ���


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
            ELSE '��ü�μ�'
       END "�μ���ȣ"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '��ü����'
       END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())  
ORDER BY 1, 2;
--> ROLLUP() ����� ����� ���� ��ȸ ���


SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


--�� TBL_EMP ���̺��� �������
--   �Ի�⵵�� �ο����� ��ȸ�Ѵ�.
--   (�Ի�⵵, �ο���, �ο�������) �����ָ� ��

-- ��
SELECT NVL(TO_CHAR(T.�Ի�⵵), '����') "�Ի�⵵", COUNT(*) "�ο���"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
    FROM TBL_EMP
) T
GROUP BY ROLLUP(T.�Ի�⵵);
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
����	19
*/

-- ��
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;


-- ���� �߻��ϴ� �� ���� ���� ���캸��.
-- ���� �Ÿ�, GROUP BY �ϴ� ���� ���� �ٸ���
SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> ���� �߻�
--     (ORA-00979: not a GROUP BY expression)
--     �׷� GROUP BY ������ TO_CHAR(HIREDATE, 'YYYY') �� ����?

-- �װ� �� �ƴ�
-- �Ʒ� ó�� SELECT ���� �ٲٸ� ���������� ó����
SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
-- SELECT ������ GROUP BY ���� ���� PARSING�ǰ�, ó����

-- �Ʒ�ó�� TO_CHAR() EXTRACT() �ٲ㼭 �ص� �������� �������
SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--     (ORA-00979: not a GROUP BY expression)
--     �׷� GROUP BY ������ EXTRACT() �� ����?

--> �ܼ��� �� ������ GROUP BY ������ EXTRACT(), TO_CHAR() �� ���ٰ� 
--  �����ϸ� �ȵ�!!

-- SELECT ������ GROUP BY ���� ���� PARSING�ǰ�, ó���Ǵµ�,
-- GROUP BY ���� ó���� �Ͱ�, 
-- ���� SELECT ���� �ٸ� �� ó���ϰڴٰ� -- �ȰŶ� �׷�����!
-- GROUP BY�� �ص�, ROLLUP(), CUBE(), GROUPING SETS() �ص� �� �Ȱ��� ��� ����

-- SELECT �������� GROUP BY ���� ó���� ������ ������ ��� ��!!!


-- ���� �߻��ϴ� ��� ���� �� ���캸��.
-- GROUP BY ���� ó���� ���� - GROUPING ���� ó���ȳ���
-- ELSE ���� ó���� ���� - THEN ���� ó���� ����
-- �ڼ��� ����!!
SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
            THEN EXTRACT(YEAR FROM HIREDATE)
            ELSE '��ü' 
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--     (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)
-- �������� ����,
-- THEN ���Ͽ� ���ڷ� ó���Ѵٰ� �س���, ELSE ���� ����ó���ϴϱ� ������
-- GROUP BY ���� EXTRACT() �� ó���ϰ�, 
-- SELECT GROUPING()������ TO_CHAR()�� ó����


-- ���� ���� �����ؼ�, EXTRACT() �� �Ǿ��ִ��� �� TO_CHAR() ������� ���Ͻ�Ŵ
SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
            THEN TO_CHAR(HIREDATE, 'YYYY')
            ELSE '��ü' 
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> ���� �����
-- ELSE ������ ���ڷ� ó���߰�, THEN ���Ͽ����� ����Ÿ������ ó������ �� �̻����
-- GROUP BY ���� TO_CHAR() �� ó���ϰ�
-- SELECT GROUPING() ���� TO_CHAR()�� ó���� �� �̻����


-- ���� ���� �����ؼ�, TO_CHAR() �� �Ǿ��ִ��� �� EXTRACT() ������� ���Ͻ�Ŵ
SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN EXTRACT(YEAR FROM HIREDATE)
            ELSE -1 
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �����
-- ELSE ������ ���ڷ� ó���߰�, THEN ���Ͽ����� ����Ÿ������ ó������ �� �̻����
-- GROUP BY ���� EXTRACT() �� ó���ϰ�
-- SELECT GROUPING() ���� EXTRACT()�� ó���� �� �̻����
--==>>
/*
  -1	19
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
*/

-- ���� ��� -1 �κ��� '��ü'�� �ٲٰ� ������ ��� �ұ�?
-- THEN �κп� TO_CHAR() �����ָ� ��
SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
            ELSE '��ü'
       END "�Ի�⵵"
     , COUNT(*) "�ο���"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
��ü	    19
*/

--�� �����ؼ� �����ۼ�����!!
-- GROUP BY ���� GROUPING ���� ������ Ÿ��
-- THEN ���Ŀ� - ELSE ������ ������ Ÿ��


--------------------------------------------------------------------------------

---���� HAVING ����--

--�� EMP ���̺��� �μ���ȣ�� 20, 30 �� �μ��� �������
--   �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.
-- ��
-- HAVING �� ��� X
SELECT T.*
FROM 
(
    SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�μ��� �� �޿�"
    FROM EMP
    WHERE DEPTNO IN (20, 30)
    GROUP BY DEPTNO
    ORDER BY 1
) T
WHERE T."�μ��� �� �޿�" < 10000;
--==>> 30	9400


-- HAVING �� ���
SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�μ��� �� �޿�"
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
ORDER BY 1;
--==>> 30	9400


-- ��
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> ���� �߻�
--     (ORA-00934: group function is not allowed here)
--     �׷� �Լ��� �� ������ ����� �� �����ϴ�.
-- �׷��Լ� WHERE ������ ����� �� ����

-- �׷� �� ���� �Ǵ°�, 
-- HAVING ��
-- ��
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400

-- ����
-- ��
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
   AND DEPTNO IN (20, 30);
--==>> 30	9400
-- ���� ���� ����� ����
-- �� ������ �ٸ��� ���� ��� ��ȯ�ϰ� �ִ�.

-- �׷���,
-- FROM WHERE GROUPBY HAVING SELECT ORDERBY
-- �̷��� SELECT �� PARSING �ϴ� ��������
-- �޸𸮿� 1�������� �ۿø��� ������
-- FROM �� WHERE ��. 
-- 1��������,
-- FROM �� �ش�Ǵ� ���̺��� WHERE �� ���ǿ� �´� ���ڵ常 ������ �ͼ�
-- ����ó���ϰ� ��!!
-- �̰͸� �Ű澲�鼭 �ص� ���ҽ� �ξ� �����

-- �׷��ٺ���, ������� ������� ���°� �δ��� ����!!!
-- �� ���̰� Ŭ���̾�Ʈ�� ���� �䱸���� ��, 
-- �𷡽ð谡 �� ������, �� �������� ���̸� �������� �ȴ� !!


--------------------------------------------------------------------------------

--���� ��ø �׷��Լ� / �м��Լ� ����--

-- (����)�׷��Լ����� ù��°�� �����ߴ� ����
-- ó���ϴ� ������ �߿� NULL �� ���ԵǾ� �ִٸ�, NULL �����ϰ� ����Ѵ�.

-- �׷� �Լ��� 2 LEVEL ���� ��ø�ؼ� ����� �� �ִ�.
-- MSSQL �� �̸����� �Ұ����ϴ�.

-- 2 LEVEL ��ø�� ���� ���̳� �ϸ�,
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
-- �μ����� �޿� ������ ����

-- �ű⼭,
SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875
-- �μ��� �޿� �� �ִ�

SELECT MIN(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 8750
-- �μ��� �޿� �� �ּڰ�


--�� RANK()
--   DENSE_RANK()
--> ORACLE 9i ���� ����... MSSQL 2005 ���� ����...

-- ���� ���������� RANK() �� DENSE_RANK() �� ����� �� ���� ������
-- ���� ���... �޿� ������ ���ϰ��� �Ѵٸ�...
-- �ش� ����� �޿����� �� ū ���� �� ������ Ȯ���� ��
-- Ȯ���� ���� +1 �� �߰� ������ �ָ�...
-- �� ���� �� �ش� ����� �޿� ����� �ȴ�.


-- RANK(), DENSE_RANK() ���� ����, ��� ���ϴ� ���
SELECT ENAME, SAL
FROM EMP;
--==>>
/*
SMITH	 800
ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
TURNER	1500
ADAMS	1100
JAMES	 950
FORD	3000
MILLER	1300
*/

--�� SMITH �� �޿� ��� Ȯ���غ���
-- SMITH ���� �޿��� ū ������� ���� ���� ����. �� 13��
-- �ű⿡ +1 �ϸ� SMITH �� �޿� ��� �� 14��
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;     -- SMITH �� �޿�
--==>> 14            -- SMITH �� �޿� ���

-- ���� ������� 
--�� ALLEN �� �޿� ��� Ȯ���غ���
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;     -- ALLEN �� �޿�
--==>> 7              -- ALLEN �� �޿� ���


-- �̷��� �ϸ� �� �� �־ Ȯ���غ��� �Ѵ�...
-- �̷� ��, �������� ����ϸ� ��
-- RANK() �Լ��� �� ��ó��, ���� �� �� �ִ�.

--�� ���� ��� ����(��� ���� ����)
--   �ζ��κ䵵 ���������� �� ����
--   ���� ��� ������ ���������� �� ����

--   ���� ������ �ִ� ���̺��� �÷���
--   ���� ������ ������(WHERE��, HAVING)�� ���Ǵ� ���
--   �츮�� �� �������� ���� ��� ����(��� ���� ����)��� �θ���.

SELECT ENAME "�����", SAL "�޿�", 1 "�޿����"
FROM EMP;
--==>>
/*
SMITH	 800	1
ALLEN	1600	1
WARD	1250	1
JONES	2975	1
MARTIN	1250	1
BLAKE	2850	1
CLARK	2450	1
SCOTT	3000	1
KING	5000	1
TURNER	1500	1
ADAMS	1100	1
JAMES	 950	1
FORD	3000	1
MILLER	1300	1
*/
-- �̷��� �ϸ� ��� ����� �޿���� 1�� ����


-- 1 ����� �ڸ��� SMITH�� �޿� ��� ���ߴ� ������ �������
-- �� ��� ����� �޿���� ��� 14�� ���� ����
SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT(*) + 1 
        FROM EMP 
        WHERE SAL > 800) "�޿����"
FROM EMP;
--==>>
/*
SMITH	 800	14
ALLEN	1600	14
WARD	1250	14
JONES	2975	14
MARTIN	1250	14
BLAKE	2850	14
CLARK	2450	14
SCOTT	3000	14
KING	5000	14
TURNER	1500	14
ADAMS	1100	14
JAMES	 950	14
FORD	3000	14
MILLER	1300	14
*/

-- ALLEN �� Ȯ���� ���� 800 �ڸ��� ALLEN �� �޿� 1600 �־��ָ� �ǰ�,
-- WARD  �� Ȯ���� ���� 800 �ڸ��� WARD  �� �޿� 1250 �־��ִ� ������� �ϸ� ��
-- �ٱ��� �ִ� ���������� ��Ī����
-- ��������.�޿� ���ָ� �������������� �޿��� 800���� ������ �ƴϴ�.
SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT(*) + 1 
        FROM EMP 
        WHERE SAL > E.SAL) "�޿����"
FROM EMP E
ORDER BY 3;
--==>>
/*
KING	5000	 1
FORD	3000	 2
SCOTT	3000	 2
JONES	2975	 4
BLAKE	2850	 5
CLARK	2450	 6
ALLEN	1600	 7
TURNER	1500	 8
MILLER	1300	 9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	 950	13
SMITH	 800	14
*/


--�� EMP ���̺��� ������� 
--   �����, �޿�, �μ���ȣ, �μ����޿����, ��ü�޿���� �׸��� ��ȸ�Ѵ�.
--   ��, RANK() �Լ��� ������� �ʰ� ������������ Ȱ���� �� �ֵ��� �Ѵ�.
SELECT E.ENAME "�����", E.SAL "�޿�", E.DEPTNO "�μ���ȣ"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL
          AND DEPTNO = E.DEPTNO) "�μ����޿����"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL) "��ü�޿����"
FROM EMP E
ORDER BY 3, 4;
--==>>
/*
KING	5000	10	1	 1
CLARK	2450	10	2	 6
MILLER	1300	10	3	 9

SCOTT	3000	20	1	 2
FORD	3000	20	1	 2
JONES	2975	20	3	 4
ADAMS	1100	20	4	12
SMITH	 800	20	5	14

BLAKE	2850	30	1	 5
ALLEN	1600	30	2	 7
TURNER	1500	30	3	 8
MARTIN	1250	30	4	10
WARD	1250	30	4	10
JAMES	 950	30	6	13
*/


SELECT *
FROM EMP;

--�� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--------------------------------------------------------------------------------
-- �����  �μ���ȣ    �Ի���       �޿�    �μ����Ի纰�޿�����
--------------------------------------------------------------------------------
--                              :                                    
-- SMITH     20     1980-12-17      800                    800  
-- JONES     20     1981-04-02     2975                   3775
-- FORD      20     1982-01-23     3000                   6775
--                              :
--------------------------------------------------------------------------------

-- �� : �� Ǯ����,,
SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , 0 + (SELECT E.SAL
        FROM EMP
        WHERE DEPTNO = 20
        GROUP BY DEPTNO) "�μ����Ի纰�޿�����"
FROM EMP E
ORDER BY 2, 3;

-- SUM() OVER() ��� --> �Ի��� ������ ó�� �ȵ�,,,
SELECT ENAME "�����", DEPTNO "�μ���ȣ", HIREDATE "�Ի���", SAL "�޿�"
     , SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP;


-- ��
SELECT EMP.ENAME, DEPTNO, HIREDATE, SAL, (1) "�μ����Ի纰�޿�����"
FROM SCOTT.EMP
ORDER BY 2, 3;


SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL "�޿�"
     , (1) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;

--���� �μ����Ի纰�޿����� ���� �ۼ��غ���
SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL "�޿�"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;
--> �׳� ��ü �޿��� ���������

SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL "�޿�"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;
--> �μ��� �޿��� ����

-- ���� �μ� �ȿ���,
-- MILLER ���忡���� KING �� �Ի����� �� ����
-- KING ���忡���� CLARK �� �Ի��� �� ����
-- �� �տ� �͵��� �� ��ȸ�ϸ� ��
SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ", E1.HIREDATE "�Ի���", E1.SAL "�޿�"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;
--==>>
/*
CLARK	10	1981-06-09	2450	 2450
KING	10	1981-11-17	5000	 7450
MILLER	10	1982-01-23	1300	 8750
SMITH	20	1980-12-17	 800	  800
JONES	20	1981-04-02	2975	 3775
FORD	20	1981-12-03	3000	 6775
SCOTT	20	1987-07-13	3000	10875  -- ���� ��¥�� �Ի��ѰŶ�
ADAMS	20	1987-07-13	1100	10875  -- �̷��� ó���Ȱ�
ALLEN	30	1981-02-20	1600	 1600
WARD	30	1981-02-22	1250	 2850
BLAKE	30	1981-05-01	2850	 5700
TURNER	30	1981-09-08	1500	 7200
MARTIN	30	1981-09-28	1250	 8450
JAMES	30	1981-12-03	 950	 9400
*/


--�� EMP ���̺��� �������
--   �Ի��� ����� ���� ���� ������ ����
--   �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--------------------------------
-- �Ի���    �ο���
--------------------------------

-- ��
-- ������� ����,,
SELECT SUBSTR(HIREDATE, 1, 7) "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY SUBSTR(HIREDATE, 1, 7)
ORDER BY 1;
--==>>
/*
�Ի���       �ο���
--------     ----------
1980-12          1
1981-02          2
1981-04          1
1981-05          1
1981-06          1
1981-09          2
1981-11          1
1981-12          2
1982-01          1
1987-07          2
*/
 
SELECT SUBSTR(HIREDATE, 1, 7) "�Ի���"
     , (SELECT COUNT(*)
        FROM EMP E2
        GROUP BY SUBSTR(HIREDATE, 1, 7)
        HAVING E1.MAX(COUNT(*)) <= E2.COUNT(*)) "�ο���"
FROM EMP E1
ORDER BY 1;

SELECT SUBSTR(HIREDATE, 1, 7) "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY SUBSTR(HIREDATE, 1, 7)
HAVING COUNT(*) = MAX(COUNT(*))
ORDER BY 1;


-- ��
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-05	    1
1981-12 	2   ��
1982-01	    1
1981-09 	2   ��
1981-02 	2   ��
1981-11	    1
1980-12	    1
1981-04	    1
1987-07	    2   ��
1981-06	    1
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
WHERE COUNT(*) = 2
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> ���� �߻�
--     (ORA-00934: group function is not allowed here)


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 2     -- ����� ��� ���� ���� �ο� ���� �Ի� ī��Ʈ
ORDER BY 1;
--==>>
/*
1981-02	    2
1981-09	    2
1981-12	    2
1987-07	    2
*/

-- ���� ���� �������� COUNT(*) = 2���� ��2�� �ڸ���
-- ����Ŭ�� ���� ��2���� ���� �� �ֵ��� ���� ������.

-- �� ��,�� ���� �ű⿡ �´� �ο� �� ��� ������
SELECT COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1
2
1
2
2
1
1
1
2
1
*/

-- ����� ��� ���� ���� �ο� ���� �Ի� ī��Ʈ
SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 2

-- ��2���ڸ��� ���� ���� �־��ֱ�
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (
                    SELECT MAX(COUNT(*))
                    FROM EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
                  )
ORDER BY 1;
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/


--------------------------------------------------------------------------------
-- �߰� �����ϴٰ� �ʱ�
-- +) ������ PPT 3��: LISTAGG �Լ�
--ex.
SELECT BUSEO "�μ�"
     , LISTAGG(NAME, '->') WITHIN GROUP(ORDER BY NUM) "LISTAGG"
FROM TBL_INSA
GROUP BY BUSEO;
--==>>
/*
���ߺ�	�̼���->�̱���->����ö->Ȳ����->�̻���->�����->�̼���->ȫ�泲->������->ä����->�̱��->�̹̼�->�Ӽ���->��ž�->������
��ȹ��	ȫ�浿->�̿���->�踻��->����ȯ->������->�ǿ���->�����
������	������->������->������->���μ�->�����->�����->��̳�->���μ�->�����->��̿�->����ȯ->ȫ����->�긶��->�ǿ���->���ѳ�->������
�λ��	������->�ڹ���->�̳���->�ڼ���
�����	������->�ɽ���->���翵->�����->��̽�->�̹̰�
�ѹ���	�̼���->�Ѽ���->������->�迵��->�踻��->������->����
ȫ����	�迵��->���ѱ�->���̼�->�ּ���->�̹���->����ȣ
*/

--+) �ʿ���� ���� �����ϱ� ���ؼ� 
--   MAX(), MIN() �� �׷��ռ� ����ص� ��
--   �� �׷��Լ��� ����(NULL) �� �ڵ������Ѵ�.






