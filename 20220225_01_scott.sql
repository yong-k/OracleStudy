SELECT USER
FROM DUAL;
--==>> SCOTT


--���� ROW_NUMBER ����--

SELECT ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;
--==> ���Ȯ���ϸ� ����� �տ� �÷� �տ� �츮�� ������ �� ������
--    ���ϰ� Ȯ���� �� �ֵ��� 1~14�� ���� ������ �� ���ȣ
--    ���� �����Ϳ��� �̷��� ���� ������? NO. ����
--    �� �� ������ ROW_NUMBER


-- ROW_NUMER() OVER(���ȣ �� �������� ���ϰ��� ����)
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;
--==>>
/*
 1	KING	5000	1981-11-17
 2	FORD	3000	1981-12-03
 3	SCOTT	3000	1987-07-13
 4	JONES	2975	1981-04-02
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 7	ALLEN	1600	1981-02-20
 8	TURNER	1500	1981-09-08
 9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	 950	1981-12-03
14	SMITH	 800	1980-12-17
*/


-- ROW_NUMBER() OVER() ���� ���ԵǴ� ORDER BY��
-- ������ ��ü���� ���� ORDER BY �� �ٸ���.
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
-- ���ȣ�� SAL DESC �������� �پ�����,
-- ������ ENAME �������� ���ĵ�
--==>>
/*
12	ADAMS	1100	1987-07-13
 7	ALLEN	1600	1981-02-20
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 2	FORD	3000	1981-12-03
13	JAMES	 950	1981-12-03
 4	JONES	2975	1981-04-02
 1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
 9	MILLER	1300	1982-01-23
 3	SCOTT	3000	1987-07-13
14	SMITH	 800	1980-12-17
 8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
     , ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
--==>>
/*
 1	ADAMS	1100	1987-07-13
 2	ALLEN	1600	1981-02-20
 3	BLAKE	2850	1981-05-01
 4	CLARK	2450	1981-06-09
 5	FORD	3000	1981-12-03
 6	JAMES	 950	1981-12-03
 7	JONES	2975	1981-04-02
 8	KING	5000	1981-11-17
 9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	 800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
     , ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;
--==>>
/*
1	ADAMS	20	1100	1987-07-13
2	FORD	20	3000	1981-12-03
3	JONES	20	2975	1981-04-02
4	SCOTT	20	3000	1987-07-13
5	SMITH	20	 800	1980-12-17
*/
-- ���� ������ ����� �� �ٸ�
-- FROM���� ���� Ÿ�����ϰ�, WHERE ���ǿ� �ش�Ǵ� �ֵ� �޸𸮿� �ۿø���,
-- �� �޸𸮿� �ۿ÷��� �ֵ鿡 ROW_NUMBER ���̴� ����
-- �׳� EMP �� ������ �ִ� ��� �ֵ����� 
-- ROW_NUMBER �ο��ϰ� ������ ���°� �ƴϴ� !



--�� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY �� ����ϰ� �Ǹ�
--   �Խù��� �������� ���, ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--   �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--   �̴�... ���ȼ� �����̳�... �̰���... 
--   �ٶ������� ���� ��Ȳ�� �� �ֱ� ������
--   ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--   ������ �������� ����� ������ SEQUENCE �� IDENTITY �� ���������
--   �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--   ������� �ʴ� ���� �ٶ����ϴ�.

-- SEQUENCE �� ORACLE ���� ���� �����̰�,
-- IDENTITY �� MSSQL  ���� ���� �����̴�.

-- +)
-- ��� ���ڵ忡�� �ĺ��� �������� ������ �ο��ϴ°� �����ϱ� ���ϴ�.
-- �Խù��� ���� ��ȣ�� DB�󿡴� ���� 99.99% ������,
-- �װ� Ŭ���̾�Ʈ�� �˰� �ϴ���, �ƴϳĿ� ���� ���̴� ũ��.
-- �� ��ȣ�� �˰� ������, �������� ���������� ��ŷ�� ����������.
-- ���Ȼ����ε� ������ ���� ���� �ְ�, �̰��� ������ ���� �� �ִ�.
-- ������ �ĺ��ڷ� Ȱ���ϰ� �Ǵ� ��ȣ����
-- ex) �Խù� ��� ���ú���,

-- 4 ... ...
-- 3 ... ...
-- 2 ...
-- 1 .... ...

--> 2���� �̴�Ȩ�� ������ �����, 3���� �����ڰ� ����
-- 7 ...
-- 6 ... ..
-- 5 ... ..... ..
-- 4 ... ...
-- 1 .... ...

--> 5��, 6�� �̴�Ȩ�� ������ ����
-- 7 ...
-- 4 ... ...
-- 1 .... ...

--> �̷��� �� �Խ��ǿ� ���� ���� �?
--  �̰� ���� �ı�, ��޾��� �̷��ſ� ���õ� �Ŷ��
--  '�̰� �����ڰ� �Խ��ǿ� ���� �˿� ��û ���Ѱ� �ƴϾ�?'
--   ��� ���԰� ���� ���� ���� �� �̰��� ���� ����




--�ڡڡ� ���⼭���� ���� ������ �ٽ�~!!!! �ڡڡ�--
-- ������ �Ǽ���,,,,����
-- ROLLBACK �ϰ� �ٽ� �Ѵٰ� ������ ���ƿ��� �� �ƴ�,,,
-- DBA���� ������ ���� �����޶�� ����ؾߵ�,,


--�� ���� �߸� ���Ǵ� ������ ����
DROP SEQUENCE SEQ_BOARD;
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


--�� SEQUENCE(������ : �ֹ���ȣ) ����
--   �� �������� �ǹ� : 1.(�Ϸ���) �������� ��ǵ�    2.(��� �ൿ ����) ����
-- ex) ���࿡ ���ǥ �̴°�, �������� ��⿭���� ��ȣ�޴°�.....
-- �Խ��ǿ� �Խù� �� ��, �츮�� ���� ��ȣ �ο��ؼ� ���� ����
-- ���� ���� 5 �����Ѵٰ� ������ 55�� �Խù� �����~ �Ѵٰ� �׷��°� �ƴ�
-- �׳� ���� ���ϱ� �ο��� ��ȣ�� 55�� �ΰ���
-- CREATE SEQUENCE �������� �� ��������� ������ �⺻ ������ ������
--                          (1���� �����ؼ� 1�� �����ؼ� ���Ѵ�������� �� ������)

CREATE SEQUENCE SEQ_BOARD   -- �⺻���� ������ ���� ����
START WITH 1                -- ���۰�
INCREMENT BY 1                 -- ������
NOMAXVALUE                  -- �ִ�
NOCACHE;                    -- ĳ�û�뿩��  
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.
-- �׳� CREATE SEQUENCE SEQ_BOARD �������ϸ�
-- ���� ���������� NOCACHE �� ������ �Ŷ� �Ȱ��� ����� ������

-- NOCACHE : �̸� ���ɰ� �̾Ƶδ� ����!
--           ó���ؾߵǴ°� 10�� �־ 10�� �̸� �̾Ƶθ�,
--           �ٸ� ��� �ͼ� �̿��� ���� ���� �տ� 10�� �� �� �͵� �ƴѵ� 11�� �ؾߵ�,,,
-- NOCACHE
-- ���� : ��ȣǥ �߱� �޴� ����� ��⿭���� ���� �ȱ�ٷ��� �ȴ�.
-- ���� : �̸� �̾Ƶΰ�, �ٸ� ���� �����ϰ� ������, 
--        ���� ����� �Ϸù�ȣ�� ���� ��ȣ�� �̰� �Ǵ� �� �ƴ϶� 
--        �׸�ŭ �پ�Ѱ� �� ��ȣ�� ���� ��,,


-- ���� �̰Ŵ� ���̺��̶� �����ְ� ����� �ƴ϶�,
-- ���������� ���� ����ϴ� ����


-- �ؿ����� ������ �����ߴµ�,,, �Ǽ��ؼ� �����Ѱ�,,!!
-- �� ���� �߸��� �����Ͱ� �Էµ� ���̺� ����
DROP TABLE TBL_BOARD PURGE;
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


SELECT *
FROM TAB;
--==>>
/*
BIN$Axk+pwWoSfmnxwvAP+d4Ig==$0	TABLE	
BIN$axIj+yKKRF6zdZShmlj9Cg==$0	TABLE	
BIN$oIjkpveUQhikguzRf40KDA==$0	TABLE	
    :
*/
-- ���� �� BIN$ ��¼�� �����°�
-- �����ߴµ� �����뿡 ����ִ� �ֵ�,,
-- ���� DROP TABLE TBL_BOARD �����ϸ� �� BIN$ ��¼��� ����
-- �����뿡 ���� �ʵ��� �ϰ� �����ϴ°� �ڿ� ��PURGE�� �ɼ� �ٿ��ָ� ��
-- WINDOWS������ �׳� DELETE �ϸ� �����밡����
--                    SHIFT + DELETE �ϸ� ������ �����ʰ� ����������


--�� ������ ����
PURGE RECYCLEBIN;
--==>> RECYCLEBIN��(��) ��������ϴ�.

-- �ٽ� ���̺� Ȯ��
SELECT *
FROM TAB;
--==>> BIN$ ��¼�� �ϴ°͵� �� ���������


-- ��PURGE��  ��PURGE RECYCLEBIN�� �̰� �� ��,,
-- BUT, 
-- �˾Ƶα⸸ �ϰ� ������ ����
-- DB���� ������ ��ġ�� �ʰ� �����ع�����, �����ϱ� ���ϰ� �������,,
-- �̰� �˾Ƽ� ������ �Ǵ� ��찡 �� ����,,!!


