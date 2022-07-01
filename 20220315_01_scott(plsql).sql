SELECT USER
FROM DUAL;
--==>> SCOTT

--------------------------------------------------------------------------------

--■■■ AFTER ROW TRIGGER 상황 실습 ■■■--
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
             -- 여기서는 :NEW로하던지, :OLD로 하던지 다 된다.
             -- 상품코드를 UPDATE 시키는 게 아니기 때문에
             -- ex) 상품코드 참조할 때 TBL_상품에서 하든, TBL_입고에서 하든지 다 되듯이
             -- BUT, 그 상황에서 부모테이블의 타입을 참조하는 게 더 좋다고 했던 것 처럼,
             -- 여기서도,
             -- 예전거를 찾아서 UPDATE 시켜줘야 하기 때문에 
             -- 『:OLD.상품코드』가 더 옳은 표현이다.
             --WHERE 상품코드 = :NEW.상품코드;
             WHERE 상품코드 = :OLD.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.


-- 20220315_02_scott.sql 로 가서 테스트 진행    
-- Line 112 까지 작성하고 돌아옴

--------------------------------------------------------------------------------

--○ TBL_출고 테이블의 데이터 입력, 수정, 삭제 시
--   TBL_상품 테이블의 재고수량 변동 트리거 작성
--   트리거 명 : TRG_CHULGO

CREATE OR REPLACE TRIGGER TRG_CHULGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_출고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량 - :NEW.출고수량
             WHERE 상품코드 = :OLD.상품코드;
    ELSIF (DELETING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;
--==>> Trigger TRG_CHULGO이(가) 컴파일되었습니다.


-- 20220315_02_scott.sql 로 가서 테스트 진행
-- Line 228 까지 작성하고 돌아옴

--------------------------------------------------------------------------------

--■■■ PACKAGE(패키지) ■■■--

-- 1. PL/SQL 의 패키지는 관계되는 타입, 프로그램 객체,
--    서브 프로그램(PROCEDURE, FUNCTION 등)을
--    논리적으로 묶어놓은 것으로
--    오라클에서 제공하는 패키지 중 하나가 바로 『DBMS_OUTPUT』 이다.

-- 2. 패키지는 서로 유사한 업무에 사용되는 여러 개의 프로시저와 함수를
--    하나의 패키지로 만들어 관리함으로써 향후 유지보수가 편리하고
--    전체 프로그램을 모듈화 할 수 있다는 장점이 있다.

-- 3. 패키지는 명세부(PACKAGE SPECIFICATION)와
--    몸체부(PACKAGE BODY)로 구성되어 있으며
--    명세 부분에는 TYPE, CONSTRAINT, VARIABLE, EXCEPTION, CURSOR, SUBPROGRAM 이 선언되고
--    몸체 부분에는 이들의 실제 내용이 존재한다.
--    그리고, 호출할 때에는 『패키지명.프로시저명』 형식의 참조를 이용해야 한다.


-- 특이사항: 명세부와 몸체부를 따로 만든다.
-- 명세부와 몸체부가 싱크가 맞아야 함
-- 명세부에 함수 5개 있다고 적어놨으면, 몸체부에 함수 5개 있어야 한다.
-- 4. 형식 및 구조(명세부)
--    → 이 안에 뭐 들어있는지 외부에 노출시켜 놓는 것
/*
CREATE [OR REPLACE] PACKAGE 패키지명
IS
    전역변수 선언;
    커서 선언;
    예외 선언;
    함수 선언;
    프로시저 선언;
        :
END 패키지명;
*/

-- 5. 형식 및 구조(몸체부)
/*
CREATE [OR REPLACE] PACKAGE BODY 패키지명
IS
    FUNCTION 함수명[(인수, ...)]
    RETURN 자료형
    IS
        변수 선언;
    BEGIN
        함수 몸체 구성 코드;
        RETURN 값;
    END;
    
    PROCEDURE 프로시저명[(인수, ...)]
    IS
        변수 선언;
    BEGIN
        프로시저 몸체 구성 코드;
    END;
END 패키지명;
*/


-- 패키지 등록 실습
-- TBL_INSA 로 주민번호 확인해서 성별 구하는 함수를 패키지 안에 넣을거임

--① 명세부 작성
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
    
END INSA_PACK;
-- 『END 패키지명;』 까먹지 말기!!
--==>> Package INSA_PACK이(가) 컴파일되었습니다.


--② 몸체부 작성 → 명세부와 패키지 이름이 같아야 한다! 
--                  가급적이면 명세부에서 작성한거 복붙해서 쓰기(다르면 안되니까)
--               → 몸체부에는 『BODY』 키워드가 들어간다.
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT    VARCHAR2(20);
    BEGIN
        IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3') )
            THEN V_RESULT := '남자';
        ELSIF ( SUBSTR(V_SSN, 8, 1) IN ('2', '4') ) 
            THEN V_RESULT := '여자';
        ELSE
            V_RESULT := '확인불가';
        END IF;
    
        RETURN V_RESULT;
    END;
    
END INSA_PACK;
--==>> Package Body INSA_PACK이(가) 컴파일되었습니다.


-- 20220315_02_scott.sql 로 가서 테스트 진행


