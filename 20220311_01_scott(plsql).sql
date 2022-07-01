SELECT USER
FROM DUAL;
--==>> SCOTT

DESC TBL_INSA;
SELECT *
FROM TBL_INSA;
--○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--   NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG 으로 구성된 컬럼 중
--   NUM 을 제외한 NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG 의 데이터 입력 시, 
--   NUM 컬럼(사원번호)의 값은 
--   기존 부여된 사원 번호의 마지막 번호 그 다음 번호를 자동으로 입력 처리할 수 있는 프로시저로 구성한다.
--   프로시저 명 : PRC_INSA_INSERT()
/*
실행 예)
EXEC PRC_INSA_INSERT('양윤정', '970131-2234567', SYSDATE, '서울', '010-8624-4533'
                    , '개발부', '대리', 2000000, 2000000);
                    
프로시저 호출로 처리된 결과
1061 양윤정  970131-2234567  2022-03-11  서울  010-8624-4533 개발부 대리 2000000  2000000
의 데이터가 신규 입력된 상황
*/

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( V_NAME      IN  TBL_INSA.NAME%TYPE
, V_SSN       IN  TBL_INSA.SSN%TYPE
, V_IBSADATE  IN  TBL_INSA.IBSADATE%TYPE
, V_CITY      IN  TBL_INSA.CITY%TYPE
, V_TEL       IN  TBL_INSA.TEL%TYPE
, V_BUSEO     IN  TBL_INSA.BUSEO%TYPE
, V_JIKWI     IN  TBL_INSA.JIKWI%TYPE
, V_BASICPAY  IN  TBL_INSA.BASICPAY%TYPE
, V_SUDANG    IN  TBL_INSA.SUDANG%TYPE
)
IS
    V_NUM   TBL_INSA.NUM%TYPE;
BEGIN
    -- 잘못했던거
    /*
    V_NUM := (SELECT MAX(NUM) + 1
              FROM TBL_INSA);
    */
    --※ MAX(), MIN(), SUM(), COUNT() 이런 집계합수들은 NULL 을 제외하고 연산한다.
    
    --※ 해당 테이블에 데이터를 다 삭자해서 데이터가 하나도 없더라도, 
    --   현재는 그 테이블에 NULL 인 데이터가 없더라도 나중에 추가됐을 때
    --   PROCEDURE 잘 실행될 수 있도록 프로그램 짜야한다!!
    
    SELECT MAX(NVL(NUM, 0)) + 1 INTO V_NUM  -- 쿼리문 값 변수에 넣으려면 『INTO』 !!
    FROM TBL_INSA;   
              
    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES(V_NUM, V_NAME, V_SSN, V_IBSADATE, V_CITY, V_TEL, V_BUSEO, V_JIKWI, V_BASICPAY, V_SUDANG);
         
    COMMIT;         
    
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.


-- 20220311_02_scott.sql 로 가서 테스트 진행
-- Line 139 까지 작성하고 돌아옴


--○ TBL_상품, TBL_입고 테이블을 대상으로
--   TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진 프로시저를 작성한다.
--   단, 이 과정에서 입고번호는 자동 증가 처리한다. (시퀀스 사용 X)
--   TBL_입고 테이블 구성 컬럼
--   : 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--   프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)

-- EXEC PRC_입고_INSERT('H001', 30, 400);
-- → 입고테이블의 데이터 입력(프로시저 매개변수로 전달받지 못한 나머지 값 → 자동 입력)
-- → 상품테이블의 바밤바 재고수량 30개가 되어야 한다.

-- 나
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( V_상품코드  IN  TBL_입고.상품코드%TYPE
    -- → 가급적이면 중복된 컬럼에서 컬럼값 쓸 때, 부모테이블 거 쓰자고 했다!
, V_입고수량  IN  TBL_입고.입고수량%TYPE
, V_입고단가  IN  TBL_입고.입고단가%TYPE
)
IS
    V_입고번호  TBL_입고.입고번호%TYPE := 0;
    --V_입고일자  TBL_입고.입고일자%TYPE;
BEGIN
    V_입고번호 := V_입고번호 + 1;
    -- 이렇게 하면 이 프로시저 사용해서 INSERT 안하고 
    -- 그냥 사용자가 INSERT 구문 써서 입고번호 추가한 경우를 고려 못한다....
    
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
    VALUES(V_입고번호, V_상품코드, DEFAULT, V_입고수량, V_입고단가);
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    COMMIT;
END;
--==> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


-- 쌤
CREATE OR REPLACE PROCEDURE PRC_입고_INSERT
( --V_상품코드  IN  TBL_입고.상품코드%TYPE
  -- → 가급적이면 중복된 컬럼에서 컬럼값 쓸 때, 부모테이블 거 쓰자고 했다!
  V_상품코드  IN  TBL_상품.상품코드%TYPE
, V_입고수량  IN  TBL_입고.입고수량%TYPE
, V_입고단가  IN  TBL_입고.입고단가%TYPE
)
IS
    -- 선언부
    -- 아래의 쿼리문을 수행하기 위해 필요한 변수 추가 선언
    V_입고번호  TBL_입고.입고번호%TYPE;
BEGIN
    -- 선언한 변수에 값 담아내기
    -- SELECT 쿼리문 수행
    SELECT NVL(MAX(입고번호), 0) INTO V_입고번호
    FROM TBL_입고;
    
    -- INSERT 쿼리문 수행
    -- 입고일자는 SYSDATE 라고 해도 되고, 입력항목에서 아예 빼도 됨
    -- DEFAULT 값으로 SYSDATE 해놨으니까
    INSERT INTO TBL_입고(입고번호, 상품코드, 입고수량, 입고단가)
    VALUES((V_입고번호+1), V_상품코드, V_입고수량, V_입고단가);
    
    -- UPDATE 쿼리문 수행
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외 처리
    EXCEPTION   -- 자바에서의 try ~ catch 구문이라고 생각하면 됨
        WHEN OTHERS THEN ROLLBACK;  
        -----------  ------------
--      위에서 명시한             
--      상황이 아니고             → 그러면 롤백해라
--      다른 상황이 발생했을 때는,
    
    -- 커밋
    COMMIT;
END;
--==> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.


-- 현재 상황,
-- 프로시저 안에 DML 구문 2개 이상 쓰이고 있다.
-- 커밋이 필요한 게 2개 이상 쓰이고 있다.

-- 트랜잭션 처리 ~!!!
/*
ex)
     현수   농협  1000000           민성  우리  50000
     
     주말에 민성이가 데이트가는데, 엄청 비싼 럭셔리한 곳에 가기로 함
     그래서 민성이가 현수한테 1000000원 빌리기로 했음
     
     현수가 민성이한테 계좌이체 해줘야 한다.
     현수가 민성이 계좌로 1000000원 이체하는 순간,
     
     SELECT 잔액
     FROM 계좌
     WHERE 계좌번호 = '현수계좌번호'
     --==>> 1000000
     
     -- 현수의 농협
     UPDATE 계좌
     SET 잔액 = 잔액 - 1000000
     WHERE 계좌주인 = '현수계좌번호';
     
     -- 민성이의 우리은행
     UPDATE 계좌
     SET 잔액 = 잔액 + 1000000
     WHERE 계좌주인 = '민성계좌번호';
     
     이렇게 UPDATE 일어날 것이다.
     
     그런데 현수의 농협에서는 UPDATE 쿼리문 수행됐는데
     민성이의 우리은행에서는 UPDATE 쿼리문이 수행되지 않으면........
     
     혹시라도 민성이 우리은행에서 UPDATE 가 먼저 일어났으면
     현수 계좌에서는 1000000원 빠지지도 않았는데
     민성이 계좌에 1000000원 추가되는 상황......
     
     어쨌든 두 개는 따로따로 실행되어야 하는 독립적인 UPDATE 문
     그런데도 둘 중에 하나만 실행되는 경우가 없었다.
     → 이게 바로 『트랜잭션 처리』
     
     (
         -- 현수의 농협
         UPDATE 계좌
         SET 잔액 = 잔액 - 1000000
         WHERE 계좌주인 = '현수계좌번호';
         
         -- 민성이의 우리은행
         UPDATE 계좌
         SET 잔액 = 잔액 + 1000000
         WHERE 계좌주인 = '민성계좌번호';
     )
     
     이거 2개를 하나로 묶어서 둘 중에 하나만 수행되는 경우에는
     COMMIT 을 수행하지 않는다. 그런 경우에는 ROLLBACK !
     둘 다 모두 수행된 경우에만, 그렇게 확인된 경우에만 COMMIT !
     
다시 본론으로 돌아와서 
원래 프로시저에서 INSERT는 됐는데 UPDATE가 안됐거나
INSERT는 안됐는데 UPDATE만 되면 문제 생김!
그래서 예외처리 구문작성하러 다시 올라가보자
*/     