--�� �ǽ� ���̺� ����
CREATE TABLE TBL_BOARD              -- TBL_BOARD ���̺� ���� ���� �� �Խ��� ���̺�
--                                                          ����ڰ������ۼ�?
( NO        NUMBER                  -- �Խù� ��ȣ           ��
, TITLE     VARCHAR2(50)            -- �Խù� ����           ��
, CONTENTS  VARCHAR2(1000)          -- �Խù� ����           ��
, NAME      VARCHAR2(20)            -- �Խù� �ۼ���         ��
, PW        VARCHAR2(20)            -- �Խù� �н�����       �� --�Ҷ������Ҷ���
, CREATED   DATE DEFAULT SYSDATE    -- �Խù� �ۼ���         ��
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.


--�� ������ �Է� �� �Խ��ǿ� �Խù��� �ۼ��ϴ� �׼�
INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, 'Ǯ��', '�� Ǯ���� �־��', '������', 'java006$', DEFAULT);
--     ------------------
--     'SEQ_BOARD �������� ���� ��ȣ�� �� ����ϰڴ�' �� �ǹ�
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '���ζ�', '���ϴ� ���׿�', '������', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '�غ�', '�ٶ��� �γ׿�', '������', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '���ͺ�', '���ͺ����ε�, ���̰� �����׿�', '�̽ÿ�', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '����ּ���', '���� �������', '�ֹ���', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '���� ���ΰ�', '���� ���� �� ��', '��μ�', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '��������', '������ �����Ϸ� �Դ�', '������', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '�翬��', '�ƹ� ���� ����', '�̾Ƹ�', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� ���� ���� ���� ('�����Ͻú���'��)
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	Ǯ��	        �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:29:37
2	���ζ�	        ���ϴ� ���׿�	                ������	java006$	2022-02-25 10:30:08
3	�غ�	        �ٶ��� �γ׿�	                ������	java006$	2022-02-25 10:30:20
4	���ͺ�	        ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:30:36
5	����ּ���	    ���� �������	                �ֹ���	java006$	2022-02-25 10:30:57
6	���� ���ΰ�	    ���� ���� �� ��	            ��μ�	java006$	2022-02-25 10:31:24
7	��������	    ������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:35
8	�翬��	        �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
*/
-- ���� ��ũ �� ����� �� �ƴ�


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խù� ����
--�� �ϴ� ���� ��ȸ ���� �ϰ�, ������
SELECT *
FROM TBL_BOARD
WHERE NO = 2;


--�� ��ȸ������ ������ �� �´ٸ� 
--   SELECT �� DELETE�� �ٲ���
DELETE
FROM TBL_BOARD
WHERE NO = 2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


-- �ٸ� �� �� ����
DELETE
FROM TBL_BOARD
WHERE NO = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO = 5;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO = 6;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


-- ���� �Ϸ��ϰ� ���̺� �ٽ� ��ȸ
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	Ǯ��	    �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:29:37
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:30:36
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:35
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
*/
-- 1, 4, 7, 8�̶�� ��ȣ ���ͼ� �����Ǿ� �ִ� ������ �ƴ�,,


--�� �Խù� �߰� �ۼ�
INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '������', '������ ���ƿ�', '�����', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	Ǯ��	    �� Ǯ���� �־��                ������	java006$	2022-02-25 10:29:37
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:30:36
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:35
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
9	������	    ������ ���ƿ�	                �����	java006$	2022-02-25 10:40:32
*/
-- ���� �ۼ��� �� �߰����� ���� �� �ƴϰ�,
-- �׳� 9������ ����


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� �Խ����� �Խù� ����Ʈ�� �����ִ� ������ ����
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	������	    �����	2022-02-25 10:40:32
4	�翬��	    �̾Ƹ�	2022-02-25 10:31:52
3	��������    	������	2022-02-25 10:31:35
2	���ͺ�	    �̽ÿ�	2022-02-25 10:30:36
1	Ǯ��	        ������	2022-02-25 10:29:37
*/
-- �տ� �ִ� ���ڴ� �Խù��� �������� ��ȣ�� �ƴ�
-- ���� �ֱٿ� �� ���� ���� ���� ������
-- Ŭ���̾�Ʈ�� ���� ���忡���� �̰� �ξ� ���� ����


--�� ��(VIEW) ����
CREATE OR REPLACE VIEW VIEW_BOARDLIST
AS
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>> View VIEW_BOARDLIST��(��) �����Ǿ����ϴ�.


