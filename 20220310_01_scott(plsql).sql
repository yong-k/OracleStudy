SELECT USER
FROM DUAL;
--==>> SCOTT


--------------------------------------------------------------------------------
--20220308_05_scott(plsql).sql 함수 부분 복사해옴


--■■■ FUNCTION(함수) ■■■--

-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다. (→ 사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXECUTE 문을 통해 실행할 수 있다.

-- 2. 형식 및 구조
-- 같은 이름으로 생성한다면, 덮어써진다는 개념이다. → CREATE OR REPLACE
/*
CREATE [OR REPLACE] FUNCTION 함수명
[( 매개변수명1 자료형
 , 매개변수명2 자료형
)]
RETURN 데이터타입            ---------> 여기까지 『함수의 선언부』
IS                           -- DECLARE 만 IS 로 바뀜 
    -- 주요 변수 선언
BEGIN
    -- 실행문;
    ...
    RETURN (값);
    
    [EXCEPTION]
        -- 예외 처리 구문;
END;
*/

--※ 사용자 정의 함수(스토어드 함수)는
--   IN 파라미터(입력 매개변수)만 사용할 수 있으며
--   반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--   FUNCTION 은 반드시 단일 값만 반환한다.

-- DBA가 아닌 이상 OUT 파라미터 쓸 일은 그렇게 많지 않다.
-- ex) 
-- 내가 김치 담아서 이웃한테 통에 김치 담아서 넘긴거  → IN 파라미터로 넘긴거
-- 이웃이 그 통에 파김치 담아서 다시 우리집에 줬다.   → OUT 파라미터로 넘긴거
-- 그런데 함수에서는 IN 파라미터만 사용가능하다!

-- 『함수의 선언부』 봤을 때, 
-- 어떤 매개변수들을 필요로 하고, 어떤 값을 반환하는지 알 수 있어야 한다.
-- 선언부의 『RETURN 데이터 타입』과 
-- 실행부에서의 『RETURN (값);』 꼭 있어야 한다!!!


--○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
-- 함수명 : FN_GENDER()
--                   ↑ SSN(주민등록번호) → '771212-1022432' → 'YYMMDD-NNNNNNN'

-- 오라클에서 IF 조건쓸 때, () 쓴다고 오류나지 않음
-- IF문에 조건 쓸 때, () 쓰자!! → 쌤 권장사항

-- 매개변수   : 자릿수(길이) 지정하지 않는다 !
-- 반환자료형 : 자릿수(길이) 지정하지 않음
CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 ) 
RETURN VARCHAR2     -- '남자', '여자', '확인불가' 문자열 반환할거임
IS
    -- 선언부 → 주요 변수 선언
    V_RESULT    VARCHAR2(20);
BEGIN
    -- 실행부(정의부) → 연산 및 처리
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
        THEN V_RESULT := '남자';
    ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') )    
        THEN V_RESULT := '여자';
    ELSE
        V_RESULT := '성별확인불가';
    END IF;
    
    -- **결과값 반환     CHECK~!!!
    RETURN V_RESULT;
    
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.


-- 20220308_04_scott.sql 로 이동
-- FN_GENDER() 함수 확인해보고 돌아옴


--○ 임의의 정수 두 개를 매개변수(입력 파라미터)로 넘겨받아 → (A, B)
--   A 의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
--   단, 기존의 오라클 내장 함수를 이용하지 않고, 반복문을 활용하여 작성한다.
--   함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/

CREATE OR REPLACE FUNCTION FN_POW( NUM1 NUMBER, NUM2 NUMBER )
RETURN NUMBER
IS
    V_RESULT    NUMBER := 1;    -- 반환 결과값 변수 → 1로 초기화     CHECK~!!!
    N           NUMBER;         -- 루프 변수
BEGIN
    -- 반복문 구성
    FOR N IN 1 .. NUM2 LOOP
        V_RESULT := V_RESULT * NUM1;
    END LOOP;
    
    -- 최종 결과값 반환
    RETURN V_RESULT;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다.