-- 20220311_02_scott.sql 로 가서 테스트 진행

--------------------------------------------------------------------------------
-- Line 298 까지 작성하고 돌아옴

--■■■ 프로시저 내에서의 예외 처리 ■■■--

--○ TBL_MEMBER 테이블에 데이터를 입력하는 프로시저를 작성
--   단, 이 프로시저를 통해 데이터를 입력할 경우
--   CITY(지역) 항목에 '서울', '경기', '대전' 만 입력이 가능하도록 구성한다.
--   이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하고자 하는 경우
--   (즉, 입력을 시도하는 경우) → 예외에 대한 처리를 하려고 한다.
--   프로시저 명 : PRC_MEMBER_INSERT()

/*
실행 예)
EXEC PRC_MEMBER_INSERT('임소민', '010-1111-1111', '서울');
--==>> 데이터 입력 ○

EXEC PRC_MEMBER_INSERT('이연주', '010-2222-2222', '부산');
--==>> 데이터 입력 Ⅹ
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN  TBL_MEMBER.NAME%TYPE
, V_TEL     IN  TBL_MEMBER.TEL%TYPE
, V_CITY    IN  TBL_MEMBER.CITY%TYPE
)  
IS
    -- 선언부(주요 변수 선언)
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 선언
    V_NUM   TBL_MEMBER.NUM%TYPE;   
    
    -- 사용자 정의 예외에 대한 변수 선언 CHECK~!!!
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN 
    -- 절차적으로 실행할 것이기 때문에,
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 코드 구성
    -- 입력할 거 아니면 아래 코드 수행 할 필요 없으니까 !
    IF (V_CITY NOT IN('서울', '경기', '대전'))
        -- V_CITY 가 '서울', '경기', '대전'이 아니라면 예외 발생시켜야 함   CHECK~!!!
        -- 예외 발생 (ORACLE 에서 예외도 변수다.)
        THEN RAISE USER_DEFINE_ERROR;
             -----발생시키겠다.
    END IF;
    -- 예외 발생하면, 
    -- 사이에 어떤 코드가 있던간에 건너뛰고, [예외 처리 구문]으로 가게 됨
 
    
    -- 선언한 변수에 값 담아내기
    SELECT NVL(MAX(NUM), 0) INTO V_NUM
    FROM TBL_MEMBER;
    
    
    -- 쿼리문 구성 → INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES((V_NUM+1), V_NAME, V_TEL, V_CITY);
    
    
    -- 예외 처리 구문
    EXCEPTION
        WHEN USER_DEFINE_ERROR 
            THEN RAISE_APPLICATION_ERROR(-20001, '서울,경기,대전만 입력이 가능합니다.');
                 ROLLBACK;  -- 기존 처리한 것도 다 ROLLBACK 해줘야 함             
    -- RAISE_APPLICATION_ERROR() 는 오라클 함수이다. 
    -- 첫번째 변수 : 오라클 에러 번호
    --               숫자 앞에 『-』는 마이너스가 아니라, 그냥 오라번호 앞에 붙이는 거임
    --               20000번까지는 오라클 내부적으로 쓰는 거 명시되어 있기 때문에,
    --               사용자정의에러는 20000 번 이후부터 규칙세워서 자유롭게 사용하면 됨
    --               ex) 클라이언트 에러는 20100번대, 서버 에러는 20500 번대로 하자~
    --                   재고처리 에러는 20800번대로, 접근권한 관한건 20900번대로 하자~
    -- 두번째 변수 : 에러에 대한 내용
        WHEN OTHERS -- 에러 발생했는데, USER_DEFINE_ERROR 아니고 다른거면
            THEN ROLLBACK;  --그냥 롤백만 해라
    
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.


-- 20220311_02_scott.sql 로 가서 테스트 진행
-- Line 347 까지 작성하고 돌아옴


--○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--   TBL_상품 테이블의 재고수량이 변동되는 프로시저를 작성한다.
--   단, 출고번호는 입고번호와 마찬가지로 자동 증가 처리한다.
--   또한, 출고수량이 재고수량보다 많은 경우...
--   출고 액션을 취소할 수 있도록 처리한다.(출고가 이루어지지 않도록...)
--   → 예외 처리 활용 CHECK~!!!
--   프로시저 명 : PRC_출고_INSERT()
/*
실행 예)
EXEC PRC_출고_INSERT('H001', 10, 600);

-- 현재 상품 테이블의 바밤바 재고수량은 50개
EXEC PRC_출고_INSERT('H001', 60, 600);
--==>> 에러 발생
--     (재고부족)
*/

-- 나중에는 PROCEDURE 에 매개변수 순서 상관없지만,
-- 지금 우리가 배운 레벨에서는
-- 우리가 넘긴 그 매개변수 순서에 의존하고 있다!!
CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    IN  TBL_상품.상품코드%TYPE
, V_출고수량    IN  TBL_출고.출고수량%TYPE
, V_출고단가    IN  TBL_출고.출고단가%TYPE
)
IS
    -- 주요 변수 선언
    V_재고수량  TBL_상품.재고수량%TYPE;
    V_출고번호  TBL_출고.출고번호%TYPE;
        
    -- 사용자 정의 예외 선언
    USER_DEFINE_ERROR   EXCEPTION;
BEGIN
    -- 쿼리문 수행 이전에 수행 여부를 확인하는 과정에서
    -- 재고 파악 → 기존 재고를 확인하는 과정이 선행되어야 한다.
    -- 그래야 프로시저 호출 시 넘겨받는 V_출고수량과 비교가 가능하기 때문...
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    
    -- 출고를 정상적으로 진행해 줄 것인지에 대한 여부 확인
    -- 위에서 파악한 V_재고수량보다 현재 프로시저에서 넘겨받은 V_출고수량이 많으면
    -- 예외 발생~!!!
    IF (V_출고수량 > V_재고수량)
        -- 예외 발생
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    
    -- 출고번호 얻어내기 → 위에서 선언한 변수에 값 담아내기
    -- V_출고번호 구하는 쿼리의 위치가 더 앞이어도 문제는 없지만,
    -- V_출고번호는 이 아래부터 필요하기 때문에,
    -- 현재 위치보다 더 위에 있으면 리소스 낭비이다.
    SELECT NVL(MAX(출고번호), 0) + 1 INTO V_출고번호
    FROM TBL_출고;
    
    
    -- 쿼리문 구성 → INSERT(TBL_출고)
    INSERT INTO TBL_출고(출고번호, 상품코드, 출고수량, 출고단가)
    VALUES(V_출고번호, V_상품코드, V_출고수량, V_출고단가);
    
    
    -- 쿼리문 구성 → UPDATE(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    
    -- 예외처리
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고 부족');
                 ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
    
    
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_출고_INSERT이(가) 컴파일되었습니다.


-- 20220311_02_scott.sql 로 가서 테스트 진행
-- Line 432 까지 작성하고 돌아옴



--++) 검색으로 찾음
--    오라클에서 조회 결과 없으면 아무 행도 출력되지 않는데
--    그런 상황에서 뭔가 값을 조회시키고자 한다면 
--    집계함수(COUNT, MAX, MIN, SUM, AVG)를 사용해 출력시키는 방법이 있다.


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
( V_출고번호     IN  TBL_출고.출고번호%TYPE
, V_변경할수량   IN  TBL_출고.출고수량%TYPE
)
IS
    V_출고번호확인    TBL_출고.출고번호%TYPE;
    V_기존출고수량    TBL_출고.출고수량%TYPE;
    V_현재재고수량    TBL_상품.재고수량%TYPE;
    V_변경할상품코드  TBL_상품.상품코드%TYPE; 
    
    출고번호_ERROR    EXCEPTION;
    재고부족_ERROR    EXCEPTION;
BEGIN

    -- 입력한 V_출고번호 존재여부 파악
    -- 위에서 검색한 방법으로 집계함수 사용해 V_출고번호가 TBL_출고에 없을경우
    -- V_출고번호확인 에 -999 를 넣음  
    SELECT NVL(MAX(출고번호), -999) INTO V_출고번호확인
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    
    -- V_출고번호가 존재하지 않을 때 예외 발생
    IF (V_출고번호확인 = -999)
        THEN RAISE 출고번호_ERROR;
    END IF;
    
    
    -- V_출고번호의 기존 출고수량 확인 후, V_기존출고수량 변수에 대입
    SELECT 출고수량 INTO V_기존출고수량
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    
    -- V_변경할상품코드 파악
    SELECT 상품코드 INTO V_변경할상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    
    -- V_기존출고수량 원상복구 해주는 UPDATE 쿼리문 
    -- 쿼리문 구성 → UPDATE(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_기존출고수량
    WHERE 상품코드 = V_변경할상품코드;
                      
   
    -- V_현재재고수량 파악
    SELECT 재고수량 INTO V_현재재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_변경할상품코드;
   
   
    -- V_변경할수량 만큼 현재 재고가 있는지 확인 후, 재고 부족하면 예외 발생
    IF (V_변경할수량 > V_현재재고수량)
        THEN RAISE 재고부족_ERROR;     
    END IF;
   
   
    -- V_변경할수량 만큼 현재 재고가 있다면, UPDATE 쿼리문 수행
    -- 쿼리문 구성 → UPDATE(TBL_출고)
    UPDATE TBL_출고
    SET 출고수량 = V_변경할수량
    WHERE 출고번호 = V_출고번호;
   
   
    -- 쿼리문 구성 → UPDATE(TBL_상품)
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 - V_변경할수량
    WHERE 상품코드 = V_변경할상품코드;
   
      
    -- 예외 처리
    EXCEPTION
        WHEN 출고번호_ERROR
                THEN RAISE_APPLICATION_ERROR(-20003, '입력하신 출고번호가 존재하지 않습니다');
                     ROLLBACK;
        WHEN 재고부족_ERROR
                THEN RAISE_APPLICATION_ERROR(-20004, '재고가 부족합니다.');
                    ROLLBACK;
        WHEN OTHERS 
                THEN ROLLBACK;
                
    -- 커밋
    COMMIT;
    
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.

-- 20220311_02_scott.sql 로 가서 테스트 진행


-- 복습할 때, 원상복구 해주는 UPDATE 쿼리문은 생략하고 UPDATE 쿼리 2개만 사용
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
	SELECT NVL(MAX(출고번호), -999) INTO V_출고번호확인
	FROM TBL_출고
	WHERE 출고번호 = V_출고번호;

	-- 없는거면 예외발생
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
			THEN RAISE_APPLICATION_ERROR(-20003, '출고번호존재x');
		WHEN 재고부족_ERROR
			THEN RAISE_APPLICATION_ERROR(-20004, '재고부족');
			ROLLBACK;
		WHEN OTHERS 
			THEN ROLLBACK;
	
	-- 커밋
	COMMIT;
END;