--�� ��(VIEW) ��ȸ
SELECT *
FROM VIEW_BOARDLIST;
--==>>
/*
5	������	    �����	2022-02-25 10:40:32
4	�翬��	    �̾Ƹ�	2022-02-25 10:31:52
3	��������	������	2022-02-25 10:31:35
2	���ͺ�	    �̽ÿ�	2022-02-25 10:30:36
1	Ǯ��	    ������	2022-02-25 10:29:37
*/

-- ROW_NUMBER() �� ������
-- SEQUENCE ���ǻ��� �� �� �ľ��ؾ� ��!!


--------------------------------------------------------------------------------

--���� JOIN(����) ����--

-- SMITH�� �μ��� Ȯ���Ϸ��� 2���� ������ ���ľ� �Ѵ�.
SELECT *
FROM EMP;
--==>> 7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20
-- ��, 20�� �μ�����

SELECT *
FROM DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
-- �� 20�� �μ��� RESEARCH �μ�����

--> SMITH�� RESEARCH �μ�

-- �׳� EMP ���̺� ���� �μ���ȣ �ڿ�, �μ���/�μ���ȭ��ȣ/�μ��ְ������....
-- �� ������ ��ȸ�ϸ� �����ٵ�,,!
-- �ڿ� SALGRADE ���̺� �ִ� SMITH �� �ش�Ǵ� �޿���޵� 1��� ������ 
-- ���̺� �� ���� �������� �ϸ� ���� �� ����.

-- BUT, �� ����
-- ��׸� �� ����������? �� ���� �����غ���
-- EMP ���̺���
--��
SELECT *
FROM EMP;

--��
SELECT ENAME
FROM EMP;

--��
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP;

-- �̰� �� �޸� ���� ���� ���� �� 
-- ��� �ƴ϶�!!!
-- ** �� �Ȱ��� **
-- �ڡ� EMP ���̺��� ���� �� �޸𸮿� �ۿø� ������ ó���Ǳ� ������ �ڡ�
-- SELECT �� CPU�� ���� ������ �� �����ϴ� ��

-- ���� �� �÷��� ��ȸ�Ѵٰ� �ϴ���,
-- �ش� ���̺��� 100���� �÷��� �ִٸ�
-- �׷��� ������ 100���� �÷������� �� �޸𸮿� �ö� �� �ۿ� ����....

-- �׷��� ������ ���̺��� �������� ���̴�.
-- ������ �־�� 2�� �� �ϳ��� ��ȸ�Ѵٰ� �ص�
-- 100�� ��ΰ� �޸𸮿� �ö󰡴� ���� ���� ������ !!

-- DB������ �޸� ���� ���� ���ؼ�
-- �ϳ��� ���̺��� �������� ������ �� �� ������ȭ��
-- �� ���̺��� �������� ����� �ְ�, �� ���̵��� ���踦 �ΰԲ� ó���Ǿ� ����
--    ������ ���̺��� ������� �����ؼ� �� ���� �־�� �ϱ� ������


-- 1. SQL 1992 CODE

--�� CROSS JOIN : ��� ����� ���� �� �̾Ƴ����Ѵ�.
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(CARTESIAN PRODUCT)
--  EMP, DEPT �� ���̺��� ������ ��� ����� ���� �� ���´�.
--  ex)
--  10�� �μ��� ���յǾ� �ִ� SMITH
--  20�� �μ��� ���յǾ� �ִ� SMITH
--  30�� �μ��� ���յǾ� �ִ� SMITH 
--  �� �� ���´�.


--�� EQUI JOIN : ���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- ������ 20�� �μ��� SMITH �� ���´�.
-- �� ���̺��� ���踦 ���ؼ� �����͸� �ϼ��ذ��� ����
-- EQUI JOIN �� JOIN �ȿ��� ���� ���� ���δ�.


-- ���� ������
-- ��Ī �������� �Ʒ�ó���� �����ϴ�.
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


--�� NO EQUI JOIN : ���� �ȿ� ������ �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
-- ��Ȯ�ϰ� �� ��ġ�ϴ� �� �ƴ϶�, ��� ���� �ȿ� �� �ִ� �͵� ���� 
-- SMITH �� SAL : 800  �� SALGRADE 1 (LOSAL 700 ~ HISAL 1200)
-- SALGRADE �ȿ� 800�� ��Ȯ�ϰ� ��ġ�ϴ� ���ڵ�� ����.
-- �� ���� �ȿ� �� �ִ� �� ã�� �Ŵ�.
SELECT *
FROM EMP;
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
-- ��Ȯ�ϰ� ��ġ���� ������, 
-- SALGRADE�� LOSAL~HISAL �� ���� �ȿ� �� �ִ� �� ã��


--�� EQUI JOIN �� (+) �� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP;
--> 19���� ��� ����
--  19���� ��� �߿� �μ���ȣ�� ���� ���� ������� 5��

SELECT *
FROM TBL_DEPT;
--> 5���� �μ� ����
--  5���� �μ� �� �Ҽӻ���� ���� ���� �μ��� 2�� (40��, 50�� �μ�)


-- ���� ����Ǵ� �͵鳢���� ���� �� ��
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ�� ���� ���� �����(5��) ��� ����
--  ����, �Ҽ� ����� ���� ���� �μ�(2��) ��� ����

-- �׷���, �� �� 
-- D.DEPTNO �ڿ� (+)�� ����ϰ� �Ǹ�
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ

-- E.DEPTNO �ڿ� (+)�� ����ϰ� �Ǹ�
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  D.DEPTNO ���� �� �����س���,
--  �ű⿡ ����Ǵ� E.DEPTNO ���� �������� ��!
--> �μ��� �������� 5���� ����� ������ ������ ����

-- (+) ��� ���ؼ� ó���Ǵ� ������
-- (+) �̰� ���� ���� �����͸� ���� ������ ������
-- �ű⿡ �´� ���̵��� ã�Ƽ� �߰��ϴ� ������
-- �� ��, (+)�� ���� ���� ���ΰ�, (+)�� �پ��ִ� �ִ� �ű⿡ ���簡�� ��

-- ���� �⺻���� (+) ���� �κ� �� ������, 
-- ���� ó���� ������ �������� (+) �پ��ִ� �Ͱ� �´� �� ������ 
-- �߰� ó���Ѵٴ� �ǹ�


--�� (+) �� ���� �� ���̺��� �����͸� ��� �޸𸮿� ���� ������ ��
--   (+) �� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--   JOIN �� �̷������ �ȴ�.

--   �̿� ���� ������...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--==>> ���� �߻�
--     (ORA-01468: a predicate may reference only one outer-joined table)
-->>   �̰� ���� ���� �׳� ���ʿ��� ÷���� �ϰڴٴ� ����

--   ���ʿ� �� (+) �ٿ����� ���� ���� �������� �������� �ʴ´�.
--   �̷� ������ JOIN �� �������� �ʴ´�.


-- **���� �ִ� SQL 1992 CODE �� ����س��� �Ѵ�.
--   ���ݵ� ������ ���� ���̰� ����
-- ���� �������� �߰ߵǼ�, �ڵ尡 ������ �� ��
-- 1992 CODE ���� 1999 CODE �� �Ѿ���鼭 
-- �ð������� ���� �ٲ� ���� 
-- 1992 CODE ������ ��JOIN�� �̶�� Ű���尡 ����
-- 1999 CODE ���ʹ� ��JOIN�� �̶�� Ű���尡 �����ϰ� �ȴ�.
-- �׸��� � ������ ��JOIN�� ���� ����ؼ� ���� �� ���Ҵ�.
-- WHERE �� ���� ������ 
-- JOIN �� ���� �������� ��ȸ�� ���� ���� ���������� ���� �ָ����� ����
-- �׷��� ��ON�� Ű���嵵 �����ϰ� �Ǿ���.

-- 2. SQL 1999 CODE (ANSI SQL) 
-- 1992 CODE ���� EQUI JOIN �� 
-- 1999 CODE ���� INNER JOIN ���� �ٲ�
--    �� ��JOIN�� Ű���� ���� �� ��JOIN��(����)�� ���� ��� 
--    �� ��ON��   Ű���� ���� �� ���� ������ WHERE ��� ��ON������

--�� CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;


--�� INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

-- ������ ����ߴ� EQUI JOIN ������ �񱳸� �غ���,
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- , �� ����ߴ� �� ��JOIN�� Ű���忡, 
-- JOIN ��ĵ� ����ϱ�� �����Ƿ� ��INNER JOIN��
-- ���������̹Ƿ� WHERE ��� ��ON��

-- ��Ī ���
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- INNER JOIN ������ INNER ���� ����
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


--�� OUTER JOIN
-- 1992 CODE ���� (+) �ٿ��� �����ߴ� ���� 
-- 1999 CODE ������ OUTER JOIN ���� �ٲ�

-- 1922 CODE �� ����,
-- WHERE ������ ��(+)�� �ٿ��� ����ߴ�.
SELECT *
FROM TBL_EMP, TBL_DEPT
WHERE TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO(+);

-- ���� �ڵ�� �������� ������ �־���.
--> JOIN �� �����ؾ��ϰ�, JOIN ������ ���
--> WHERE �� ��ſ� ON �� �����ؾ���
--> (+)�� (+) �� ���� ���� ���ΰ��ε�, (+) ���� �ſ� ���� �� ������,,
--> �׷���   ������ ���ΰ��̸� ��LEFT OUTER JOIN��
-->        �������� ���ΰ��̸� ��RIGHT OUTER JOIN�� 
--  �� �ٲٱ�� �ߴ�.

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- �׸���, 1992 CODE������ �� �ʿ� �� �� (+) ���� �� ������
-- �� �� ����� ���� ���� ���,,,
-- 1999 CODE ������ RIGHT, LEFT �� ������ ��Ÿ���Ƿ�
-- �� �� ���ΰ����� ���� �� �ְ� �Ǿ���. 
-- �� ��FULL OUTER JOIN�� : �̰� 1999 CODE���� ���� ������� ��
SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


