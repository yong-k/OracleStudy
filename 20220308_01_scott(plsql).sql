SELECT USER
FROM DUAL;
--==>> SCOTT


--○ IF문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL/SQL 의 IF 문장은 다른 언어의 IF 조건문과 거의 유사하다.
--    일치하는 조건에 따라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE 이면 THEN 과 ELSE 사이의 문장을 수행하고
--    FALSE 나 NULL 이면 ELSE 와 END IF; 사이의 문장을 수행하게 된다.

-- 2. 형식 및 구조
-- → 자바에서 처럼 {} 가 있는게 아니라 영역 잘 구분해야하고,
--    키워드 잘 맞춰서 써야한다!
-- → 작성순서 :   IF  
--                 END IF; 
--                 먼저 써놓기
--    END IF 가 마지막이라 까먹을 때가 많음
-- → ** ELSE 에는 THEN 없음 !
-- → 오라클의 IF ELSE 구문도 중첩이 가능하다.
/*
IF 조건
    THEN 처리문;
END IF;
*/

/*
IF 조건
    THEN 처리문;
ELSE
    처리문;
END IF;    
*/

/*
-- 중첩 시에, ELSE IF 로 쓰는게 아니라
-- 『ELSIF』 키워드 사용!
IF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문
ELSIF 조건   
    THEN 처리문;
ELSE
    처리문
END IF;
*/


-- 만약 변수 선언 시에,
-- COL1 NUMBER;
-- 이렇게 길이를 명시하지 않으면, COL1의 범위는 어떻게 될까??
-- → NUMBER 가 담을 수 있는(표현할 수 있는) MIN ~ MAX 까지 다 담을 수 있음

-- COL2 CHAR;
-- 길이 명시하지 않으면, COL2의 범위는?
-- → CHAR 데이터 타입은 문자 하나 들어감
--    CHAR(10) 하면 오라클 내부에서 알아서 배열처럼 10글자 넣을 수 있게 해놨지만
--    길이를 명시하지 않으면 한 글자 밖에 안 들어감 !!!

--○ 출력위해서, 환경변수 ON
SET SERVEROUTPUT ON;


--○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    -- 선언부
    GRADE CHAR;     -- GRADE 변수를 문자 담는 CHAR TYPE 으로 선언
BEGIN
    -- 실행부
    --GRADE := 'A';
    --GRADE := 'B';
    GRADE := 'C';
    
    --DBMS_OUTPUT.PUT_LINE(GRADE);
    
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('COOL');
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
    
END;
--==>>
/*
EXCELLENT


PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


--○ CASE 문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;
-- → 자바에서의 SWITCH 문 생각하면 됨
--    변수에 어떤 값이 들어있느냐에 따라서, 그 값을 통해서 분기
-- → 문장 형식은 SQL에서 다루고 있던 CASE문을 따르고 있음
-- → CASE
--    END CASE;
--    먼저 쓰고 시작하기
--    {} 가 따로 없고, 블럭 형식이기 때문에 
--    그 문장이 끝났다는 걸 알려주기 위해 END CASE; 형식으로 이루어져 있음

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문;
    WHEN 값2 THEN 실행문;
    ELSE 실행문;           → ELSE 문에는 THEN 없음!!
END CASE;
*/



-- ACCEPT 옆에는 주석달지 말고, 위나 아래에 달기!
ACCEPT NUM PROMPT '남자1 여자2 입력하세요';
--     ---        ------------------------
--    입력값을      입력 대화창의 안내문구
--    담아낼 변수
-- 『ACCEPT』 : 얘 나오면 외부 데이터를 PL/SQL 영역으로 끌어들이겠다는 의미
-- 외부로부터 임의의 변수(여기선 NUM)를 수용하겠다.
-- 『PROMPT』 : 화면에 띄우겠다.
--> 스크립트 띄우는 창 쪽에 ScriptRunner 작업 왔다갔다하면서 
--  값 입력하라는 입력 대화창 뜸


DECLARE
    -- 주요 변수 선언
    SEL NUMBER := &NUM;
    --            - → 『&』 : 위에 ACCPET 뒤에 나오는 임시 변수 값을
    --                         PL/SQL 안으로 가져옴 
    --                         NUMBER TYPE의 SEL 변수에 사용자 입력 NUM 값을 넣어줌
    RESULT VARCHAR2(10) := '남자';
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- 연산 및 처리
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다.');
        ELSE 
             DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '남자';
        WHEN 2
        THEN RESULT := '여자';
        ELSE
             RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || '입니다.');

END;


--※ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
--> 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할 때
-- 『&외부변수명』 형태로 접근하게 된다.


--○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--   이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.

ACCEPT NUM1 PROMPT '정수1 입력';
ACCEPT NUM2 PROMPT '정수2 입력';

DECLARE
    -- 주요 변수 선언
    NUM1    NUMBER := &NUM1;
    NUM2    NUMBER := &NUM2;
    RESULT  NUMBER := 0;
