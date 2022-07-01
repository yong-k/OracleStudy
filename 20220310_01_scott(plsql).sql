SELECT USER
FROM DUAL;
--==>> SCOTT


--------------------------------------------------------------------------------
--20220308_05_scott(plsql).sql �Լ� �κ� �����ؿ�


--���� FUNCTION(�Լ�) ����--

-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�. (�� ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
-- ���� �̸����� �����Ѵٸ�, ��������ٴ� �����̴�. �� CREATE OR REPLACE
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[( �Ű�������1 �ڷ���
 , �Ű�������2 �ڷ���
)]
RETURN ������Ÿ��            ---------> ������� ���Լ��� ����Ρ�
IS                           -- DECLARE �� IS �� �ٲ� 
    -- �ֿ� ���� ����
BEGIN
    -- ���๮;
    ...
    RETURN (��);
    
    [EXCEPTION]
        -- ���� ó�� ����;
END;
*/

--�� ����� ���� �Լ�(������ �Լ�)��
--   IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--   �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--   FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.

-- DBA�� �ƴ� �̻� OUT �Ķ���� �� ���� �׷��� ���� �ʴ�.
-- ex) 
-- ���� ��ġ ��Ƽ� �̿����� �뿡 ��ġ ��Ƽ� �ѱ��  �� IN �Ķ���ͷ� �ѱ��
-- �̿��� �� �뿡 �ı�ġ ��Ƽ� �ٽ� �츮���� ���.   �� OUT �Ķ���ͷ� �ѱ��
-- �׷��� �Լ������� IN �Ķ���͸� ��밡���ϴ�!

-- ���Լ��� ����Ρ� ���� ��, 
-- � �Ű��������� �ʿ�� �ϰ�, � ���� ��ȯ�ϴ��� �� �� �־�� �Ѵ�.
-- ������� ��RETURN ������ Ÿ�ԡ��� 
-- ����ο����� ��RETURN (��);�� �� �־�� �Ѵ�!!!


--�� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹε�Ϲ�ȣ) �� '771212-1022432' �� 'YYMMDD-NNNNNNN'

-- ����Ŭ���� IF ���Ǿ� ��, () ���ٰ� �������� ����
-- IF���� ���� �� ��, () ����!! �� �� �������

-- �Ű�����   : �ڸ���(����) �������� �ʴ´� !
-- ��ȯ�ڷ��� : �ڸ���(����) �������� ����
CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 ) 
RETURN VARCHAR2     -- '����', '����', 'Ȯ�κҰ�' ���ڿ� ��ȯ�Ұ���
IS
    -- ����� �� �ֿ� ���� ����
    V_RESULT    VARCHAR2(20);
BEGIN
    -- �����(���Ǻ�) �� ���� �� ó��
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
        THEN V_RESULT := '����';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )    
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- **����� ��ȯ     CHECK~!!!
    RETURN V_RESULT;
    
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.


-- 20220308_04_scott.sql �� �̵�
-- FN_GENDER() �Լ� Ȯ���غ��� ���ƿ�


--�� ������ ���� �� ���� �Ű�����(�Է� �Ķ����)�� �Ѱܹ޾� �� (A, B)
--   A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--   ��, ������ ����Ŭ ���� �Լ��� �̿����� �ʰ�, �ݺ����� Ȱ���Ͽ� �ۼ��Ѵ�.
--   �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

CREATE OR REPLACE FUNCTION FN_POW( NUM1 NUMBER, NUM2 NUMBER )
RETURN NUMBER
IS
    V_RESULT    NUMBER := 1;    -- ��ȯ ����� ���� �� 1�� �ʱ�ȭ     CHECK~!!!
    N           NUMBER;         -- ���� ����
BEGIN
    -- �ݺ��� ����
    FOR N IN 1 .. NUM2 LOOP
        V_RESULT := V_RESULT * NUM1;
    END LOOP;
    
    -- ���� ����� ��ȯ
    RETURN V_RESULT;
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.


--�� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--   �޿��� ��(�⺻��)*12+���硻 ������� ������ �����Ѵ�.
--   �Լ��� : FN_PAY(�⺻��, ����)
CREATE OR REPLACE FUNCTION FN_PAY(BASICPAY NUMBER, SUDANG NUMBER)
RETURN NUMBER
IS
    SALARY  NUMBER;
BEGIN 
    --SALARY := BASICPAY * 12 + SUDANG;
    --�� BASICPAY �� SUDANG �� NULL �̸� ��� NULL �� ��
    
    SALARY := NVL(BASICPAY, 0) * 12 + NVL(SUDANG, 0);
    --SALARY := COALESCE(BASICPAY*12+SUDANG, BASICPAY*12, SUDANG, 0);
    
    RETURN SALARY;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.


-- 20220310_02_scott.sql �� ���� �Լ� ��� Ȯ���غ��� ���ƿ�


--�� TBL_INSA ���̺��� �Ի����� �������� 
--   ��������� �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--   ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--   �Լ��� : FN_WORKYEAR(�Ի���)
CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    WORKYEAR    NUMBER;
BEGIN
    WORKYEAR := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM IBSADATE);
    
    RETURN WORKYEAR;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.
-- EXTRACT() �� �̾Ƽ� ����ϸ� ���� - ���� ����� �Ǿ 
-- �Ҽ��� ���� ���ڸ��� �ȳ���


-- �ٽ�
CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    WORKYEAR    NUMBER;
BEGIN
    WORKYEAR := TRUNC(MONTHS_BETWEEN(SYSDATE, IBSADATE) / 12, 1);
    
    RETURN WORKYEAR;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.


-- �� �� '��� ���' �� �����Բ�
CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VRESULT VARCHAR2(20);
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) / 12) || '�� ' ||
               TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, VIBSADATE), 12)) || '����';
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.


-- �� �� ������ ���ϴ� ��� �Ҽ��� ���ڸ� ������ �� ���� Ǭ�ſ� ����


--------------------------------------------------------------------------------

--�� ����

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�. 

-- 4. COMMIT, ROLLBACK
--==> TCL(Transaction Control Language)

-- ���� PL/SQL �� �� DML��, TCL���� ��� �����ϴ�.
-- ���� PL/SQL �� �� DML��, DDL��, DCL��, TCL�� ��� �����ϴ�.


--------------------------------------------------------------------------------

--���� PROCEDURE(���ν���) ����--

-- PL/SQL ����ϴ� ������ PROCEDURE ����ϱ� ���ؼ���� �ص�
-- ������ �ƴ� ������ ���� ����Ѵ�!

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� ������ ȣ���Ͽ� ������ �� �ֵ��� ó�����ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS 
    [-- �ֿ� ���� ����]
BEGIN
    -- ���� ����;
    ...
    
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/
-- �Լ��� �޸� ��RETURN �ڷ���;�� �� ����
-- PROCEDURE �� ��ȯ���� ���� ���� ����
-- ��ȯ�ϴ°� ������ �ƴ϶�, ȣ���� �κп��� �� �ڵ尡 ���ư��ٴ°� �߿��� ����
-- �׷��� ����� �ȿ��� RETURN �� ����

-- �Լ��� �Է� �Ű������� �ѱ� �� �ִµ�,
-- ���ν����� �Է�, ���, ����� �Ű����� �� �ѱ� �� �ִ�.
-- �Է�   �Ű����� : ���� ������ �����͸� �ǳ��ֱ⸸ �Ұ�        
-- ���   �Ű����� : ���� ������ �� �� �ϳ� ���״�, �ʰ� �ű⿡ ������ ��Ƽ� ��
-- ����� �Ű����� : ���� ������ ������ �� �״ϱ�, �ʵ� �ű⿡ ������ ��Ƽ� ��


--�� FUNCTION �� ������ �� ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--   ��RETURN���� ��ü�� �������� ������,
--   ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������ 
--   IN(�Է�), OUT(���), INOUT(�����) ���� ���еȴ�.


--3. ����(ȣ��)
/*
EXEC[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/



--�� ���ν��� �ǽ��� ���� ���̺� ����
--   20220310_02_scott.sql ���� ����~!!!

--   314 line ���� �ۼ��ϰ� �ٽ� ���ƿ�


--�� ���ν��� ����
--   ��EXEC PRC_STUDENT_INSERT('happy', 'java006$', '�̽ÿ�', '010-1111-1111', '���� ��������');��
-- �Լ������� �Ű����� �̸��� ������Ÿ�Ը� ����߾���
-- �Լ������� ��� �Է� �Ű������� �����ϱ� ������ !!
-- ���ν��������� �Է�, ���, ����� �Ű����� ������ �� �ֱ� ������
-- �̰� ���� �Ű����� ������ ���� Ű���� �־�� �Ѵ�.(IN, OUT, INOUT)
-- ������ �Լ������� IN �ۿ� ���ϴϱ� IN Ű���尡 �����ȰŶ�� ���� �ȴ�.
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN  TBL_IDPW.ID%TYPE    -- TBL_STUDENTS, TBL_IDPW �� �� ù��°�� �Է¹�����
, V_PW      IN  TBL_IDPW.PW%TYPE
, V_NAME    IN  TBL_STUDENTS.NAME%TYPE
, V_TEL     IN  TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�(INSERT �� DML ���� �� COMMIT �ʿ���)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_STUDENT_INSERT��(��) �����ϵǾ����ϴ�.


--�� 20220310_02_scott.sql ���� ����~!!!

--�� ���ν��� �ǽ��� ���� ���̺� ����
--   20220310_02_scott.sql ���� ����~!!!

--   507 line ���� �ۼ��ϰ� �ٽ� ���ƿ�


--�� ������ �Է� �� Ư�� �׸��� �����͸� �Է��ϸ�
--                  ---------
--                  (�й�, �̸�, ��������, ��������, ��������)
--   ���������� �ٸ� �߰��׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--                   --------
--                   (����, ���, ���)
--   ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--   ���ν��� �� : PRC_SUNGJUK_INSERT()

/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '�ּ���', 90, 80, 70);

���ν��� ȣ��� ó���� ���
�й�  �̸�    ��������  ��������  ��������  ����  ���  ���
 1    �ּ���     90        80        70     240    80     B
*/
-- ����ο��� ����ó�� �ϴٰ� ���� �ʿ��ϸ�, ���� �����ص� �����
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN  TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN  TBL_SUNGJUK.NAME%TYPE           
, V_KOR     IN  TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN  TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN  TBL_SUNGJUK.MAT%TYPE
-- ���⿡ ������ ����ڰ� EXCE PRC_SUNGJUK_INSERT() �� ��
-- �� �� �Ѱ���� �Ѵ�.
--, V_TOT     OUT TBL_SUNGJUK.TOT%TYPE
--, V_AVG     OUT TBL_SUNGJUK.AVG%TYPE
--, V_GRADE   OUT TBL_SUNGJUK.GRADE%TYPE
)
IS
    -- �����
    -- INSERT ������ ������ �ϱ� ���� �ʿ��� �߰� ���� ����
    -- ���⼭ ��ü�� ������ �����̱� ������ ��IN, OUT, INOUT�� �ʿ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    -- �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�.
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- INSERT ������ ����
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- Ŀ��
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.


-- 20220310_02_scott.sql �� ���� �׽�Ʈ ����

-- 537 line ���� �ۼ��ϰ� �ٽ� ���ƿ�


--�� TBL_SUNGJUK ���̺��� Ư�� �л��� ����
--   (�й�, ��������, ��������, ��������) ������ ���� ��
--   ����, ���, ��ޱ��� �Բ� �����Ǵ� ���ν����� �����Ѵ�.
--   ���ν��� �� : PRC_SUNGJUK_UPDATE()