-- OUTER JOIN ���� OUTER �� ���� �����ϴ�.
SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- INNER, OUTER �����ϸ�... INNER ���� OUTER ���� ��� ������?
-- �� ���⼺�� �پ������� OUTER !!
-- �� ���⼺ ���� �׳� ��JOIN���� ������ INNER JOIN


--�� NATURAL JOIN
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

-- � �÷��� ������ JOIN ���Ѵ޶�� ������� ����
-- DEPTNO �� EMP, DEPT TABLE �� �� �־ �Ҽ� ���̺� ����ؾ� ��
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT;
--==>> ���� �߻�
--     (ORA-00905: missing keyword)


-- ���� ������ ��NATURAL JOIN�� ���� �������ָ�, ���� �߻����� ����
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/  
--> ���������� ���� ��,,, �� ���忡���� �������� ����
--  �̷� ������ �ִٴ� �� ������ �˾Ƶα�


-- DBA���� ���
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
--> DEPTNO �� ����ؼ� JOIN ����
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

--------------------------------------------------------------------------------

--�� �����ؾ� �� ��
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- ���⼭ ������ CLERK �� ����� ��ȸ�غ�����~
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
--> �̿� ���� ������� �������� �����ص�
--  ��ȸ ����� ��� ������ ������ ����.

-- �׷�����, ����ó�� ��������
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--  �̷��� ����.
--> ����� ������
--  �̿� ���� �����Ͽ� ��ȸ�ϴ� ���� �����Ѵ�.
/*
-- ON �̶�� Ű���尡 ������ �����
-- ���� ���ǰ� ���� ������ �����ϱ� ���ؼ��ε�,
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
�̷��� ����
������������ ���� �Ǿ������ ���̱� ������

ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
�����ؼ� ���� �� �����Ѵ�.

1992 CODE �� ���� ��쿡��,
�������� ��ü�� WHERE �̱� ������ ��¿ �� ����
*/

--------------------------------------------------------------------------------

--�� EMP ���̺�� DEPT ���̺��� �������
--   ������ MANAGER �� CLERK �� ����鸸 ��ȸ�Ѵ�.
--   �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.

-- ��
-- ���� ��ȸ����
SELECT *
FROM EMP;

SELECT *
FROM DEPT;
-- ������ ��ȸ�׸��� �� EMP �� ������
-- �μ����� DEPT ���� �����Ƿ�
-- EMP�� DEPT JOIN �ؾ� �Ѵ�.

-- ������ �ۼ�
SELECT D.DEPTNO "�μ���ȣ", D.DNAME "�μ���"
     , E.ENAME "�����", E.JOB "������", E.SAL "�޿�"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN ('MANAGER', 'CLERK');
--==>>
/*
10	ACCOUNTING	MILLER	CLERK	1300
10	ACCOUNTING	CLARK	MANAGER	2450
20	RESEARCH	ADAMS	CLERK	1100
20	RESEARCH	JONES	MANAGER	2975
20	RESEARCH	SMITH	CLERK	 800
30	SALES	    JAMES	CLERK	 950
30	SALES	    BLAKE	MANAGER	2850
*/
-- PARSING ����
-- FROM ���� ON�� �°� ���յǰ� ����� ����
-- �׷��Ƿ� 
-- WHERE ���������� ON �� ���� ó���ȴ�.
-- FROM EMP ���̺�� DEPT ���̺�
-- �ű⿡ ON�� �°� ó��!
-- �׸��� WHERE�� �°� ó���ϰ� ��


-- ��
SELECT *
FROM EMP;
SELECT *
FROM DEPT;


SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>
/*
ACCOUNTING	CLARK	MANAGER	    2450
ACCOUNTING	KING	PRESIDENT	5000
ACCOUNTING	MILLER	CLERK	    1300
RESEARCH	JONES	MANAGER	    2975
RESEARCH	FORD	ANALYST	    3000
RESEARCH	ADAMS	CLERK	    1100
RESEARCH	SMITH	CLERK	     800
RESEARCH	SCOTT	ANALYST	    3000
SALES	    WARD	SALESMAN	1250
SALES	    TURNER	SALESMAN	1500
SALES	    ALLEN	SALESMAN	1600
SALES	    JAMES	CLERK	     950
SALES	    BLAKE	MANAGER	    2850
SALES	    MARTIN	SALESMAN	1250
*/


SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> ���� �߻�
--     (ORA-00918: column ambiguously defined)
--     DEPTNO ������ �߻��ϴ� ���� (����ó�� DEPTNO ���� ��ȸ�ϸ� �����߻� X)
--     DNAME�� DEPT ���� ������ DEPT �������� �ǰ�,
--     ENAME, JOB, SAL �� EMP ���� ������ EMP���� �������� �Ǵµ�
--     DEPTNO �� EMP �� DEPT TABLE �� �� ��� ���� ������
--     ��𿡼� �����;� �ϴ��� ���� �߻��ϴ� ����..!

--     �� ���̺� �� �ߺ��Ǵ� �÷�(DEPTNO) �� ���� 
--     �Ҽ� ���̺��� �������(��������)�Ѵ�!


SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> ���� �� ���� ��� ���� ���
/*
10	ACCOUNTING	CLARK	MANAGER	    2450
10	ACCOUNTING	KING	PRESIDENT	5000
10	ACCOUNTING	MILLER	CLERK	    1300
20	RESEARCH	JONES	MANAGER	    2975
20	RESEARCH	FORD	ANALYST	    3000
20	RESEARCH	ADAMS	CLERK	    1100
20	RESEARCH	SMITH	CLERK	     800
20	RESEARCH	SCOTT	ANALYST	    3000
30	SALES	    WARD	SALESMAN	1250
30	SALES	    TURNER	SALESMAN	1500
30	SALES	    ALLEN	SALESMAN	1600
30	SALES	    JAMES	CLERK	     950
30	SALES	    BLAKE	MANAGER	    2850
30	SALES	    MARTIN	SALESMAN	1250
*/

-- �Ҽ� ���̺��� ������ָ� �����߻� X
-- �� �� ��� �����ϴ�,
-- �׷� EMP, DEPT �� �ƹ��ų� �ᵵ ��������?
-- NO

-- �� �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--    �θ� ���̺��� �÷��� ������ �� �ֵ��� ó���ؾ� �Ѵ�.

--    ��, EMP �� DEPT �� �� �� ���� �θ�Ŀ� ����
--    EMP  �� �θ� ���̺��̸�, E.DEPTNO
--    DEPT �� �θ� ���̺��̸�, D.DEPTNO
--    ��� �ؾ� �Ѵ�.

-- ��� �θ����̺�����, �ڽ����̺����� ��� �˾�??
-- �� ���̺� ���� ����� �÷��� �ִ��� Ȯ���ϱ�
-- �� ���̿� �������� �÷� �ϳ��� ���ٸ� �� ���� ������� ���̺�
-- ����� �÷� �ִٸ� �� �θ�-�ڽ� ������ �� �ִ� ���ɼ� �ſ� ����!
--
-- ���� ���⼭��
-- ����� �÷� �� DEPTNO

-- �� ���� ���̺� ��ȸ ���� ��
SELECT *
FROM EMP;
SELECT *
FROM DEPT;
-- ����� �÷� DEPTNO�� ���� ��,
-- EMP  ���̺��� DEPTNO ���� ���� �÷��� �������� ����
-- DEPT ���̺��� DEPTNO ���� ������ �� ����
-- �� ���̺� ��� DEPTNO �� �����Ѱ� ������ �ִ� ����� �� �ŷڼ� ����
-- �� ���Ἲ ����

-- DEPT������ DEPTNO 30���� �ϳ��� �־�� ������,
-- EMP ������ DEPTNO 30���� �������� �־ �Ǵ� ��Ȳ
-- �� ��1:�١� ��Ȳ

-- DEPT ���̺��� DEPTNO 30���� 
-- EMP  ���̺��� �������� ����� �����ϰ� �ִ� ��Ȳ

-- (�θ� �� �� �������� �ڽ��� �����ϴϱ�)
-- DEPT �� �θ� ���̺�
-- EMP  �� �ڽ� ���̺�


-- �� �� �θ����̺��� �����϶�� ������?
-- �ϳ��� E.DEPTNO�� �ϰ�, �ϳ��� D.DEPTNO�� �����ϴµ�
-- OUTER JOIN �� ������ ���̴�.
-- �� ������ 15��° �ٿ� ���� ���̰� ����
SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--==>>
/*
    :
(null)	OPERATIONS  (null)  (null)  (null)			    
*/
-- OPRATIONS �� �μ���ȣ(DEPTNO) �� ������ ����

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--==>>
/*
    :
    40	OPERATIONS  (null)  (null)  (null)			
*/
-- OPRATIONS �� �μ���ȣ(DEPTNO) �� ����

--> �̷� ��Ȳ�̸� �μ���ȣ(DEPTNO)�� ���̰� ��ȸ�ؾ� �ϴ°� ����
--  �׷��Ƿ�,
--  �ڽ����̺��� �����ϴ� �� �ƴ϶�, �θ����̺� ���� �����ؾ� �Ѵ�.

-- �׷���, ������ �÷� ���� ��쿡�� 
-- �Ҽ� ���̺��� ������ ������ ������ �ʴ´�.
-- �׷���! ������ִ� �� ����Ѵ�.
SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- ����ó�� �ۼ����� ����,
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- �Ҽ� ���̺� ������� ������
-- DNAME�� DEPT ���̺� ���� ORACLE �� ���� ã�ƿ�
-- ENAME, JOB, SAL �� EMP ���̺� ���� ORACLE �� ã�ƿ�

-- ORACLE�� �� ������ ���� ���� ã�´ٸ�,
-- DEPTNO ���� DEPT ���̺� ������� �ʾƵ� ���� �Ŵ�.
-- �ֳĸ�, ORACLE �� DEPT TABLE�̳� EMP TABLE �� ���� ������ ������ �������� �Ǵϱ�

-- �׷��� DEPTNO��� �Ҽ� ���̺� ������� �ʾ��� ��, ������ ����ٴ� ����
-- ORACLE�� DEPT TABLE�� EMP TABLE �� �� �����ٴ� ���̴�.

-- �Ҽ� ���̺��� ��õ��� ������
-- �ش� �÷��� DEPT TABLE ���� �ִٰ� �ϴ���,
-- ORACLE�� DEPT TABLE, EMP TABLE �� �ٿ� ���� �´�.
-- �׷��� �츮�� ��Ȯ�ϰ� D.DNAME ���� ����س��´ٸ�
-- ORACLE�� DEPT TABLE���� ���ٿ��� �ȴ�.

--> ORACLE�� ���� �� ����ϰ�, ���� �� ������ �����ϱ� ���ؼ�!!

--�� �� ���̺� ��� ���ԵǾ� �ִ� �ߺ��� �÷��� �ƴϴ���
--   �����ϴ� �������� �÷��� �Ҽ� ���̺��� ������� �� �ֵ��� �����Ѵ�.


-- ���������� �� ���� �ذ�
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.JOB IN ('CLERK', 'MANAGER');
--==>>
/*
10	ACCOUNTING	CLARK	MANAGER	    2450
10	ACCOUNTING	MILLER	CLERK	    1300
20	RESEARCH	ADAMS	CLERK	    1100
20	RESEARCH	JONES	MANAGER	    2975
20	RESEARCH	SMITH	CLERK	     800
30	SALES	    BLAKE	MANAGER	    2850
30	SALES	    JAMES	CLERK	     950
*/


--�� SELF JOIN (�ڱ� ����)

-- EMP ���̺��� �����͸� ������ ���� ��ȸ�� �� �ֵ���
-- �������� �����Ѵ�.
---------------------------------------------------------
-- �����ȣ ����� ������  �����ڹ�ȣ �����ڸ� ������������
---------------------------------------------------------
--   ex)
--   7369   SMITH  CLERK   7902      FORD     ANALYST
---------------------------------------------------------
SELECT *
FROM EMP;

-- �� : KING �����Ȱ� ã�Ƴ��� ������
-- �ڡڡ� ���� Ǯ��, ��� ����� ���Դ���, ������ ���� ������(null ����)
--        �� ���̺� ��ȸ�غ��鼭 Ȯ���غ��� !!! �ڡڡ�
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������", E1.MGR "�����ڹ�ȣ"
     , E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
*/
-- KING �����Ȱ� ã�Ƴ��� ������
-- Ʋ����!!


-- ��
---------------------------------------------------------
-- �����ȣ ����� ������  �����ڹ�ȣ �����ڸ� ������������
---------------------------------------------------------
--   7369   SMITH  CLERK   7902      FORD     ANALYST
--    |       |      |       |        |          |
--   EMP1    EMP1   EMP1  EMP1(MGR)  EMP2       EMP2
--                           OR
--                        EMP2(EMPNO)

SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
*/
-- ���⼭ ���� �ƴϴ�.
-- KING �� �����Ǿ���
-- KING �� ������ ������?? 
-- KING �� �Ƕ�̵� ������ �ֱ� ������, (JOB : PRESIDENT)
-- ȸ����� ������ �����ڰ� ����,
-- ������ ������� ���� SELF JOIN ���� ������� ���� ������
-- ��ȸ������� ������,,,


-- �׷���
-- 1999 CODE ���
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT  (null)  (null)	(null)	
*/
-- LEFT JOIN �ؼ�,
-- �����ڹ�ȣ ������ ������ ����� �Ѵ�!!


-- ���� ������ 1992 CODE ������� ����
SELECT E1.EMPNO "�����ȣ", E1.ENAME "�����", E1.JOB "������"
     , E2.EMPNO "�����ڹ�ȣ", E2.ENAME "�����ڸ�", E2.JOB "������������"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT  (null)  (null)	(null)	
*/


-- HR �� ������

