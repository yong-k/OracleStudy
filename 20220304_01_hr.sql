SELECT USER
FROM DUAL;
--==> HR


--              UNIQUE�� UK ��� �ϰ� U ��� ��
--             �ٸ� å�̳� �̷� ���� ��õǾ� �ִ� �� ������� ����
--             -----
--���� UNIQUE(UK:U) ����--

-- 1. ���̺��� ������ �÷��� �����Ͱ� 
--    �ߺ����� �ʰ� ������ �� �ֵ��� �����ϴ� ��������
--    PRIMARY KEY �� ������ ��������������, NULL �� ����Ѵٴ� �������� �ִ�.
--    ���������� PRIMARY KEY �� ���������� UNIQUE INDEX �� �ڵ� �����ȴ�.
--                                         =========================
--    �ϳ��� ���̺� ������ UNIQUE ���������� ���� �� �����ϴ� ���� �����ϴ�.
--    ��, �ϳ��� ���̺� UNIQUE ���������� ���� �� ����� ���� �����ϴٴ� ���̴�.

-- PRIMARY KEY���� NOT NULL �������� ���� => UNIQUE
-- UNIQUE �� PRIMARY KEY �ɾ������ ORACLE �� ���� ã������ INDEX �ɾ���� ����
-- �׷��� �����Ͱ� ������ ���� ���� UNIQUE �� PRIMARY KEY �� �ݵ�� �־�� �Ѵ�.
-- ���� ��ĥ ���� �����Ͱ� ���ٰ� �Ǵ��ϴ��� �������� �ɾ�� �Ѵ�.

-- �ܼ��� ��ġ�� �� ���� �Ϸ��� PRIMARY KEY �� UNIQUE �Ŵ� �� �ƴϴ�.
-- ����ڰ� �˻�â���� ���� ã�ڴ� �� ���� 
-- ���������� �ɾ�� �ϴ����� ���� �������� �Ǵ��� �ʿ��ϴ�.

-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] UNIQUE

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� UNIQUE(�÷���, ...)


--�� UK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    UNIQUE
);
--==>> Table TBL_TEST5��(��) �����Ǿ����ϴ�.


-- �������� ��ȸ
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
--==>>
/*
HR	SYS_C007065	TBL_TEST5	P	COL1		
HR	SYS_C007066	TBL_TEST5	U	COL2		
*/


-- ������ �Է�
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
--==>> ���� �߻�
--     (ORA-00001: unique constraint (HR.SYS_C007065) violated)

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'ABCD');
--==>> ���� �߻�
--     (ORA-00001: unique constraint (HR.SYS_C007065) violated)

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2, 'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
-- ������ NULL �� ó�� �� ������,
-- �����ؾ� �Ѵٰ� �ߴµ�, NULL�� �� �� �� ������??
-- YES �� NULL�� ���� �ƴϴ�. ����ִٴ� ���¸� ǥ���ϴ� ���� NULL �̴�.

INSERT INTO TBL_TEST5(COL1) VALUES(4);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(5, 'ABCD');
--==>> ���� �߻�
--     (ORA-00001: unique constraint (HR.SYS_C007066) violated)

COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT *
FROM TBL_TEST5;
--==>>
/*
1	TEST
2	ABCD
3	(null)
4	(null)
*/


--�� UK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST6
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6��(��) �����Ǿ����ϴ�.


-- �������� ��ȸ(Ȯ��)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
--==>>
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/


--�� UK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST7
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST7��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>> ��ȸ ��� ����
-- �׳� ���̺��� ����⸸ ���� ���� ���� ���� ����


-- �������� �߰�
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
--     +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);

--     �� (�� �� ���ļ�)

ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>> Table TBL_TEST7��(��) ����Ǿ����ϴ�.


-- �������� �߰� ���� �ٽ� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/


--------------------------------------------------------------------------------

--���� CHECK(CK:C) ����--

-- 1. �÷����� ��� ������ �������� ������ ������ �����ϱ� ���� ��������
--    �÷��� �ԷµǴ� �����͸� �˻��Ͽ� ���ǿ� �´� �����͸� �Էµ� �� �ֵ��� �Ѵ�.
--    ����, �÷����� �����Ǵ� �����͸� �˻��Ͽ�
--    ���ǿ� �´� �����ͷ� �����Ǵ� �͸� ����ϴ� ����� �����ϰ� �ȴ�.