--○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--   급여는 『(기본급)*12+수당』 기반으로 연산을 수행한다.
--   함수명 : FN_PAY(기본급, 수당)
CREATE OR REPLACE FUNCTION FN_PAY(BASICPAY NUMBER, SUDANG NUMBER)
RETURN NUMBER
IS
    SALARY  NUMBER;
BEGIN 
    --SALARY := BASICPAY * 12 + SUDANG;
    --→ BASICPAY 나 SUDANG 이 NULL 이면 결과 NULL 이 됨
    
    SALARY := NVL(BASICPAY, 0) * 12 + NVL(SUDANG, 0);
    --SALARY := COALESCE(BASICPAY*12+SUDANG, BASICPAY*12, SUDANG, 0);
    
    RETURN SALARY;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.


-- 20220310_02_scott.sql 로 가서 함수 결과 확인해보고 돌아옴


--○ TBL_INSA 테이블에서 입사일을 기준으로 
--   현재까지의 근무년수를 반환하는 함수를 정의한다.
--   단, 근무년수는 소수점 이하 한자리까지 계산한다.
--   함수명 : FN_WORKYEAR(입사일)
CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    WORKYEAR    NUMBER;
BEGIN
    WORKYEAR := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM IBSADATE);
    
    RETURN WORKYEAR;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.
-- EXTRACT() 로 뽑아서 계산하면 정수 - 정수 계산이 되어서 
-- 소수점 이하 한자리가 안나옴


-- 다시
CREATE OR REPLACE FUNCTION FN_WORKYEAR(IBSADATE DATE)
RETURN NUMBER
IS
    WORKYEAR    NUMBER;
BEGIN
    WORKYEAR := TRUNC(MONTHS_BETWEEN(SYSDATE, IBSADATE) / 12, 1);
    
    RETURN WORKYEAR;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.


-- 쌤 ① '몇년 몇개월' 로 나오게끔
CREATE OR REPLACE FUNCTION FN_WORKYEAR(VIBSADATE DATE)
RETURN VARCHAR2
IS
    VRESULT VARCHAR2(20);
BEGIN
    VRESULT := TRUNC(MONTHS_BETWEEN(SYSDATE, VIBSADATE) / 12) || '년 ' ||
               TRUNC(MOD(MONTHS_BETWEEN(SYSDATE, VIBSADATE), 12)) || '개월';
    
    RETURN VRESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.


-- 쌤 ② 문제가 원하는 대로 소수점 한자리 나오게 → 내가 푼거와 동일


--------------------------------------------------------------------------------

--※ 참고

-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Manipulation Language)
-- COMMIT / ROLLBACK 이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다. 

-- 4. COMMIT, ROLLBACK
--==> TCL(Transaction Control Language)

-- 정적 PL/SQL 문 → DML문, TCL문만 사용 가능하다.
-- 동적 PL/SQL 문 → DML문, DDL문, DCL문, TCL문 사용 가능하다.


--------------------------------------------------------------------------------

--■■■ PROCEDURE(프로시저) ■■■--

-- PL/SQL 사용하는 이유가 PROCEDURE 사용하기 위해서라고 해도
-- 과언이 아닐 정도로 많이 사용한다!

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때마다 호출하여 실행할 수 있도록 처리해주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입
 , 매개변수 OUT 데이터타입
 , 매개변수 INOUT 데이터타입
)]
IS 
    [-- 주요 변수 선언]
BEGIN
    -- 실행 구문;
    ...
    
    [EXCEPTION
        -- 예외 처리 구문;]
END;
*/
-- 함수와 달리 『RETURN 자료형;』 이 없음
-- PROCEDURE 는 반환하지 않을 수도 있음
-- 반환하는게 목적이 아니라, 호출한 부분에서 이 코드가 돌아간다는게 중요한 거임
-- 그래서 실행부 안에서 RETURN 문 없음