BEGIN
    -- 연산 및 처리
    RESULT := NUM1 + NUM2;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(NUM1 || ' + ' || NUM2 || ' = ' || RESULT);
END;
--==>> 25 + 47 = 72


--○ 사용자로부터 입력받은 금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
--   단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/
-- 나
ACCEPT MONEY PROMPT '금액 입력';

DECLARE
    -- 주요 변수 선언
    MONEY   NUMBER := &MONEY;
    RE500   NUMBER;
    RE100   NUMBER;
    RE50    NUMBER;
    RE10    NUMBER;
BEGIN
    -- 연산 및 처리
    RE500 := TRUNC(MONEY / 500);
    RE100 := TRUNC((MONEY - RE500*500) / 100);
    RE50  := TRUNC((MONEY - RE500*500 - RE100*100) / 50);
    RE10  := TRUNC((MONEY - RE500*500 - RE100*100 - RE50*50) / 10);
    
    -- 출력
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || RE500 || ', 백원 ' || RE100 
        || ', 오십원 ' || RE50 || ', 십원 ' || RE10);
    
END;
--==>>
/*
입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

-- 쌤
ACCEPT INPUT PROMPT '금액 입력';
DECLARE
    --○ 주요 변수 선언
    MONEY       NUMBER  := &INPUT;      -- 연산을 위해 입력값을 담아둘 변수
    MONEYBACKUP NUMBER  := &INPUT;      -- MONEY가 연산과정에서 값이 변하기 때문에
                                        -- MONEYBACKUP 에도 담아둠 (결과 출력 위해서)
    M500        NUMBER;                 -- 500원 짜리 개수를 담아둘 변수
    M100        NUMBER;                 -- 100원 짜리 개수를 담아둘 변수
    M50         NUMBER;                 --  50원 짜리 개수를 담아둘 변수
    M10         NUMBER;                 --  10원 짜리 개수를 담아둘 변수
BEGIN
    --○ 연산 및 처리
    -- 자바에서는 『/』 수행하면 나머지는 버리고, 정수의 몫만 취하지만
    -- ORACLE 에서는 소수점까지 나와서 정수로 얻고 싶으면 TRUNC() 해줘야 한다.
    
    -- MONEY 를 500으로 나눠서 몫을 취하고 나머지는 버린다. → 500원의 개수
    M500 := TRUNC(MONEY /500);
    
    -- MONEY 를 500으로 나눠서 몫은 버리고 나머지를 취한다. → 500원의 개수 확인하고 남은 금액
    MONEY := MOD(MONEY, 500);
    
    -- MONEY 를 100으로 나눠서 몫을 취하고 나머지는 버린다. → 100원의 개수
    M100 := TRUNC(MONEY / 100);
    
    -- MONEY 를 100으로 나눠서 몫은 버리고 나머지를 취한다. → 100원의 개수 확인하고 남은 금액
    MONEY := MOD(MONEY, 100);
    
    -- MONEY 를 50으로 나눠서 몫을 취하고 나머지는 버린다. → 50원의 개수
    M50 := TRUNC(MONEY / 50);
    
    -- MONEY 를 50으로 나눠서 몫은 버리고 나머지를 취한다. → 50원의 개수 확인하고 남은 금액
    MONEY := MOD(MONEY, 50);
    
    -- MONEY 를 10으로 나눠서 몫을 취하고 나머지는 버린다. → 10원의 개수   
    M10 := TRUNC(MONEY / 10);    
    
    --○ 결과 출력
    -- 취합된 결과(화폐단위별 개수)를 형식에 맞게 최종 출력한다.
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEYBACKUP || '원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || M500 || ', 백원 ' || M100 
        || ', 오십원 ' || M50 || ', 십원 ' || M10);
END;
--==>>
/*
입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/


-- 복습시에 나
ACCEPT MONEY PROMPT '금액 입력';

DECLARE
	MONEY	NUMBER	:= &MONEY;
	M500	NUMBER;
	M100	NUMBER;
	M50	NUMBER;
	M10	NUMBER;
BEGIN
	M500 := TRUNC(MONEY / 500);
	M100 := TRUNC( MOD(MONEY, 500) / 100 );
	M50  := TRUNC( MOD(MOD(MONEY, 500), 100) / 50 );
	M10  := TRUNC( MOD(MOD(MOD(MONEY, 500), 100), 50) / 10 );
	
	DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || MONEY || '원');
	DBMS_OUTPUT.PUT_LINE('화폐단위 : 오백원 ' || M500 || ', 백원 ' || M100 
        || ', 오십원 ' || M50 || ', 십원 ' || M10);
END;



--○ 기본 반복문
-- LOOP ~ END LOOP;

-- 1. 조건과 상관없이 무조건 반복하는 구문.

-- 2. 형식 및 구조
/*
LOOP
    -- 실행문
    
    EXIT WHEN 조건;   -- 조건이 참인 경우 반복문을 빠져나간다.
END LOOP;    
*/

