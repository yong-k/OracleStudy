
--------------------------------------------------------------------------------

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


--------------------------------------------------------------------------------