-- 함수는 입력 매개변수만 넘길 수 있는데,
-- 프로시저는 입력, 출력, 입출력 매개변수 다 넘길 수 있다.
-- 입력   매개변수 : 내가 너한테 데이터를 건네주기만 할게        
-- 출력   매개변수 : 내가 너한테 빈 통 하나 줄테니, 너가 거기에 데이터 담아서 줘
-- 입출력 매개변수 : 내가 너한테 데이터 줄 테니까, 너도 거기에 데이터 담아서 줘


--※ FUNCTION 과 비교했을 때 『RETURN 반환자료형』 부분이 존재하지 않으며,
--   『RETURN』문 자체도 존재하지 않으며,
--   프로시저 실행 시 넘겨주게 되는 매개변수의 종류는 
--   IN(입력), OUT(출력), INOUT(입출력) 으로 구분된다.


--3. 실행(호출)
/*
EXEC[UTE] 프로시저명[(인수1, 인수2, ...)];
*/



--※ 프로시저 실습을 위한 테이블 생성
--   20220310_02_scott.sql 파일 참조~!!!

--   314 line 까지 작성하고 다시 돌아옴


--○ 프로시저 생성
--   『EXEC PRC_STUDENT_INSERT('happy', 'java006$', '이시우', '010-1111-1111', '제주 서귀포시');』
-- 함수에서는 매개변수 이름과 데이터타입만 명시했었음
-- 함수에서는 모두 입력 매개변수만 가능하기 때문에 !!
-- 프로시저에서는 입력, 출력, 입출력 매개변수 구성할 수 있기 때문에
-- 이게 무슨 매개변수 인지에 대한 키워드 있어야 한다.(IN, OUT, INOUT)
-- 어차피 함수에서는 IN 밖에 못하니까 IN 키워드가 생략된거라고 보면 된다.
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN  TBL_IDPW.ID%TYPE    -- TBL_STUDENTS, TBL_IDPW 둘 다 첫번째로 입력받을거
, V_PW      IN  TBL_IDPW.PW%TYPE
, V_NAME    IN  TBL_STUDENTS.NAME%TYPE
, V_TEL     IN  TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력(INSERT → DML 구문 → COMMIT 필요함)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);
    
    -- TBL_STUDENTS 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);
    
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_STUDENT_INSERT이(가) 컴파일되었습니다.


--※ 20220310_02_scott.sql 파일 참조~!!!

--※ 프로시저 실습을 위한 테이블 생성
--   20220310_02_scott.sql 파일 참조~!!!

--   507 line 까지 작성하고 다시 돌아옴


--○ 데이터 입력 시 특정 항목의 데이터만 입력하면
--                  ---------
--                  (학번, 이름, 국어점수, 영어점수, 수학점수)
--   내부적으로 다른 추가항목에 대한 처리가 함께 이루어질 수 있도록 하는
--                   --------
--                   (총점, 평균, 등급)
--   프로시저를 작성한다.(생성한다.)
--   프로시저 명 : PRC_SUNGJUK_INSERT()

/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '최선하', 90, 80, 70);

프로시저 호출로 처리된 결과
학번  이름    국어점수  영어점수  수학점수  총점  평균  등급
 1    최선하     90        80        70     240    80     B
*/
-- 실행부에서 연산처리 하다가 변수 필요하면, 변수 선언해도 충분함
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAKBUN  IN  TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN  TBL_SUNGJUK.NAME%TYPE           
, V_KOR     IN  TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN  TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN  TBL_SUNGJUK.MAT%TYPE
-- 여기에 쓰려면 사용자가 EXCE PRC_SUNGJUK_INSERT() 할 때
-- 빈 통 넘겨줘야 한다.
--, V_TOT     OUT TBL_SUNGJUK.TOT%TYPE
--, V_AVG     OUT TBL_SUNGJUK.AVG%TYPE
--, V_GRADE   OUT TBL_SUNGJUK.GRADE%TYPE
)
IS
    -- 선언부
    -- INSERT 쿼리문 수행을 하기 위해 필요한 추가 변수 구성
    -- 여기서 자체로 선언한 변수이기 때문에 『IN, OUT, INOUT』 필요없음
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 실행부
    -- 추가로 선언한 주요 변수들에 값을 담아내야 한다.
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
    
    -- INSERT 쿼리문 수행
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES(V_HAKBUN, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.


-- 20220310_02_scott.sql 로 가서 테스트 진행

-- 537 line 까지 작성하고 다시 돌아옴


--○ TBL_SUNGJUK 테이블에서 특정 학생의 점수
--   (학번, 국어점수, 영어점수, 수학점수) 데이터 수정 시
--   총점, 평균, 등급까지 함께 수정되는 프로시저를 생성한다.
--   프로시저 명 : PRC_SUNGJUK_UPDATE()

/*
실행 예)
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);

프로시저 호출로 처리된 결과
학번  이름    국어점수  영어점수  수학점수  총점  평균  등급
 1    최선하     90        80        70     240    80     B
 2    박현수     50        50        50     150    50     F
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( V_HAKBUN  IN  TBL_SUNGJUK.HAKBUN%TYPE
, V_KOR     IN  TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN  TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN  TBL_SUNGJUK.MAT%TYPE
)                                       -- 사이사이에 『,』 들어가 있으니까 
                                        -- 『;』 안 붙임 !!!!
IS
    -- 선언부
    -- UPDATE 쿼리문을 수행하기 위해 필요한 변수
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    -- 실행부
    -- 추가로 선언한 주요 변수들에 값을 담아내야 한다
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
    
    -- UPDATE 쿼리문 수행 
    UPDATE TBL_SUNGJUK
    SET KOR = V_KOR, ENG = V_ENG, MAT = V_MAT
      , TOT = V_TOT, AVG = V_AVG, GRADE = V_GRADE
    WHERE HAKBUN = V_HAKBUN;
    
    -- 커밋 
    COMMIT;
    
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.


-- 20220310_02_scott.sql 로 가서 테스트 진행

-- 558 line 까지 작성하고 다시 돌아옴


--○ TBL_STUDENTS 테이블에서 전화번호와 주소 데이터를 수정하는(변경하는)
--   프로시저를 작성한다.
--   단, ID 와 PW 가 일치하는 경우에만 수정을 진행할 수 있도록 처리한다.
--   프로시저 명 : PRC_STUDENTS_UPDATE()

/*
실행 예)
EXEC PRC_STUDENTS_UPDATE('happy', 'java006', '010-9999-9999', '강원도 횡성');
--==>> 데이터 수정되지 않음...
--     비밀번호가 다르기 때문에 !!!

EXEC PRC_STUDENTS_UPDATE('happy', 'java006$', '010-9999-9999', '강원도 횡성');
--==>> 데이터 수정 ok
*/
-- 나
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
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

-- 쌤 방법①
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( V_ID      IN  TBL_IDPW.ID%TYPE
, V_PW      IN  TBL_IDPW.PW%TYPE
, V_TEL     IN  TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN  TBL_STUDENTS.ADDR%TYPE
)
IS
    V_PW2   TBL_IDPW.PW%TYPE;
    V_FLAG  NUMBER := 0;        -- 자바로 치면, boolean flag 하나 만든거
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
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.
-- 내 코드랑 똑같은 내용임
-- V_FLAG 사용하는 거 봐두기


-- 쌤 방법② JOIN 해주기
-- 확인해야 할 ID, PW 는 TBL_IDPW 에 있고,
-- UPDATE 는 TBL_STUDENTS 해줘야한다.
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
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.


-- 20220310_02_scott.sql 로 가서 테스트 진행

-- 프로시저 작업한 다음에는 별도로 COMMIT, ROLLBACK 하게 하는 거 아님
-- 그 코드 안에 COMMIT; 들어있으니까
