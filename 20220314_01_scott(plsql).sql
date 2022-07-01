SELECT USER
FROM DUAL;
--==>> SCOTT


--++) 검색으로 찾음
--    오라클에서 조회 결과 없으면 아무 행도 출력되지 않는데
--    그런 상황에서 뭔가 값을 조회시키고자 한다면 
--    집계함수(COUNT, MAX, MIN, SUM, AVG)를 사용해 출력시키는 방법이 있다.


-- 내 풀이 
--○ TBL_출고 테이블에서 출고수량을 수정(변경)하는 프로시저를 작성한다.
--   프로시저 명 : PRC_출고_UPDATE()
-- 이전까지 만들었던 프로시저와 다른 점
--① 상품, 출고 테이블 다 UPDATE
--② 기존에 입고, 출고되던 수량 더하고 뺐는데
--   이전에 몇 개 출고했었는지 파악해서 연산에 포함시켜야 한다.
/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할수량);
*/

CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호	IN	TBL_출고.출고번호%TYPE
, V_변경할수량	IN	TBL_출고.출고수량%TYPE
)
IS
	V_출고번호확인	TBL_출고.출고번호%TYPE;
	V_기존출고수량	TBL_출고.출고수량%TYPE;
	V_상품코드	    TBL_상품.상품코드%TYPE;
	V_재고수량	    TBL_상품.재고수량%TYPE;

	출고번호_ERROR 	EXCEPTION;
	재고부족_ERROR	EXCEPTION;
BEGIN
	-- V_출고번호가 TBL_출고에 존재하는 존재하는 출고번호인지 확인
    -- 위에서 검색한 방법으로 집계함수 사용해 V_출고번호가 TBL_출고에 없을경우
    -- V_출고번호확인 에 -999 를 넣음 
	SELECT NVL(MAX(출고번호), -999) INTO V_출고번호확인
	FROM TBL_출고
	WHERE 출고번호 = V_출고번호;

	-- V_출고번호가 존재하지 않을 때 예외 발생
	IF (V_출고번호확인 = -999)
		THEN RAISE 출고번호_ERROR;
	END IF;

	-- V_기존출고수량 값 대입
	SELECT 출고수량 INTO V_기존출고수량
	FROM TBL_출고
	WHERE 출고번호 = V_출고번호;

	-- V_상품코드 값 대입
	SELECT 상품코드 INTO V_상품코드
	FROM TBL_출고
	WHERE 출고번호 = V_출고번호;

	-- V_재고수량 값 대입
	SELECT 재고수량 INTO V_재고수량
	FROM TBL_상품
	WHERE 상품코드 = V_상품코드;
	
	-- V_변경할수량 만큼 상품테이블에 V_재고수량+V_기존출고수량 있는지 확인
	IF (V_변경할수량 > V_재고수량 + V_기존출고수량)
		THEN RAISE 재고부족_ERROR;
	END IF;

	-- UPDATE 쿼리(TBL_출고)
	UPDATE TBL_출고
	SET 출고수량 = V_변경할수량
	WHERE 출고번호 = V_출고번호;

	-- UPDATE 쿼리(TBL_상품)
	UPDATE TBL_상품
	SET 재고수량 = 재고수량 + V_기존출고수량 - V_변경할수량
	WHERE 상품코드 = V_상품코드;

	-- 예외발생
	EXCEPTION
		WHEN 출고번호_ERROR
			THEN RAISE_APPLICATION_ERROR(-20003, '입력하신 출고번호가 존재하지 않습니다');
                 ROLLBACK;
		WHEN 재고부족_ERROR
			THEN RAISE_APPLICATION_ERROR(-20002, '재고가 부족합니다.');
                 ROLLBACK;
		WHEN OTHERS 
			THEN ROLLBACK;
	
	-- 커밋
	COMMIT;
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.

-- 20220314_02_scott.sql 로 가서 테스트 진행


