SELECT USER
FROM DUAL;
--==>> SYS


--■■■ 암호화 및 복호화 ■■■--

/*
암호화: 암호의 형태로 만드는 과정
복호화: 암호를 원래 뜻을 가진 문자로 다시 복원해내는 과정

구조는 상당히 단순하다.

『book』 을 어딘가에 넘긴다고 하면,
book으로 전달하는 게 아니라
↓ (암호화)
알파벳 순서대로 숫자매겨서 2 15 15 11 로 넘기면 book이라는 단어가 아님
↓ (복호화)
그걸 복원했더니 book 이 되더라.

아래처럼 알파벳 하나씩 다음걸로 바꿈
이것도 암호화/복호화이다.
book → cppl → book

→ 어떤 형태든지 원래 데이터가 뭔지 알아보지 못하게 하는 것!
*/


-- 1. 오라클 암호화 기능을 사용하기 위해서는
--    DBMS_OBFUSCATION_TOOLKIT 패키지를 이용할 수 있다.
--    (관련 패키지를 활용하지 않고, 암호화 복호화 알고리즘을 직접 구현할 수도 있다.)

-- 2. DBMS_OBFUSCATION_TOOLKIT 패키지는
--    기본적(default)으로는 사용할 수 없는 상태로 설정되어 있으므로
--    추가로 이 패키지를 설치하는 과정이 필요하다.
--    이를 위해... 『dbmsobtk.sql』과 『prvtobtk.plb』 파일을 찾아 실행해야 한다.
/*
DBMS_OBFUSCATION TOOLKIT 패키지 기본설치 아니라 설치먼저 해야한다!
경로 : C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\dbmsobtk.sql
위의 경로에서 『dbmsobtk.sql』 찾기 (파일 있어야 실행가능한거라 있는지 먼저 확인)

import 하는 방법
@ 붙이고 + 경로 → ctrl+enter
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\dbmsobtk.sql

같은 경로에서 『prvtobtk.plb』 찾기 (파일 있어야 실행가능한거라 있는지 먼저 확인)
@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\prvtobtk.plb
*/


@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\dbmsobtk.sql
--==>>
/*
Library DBMS_OBFUSCATION_LIB이(가) 컴파일되었습니다.
Library CRYPTO_TOOLKIT_LIBRARY이(가) 컴파일되었습니다.
Package DBMS_CRYPTO이(가) 컴파일되었습니다.
SYNONYM DBMS_CRYPTO이(가) 생성되었습니다.
Package DBMS_OBFUSCATION_TOOLKIT이(가) 컴파일되었습니다.
SYNONYM DBMS_OBFUSCATION_TOOLKIT이(가) 생성되었습니다.
Grant을(를) 성공했습니다.
Package DBMS_SQLHASH이(가) 컴파일되었습니다.
SYNONYM DBMS_SQLHASH이(가) 생성되었습니다.
*/

@C:\oraclexe\app\oracle\product\11.2.0\server\rdbms\admin\prvtobtk.plb
--==>>
/*
Package DBMS_CRYPTO_FFI이(가) 컴파일되었습니다.
Package Body DBMS_CRYPTO_FFI이(가) 컴파일되었습니다.
Package Body DBMS_CRYPTO이(가) 컴파일되었습니다.
Package DBMS_OBFUSCATION_TOOLKIT_FFI이(가) 컴파일되었습니다.
Package Body DBMS_OBFUSCATION_TOOLKIT_FFI이(가) 컴파일되었습니다.
Package Body DBMS_OBFUSCATION_TOOLKIT이(가) 컴파일되었습니다.
Package Body DBMS_SQLHASH이(가) 컴파일되었습니다.
*/


-- 3. 이 패키지는 4개의 프로시저로 이루어져 있다.
--    VARCHAR2 타입을 Encrypt/Decrypt 할 수 있는 2개의 프로시저
--    RAW 타입을 Encrypt/Decrypt 할 수 있는 2개의 프로시저
--    (다른 타입은 지원하지 않기 때문에 NUMBER 인 경우는 TO_CHAR() 이용)


-- ※ RAW, LONG RAW, ROWID 타입
--    그래픽 이미지나 디지털 사운드 등을 저장
--    HEXA-DECIMAL(16진수) 형태로 RETURN
--    이 중 RAW 는 VARCHAR2 와 유사하다.
--    LONG RAW 는 LONG 과 유사하지만 다음과 같은 제한사항이 있다.
--    ·저장과 추출만 가능하고, DATA 를 가공할 수 없다.
--    ·LONG RAW 는 LONG 과 같은 제한사항을 갖는다.

--※ 묶여있는 패키지 풀어서 사용가능하게 만드는건
--   1차적으로 SYS 가 해야한다.
--   그러고나서 그 패키지를 사용할 수 있도록, 
--   계정에 사용권한을 부여해줘야 한다.

--   파이널 때 이렇게 해줘야 한다!!

--○ 해당 패키지를 사용할 수 있도록 권한 부여
GRANT EXECUTE ON DBMS_OBFUSCATION_TOOLKIT TO SCOTT;
--==>> Grant을(를) 성공했습니다.
--> SCOTT 계정으로 DBMS_OBFUSCATION_TOOLKIT 패키지의
--  프로시저를 사용할 수 있는 권한 부여

GRANT EXECUTE ON DBMS_OBFUSCATION_TOOLKIT TO PUBLIC;
--==>> Grant을(를) 성공했습니다.
--> PUBLIC 으로 DBMS_OBFUSCATION_TOOLKIT 패키지의
--  프로시저를 사용할 수 있는 권한 부여

--  +) PUBLIC: sysoper (운영자 형태의 계정)