-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] CHECK(�÷� ����)

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��,
-- CONSTRAINT CONSTRAINT�� CHECK(�÷� ����)


--�� CK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST8
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    
, COL3  NUMBER(3)       CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST8��(��) �����Ǿ����ϴ�.
-- NUBMER(3) �ϸ� -999 ~ 999 ���� �Է°���������
-- ���⼭ 0 ~ 100 ������ �Է°����ϰ� �ϰ� ����
-- �� CHECK �������� ����ϸ� ��

-- ������ �Է�
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '�ҹ�', 100);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '����', 101);
--==>> ���� �߻�
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 �� 0 ~ 100 ������ ���� �ƴϱ� ������ ���� �߻�

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '����', -1);
--==>> ���� �߻�
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 �� 0 ~ 100 ������ ���� �ƴϱ� ������ ���� �߻�

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '�̻�', 80);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

COMMIT;
--==>> Ŀ�� �Ϸ�.


SELECT *
FROM TBL_TEST8;
--==>>
/*
1	�ҹ�	100
2	�̻�	 80
*/


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
    �츮�� �������Ǹ� �������ؼ�
    ����Ŭ�� �̸� ���ΰ�                CHECK �� � �������� �ɷ��ִ���
    -----------                         ------------------------
HR	SYS_C007071	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007072	TBL_TEST8	P	COL1		
*/


--�� CK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST9
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9��(��) �����Ǿ����ϴ�.


-- ������ �Է�
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '�ҹ�', 100);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '����', 101);
--==>> ���� �߻�
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 �� 0 ~ 100 ������ ���� �ƴϱ� ������ ���� �߻�

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '����', -1);
--==>> ���� �߻�
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 �� 0 ~ 100 ������ ���� �ƴϱ� ������ ���� �߻�

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '�̻�', 80);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


-- Ȯ��
SELECT *
FROM TBL_TEST9;
--==>>
/*
1	�ҹ�	100
2	�̻�	 80
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>>
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/


--�� CK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST10
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
);
--==>> Table TBL_TEST10��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> ��ȸ ��� ����


-- �������� �߰�
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100) );
--==>> Table TBL_TEST10��(��) ����Ǿ����ϴ�.  
   
               
-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/


--�� �ǽ� ����
-- ������ ���� TBL_TESTMEMBER ���̺��� �����Ͽ�
-- SSN �÷�(�ֹι�ȣ �÷�)����
-- ������ �Է� �� ������ ��ȿ�� �����͸� �Էµ� �� �ֵ���
-- üũ ���������� �߰��� �� �ֵ��� �Ѵ�.
-- (�� �ֹι�ȣ Ư�� �ڸ��� �Է� ������ �����͸� 1, 2, 3, 4 �� �����ϵ��� ó��)
-- ����, SID �÷����� PRIMARY KEY ���������� ������ �� �ֵ��� �Ѵ�.

-- ���̺� ����
CREATE TABLE TBL_TESTMEMBER
( SID   NUMBER
, NAME  VARCHAR2(30)
, SSN   CHAR(14)        -- ������ �Է� ���� �� 'YYMMDD-NNNNNNN'
, TEL   VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER��(��) �����Ǿ����ϴ�.

-- �������� �߰�
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN, 8, 1) IN ('1', '2', '3', '4')) );
--==>> Table TBL_TESTMEMBER��(��) ����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
--==>>
/*
HR	TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	SUBSTR(SSN, 8, 1) IN ('1', '2', '3', '4')	
*/


-- ������ �Է� �׽�Ʈ
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(1, '��ȣ��', '961112-1234567', '010-1111-1111');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(2, '������', '970131-2234567', '010-2222-2222');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(3, 'ȫ����', '000504-4234567', '010-3333-3333');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(4, '����', '061004-3234567', '010-4444-4444');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '��ȣ��', '961112-5234567', '010-1111-1111');
--==>> �����߻�
--     (ORA-02290: check constraint (HR.TESTMEMBER_SSN_CK) violated)

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(6, '������', '970131-6234567', '010-2222-2222');
--==>> �����߻�
--     (ORA-02290: check constraint (HR.TESTMEMBER_SSN_CK) violated)


SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	��ȣ��	961112-1234567	010-1111-1111
2	������	970131-2234567	010-2222-2222
3	ȫ����	000504-4234567	010-3333-3333
4	����	061004-3234567	010-4444-4444
*/

COMMIT;
--==>> Ŀ�� �Ϸ�.


--------------------------------------------------------------------------------

--���� FOREIGN KEY(FK:F:R) ����--

-- 1. ���� Ű �Ǵ� �ܷ� Ű(FK)�� �� ���̺��� ������ �� ������ �����ϰ�
--    ���� �����Ű�µ� ���Ǵ� ���̴�.
--    �� ���̺��� �⺻ Ű ���� �ִ� ����
--    �ٸ� ���̺� �߰��ϸ� ���̺� �� ������ ������ �� �ִ�.
--    �� ��, �� ��° ���̺� �߰��Ǵ� ���� �ܷ�Ű�� �ȴ�.

-- 2. �θ� ���̺�(�����޴� �÷��� ���Ե� ���̺�)�� ���� ������ ��
--    �ڽ� ���̺�(�����ϴ� �÷��� ���Ե� ���̺�)�� �����Ǿ�� �Ѵ�.
--    �� ��, �ڽ� ���̺� FOREIGN KEY ���������� �����ȴ�.
--    ex) EMP ���̺� �����, DEPT ���̺� ����� �ȵȴٴ� ���� !

-- 3. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��]
--                   REFERENCES �������̺��(�����÷���)
--                   [ON DELETE CASCADE | ON DELETE SET NULL]   �� �߰� �ɼ�

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��,
-- �÷��� ������Ÿ��
-- CONSTRAINT CONSTRAINT�� FOREIGN KEY(�÷���)
--              REFERENCES �������̺��(�����÷���)
--              [ON DELETE CASCADE | ON DELETE SET NULL]        �� �߰� �ɼ�


-- [ON DELETE CASCADE | ON DELETE SET NULL] �������� ������
-- �θ� ���̺��� �ڽ� ���̺��� �����ϰ� �ִ� PK ���� �Ұ��ϴ�.
-- [ON DELETE CASCADE | ON DELETE SET NULL] ������ ������
-- �θ� ���̺��� �ڽ� ���̺��� �����ϰ� �ִ� PK ������ ����������,
-- �������� ��, �ڽ� ���̺���
-- ON DELETE CASCADE : �����ϰ� �ִ� �� ����� ����
-- ON DELETE SET NULL : �����ϰ� �ִ� �� NULL �� ����
-- �� ������ �߰� �ɼ���..!


--�� FOREIGN KEY ���������� �����ϴ� �ǽ��� �����ϱ� ���ؼ���
--   �θ� ���̺��� ���� �۾��� ���� �����ؾ� �Ѵ�.
--   �׸��� �� ��, �θ� ���̺��� �ݵ�� PK �Ǵ� UK ���������� 
--   ������ �÷��� �����ؾ� �Ѵ�.


-- �θ� ���̺� ����
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS��(��) �����Ǿ����ϴ�.


-- �θ� ���̺� ������ �Է�
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '���');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '�븮');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '����');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '����');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�. * 4


-- Ȯ��
SELECT *
FROM TBL_JOBS;
--==>>
/*
4	����
3	����
2	�븮
1	���
*/


-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� FK ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_EMP1
( SID       NUMBER          PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007080	TBL_EMP1	P	SID		
HR	SYS_C007081	TBL_EMP1	R	JIKWI_ID		NO ACTION
                           ---                  -----------
                        REFERENCE               ON DELETE CASCADE �� 
                                                ON DELETE SET NULL ��
                                                �����Ǿ� ���� ���� ��
                                                ������ DELETE_RULE                                              
*/


-- ������ �Է�
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '������', 1);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '�Ž���', 2);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '�̾Ƹ�', 3);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '������', 4);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '������', 5);
--==>> ���� �߻�
--     (ORA-02291: integrity constraint (HR.SYS_C007081) violated 
--      - parent key not found) 
--     �θ� ���̺� JIKWI_ID�� 1~4�������� �ֱ� ������ 
--     JIKWI_ID 5������ �Է��Ϸ��� �ϸ� ��������.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '������', 1);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(6, '���̻�', NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
-- �θ� ���̺� �ִ� �����͵� �� �ϳ��� �����ϴ���,
-- �ƴϸ� �ƿ� ����δ� ��(NULL)�� �ȴ�.

INSERT INTO TBL_EMP1(SID, NAME) VALUES(7, '������');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�
-- 534��� ���� �ǹ��� �����̴�. 
-- (JIKWI_ID �� NULL �� ���δ� ��)


-- Ȯ��
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3
4	������	4
5	������	1
6	���̻�	(null)
7	������	(null)
*/


-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� FK ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	        TBL_EMP2	P	SID		
HR	EMP2_JIKWI_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--�� FK ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> ��ȸ ��� ����


-- �������� �߰�
ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID) );
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.


-- �������� ����
-- ���������� �̸��� �˰� ������ �ȴ�.
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.


-- �ٽ� FOREIGN KEY �������� �߰�
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID);
--==>> Table TBL_EMP3��(��) ����Ǿ����ϴ�.


-- �������� Ȯ��(��ȸ)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	        TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


-- 4. FOREIGN KEY ���� �� ���ǻ���
--    �����ϰ��� �ϴ� �θ� ���̺��� ���� �����ؾ� �Ѵ�.
--    �����ϰ��� �ϴ� �÷��� PRIMARY KEY �Ǵ� UNIQUE ���������� �����Ǿ� �־�� �Ѵ�.
--    ���̺� ���̿� PRIMARY KEY �� FOREIGN KEY �� ���ǵǾ� ������
--    PRIMARY KEY ���������� ������ �÷��� ������ ���� ��
--    FOREIGN KEY �÷��� �� ���� �ԷµǾ� �ִ� ��� �������� �ʴ´�.
--    (��, �ڽ� ���̺� �����ϴ� ���ڵ尡 ������ ���
--     �θ� ���̺��� �����޴� ���ڵ�� ������ �� ���ٴ� ���̴�.)
--    ��, FK ���� �������� ��ON DELETE CASCADE�� �� ��ON DELETE SET NULL�� �ɼ���
--    ����Ͽ� ������ ��쿡�� ������ �����ϴ�.
--    ����, �θ� ���̺��� �����ϱ� ���ؼ��� �ڽ� ���̺��� ���� �����ؾ� �Ѵ�.


-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
--==>>
/*
4	����
3	����
2	�븮
1	���
*/

-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3
4	������	4
5	������	1
6	���̻�	
7	������	
*/


-- ������ ������ ������ ������� ����
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID = 4;
--==>> 1 �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- Ȯ��
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3
4	������	1
5	������	1
6	���̻�	
7	������	
*/


-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


-- �θ� ���̺�(TBL_JOBS)�� ���� �����͸� �����ϰ� �ִ�
-- �ڽ� ���̺�(TBL_EMP1)�� �����Ͱ� �������� �ʴ� ��Ȳ�̴�.

-- �̿� ���� ��Ȳ���� �θ� ���̺�(TBL_JOBS)��
-- ���� ������ ���� 
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
-- SELECT �� ���� Ȯ�� ��, SELECT �� DELETE �� �ٲٸ� ��
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


-- Ȯ��
SELECT *
FROM TBL_JOBS;
--==>>
/*
3	����
2	�븮
1	���
*/


-- Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


-- �θ� ���̺�(TBL_JOBS)�� ��� ������ ����
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> ���� �߻�
--     (ORA-02292: integrity constraint (HR.SYS_C007081) violated 
--      child record found)
--      �ڽ� ���ڵ尡 �߰ߵǾ��� ������ ���� �߻�

-- �׷��ٸ� �����͸� �����ϴ� �� �ƴ϶�, 
-- �θ� ���̺�(TBL_JOBS)�� ���������� �ƿ� �����غ���
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     (ORA-02449: unique/primary keys in table referenced by foreign keys)


--> ���� �ڽ��� �ִ� ��쿡,
--  �θ� ���̺��� ���� �ִ� �����͵� ������ �Ұ��ϰ�,
--  �θ� ���̺� ��ü�� ����� �͵� �Ұ��ϴ�.

--�� �θ� ���̺��� �����͸� �����Ӱ�(?) �����ϱ� ���ؼ���
--   �ڽ� ���̺��� FOREIGN KEY �������� ���� ��
--   ��ON DELETE CASCADE���� ��ON DELETE SET NULL�� �ɼ� ������ �ʿ��ϴ�.


-- TBL_EMP1 ���̺�(�ڽ� ���̺�)���� FK ���������� ������ ��
-- CASCADE �ɼ��� �����Ͽ� �ٽ� FK ���������� �����Ѵ�.

-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007080	TBL_EMP1	P	SID		
HR	SYS_C007081	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- FK �������� ����
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007081;
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.


-- �������� ���� ���� �ٽ� Ȯ�� 
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>> HR	SYS_C007080	TBL_EMP1	P	SID		


-- ��ON DELETE CASCADE�� �ɼ� ���Ե� �������� �������� �ٽ� ����
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;               -- CHECK~!!!
--==>> Table TBL_EMP1��(��) ����Ǿ����ϴ�.


-- �������� ���� ���� �ٽ� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007080	TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE   �� CHECK~!!!
                                                       ======== 
*/

--�� CASCADE �ɼ��� ������ �Ŀ���
--   �����ް� �ִ� �θ� ���̺��� �����͸�
--   �������� �����Ӱ� �����ϴ� ���� �����ϴ�.
--   ��, ... �θ� ���̺��� �����Ͱ� ������ ���...
--   �̸� �����ϴ� �ڽ� ���̺��� �����͵� 
--   ��~~~~~~~~�� �Բ� �����ȴ�.        �� ���� ������ �� ~!!!


-- �θ� ���̺�
SELECT *
FROM TBL_JOBS;
--==>>
/*
3	����
2	�븮
1	���
*/


-- �ڽ� ���̺�
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	������	1
2	�Ž���	2
3	�̾Ƹ�	3   �� �̾Ƹ� ����
4	������	1
5	������	1
6	���̻�	
7	������	
*/


-- �̾Ƹ� ������ �����ϴµ�,
-- �θ� ���̺�(TBL_JOBS)���� ���� ���� ������ �����غ���.
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 3;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.


-- �ڽ� ���̺� ��ȸ(Ȯ��)
SELECT *
FROM TBL_EMP1;
--==>> 
/*
1	������	1
2	�Ž���	2
4	������	1
5	������	1
6	���̻�	
7	������	
*/
--  3	�̾Ƹ�	3  �� ���ڵ尡 �ƿ� �����Ǿ���.
--> �̾Ƹ� ���� �����Ͱ� �����Ǿ����� Ȯ��~!!!


-- �θ� ���̺� ��ü�� �����غ���
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     (ORA-02449: unique/primary keys in table referenced by foreign keys)
-- ���� TBL_EMP1�� TBL_JOBS�� �����ϰ� �ִ� ��Ȳ�� �ƴϰ�,
-- �߰������� �������� �ڽ� ���̺��� �־ ���� �߻�


-- TBL_EMP1 ���̺� �̿��� �ڽ� ���̺� ����
DROP TABLE TBL_EMP2;
--==>> Table TBL_EMP2��(��) �����Ǿ����ϴ�.

DROP TABLE TBL_EMP3;
--==>> Table TBL_EMP3��(��) �����Ǿ����ϴ�.


-- �θ� ���̺� �ٽ� ���� (���� TBL_EMP1 ���̺��� �������� ���� ����)
DROP TABLE TBL_JOBS;
--==>> ���� �߻�
--     (ORA-02449: unique/primary keys in table referenced by foreign keys) 
-- CASCADE �ɼ��� �ɷ��ִٰ� �ϴ���,
-- �����ϰ� �ִ� �ڽ��� ������, �θ����̺��� ���Ű� ������ �ʴ´�.


-- TBL_EMP1 �� ����
DROP TABLE TBL_EMP1;
--==>> Table TBL_EMP1��(��) �����Ǿ����ϴ�.


-- �θ� ���̺� �ٽ� ����
DROP TABLE TBL_JOBS;
--==>> Table TBL_JOBS��(��) �����Ǿ����ϴ�.
-- ���� �ڽ����̺� ������ ���� ����


--------------------------------------------------------------------------------

--���� NOT NULL(NN:CK:C) ����--

-- �̰� CHECK ���� ���� �� ��, �÷� �������� NOT NULL �ϸ� �Ǳ� ������

-- NOT NULL�� ������ ������������ �̾Ƽ� �����ϴ� å�� ���� ����.
-- �׷����� ���� �̾Ƽ� ���������� ���� ������,
-- �길�� ���� ���� �ٸ� ������ �ֱ� �����̴�.


-- 1. ���̺��� ������ �÷��� �����Ͱ�
--    NULL �� ���¸� ���� ���ϵ��� �ϴ� ��������



--�� �ٸ� ���� ���ǵ��� ���̺� ������ �������� �� ���� ��������,
--   NOT NULL ���� ������ �÷� ������ �������� �� ���� ���δ�.

-- 2. ���� �� ����
-- �� �÷� ������ ����
-- �÷��� ������Ÿ�� [CONSTRAINT CONSTRAINT��] NOT NULL

-- �� ���̺� ������ ����
-- �÷��� ������Ÿ��
-- �÷��� ������Ÿ��
-- CONSTRAINT CONSTRAINT�� CHECK(�÷��� IS NOT NULL)



--�� �ٸ� ���� ���ǵ��� ������ ������ ���̺� �������� �߰��� ��,
--   ALTER ���� ADD �� ���������,
--   NOT NULL ���� ������ ALTER ���� MODIFY �� �� ���� ����Ѵ�.

-- 3. ������ �����Ǿ� �ִ� ���̺� NOT NULL ���������� �߰��� ���
--    ADD ���� MODIFY ���� �� ���� ���ȴ�.
-- ALTER TABLE ���̺��
-- MODIFY �÷��� ������Ÿ�� NOT NULL;


--��  �׳� ����ִ�, ä�����ִ� ������ ���������� �����ϴٺ���
--    �̹� NULL �� ���ԵǾ� �ִµ�, �� ���̺� NOT NULL ���� �����Ϸ��� �ϸ�
--    ���������� ���� ���� ���� �� �ִ� ������.

-- 4. ���� �����Ǿ� �ִ� ���̺� 
--    �����Ͱ� �̹� ������� ���� �÷�(�� NULL �� ������ �÷�)��
--    NOT NULL ���������� ���Բ� �����ϴ� ��쿡�� ���� �߻��Ѵ�.(�Ұ����ϴ�)


--�� NOT NULL ���� �ǽ�(�� �÷� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST11
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    NOT NULL        -- �̰͵� �Ϲ����� CHECK �� �ٸ���.
                                        -- CHECK Ű���� ���� ��밡��
);
--==>> Table TBL_TEST11��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*          
                                         CHECK ����ó��
                                         SEARCH_CONDITION �� 
                                         NOT NULL ���� ������ �ִ�.
                                        ------------------
HR	SYS_C007088	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007089	TBL_TEST11	P	COL1		
*/


-- ������ �Է�
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(1, 'TEST');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(2, 'ABCD');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(3, NULL);
--==>> ���� �߻�
--     (ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2"))

INSERT INTO TBL_TEST11(COL1) VALUES(3);
--==>> ���� �߻�
--     (ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2"))


-- Ȯ��
SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
*/


--�� NOT NULL ���� �ǽ�(�� ���̺� ������ ����)
-- ���̺� ����
CREATE TABLE TBL_TEST12
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST12';
--==>>
/*
                                            ----------------
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/
-- ������
-- �Ʊ� �� �� �ǽ�������
-- HR	SYS_C007088	TBL_TEST11	C	COL2	"COL2" IS NOT NULL
-- ���� ����ó�� "" ū����ǥ �ȿ� �����־��µ�
-- ���� �ǽ������� ū����ǥ�� ����.


--�� NOT NULL ���� �ǽ�(�� ���̺� ���� ���� �������� �߰�)
-- ���̺� ����
CREATE TABLE TBL_TEST13
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST13��(��) �����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> ��ȸ ��� ����


-- �������� �߰�
ALTER TABLE TBL_TEST13
ADD ( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL) );
--==>> Table TBL_TEST13��(��) ����Ǿ����ϴ�.


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007100	    TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/
-- COL2 �� CHECK ���� ������ 2�� �ɸ� ��ó�� ��Ÿ���ٴ� Ư¡�� �����ص���


--�� NOT NULL �������Ǹ� TBL_TEST13 ���̺��� COL2 �� �߰��ϴ� ���
--   ������ ���� ����� ����ϴ� �͵� �����ϴ�.
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--==>> Table TBL_TEST13��(��) ����Ǿ����ϴ�.


-- �÷� �������� NOT NULL ���������� ������ ���̺�(TBL_TEST11)
DESC TBL_TEST11;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
-- DESCRIBE ���� Ȯ�ΰ���


-- ���̺� �������� NOT NULL ���������� ������ ���̺�(TBL_TEST12)
DESC TBL_TEST12;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
-- DESCRIBE ���� Ȯ�� �Ұ�
--> DESCRIBE �� ���� NOT NULL �̴�, �ƴϴ� �Ǵ��� �� ����


-- ���̺� ���� ���� ADD �� ���� NOT NULL ���������� �߰��Ͽ�����
-- ���⿡ ���Ͽ�, MODIFY ���� ���� NOT NULL ���������� �߰��� ���̺�(TBL_TEST13)
-- DESCRIBE �� �ص� ������, VIEW_CONSTCHECK �� ���� ���´�.

DESC TBL_TEST13;
--==>>
/*
�̸�   ��?       ����           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/


-- �������� Ȯ��
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('TBL_TEST11', 'TBL_TEST12', 'TBL_TEST13');
--==>> 
/*
HR	SYS_C007088	    TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007089	    TBL_TEST11	P	COL1		
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007100	    TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/


--------------------------------------------------------------------------------

--���� DEFAULT ǥ���� ����--

-- 1. INSERT �� UPDATE ������
--    Ư�� ���� �ƴ� �⺻ ���� �Է��ϵ��� ó���� �� �ִ�.

-- 2. ���� �� ����
-- �÷��� ������Ÿ�� DEFAULT �⺻��

-- 3. INSERT ��� �� �ش� �÷��� �Էµ� ���� �Ҵ����� �ʰų�,
--    DEFAULT Ű���带 Ȱ���Ͽ� �⺻���� ������ ���� �Է��ϵ��� �� �� �ִ�.

-- 4. DEFAULT Ű����� �ٸ� ����(NOT NULL ��) ǥ�Ⱑ �Բ� ���Ǿ�� �ϴ� ���
--    DEFAULT Ű���带 ���� ǥ��(�ۼ�)�� ���� �����Ѵ�.
--    ex) , COL4    DATE    NOT NULL    DEFAULT SYSDATE
--        , COL4    DATE    DEFAULT SYSDATE     NOT NULL    �� ����!


--�� DEFAULT ǥ���� ���� �ǽ�
-- ���̺� ����
CREATE TABLE TBL_BBS                        -- �Խ��� ���̺� ����
( SID       NUMBER          PRIMARY KEY     -- �Խù� ��ȣ �� �ĺ��� �� �ڵ� ����
, NAME      VARCHAR2(20)                    -- �Խù� �ۼ��� 
, CONTENTS  VARCHAR2(200)                   -- �Խù� ����
, WRITEDAY  DATE            DEFAULT SYSDATE -- �Խù� �ۼ���
, COUNTS    NUMBER          DEFAULT 0       -- �Խù� ��ȸ��
, COMMENTS  NUMBER          DEFAULT 0       -- �Խù� ��� ����
);
--==>> Table TBL_BBS��(��) �����Ǿ����ϴ�.


--�� SID �� �ڵ� ���� ������ ��Ϸ��� ������ ��ü�� �ʿ��ϴ�
--   �ڵ����� �ԷµǴ� �÷��� ������� �Է� �׸񿡼� ���ܽ�ų �� �ִ�.

-- ������ ����
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==>> Sequence SEQ_BBS��(��) �����Ǿ����ϴ�.


-- ��¥ ���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.


-- �Խù� �ۼ�
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '�ֹ���', '����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.'
     , TO_DATE('2022-02-01 15:34:10', 'YYYY-MM-DD HH24:MI:SS'), 0, 0);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
-- ���� ��ȸ���� ��ۼ��� 0 �̶�� 0�� ���� �ʰ�,
-- �� ���� ����ΰ� �Ǹ�, NULL �� ���� ��
-- �� ���� �����ϸ� ��ȸ���� 1��ŭ �������Ѿ� �ϴµ� 
--    NULL + 1 �� �Ǵϱ�, ������� �׳� NULL �� �Ǿ����...!


INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '��ȣ��', '��� �ǽ����Դϴ�.', SYSDATE, 0, 0);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.
-- ����ڰ� �Խù� �Է��� ������ �Է��ϴ� �ð� ���� ����
-- SYSDATE�� ���� �� �� �װ� ��� DAFAULT �� �� ���� ����
-- ��?
-- �� ���̺��� ���� ��, WRITEDAY�� DEFAULT ���� SYSDATE ��� �߱� ����

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '�̿���', '������ �ǽ����Դϴ�.', DEFAULT, 0, 0);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

-- �ڿ� COUNTS, COMMENTS�� DAFAULT ���� 0 ���� �����س��� ������ 
-- DEFAULT �� �� �� ����
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '������', '������ �ǽ����Դϴ�.', DEFAULT, DEFAULT, DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

-- DEFAULT�� �̹� �������ִٸ�, 
-- WRITEDAY, COUNTS, COMMENTS�� �ƿ� ������ �� �ִ�.
INSERT INTO TBL_BBS(SID, NAME, CONTENTS)
VALUES(SEQ_BBS.NEXTVAL, '������', '������ �ǽ����Դϴ�.');
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

-- SID, NAME, CONTENTS �� ����ؼ� ����
-- �ٸ� ���̺� ���� ��쿡��, ���⿡�� ������� ���� �� NULL �� ��������,
-- �׷��� DEFAULT ǥ������ ���� �Ǹ�
-- ���� �Է����� �ʾƵ� NULL �� �ƴ� DEFAULT ���� ������ ��


-- Ȯ��
SELECT *
FROM TBL_BBS;
--==>>
/*
1	�ֹ���	����Ŭ DEFAULT ǥ������ �ǽ����Դϴ�.	2022-02-01 15:34:10	0	0
2	��ȣ��	��� �ǽ����Դϴ�.	                    2022-03-04 14:29:44	0	0
3	�̿���	������ �ǽ����Դϴ�.	                2022-03-04 14:30:46	0	0
4	������	������ �ǽ����Դϴ�.	                2022-03-04 14:31:29	0	0
5	������	������ �ǽ����Դϴ�.	                2022-03-04 14:32:33	0	0
*/


-- �ش� ���̺� � DEFAULT ���� �����Ǿ� �ִ��� ��� Ȯ���ұ�?
--�� DEFAULT ǥ���� Ȯ��(��ȸ)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TBL_BBS';
--==>>
/*                                                          [DATA_DEFAULT]
TBL_BBS	SID	        NUMBER			 22			N	1				  
TBL_BBS	NAME	    VARCHAR2		 20			Y	2				  
TBL_BBS	CONTENTS	VARCHAR2		200			Y	3				  
TBL_BBS	WRITEDAY	DATE			  7			Y	4	8	"SYSDATE"
TBL_BBS	COUNTS	    NUMBER			 22			Y	5	2	"0"		
TBL_BBS	COMMENTS	NUMBER			 22			Y	6	2	"0"		
*/


--�� ���̺� ���� ���� DEFAULT ǥ���� �߰� / ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT �⺻��;


-- �������ǵ��� �⺻������ �� �����ؼ� ���� ���°� �ƴ�
-- ���������� �ο��ϰų�, �����ϰų�, 
-- �ο��� �������ǿ� �ߵ��� �ɰų�, ������ �� ���� �극��ũ �ɾ�ΰų� �ϴ� ��
-- �������ǿ��� �� �̸��� �־, Ư�� �������� ���� ����
-- DEFAULT ǥ������ �̸��� �ο��ؼ� ���� �ʱ� ������ ���������� �����ϴ� �� ����

-- ���� DEFAULT �� ���� ��, ������ ������� ������ NULL �� ó����
-- �׷��� ó���ǰ� �ϸ� �� !

--�� ������ DEFAULT ǥ���� ���� �� DROP ����� �� ����
ALTER TABLE ���̺��
MODIFY �÷��� [�ڷ���] DEFAULT NULL;


COMMIT;
--==>> Ŀ�� �Ϸ�.