-- 쌤 풀이
CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
(
    --① 매개변수 구성
  V_출고번호  IN  TBL_출고.출고번호%TYPE
, V_출고수량  IN  TBL_출고.출고수량%TYPE
)
IS
    --③ 필요한 변수 선언
    V_상품코드          TBL_상품.상품코드%TYPE;
    V_이전출고수량      TBL_출고.출고수량%TYPE;
    V_재고수량          TBL_상품.재고수량%TYPE;
    
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN

    -- ④ 선언한 변수에 값 담기 (V_상품코드)
    -- ⑥ 어차피 FROM, WHERE 절이 다 같으므로, 여기에 V_이전출고수량 추가로 얻어냄
    SELECT 상품코드, 출고수량 INTO V_상품코드, V_이전출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- ⑧ 출고 정상수행여부 판단 필요
    --    변경 이전의 출고수량 및 현재의 재고수량 확인
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- ⑨ 파악한 재고수량에 따라 데이터 변경 실시 여부 판단
    --    (『재고수량+이전출고수량 < 현재출고수량』 인 상황이라면... 사용자정의예외 발생 )
    IF (V_재고수량 + V_이전출고수량 < V_출고수량)
        -- 사용자정의 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    -- ② 수행될 쿼리문 체크(UPDATE → TBL_출고 / UPDATE → TBL_상품)
    UPDATE TBL_출고
    SET 출고수량 = V_출고수량
    WHERE 출고번호 = V_출고번호;
    
    -- ⑤
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_이전출고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- ⑩ 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고가 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- ⑦ 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.


-- 20220314_02_scott.sql 로 가서 테스트 진행
--------------------------------------------------------------------------------
-- Line 156 까지 작성하고 돌아옴

/*
1. PRC_입고_UPDATE(입고번호, 입고수량)
2. PRC_입고_DELETE(입고번호)
3. PRC_출고_DELETE(출고번호)
*/

-- 1. PRC_입고_UPDATE(입고번호, 입고수량)
/* 
1. 입고번호 유효한지 확인 → 없으면 에러발생

현재 재고수량 (변경할입고수량 - 기존입고했던 수량
현재 재고수량 - 기존재고 + 변경
------------------------------- 음수면 UPDATE 불가

2. UPDATE → TBL_입고, TBL_상품(재고수량+입고수량)
*/
CREATE OR REPLACE PROCEDURE PRC_입고_UPDATE
( V_입고번호          IN  TBL_입고.입고번호%TYPE
, V_변경할입고수량    IN  TBL_입고.입고수량%TYPE
)
IS
    V_입고번호확인    TBL_입고.입고번호%TYPE;
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_기존입고수량    TBL_입고.입고수량%TYPE;
    V_재고수량        TBL_상품.재고수량%TYPE;
    
    입고번호_ERROR    EXCEPTION;
    재고부족_ERROR    EXCEPTION;
BEGIN
    -- V_입고번호 존재 확인
    SELECT NVL(MAX(입고번호), -999) INTO V_입고번호확인
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- V_입고번호가 존재하지 않는다면 예외 발생
    IF (V_입고번호확인 = -999)
        THEN RAISE 입고번호_ERROR;
    END IF;

    -- V_상품코드, V_기존입고수량 값 대입
    SELECT 상품코드, 입고수량 INTO V_상품코드, V_기존입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- V_재고수량 값 대입
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- V_재고수량 - V_기존입고수량 + V_변경할입고수량
    --------------------------------------------------> 음수면 UPDATE 불가
    IF (V_재고수량 - V_기존입고수량 + V_변경할입고수량 < 0)
        THEN RAISE 재고부족_ERROR;
    END IF;
    
    -- UPDATE 쿼리문(TBL_입고)
    UPDATE TBL_입고
    SET 입고수량 = V_변경할입고수량
    WHERE 입고번호 = V_입고번호;
    
    -- UPDATE 쿼리문(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_기존입고수량 + V_변경할입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리
    EXCEPTION
        WHEN 입고번호_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '입력하신 입고번호가 존재하지 않습니다');
                 ROLLBACK;
        WHEN 재고부족_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고가 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS 
            THEN ROLLBACK;
    
    -- 커밋
    --COMMIT;
END;
--==>> Procedure PRC_입고_UPDATE이(가) 컴파일되었습니다.


-- 20220314_02_scott.sql 로 가서 테스트 진행
--------------------------------------------------------------------------------

-- 2. PRC_입고_DELETE(입고번호)
/*
1. 입고번호 유효한지 확인 → 없으면 에러발생
2. 현재 남아있는 재고수량보다 그 때 입고했던 수량이 많다면 삭제 불가
3. TBL_입고 DELETE
4. UPDATE TBL_상품 재고수량 - 입고수량 
*/
CREATE OR REPLACE PROCEDURE PRC_입고_DELETE
(
    V_입고번호  IN  TBL_입고.입고번호%TYPE
)
IS
    V_입고번호확인    TBL_입고.입고번호%TYPE;
    V_재고수량        TBL_상품.재고수량%TYPE;
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_입고수량        TBL_입고.입고수량%TYPE;
    
    입고번호_ERROR    EXCEPTION;
    재고부족_ERROR    EXCEPTION;
BEGIN
    -- V_입고번호 존재 확인
    SELECT NVL(MAX(입고번호), -999) INTO V_입고번호확인
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- V_입고번호가 존재하지 않는다면 예외 발생
    IF (V_입고번호확인 = -999)
        THEN RAISE 입고번호_ERROR;
    END IF;
    
    -- V_상품코드 값 대입
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- V_재고수량 값 대입
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- V_입고수량 값 대입
    SELECT 입고수량 INTO V_입고수량
    FROM TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- 현재 재고수량이 삭제할 입고수량만큼 있는지 확인 후, 없으면 예외 발생
    IF (V_재고수량 < V_입고수량)
        THEN RAISE 재고부족_ERROR;
    END IF;
    
    -- DELETE 쿼리문(TBL_입고)
    DELETE TBL_입고
    WHERE 입고번호 = V_입고번호;
    
    -- UPDATE 쿼리문(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리
    EXCEPTION
        WHEN 입고번호_ERROR
            THEN RAISE_APPLICATION_ERROR(-20004, '입력하신 입고번호가 존재하지 않습니다');
                 ROLLBACK;
        WHEN 재고부족_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고가 부족합니다.');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    -- 커밋
    --COMMIT;
END;
--==>> Procedure PRC_입고_DELETE이(가) 컴파일되었습니다.


-- 20220314_02_scott.sql 로 가서 테스트 진행
--------------------------------------------------------------------------------

-- 3. PRC_출고_DELETE(출고번호)
/*
1. 출고번호 유효한지 확인 → 없으면 에러발생
2. DELETE TBL_출고
3. UPDATE TBL_상품 재고수량 + 출고수량
*/
CREATE OR REPLACE PROCEDURE PRC_출고_DELETE
(
    V_출고번호  IN  TBL_출고.출고번호%TYPE
)
IS
    V_출고번호확인    TBL_출고.출고번호%TYPE;
    V_출고수량        TBL_출고.출고수량%TYPE;
    V_상품코드        TBL_상품.상품코드%TYPE;
    
    출고번호_ERROR    EXCEPTION;
BEGIN
    -- V_출고번호 존재 확인
    SELECT NVL(MAX(출고번호), -999) INTO V_출고번호확인
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- V_입고번호가 존재하지 않는다면 예외 발생
    IF (V_출고번호확인 = -999)
        THEN RAISE 출고번호_ERROR;
    END IF;
    
    -- V_출고수량, V_상품코드 값 대입
    SELECT 출고수량, 상품코드 INTO V_출고수량, V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    
    -- DELETE 쿼리문(TBL_출고)
    DELETE TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- UPDATE 쿼리문(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리
    EXCEPTION
        WHEN 출고번호_ERROR
            THEN RAISE_APPLICATION_ERROR(-20005, '입력하신 출고번호가 존재하지 않습니다');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    -- 커밋
    --COMMIT;

END;
--==>> Procedure PRC_출고_DELETE이(가) 컴파일되었습니다.


-- 20220314_02_scott.sql 로 가서 테스트 진행
--------------------------------------------------------------------------------
-- Line 313 까지 작성하고 돌아옴

--■■■ CURSOR(커서) ■■■--

-- 1. 오라클에서는 하나의 레코드가 아닌 여러 레코드로 구성된
--    작업 영역에서 SQL 문을 실행하고 그 과정에서 발생한 정보를
--    저장하기 위해 커서(CURSOR)를 사용하며,
--    커서에는 암시적인 커서와 명시적인 커서가 있다.

-- 2. 암시적 커서는 모든 SQL 구문에 존재하며 
--    SQL 문 실행 후 오직 하나의 행(ROW)만 출력하게 된다.
--    그러나 SQL 문을 실행한 결과물(RESULT SET)이
--    여러 행(ROW)으로 구성된 경우
--    커서(CURSOR)를 명시적으로 선언해야 여러 행(ROW)을 다룰 수 있다.


--○ 커서 이용 전 상황(단일 행 접근 시)
SET SERVEROUTPUT ON;
--==>> 작업이 완료되었습니다.(0.045초)

DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA
    WHERE NUM = 1001;   -- 이거 없애면 다중문처리 됨
                        -- BUT, 여기서 지금 없애면 에러 발생함
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>> 홍길동 -- 011-2356-4528


DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
BEGIN
    SELECT NAME, TEL INTO V_NAME, V_TEL
    FROM TBL_INSA;
    
    DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
END;
--==>> 에러 발생
--     (ORA-01422: exact fetch returns more than requested number of rows)


--○ 커서 이용 전 상황(다중 행 접근 시 - 반복문 활용)
DECLARE
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    V_NUM   TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL INTO V_NAME, V_TEL
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
        V_NUM := V_NUM + 1;
        
        EXIT WHEN V_NUM >= 1061;

    END LOOP;
END;
--==>>
/*
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
이순애 -- 010-4231-1236
김정훈 -- 019-5236-4221
한석봉 -- 018-5211-3542
이기자 -- 010-3214-5357
장인철 -- 011-2345-2525
김영년 -- 016-2222-4444
나윤균 -- 019-1111-2222
김종서 -- 011-3214-5555
유관순 -- 010-8888-4422
정한국 -- 018-2222-4242
조미숙 -- 019-6666-4444
황진이 -- 010-3214-5467
이현숙 -- 016-2548-3365
이상헌 -- 010-4526-1234
엄용수 -- 010-3254-2542
이성길 -- 018-1333-3333
박문수 -- 017-4747-4848
유영희 -- 011-9595-8585
홍길남 -- 011-9999-7575
이영숙 -- 017-5214-5282
김인수 -- 
김말자 -- 011-5248-7789
우재옥 -- 010-4563-2587
김숙남 -- 010-2112-5225
김영길 -- 019-8523-1478
이남신 -- 016-1818-4848
김말숙 -- 016-3535-3636
정정해 -- 019-6564-6752
지재환 -- 019-5552-7511
심심해 -- 016-8888-7474
김미나 -- 011-2444-4444
이정석 -- 011-3697-7412
정영희 -- 
이재영 -- 011-9999-9999
최석규 -- 011-7777-7777
손인수 -- 010-6542-7412
고순정 -- 010-2587-7895
박세열 -- 016-4444-7777
문길수 -- 016-4444-5555
채정희 -- 011-5125-5511
양미옥 -- 016-8548-6547
지수환 -- 011-5555-7548
홍원신 -- 011-7777-7777
허경운 -- 017-3333-3333
산마루 -- 018-0505-0505
이기상 -- 
이미성 -- 010-6654-8854
이미인 -- 011-8585-5252
권영미 -- 011-5555-7548
권옥경 -- 010-3644-5577
김싱식 -- 011-7585-7474
정상호 -- 016-1919-4242
정한나 -- 016-2424-4242
전용재 -- 010-7549-8654
이미경 -- 016-6542-7546
김신제 -- 010-2415-5444
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444
*/

/*
일반변수 → 선언
예외변수 → 선언
커서     → 정의

변수는 선언할 때,
『선언』
변수명 타입
예외변수명 타입
커서명 CURSOR (Ⅹ)
→ 이런 형태를 사용하는데

『커서는 정의한다』 고 표현하는 이유가
『정의』
TABLE 테이블명
INDEX 인덱스명
USER 사용자명
CURSOR 커서명 (○)
→ 뒤에 있는 이름이 TABLE이야, INDEX야, USER야 라는 형태로
   변수 선언과 반대의 형태
   
커서 → 놀래켜주는 깜짝상자 생각하면 됨
        그 상자 안에 차곡차곡 넣어두는거
        사용하려면 → 상자 오픈(커서 오픈) 해줘야 함
        쓰고 나서 꾹 눌러서 상자 닫아야 다시 열어서 깜짝상자 사용 가능
        → 커서도 다 쓰고 CLOSE 해 줘야 또 쓸 수 있다!!
*/
--○ 커서 이용 후 상황
DECLARE
    -- 주요 변수 선언
    V_NAME  TBL_INSA.NAME%TYPE;
    V_TEL   TBL_INSA.TEL%TYPE;
    
    -- 예외도 변수를 선언했듯이, 커서도 그래야 한다.
    -- 커서는 변수를 선언한다고 하지 않고, 정의한다고 한다.
    -- 커서 이용을 위한 커서 정의                              CHECK~!!!
    -- 『IS』 키워드 통해서 커서 정의해줌
    CURSOR CUR_INSA_SELECT
    IS
    SELECT NAME, TEL
    FROM TBL_INSA;
BEGIN
    -- 커서 오픈
    OPEN CUR_INSA_SELECT;
    
    -- 커서 오픈 시 쏟아져나오는 데이터들 처리(반복문을 활용하여 처리)
    -- FETCH : V) 가지고오다 → 데이터 하나하나 가져오는 거 생각하면 됨
    LOOP
        -- 한 행 한 행 받아다가 처리하는 행위 → 가져오다(데러오다) → 『FETCH』
        FETCH CUR_INSA_SELECT INTO V_NAME, V_TEL;
        -- CUR_INSA_SELECT 로 부터 쏟아져나오는 데이터를 V_NAME, V_TEL 로 가져오겠다.
        
        -- 반복하다보면 남아있는 데이터가 없는 상태가 될 것이다.
        -- 커서에서 더 이상 데이터가 쏟아져 나오지 않는 상태
        -- → CURSOR 『NOTFOUND』 상태라고 함
        EXIT WHEN CUR_INSA_SELECT%NOTFOUND;
                --------------------------
                -- 커서의 상태를 살펴보는데, NOTFOUND 상태이면 그거 참조해옴
                
        -- NOTFOUND 상태가 되기 전까지는 가져온 데이터를 출력해줘야함
        -- 출력
        DBMS_OUTPUT.PUT_LINE(V_NAME || ' -- ' || V_TEL);
        
    END LOOP;
    
    -- 커서 클로즈
    CLOSE CUR_INSA_SELECT;
    
END;
--==>>
/*
양윤정 -- 010-8624-4533
홍길동 -- 011-2356-4528
이순신 -- 010-4758-6532
이순애 -- 010-4231-1236
김정훈 -- 019-5236-4221
한석봉 -- 018-5211-3542
이기자 -- 010-3214-5357
장인철 -- 011-2345-2525
김영년 -- 016-2222-4444
나윤균 -- 019-1111-2222
김종서 -- 011-3214-5555
유관순 -- 010-8888-4422
정한국 -- 018-2222-4242
조미숙 -- 019-6666-4444
황진이 -- 010-3214-5467
이현숙 -- 016-2548-3365
이상헌 -- 010-4526-1234
엄용수 -- 010-3254-2542
이성길 -- 018-1333-3333
박문수 -- 017-4747-4848
유영희 -- 011-9595-8585
홍길남 -- 011-9999-7575
이영숙 -- 017-5214-5282
김인수 -- 
김말자 -- 011-5248-7789
우재옥 -- 010-4563-2587
김숙남 -- 010-2112-5225
김영길 -- 019-8523-1478
이남신 -- 016-1818-4848
김말숙 -- 016-3535-3636
정정해 -- 019-6564-6752
지재환 -- 019-5552-7511
심심해 -- 016-8888-7474
김미나 -- 011-2444-4444
이정석 -- 011-3697-7412
정영희 -- 
이재영 -- 011-9999-9999
최석규 -- 011-7777-7777
손인수 -- 010-6542-7412
고순정 -- 010-2587-7895
박세열 -- 016-4444-7777
문길수 -- 016-4444-5555
채정희 -- 011-5125-5511
양미옥 -- 016-8548-6547
지수환 -- 011-5555-7548
홍원신 -- 011-7777-7777
허경운 -- 017-3333-3333
산마루 -- 018-0505-0505
이기상 -- 
이미성 -- 010-6654-8854
이미인 -- 011-8585-5252
권영미 -- 011-5555-7548
권옥경 -- 010-3644-5577
김싱식 -- 011-7585-7474
정상호 -- 016-1919-4242
정한나 -- 016-2424-4242
전용재 -- 010-7549-8654
이미경 -- 016-6542-7546
김신제 -- 010-2415-5444
임수봉 -- 011-4151-4154
김신애 -- 011-4151-4444
*/
-- ** 커서 사용하고 나니
--    - 번호가 시리얼화 되어 있지 않아도 처리 가능하다.
--      (중간에 비워져 있어도 상관없음)
--    - 시작 번호를 몰라도, 끝 번호를 몰라도 처리 가능하다.  **

-- 참고) 나중에 JDBC 배울 때, 
--       ORACLE에서 제공하는 CURSOR는 사용법 조금 다름


--------------------------------------------------------------------------------

--■■■ TRIGGER(트리거) ■■■--
-- 영화에서 보면 금고에 붙여놓는 폭탄 같은 거
-- 장착해서 써야 한다.
-- 시퀀스가 테이블 안에 붙어 있는 게 아닌 것 처럼
-- 트리거도 특정 테이블에 의존적인 형태로 만들어지는 것이 아니다.
-- 시퀀스 따로, 테이블 따로. 인 것 처럼
-- 트리거 따로, 테이블 따로.


-- 사전적인 의미 : 방아쇠. 촉발시키다. 야기하다. 유발하다.

-- 1. TRIGGER(트리거)란 DML 작업(즉, INSERT, UPDATE, DELETE)이 일어날 때
--    자동적으로 실행되는(유발되는, 촉발되는) 객체로
--    이와 같은 특징을 강조하여 DML TRIGGER 라고 부르기도 한다.
--    TRIGGER 는 무결성 뿐 아니라
--    다음과 같은 작업에도 널리 사용된다.

-- 자동으로 파생된 열 값 생성
    --ex) 담임쌤이 자리비우면서 반장 앞으로 불러놓고, 떠든 사람 이름 적으라고 하는거
    --    담임쌤 와서 보면 칠판에 자동으로 이름 적혀있는 거
-- 잘못된 트랜잭션 방지
-- 복잡한 보안 권한 강제 수행
    --ex) 주식/쇼핑하는 사람 워낙 많다보니, 
    --    회사에서 근무시간에는 못하게 업무시간 내에 주식/쇼핑 사이트 못들어가게 해놓음
    --    '우리 회사는 점심시간에만 주식/쇼핑 사이트가 들어가져' 이런 거
    --ex) '이 테이블에 insert, update, delete 는 업무시간 내에만 가능해!' 이런 거
-- 분산 데이터베이스 노드 상에서 참조 무결성 강제 수행
    --ex) EMP 테이블은 내 컴퓨터에 있는데, DEPT 테이블은 대전에 있는 오라클에 있음
    --    대전에 있는 오라클 DB랑 서울에 있는 오라클 DB랑 다름
    --    서울에 있는 EMP 테이블에 부서번호 입력하려고 할 때, 대전에 있는 DEPT 테이블과 참조관계 안됨
    --    그럴 때는 INSERT 쿼리문 돌아갈 때마다 부서번호 DEPT 안에 있는 건지 확인시키면서 하는거
-- 복잡한 업무 규칙 강제 적용 (위에 4가지 다 포함된 말)
-- 투명한 이벤트 로깅 제공
    --로그: ex) 예전 중세시대에 성 주변으로 땅파서 물 넣어놓음.(외부침입 막기위해)
    --          우리 성 사람 들어오면 성문 드드득 해서 열어서 다리로 만들어서 건너게 해줌
    --          그 성문 → 로그
    --          거기 들락날락 하는 걸 기록으로 남김 → 로그기록(출입기록)
    -- 이벤트 로그 : 어떤 이벤트가 벌어졌을 때, 그거 하나하나 남기는 거
-- 복잡한 감사 제공
-- 동기 테이블 복제 유지관리
-- 테이블 액세스 통계 수집 (투명한 이벤트 로깅, 복잡한 감사 제공과 같은 의미)


-- 2. TIRGGER(트리거) 내에서는 COMMIT, ROLLBACK 문을 사용할 수 없다.
--    왜? INSERT, DELETE, UPDATE 구문이 벌어졌을 때 어떻게 처리해라 
--    → 이런게 트리거기 때문에
-- PROCEDURE는 사용자가 직접 DML구문을 쓰지 않으니까 COMMIT, ROLLBACK 사용하는거
-- TRIGGER  는 DML 구문을 사용자가 직접 씀. 사용자가 모르는 사이에 TIRGGER 를 건드리고 다니는 거


-- 3. 특징 및 종류
--    - BEFORE STATEMENT
--    - BEFORE ROW
--    - AFTER STATEMENT
--    - AFTER ROW
-- ex) 
--     BEFORE / AFTER
--     아까 말한 떠든사람 이름 적는 거 → 떠든 후에 이름 적는 거니까 → AFTER
--     업무시간에만 테이블에 INSERT 하게 하는거 
--     → INSERT 한 후에 막으면 안 되고, INSERT 하기 전에 미리 막아야 하는 거 → BEFORE
--     STATEMENT / ROW
--     그 문장에 대해서만 처리 → STATEMENT TRIGGER
--     모든 테이블을 다 훑어보면서 각각의 행들을 다 검토해야 되는거면 → ROW TRIGGER


-- 4. 형식 및 구조
/*
CREATE [OR REPLACE] TRIGGER 트리거명
    [BEFORE | AFTER]
    이벤트1 [OR 이벤트2 [OR 이벤트3]] ON 테이블명
    [FOR EACH ROW [WHEN TRIGGER 조건]]
[DECLARE]
    -- 선언 구문;
BEGIN
    -- 실행 구문;
END;
*/

--------------------------------------------------------------------------------

--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업에 대한 이벤트 기록을 남길 때 주로 사용한다.

-- 20220314_02_scott.sql 로 가서 실습 환경 마련
-- Line 364 까지 작성하고 돌아옴

--○ TRIGGER(트리거 생성) → TRG_EVENTLOG
CREATE OR REPLACE TRIGGER TRG_EVENTLOG
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_TEST1     -- 감시대상이 되는게 ON 뒤에 테이블이름!!
    -- TBL_TEST1 에 INSERT나 UPDATE나 DELETE 가 일어나면
    -- 그 후에 수행하는 TRIGGER
--DECLARE   → 추가로 선언할 거 없기 때문에 DECLARE 생략함
BEGIN
    -- 이벤트 종류 구문(조건문을 통한 분기)
    -- INSERTING, UPDATING, DELETING 용어는 기본적으로 정의되어 있는 것
    IF (INSERTING)  -- INSERT 일어났을 때
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('INSERT 쿼리가 실행되었습니다.');
    ELSIF (UPDATING) -- UPDATE 일어났을 때
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('UPDATE 쿼리가 실행되었습니다.');
    ELSIF (DELETING) -- DELETE 일어났을 때
        THEN INSERT INTO TBL_EVENTLOG(MEMO)
            VALUES('DELETE 쿼리가 실행되었습니다.');
    END IF;
    
    -- COMMIT;
    -- ※ TRIGGER 내에서는 COMMIT / ROLLBACK 구문 사용 불가~!!!  CHECK~!!!
END;
--==>> Trigger TRG_EVENTLOG이(가) 컴파일되었습니다.


-- 20220314_02_scott.sql 로 가서 테스트 진행
-- Line 445 까지 작성하고 돌아옴


--------------------------------------------------------------------------------

--■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업 수행 전에 작업에 대한 가능 여부 확인
--    시간 제한, 계정 제한, 상태 제한이 있는 상황에서 
--    DML 작업을 수행할 수 있게 해주냐, 못하게하느냐 처리해주는 거

--○ TRIGGER(트리거 생성) → TRG_TEST1_DML
-- 작업 시간이 오전 9시 이전이나, 오후 6시 이후
-- 즉, 근무시간이 아닌 경우에는 DML 구문 수행 못하게 처리할 거임
CREATE OR REPLACE TRIGGER TRG_TEST1_DML
    BEFORE      
    INSERT OR UPDATE OR DELETE ON TBL_TEST1     -- 감시대상이 되는게 ON 뒤에 테이블이름!!
    -- INSERT/UPDATE/DELETE 가 일어났을 때 그 구문에 대해서 이루어져야 하기 때문에 
    -- → STATEMENT
    -- STATEMENT TRIGGER의 경우에는 STATEMENT 라고 명시 안함
--DECLARE
    -- 보통 트리거 만들 때 변수 선언해서 구성하는 경우 별로 없음
    -- 그럴 때는 그냥 DECLARE 생략하면 됨
BEGIN
    -- 만약, INSERT/DELETE/UPDATE 일어났는데, 작업이 일어난 시간이
    -- 오전 9시 이전이거나, 오후 6시 이후라면 → 작업 수행하지 못하도록 처리
                          --------------- > 18 로 하면 오후 6시 10분, 20분이어도 처리가능해짐!
    IF (TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) < 9 OR TO_NUMBER(TO_CHAR(SYSDATE, 'HH24')) > 17)
        -- 작업처리하지 못하게 하겠다.
        -- → 이런 상황이라면 사용자 정의 예외 발생시킬 수 있도록 하겠다.
        -- 예외는 선언부에서 미리 선언해놓고 쓸 수도 있지만 아래처럼 쓸 수도 있다.
        THEN RAISE_APPLICATION_ERROR(-20003, '작업은 09:00 ~ 18:00 까지만 가능합니다.');
        -- → '예외를 만들어줄테니 그걸 따로 처리해라' 가 아니라
        --    예외상황인거 사용자에게 알려 !
        
    END IF;
END;
--==>> Trigger TRG_TEST1_DML이(가) 컴파일되었습니다.
-- 여기서의 시간은 클라이언트의 시간이 아니라, 오라클 서버의 시간이다!


-- 20220314_02_scott.sql 로 가서 테스트 진행

-- 20220314_02_scott.sql 에 다음 실습 환경 마련
-- Line 625 까지 작성하고 돌아옴

--------------------------------------------------------------------------------

--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■--
-- ※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

-- 트리거 만들고 나면,
-- 1번 레코드 지우려고 할 때, 에러가 발생하는 게 아니라
-- 자식 테이블에서 1번을 참조하고 있는 애들을 찾아서 한 행 한 행 제거함
-- 1번 참조하고 있는 것만 싹 다 제거하고 나면, 부모 테이블의 1번도 지울 수 있게 된다.
-- → 부모테이블의 1번 지우는 거 실행한게 10시라면,
--    9시 50분에 자식한테 가서 1번 참조하고 있는 자식들 
--    먼저 다 지워놓으면 부모테이블의 1번 다 지워짐

-- 부모 테이블의 2번 냉장고 지우겠다고 했을 때,
-- 자식 테이블의 나머지는 PASS 하고, 5, 7, 8, 9는 냉장고 참조하고 있으니까 삭제하면
-- 부모 테이블의 2번 냉장고 제거된다.

-- 부모 테이블의 2번 냉장고 지우겠다고 하는 거 실행한다고 하기 전에,
-- 먼저 실행되어야 하기 때문에 !! → 『BEFORE』
-- 한 행 한 행 다 보면서 참조하고 있는지 확인해야 함 → 『ROW TRIGGER』


--○ TRIGGER(트리거 생성) → TRG_TEST2_DELETE
CREATE OR REPLACE TRIGGER TRG_TEST2_DELETE
    -- 부모 테이블에서 삭제 이벤트 발생했을 때, 먼저 실행
    BEFORE
    DELETE ON TBL_TEST2
    -- ROW TRIGGER 로 작동해야 할 때는 『FOR EACH ROW』 옵션이 들어가야 한다!!
    -- 저 옵션이 들어가야 ROW TRIGGER
    FOR EACH ROW    -- 각각의 행에 대해서 처리
BEGIN
    -- 부모 테이블에서 삭제한다고 했을 때,
    -- 그 행을 참조하고 있는 자식의 행 삭제해줘야 한다.
    -- CODE가 뭐 인걸 삭제해줘야 할까?
    -- 10시에 DELETE 구문 수행했을 때, 시간 멈추라고 했음
    -- DELETE 쿼리가 10시에 제대로 수행된 거라면, 그 전에 자식 테이블이 다 제거되었다는 거임
    -- 그거보다 과거로 가서 자식을 제거해줘야 한다. 
    -- → 『:OLD』 → 현재 시점에서 과거로 가서 어떤 코드인지 확인하고 오는 것!
    DELETE
    FROM TBL_TEST3
    WHERE CODE = :OLD.CODE;
    -- 자식테이블에서 삭제할 자료의 코드를 가져와서 그걸 먼저 DELETE 하고
    -- 부모테이블에서 DELETE 수행
END;
--==>> Trigger TRG_TEST2_DELETE이(가) 컴파일되었습니다.


--※ 『:OLD』
--   참조 전 열의 값
--   (INSERT 할 때 → 입력하기 이전 자료, 
--    DELETE 할 때 → 삭제하기 이전 자료 즉, 삭제할 자료) 로 이해하면 된다.

-- 오라클 내부로 사실 UPDATE 구문이 존재하지 않는다.
--※ UPDATE : 내부적으로는 DELETE 그리고 INSERT 가 결합된 형태
--            UPDATE 하기 이전의 데이터는 『:OLD』
--            UPDATE 수행한 이후의 데이터는 『:NEW』



-- 20220314_02_scott.sql 로 가서 테스트 진행

--------------------------------------------------------------------------------
-- Line 740 까지 작성하고 돌아옴

--■■■ AFTER ROW TRIGGER 상황 실습 ■■■--
-- ※ 참조 테이블 관련 트랜잭션 처리

-- TBL_입고, TBL_상품, TBL_출고
-- 현재 상품테이블에 재고가 0개이까 출고 못하겠네? 가 아니라
-- 단순 산술적인 트랜잭션 처리이다.
-- 현재 재고수량 0인 상태에서
-- 출고테이블에 바밤바 10개 INSERT 시켜버리면
-- 상품테이블에 바밤바 재고수량 -10 되는거


--○ TBL_입고 테이블의 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
--   트리거 명 : TRG_IBGO
--> 입고가 된 다음에 재고 증가되게 처리 → AFTER TRIGGER
CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER 
    INSERT ON TBL_입고
    -- 어떤 상품이 입고되느냐에 따라 각각의 행 다 확인해봐야 한다. → ROW TRIGGER(행 트리거)
    FOR EACH ROW
BEGIN
    -- IF 없이 그냥 INSERT 쿼리해도 상관 없기는 하지만 일단 이거 먼저보기
    -- 트리거 이름에서도 TRG_INBO_INSERT 로 안했음
    -- 나중에 우리가 수정할 거임. 같은 이름으로!
    -- INSERT 될 데이터면 → 『:NEW』 에 있다고 했음
    IF (INSERTING)
        THEN UPDATE TBL_상품
             --SET 재고수량 = 재고수량 + 새로입고되는입고수량
             SET 재고수량 = 재고수량 + :NEW.입고수량
             --WHERE 상품코드 = 새로입고되는상품코드;
             WHERE 상품코드 = :NEW.상품코드;
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.    
    
    
-- 20220314_02_scott.sql 로 가서 테스트 진행
-- Line 791 까지 작성하고 돌아옴


--○ TBL_입고 테이블의 데이터 입력, 수정, 삭제 시
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
--   트리거 명 : TRG_IBGO
CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_입고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.

-- 20220314_02_scott.sql 로 가서 테스트 진행    


