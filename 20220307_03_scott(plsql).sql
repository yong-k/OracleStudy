-- 지금까지 ORACLE SQL 파트를 봤다면,
-- 지금부터는 ORACLE 의 PL/SQL 파트를 볼거다.

-- PL/SQL을 ADMIN 파트라고 수업 안하는 곳도 있는데,
-- 중요성이 SQL 만큼은 아니지만 그래도 PL/SQL도 알아야 한다.

-- 면접 가서도 많이 물어보고, 실제 실무에서도 많이 쓰이고 있음

SELECT USER
FROM DUAL;
--==>> SCOTT

--          Structed Query Language
--          ---
--■■■ PL/SQL ■■■--
--       --
--       Procedure Language → 절차적인 언어
-- PL/SQL : 프로그래밍적 요소를 가미한 SQL

-- 1. PL/SQL(Procedural Language extension to SQL) 은 
--    프로그래밍 언어의 특성을 가지는 SQL 의 확장이며
--    데이터 조작과 질의 문장은 PL/SQL 의 절차적 코드 안에 포함된다.
--    또한, PL/SQL 을 사용하면 SQL 로 할 수 없는 절차적 작업이 가능하다.
--    여기에서 『절차적』 이라는 단어가 가지는 의미는
--    어떤 것이 어떤 과정을 거쳐서 어떻게 완료되는지
--    그 방법을 정확하게 코드에 기술한다는 것을 의미한다.

-- 2. PL/SQL 은 절차적으로 표현하기 위해
--    변수를 선언할 수 있는 기능,
--    참과 거짓을 구별할 수 있는 기능,
--    실행 흐름을 컨트롤할 수 있는 기능 등을 제공한다.

-- 3. PL/SQL 은 블럭 구조로 되어 있으며
--    블럭은 선언 부분, 실행 부분, 예외 처리 부분의
--    세 부분으로 구성되어 있다.
--    또한, 반드시 실행 부분은 존재해야 하며, 구조는 다음과 같다.

-- +) 자바에서는 {} 로 시작-끝을 알 수 있었지만
--    PL/SQL 은 아니라,
--    띄어쓰기, 들여쓰기 잘 구분해서 해야 알아보기 편하다!

-- 4. 형식 및 구조
/*
[DECLARE]
    -- 선언문(DECLARATIONS)
BEGIN
    -- 실행문(STATEMENTS)
    
    [EXCEPTION]
        -- 예외 처리문(EXCEPTION HANDLERS)
END;        
*/

-- 5. 변수 선언
/*
DECLARE
    변수명 자료형;
    변수명 자료형 := 초기값;
BEGIN
END;
*/


/*
-- 자바에서 변수 선언할 때

    자료형 변수명;
    int num; 
    
    -- 대입할 때는
    int num = 10;
    
-- 오라클은 반대임

    변수명 자료형;
    col1 number;    → 테이블 선언할 때도 이렇게 했었으니까!
    
    -- 대입할 때는
    col1 number := 10;
    -- 오라클에서는 『=』는 대입연산자가 아님
    -- 오라클에서의 대입연산자 → 『:=』
    -- 우측에서 좌측으로 대입하는 건 자바와 같음
    -- 그냥 := 나오면 : 점 연결해서 <= 화살표라고 생각하기
    -- 그래서 =: 는 존재하지 않는다.
*/


-- 일단 CASE WHEN THEN ELSE END 처럼
-- DECLARE
-- BEGIN
-- END;
-- 작성해놓고 시작하기


-- 앞으로 (plsql).sql 형식으로 워크시트 만들면
--※ 블럭(영역)을 잡아(선택하여) 실행~!!!!
--SET SERVEROUTPUT ON; 그거만 블럭잡아서 실행
--DECLARE~END까지 블럭잡아서 실행
-- SQL 워크시트와 PL/SQL 워크시트가 따로 있는게 아님
-- 이걸 근데 한 곳에 작성하면 실행할 때 난리남 ㅎㅎ...
-- 반드시!! 블럭잡아서 CTRL+ENTER !!!!!!!



--※ 『DBMS_OUTPUT.PUT_LINE()』 을 통해
--    화면에 결과를 출력하기 위한 환경변수 설정
SET SERVEROUTPUT ON;        -- SERVEROUTPUT 환경변수를 ON 해줘야 한다.
                            -- 세션 당 한 번만 해주면 된다.



--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
--   선언부 → 값 대입
--   실행부 → 출력     만 할 예정
DECLARE
    -- 선언부 : 실행부에서 쓸 것들을 여기서 선언함
    --          자바에서의 [변수선언 및 초기화] 부분
    V1 NUMBER := 10; 
    -- V1 이라는 변수를 NUMBER TYPE 으로 선언
    -- 그 안에 10을 담음
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'Oracle';
BEGIN
    -- 실행부
    -- [IN 자바] System.out.println()
    -- 오라클에서는 『DBMS_OUTPUT.PUT_LINE();』
    -- 『DBMS_OUTPUT.PUT_LINE();』 사용하려면 
    -- 『SET SERVEROUTPUT ON;』 설정을 해줘야 함
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
    
END;
--==>>
/*
10
HELLO
Oracle


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
-- 『SET SERVEROUTPUT ON;』 은 세션 당 한 번만 하면 된다.
-- 위에서 했으니까, 위에서 할 필요 없음
DECLARE
    -- 선언부
    V1  NUMBER := 10;
    V2  VARCHAR2(30) := 'HELLO';
    V3  VARCHAR2(30) := 'ORACLE';
BEGIN
    -- 실행부
    -- (연산 및 처리)
    V1 := V1 + 20;      -- 자바에서의 NUM1 + NUM1 + 20; → NUM += 20;
                        -- 오라클에는 안타깝게도 복합대입연산자 없음...!
    V2 := V2 || ' 신시은';
    V3 := V3 || ' World~!!!';
    
    -- (결과 출력)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);   
END;
--==>>
/*
30
HELLO 신시은
ORACLE World~!!!


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

