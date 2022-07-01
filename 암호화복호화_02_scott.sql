SELECT USER
FROM DUAL;
--==>> SCOTT

-- (���� SCOTT ���� ����� ����)
-- �� ��Ű���� �츮�� ����� �� �ִ� ���·� ������ ���̴�.

--�� ��Ű�� ����(CRYPTPACK)
CREATE OR REPLACE PACKAGE CRYPTPACK
AS  
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
    
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;

END CRYPTPACK;
--==>> Package CRYPTPACK��(��) �����ϵǾ����ϴ�.
--     (���� �������)
--     ����Ŭ���� package�� ����/��ü�� ���еǾ� �ִ�.


--�� ��Ű�� ��ü(CRYPTPACK)
/*
��=>���Ķ���� �� ���� �����ؼ� �ѱ� �� ����ϴ� ��ȣ
Ư���� �̸��� ���� ������ �����Ѵٴ� �ǹ�
*/
CREATE OR REPLACE PACKAGE BODY CRYPTPACK
IS
    CRYPTED_STRING VARCHAR2(2000);      --�������� ����
    
    --�츮�� ������� �ߴ� �Լ� 2��
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2
    IS
        PIECES_OF_EIGHT NUMBER := ((FLOOR(LENGTH(STR)/8 + .9)) * 8);
    BEGIN
        DBMS_OBFUSCATION_TOOLKIT.DESENCRYPT
        ( INPUT_STRING      => RPAD(STR, PIECES_OF_EIGHT)
        , KEY_STRING        => RPAD(HASH, 8, '#')
        , ENCRYPTED_STRING  => CRYPTED_STRING
        );
        RETURN CRYPTED_STRING;
    END;
    
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2
    IS
    BEGIN
        DBMS_OBFUSCATION_TOOLKIT.DESDECRYPT
        ( INPUT_STRING      => XCRYPT
        , KEY_STRING        => RPAD(HASH, 8, '#')
        , DECRYPTED_STRING  => CRYPTED_STRING
        );
        RETURN TRIM(CRYPTED_STRING);
    END;
    
END CRYPTPACK;
--==>> Package Body CRYPTPACK��(��) �����ϵǾ����ϴ�.


