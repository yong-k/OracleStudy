
--------------------------------------------------------------------------------

/*
1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
2. PRC_�԰�_DELETE(�԰��ȣ)
3. PRC_���_DELETE(����ȣ)
*/

-- 1. PRC_�԰�_UPDATE(�԰��ȣ, �԰����)
/* 
1. �԰��ȣ ��ȿ���� Ȯ�� �� ������ �����߻�

���� ������ (�������԰���� - �����԰��ߴ� ����
���� ������ - ������� + ����
------------------------------- ������ UPDATE �Ұ�

2. UPDATE �� TBL_�԰�, TBL_��ǰ(������+�԰����)
*/
CREATE OR REPLACE PROCEDURE PRC_�԰�_UPDATE
( V_�԰��ȣ          IN  TBL_�԰�.�԰��ȣ%TYPE
, V_�������԰����    IN  TBL_�԰�.�԰����%TYPE
)
IS
    V_�԰��ȣȮ��    TBL_�԰�.�԰��ȣ%TYPE;
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_�����԰����    TBL_�԰�.�԰����%TYPE;
    V_������        TBL_��ǰ.������%TYPE;
    
    �԰��ȣ_ERROR    EXCEPTION;
    ������_ERROR    EXCEPTION;
BEGIN
    -- V_�԰��ȣ ���� Ȯ��
    SELECT NVL(MAX(�԰��ȣ), -999) INTO V_�԰��ȣȮ��
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- V_�԰��ȣ�� �������� �ʴ´ٸ� ���� �߻�
    IF (V_�԰��ȣȮ�� = -999)
        THEN RAISE �԰��ȣ_ERROR;
    END IF;

    -- V_��ǰ�ڵ�, V_�����԰���� �� ����
    SELECT ��ǰ�ڵ�, �԰���� INTO V_��ǰ�ڵ�, V_�����԰����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- V_������ �� ����
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- V_������ - V_�����԰���� + V_�������԰����
    --------------------------------------------------> ������ UPDATE �Ұ�
    IF (V_������ - V_�����԰���� + V_�������԰���� < 0)
        THEN RAISE ������_ERROR;
    END IF;
    
    -- UPDATE ������(TBL_�԰�)
    UPDATE TBL_�԰�
    SET �԰���� = V_�������԰����
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- UPDATE ������(TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_�����԰���� + V_�������԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó��
    EXCEPTION
        WHEN �԰��ȣ_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '�Է��Ͻ� �԰��ȣ�� �������� �ʽ��ϴ�');
                 ROLLBACK;
        WHEN ������_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� �����մϴ�.');
                 ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
    
    -- Ŀ��
    --COMMIT;
END;
--==>> Procedure PRC_�԰�_UPDATE��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

-- 2. PRC_�԰�_DELETE(�԰��ȣ)
/*
1. �԰��ȣ ��ȿ���� Ȯ�� �� ������ �����߻�
2. ���� �����ִ� ���������� �� �� �԰��ߴ� ������ ���ٸ� ���� �Ұ�
3. TBL_�԰� DELETE
4. UPDATE TBL_��ǰ ������ - �԰���� 
*/
CREATE OR REPLACE PROCEDURE PRC_�԰�_DELETE
(
    V_�԰��ȣ  IN  TBL_�԰�.�԰��ȣ%TYPE
)
IS
    V_�԰��ȣȮ��    TBL_�԰�.�԰��ȣ%TYPE;
    V_������        TBL_��ǰ.������%TYPE;
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_�԰����        TBL_�԰�.�԰����%TYPE;
    
    �԰��ȣ_ERROR    EXCEPTION;
    ������_ERROR    EXCEPTION;
BEGIN
    -- V_�԰��ȣ ���� Ȯ��
    SELECT NVL(MAX(�԰��ȣ), -999) INTO V_�԰��ȣȮ��
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- V_�԰��ȣ�� �������� �ʴ´ٸ� ���� �߻�
    IF (V_�԰��ȣȮ�� = -999)
        THEN RAISE �԰��ȣ_ERROR;
    END IF;
    
    -- V_��ǰ�ڵ� �� ����
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- V_������ �� ����
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- V_�԰���� �� ����
    SELECT �԰���� INTO V_�԰����
    FROM TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- ���� �������� ������ �԰������ŭ �ִ��� Ȯ�� ��, ������ ���� �߻�
    IF (V_������ < V_�԰����)
        THEN RAISE ������_ERROR;
    END IF;
    
    -- DELETE ������(TBL_�԰�)
    DELETE TBL_�԰�
    WHERE �԰��ȣ = V_�԰��ȣ;
    
    -- UPDATE ������(TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ - V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó��
    EXCEPTION
        WHEN �԰��ȣ_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '�Է��Ͻ� �԰��ȣ�� �������� �ʽ��ϴ�');
                 ROLLBACK;
        WHEN ������_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '��� �����մϴ�.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- Ŀ��
    --COMMIT;
END;
--==>> Procedure PRC_�԰�_DELETE��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------

-- 3. PRC_���_DELETE(����ȣ)
/*
1. ����ȣ ��ȿ���� Ȯ�� �� ������ �����߻�
2. DELETE TBL_���
3. UPDATE TBL_��ǰ ������ + ������
*/
CREATE OR REPLACE PROCEDURE PRC_���_DELETE
(
    V_����ȣ  IN  TBL_���.����ȣ%TYPE
)
IS
    V_����ȣȮ��    TBL_���.����ȣ%TYPE;
    V_������        TBL_���.������%TYPE;
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    
    ����ȣ_ERROR    EXCEPTION;
BEGIN
    -- V_����ȣ ���� Ȯ��
    SELECT NVL(MAX(����ȣ), -999) INTO V_����ȣȮ��
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    -- V_�԰��ȣ�� �������� �ʴ´ٸ� ���� �߻�
    IF (V_����ȣȮ�� = -999)
        THEN RAISE ����ȣ_ERROR;
    END IF;
    
    -- V_������, V_��ǰ�ڵ� �� ����
    SELECT ������, ��ǰ�ڵ� INTO V_������, V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    
    -- DELETE ������(TBL_���)
    DELETE TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    -- UPDATE ������(TBL_��ǰ)
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó��
    EXCEPTION
        WHEN ����ȣ_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '�Է��Ͻ� ����ȣ�� �������� �ʽ��ϴ�');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- Ŀ��
    --COMMIT;

END;
--==>> Procedure PRC_���_DELETE��(��) �����ϵǾ����ϴ�.


--------------------------------------------------------------------------------