/*
���� ��)
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);

���ν��� ȣ��� ó���� ���
�й�  �̸�    ��������  ��������  ��������  ����  ���  ���
 1    �ּ���     90        80        70     240    80     B
 2    ������     50        50        50     150    50     F
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN  TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN  TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN  TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN  TBL_SUNGJUK.MAT%TYPE
)                                       -- ���̻��̿� ��,�� �� �����ϱ� 
                                        -- ��;�� �� ���� !!!!
IS
    -- �����
    -- UPDATE �������� �����ϱ� ���� �ʿ��� ����
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- �����
    -- �߰��� ������ �ֿ� �����鿡 ���� ��Ƴ��� �Ѵ�
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
     
    IF (V_AVG >= 90)
        THEN V_GRADE := 'A';
    ELSIF (V_AVG >= 80)
        THEN V_GRADE := 'B';
    ELSIF (V_AVG >= 70)
        THEN V_GRADE := 'C';
    ELSIF (V_AVG >= 60)
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    -- UPDATE ������ ���� 
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT
      , TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- Ŀ�� 
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.


-- 20220310_02_scott.sql �� ���� �׽�Ʈ ����

-- 558 line ���� �ۼ��ϰ� �ٽ� ���ƿ�


--�� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--   ���ν����� �ۼ��Ѵ�.
--   ��, ID �� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.
--   ���ν��� �� : PRC_STUDENTS_UPDATE()

/*
���� ��)
EXEC PRC_STUDENTS_UPDATE('happy', 'java006', '010-9999-9999', '������ Ⱦ��');
--==>> ������ �������� ����...
--     ��й�ȣ�� �ٸ��� ������ !!!

EXEC PRC_STUDENTS_UPDATE('happy', 'java006$', '010-9999-9999', '������ Ⱦ��');
--==>> ������ ���� ok
*/
-- ��
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN  TBL_IDPW.ID%TYPE
, V_PW      IN  TBL_IDPW.PW%TYPE
, V_TEL     IN  TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID
      AND V_PW = (SELECT PW
                  FROM TBL_IDPW
                  WHERE ID = V_ID);
                  
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

-- �� �����
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN  TBL_IDPW.ID%TYPE
, V_PW      IN  TBL_IDPW.PW%TYPE
, V_TEL     IN  TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2   TBL_IDPW.PW%TYPE;
    V_FLAG  NUMBER := 0;        -- �ڹٷ� ġ��, boolean flag �ϳ� �����
BEGIN
    SELECT PW INTO V_PW2
    FROM TBL_IDPW
    WHERE ID = V_ID;
    
    IF (V_PW = V_PW2)
        THEN V_FLAG := 1;
    ELSE
        V_FLAG := 2;
    END IF;
    
    UPDATE TBL_STUDENTS
    SET TEL = V_TEL, ADDR = V_ADDR
    WHERE ID = V_ID
      AND V_FLAG = 1;
                  
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.
-- �� �ڵ�� �Ȱ��� ������
-- V_FLAG ����ϴ� �� ���α�


-- �� ����� JOIN ���ֱ�
-- Ȯ���ؾ� �� ID, PW �� TBL_IDPW �� �ְ�,
-- UPDATE �� TBL_STUDENTS ������Ѵ�.
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN  TBL_IDPW.ID%TYPE
, V_PW      IN  TBL_IDPW.PW%TYPE
, V_TEL     IN  TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    UPDATE (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
            FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
            ON T1.ID = T2.ID) T
    SET T.TEL = V_TEL, T.ADDR = V_ADDR
    WHERE T.ID = V_ID
      AND T.PW = V_PW;
                  
    COMMIT;
END;
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.


-- 20220310_02_scott.sql �� ���� �׽�Ʈ ����

-- ���ν��� �۾��� �������� ������ COMMIT, ROLLBACK �ϰ� �ϴ� �� �ƴ�
-- �� �ڵ� �ȿ� COMMIT; ��������ϱ�
