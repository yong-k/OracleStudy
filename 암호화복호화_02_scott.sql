SELECT USER
FROM DUAL;
--==>> SCOTT

-- (현재 SCOTT 으로 연결된 상태)
-- 저 패키지를 우리가 사용할 수 있는 형태로 가공할 것이다.

--○ 패키지 선언(CRYPTPACK)
CREATE OR REPLACE PACKAGE CRYPTPACK
AS  
    FUNCTION ENCRYPT(STR VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;
    
    FUNCTION DECRYPT(XCRYPT VARCHAR2, HASH VARCHAR2)
    RETURN VARCHAR2;

END CRYPTPACK;
--==>> Package CRYPTPACK이(가) 컴파일되었습니다.
--     (명세부 만들었음)
--     오라클에서 package는 명세부/몸체부 구분되어 있다.


--○ 패키지 몸체(CRYPTPACK)
/*
『=>』파라미터 값 직접 지정해서 넘길 때 사용하는 기호
특정한 이름을 가진 애한테 전달한다는 의미
*/
CREATE OR REPLACE PACKAGE BODY CRYPTPACK
IS
    CRYPTED_STRING VARCHAR2(2000);      --전역변수 선언
    
    --우리가 만들고자 했던 함수 2개
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
--==>> Package Body CRYPTPACK이(가) 컴파일되었습니다.