-- 1 부터 10 까지의 수 출력 (LOOP 문 활용)
DECLARE
    N   NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        
        EXIT WHEN N >= 10;      -- 기본 LOOP 문은 빠져나갈 방법이 이것 밖에 없음
                                -- 『EXIT WHEN 조건』이 TRUE 면 빠져나감
        
        -- 자바에서는, N++; N+=1; 이런거 있지만, ORACLE 에는 없음
        N := N + 1;
    END LOOP;
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 구문을 사용한다.
--    조건은 반복이 시작되는 시점에 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 때 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP       -- 조건이 참인 경우 반복 수행
    -- 실행문
END LOOP;
*/

-- 1 부터 10 까지의 수 출력 (WHILE LOOP 문 활용)
DECLARE
    N NUMBER;
BEGIN
    N := 0;
    WHILE N < 10 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;  
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--○ FOR 반복문
-- FOR LOOP ~ END LOOP;

-- 1. 『시작수』에서 1씩 증가하여
--    『끝냄수』가 될 때까지 반복한다.

-- 2. 형식 및 구조
-- 자바에서 일반 FOR 문 생각하지말고,
-- 자바에서의 『향상된 FOR문』과 상당히 비슷하다고 생각하기!
/*
               거꾸로 돌 때    『..』도 문법임!!
              ---------        --
FOR 카운터 IN [REVERSE] 시작수 .. 끝남수 LOOP
    -- 실행문
END LOOP;
*/

-- 1 부터 10 까지의 수 출력(FOR LOOP 문 활용)
DECLARE
    N   NUMBER;
BEGIN
    FOR N IN 1 .. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;    
END;
--==>>
/*
1
2
3
4
5
6
7
8
9
10
*/


--○ 사용자로부터 임의의 단(구구단)을 입력받아
--   해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2

2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
    :
2 * 9 = 18    
*/

-- 1. LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';

DECLARE
    INPUT   NUMBER  := &INPUT;
    N       NUMBER;
BEGIN
    N := 0; 
    LOOP
        N := N + 1;   
        DBMS_OUTPUT.PUT_LINE(INPUT || ' * ' || N || ' = ' || (INPUT*N));   
        EXIT WHEN N >= 9;
    END LOOP;
END;
--==>>
/*
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
*/


-- 2. WHILE LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';

DECLARE
    INPUT   NUMBER := &INPUT;
    N       NUMBER;
BEGIN
    N := 0;    
    
    WHILE N < 9 LOOP
        N := N + 1;
        DBMS_OUTPUT.PUT_LINE(INPUT || ' * ' || N || ' = ' || (INPUT*N));
    END LOOP;
END;
--==>>
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
*/


-- 3. FOR LOOP 문의 경우
ACCEPT INPUT PROMPT '단을 입력하세요';

DECLARE
    INPUT   NUMBER := &INPUT;
    N       NUMBER;
BEGIN
    FOR N IN 1 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(INPUT || ' * ' || N || ' = ' || (INPUT*N));
    END LOOP;
END;
--==>>
/*
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36
*/


--○ 구구단 전체(2단 ~ 9단)를 출력하는 PL/SQL 구문을 작성한다.
--   단, 이중 반복문(반복문의 중첩) 구문을 활용한다.
/*
실행 예)

==[ 2단]==
2 * 1 = 2
    :
==[ 3단]==
    :  

9 * 9 = 81    
*/

-- 1. LOOP 문
DECLARE 
    I   NUMBER;
    J   NUMBER;
BEGIN
    I := 2;   
    LOOP
        EXIT WHEN I > 9;    -- 세미콜론도 꼭 찍고!!
        DBMS_OUTPUT.PUT_LINE('==[ ' || I || '단]==');
        
        J := 1;     -- 이거 위에 I랑 같이 써놔서 안됐었음
        LOOP
            EXIT WHEN J > 9;
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' || (I * J));
            J := J + 1;
        END LOOP;
        
        I := I + 1;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;


-- 2. WHILE LOOP 문
DECLARE
    I   NUMBER;
    J   NUMBER;
BEGIN
    I := 2;
    WHILE I <= 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || I || '단]==');
        
        J := 1;
        WHILE J <= 9 LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' || (I * J));
            J := J + 1;
        END LOOP;
        
        I := I + 1;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;


-- 3. FOR LOOP 문
DECLARE
    I   NUMBER;
    J   NUMBER;
BEGIN
    FOR I IN 2 .. 9 LOOP
        DBMS_OUTPUT.PUT_LINE('==[ ' || I || '단]==');
        
        FOR J IN 1 .. 9 LOOP
            DBMS_OUTPUT.PUT_LINE(I || ' * ' || J || ' = ' || (I * J));
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
--==>>
/*

==[ 2단]==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18

==[ 3단]==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27

==[ 4단]==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36

==[ 5단]==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45

==[ 6단]==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54

==[ 7단]==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63

==[ 8단]==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72

==[ 9단]==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81
*/


-- HR 로 이동

