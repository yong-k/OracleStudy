SELECT USER
FROM DUAL;
--==>> SCOTT

--------------------------------------------------------------------------------

--���� AFTER ROW TRIGGER ��Ȳ �ǽ� ����--
--�� TBL_�԰� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_�԰�
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
             -- ���⼭�� :NEW���ϴ���, :OLD�� �ϴ��� �� �ȴ�.
             -- ��ǰ�ڵ带 UPDATE ��Ű�� �� �ƴϱ� ������
             -- ex) ��ǰ�ڵ� ������ �� TBL_��ǰ���� �ϵ�, TBL_�԰��� �ϵ��� �� �ǵ���
             -- BUT, �� ��Ȳ���� �θ����̺��� Ÿ���� �����ϴ� �� �� ���ٰ� �ߴ� �� ó��,
             -- ���⼭��,
             -- �����Ÿ� ã�Ƽ� UPDATE ������� �ϱ� ������ 
             -- ��:OLD.��ǰ�ڵ塻�� �� ���� ǥ���̴�.
             --WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰����
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.


-- 20220315_02_scott.sql �� ���� �׽�Ʈ ����    
-- Line 112 ���� �ۼ��ϰ� ���ƿ�

--------------------------------------------------------------------------------

--�� TBL_��� ���̺��� ������ �Է�, ����, ���� ��
--   TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--   Ʈ���� �� : TRG_CHULGO

CREATE OR REPLACE TRIGGER TRG_CHULGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_���
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    ELSIF (DELETING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;
--==>> Trigger TRG_CHULGO��(��) �����ϵǾ����ϴ�.


-- 20220315_02_scott.sql �� ���� �׽�Ʈ ����
-- Line 228 ���� �ۼ��ϰ� ���ƿ�

--------------------------------------------------------------------------------

--���� PACKAGE(��Ű��) ����--

-- 1. PL/SQL �� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü,
--    ���� ���α׷�(PROCEDURE, FUNCTION ��)��
--    �������� ������� ������
--    ����Ŭ���� �����ϴ� ��Ű�� �� �ϳ��� �ٷ� ��DBMS_OUTPUT�� �̴�.

-- 2. ��Ű���� ���� ������ ������ ���Ǵ� ���� ���� ���ν����� �Լ���
--    �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ���ϰ�
--    ��ü ���α׷��� ���ȭ �� �� �ִٴ� ������ �ִ�.

-- 3. ��Ű���� ����(PACKAGE SPECIFICATION)��
--    ��ü��(PACKAGE BODY)�� �����Ǿ� ������
--    �� �κп��� TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR, SUBPROGRAM �� ����ǰ�
--    ��ü �κп��� �̵��� ���� ������ �����Ѵ�.
--    �׸���, ȣ���� ������ ����Ű����.���ν����� ������ ������ �̿��ؾ� �Ѵ�.


-- Ư�̻���: ���ο� ��ü�θ� ���� �����.
-- ���ο� ��ü�ΰ� ��ũ�� �¾ƾ� ��
-- ���ο� �Լ� 5�� �ִٰ� ���������, ��ü�ο� �Լ� 5�� �־�� �Ѵ�.
-- 4. ���� �� ����(����)
--    �� �� �ȿ� �� ����ִ��� �ܺο� ������� ���� ��
/*
CREATE [OR REPLACE] PACKAGE ��Ű����
IS
    �������� ����;
    Ŀ�� ����;
    ���� ����;
    �Լ� ����;
    ���ν��� ����;
        :
END ��Ű����;
*/

-- 5. ���� �� ����(��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű����
IS
    FUNCTION �Լ���[(�μ�, ...)]
    RETURN �ڷ���
    IS
        ���� ����;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[(�μ�, ...)]
    IS
        ���� ����;
    BEGIN
        ���ν��� ��ü ���� �ڵ�;
    END;
END ��Ű����;
*/


-- ��Ű�� ��� �ǽ�
-- TBL_INSA �� �ֹι�ȣ Ȯ���ؼ� ���� ���ϴ� �Լ��� ��Ű�� �ȿ� ��������

--�� ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END INSA_PACK;
-- ��END ��Ű����;�� ����� ����!!
--==>> Package INSA_PACK��(��) �����ϵǾ����ϴ�.


--�� ��ü�� �ۼ� �� ���ο� ��Ű�� �̸��� ���ƾ� �Ѵ�! 
--                  �������̸� ���ο��� �ۼ��Ѱ� �����ؼ� ����(�ٸ��� �ȵǴϱ�)
--               �� ��ü�ο��� ��BODY�� Ű���尡 ����.
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT    VARCHAR2(20);
    BEGIN
        IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
            THEN V_RESULT := '����';
        ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') ) 
            THEN V_RESULT := '����';
        ELSE
            V_RESULT := 'Ȯ�κҰ�';
        END IF;
    
        RETURN V_RESULT;
    END;
    
END INSA_PACK;
--==>> Package Body INSA_PACK��(��) �����ϵǾ����ϴ�.


-- 20220315_02_scott.sql �� ���� �׽�Ʈ ����


