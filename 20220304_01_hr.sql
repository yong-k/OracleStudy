SELECT USER
FROM DUAL;
--==> HR


--              UNIQUE를 UK 라고도 하고 U 라고도 함
--             다른 책이나 이런 곳에 명시되어 있는 거 적어놓은 거임
--             -----
--■■■ UNIQUE(UK:U) ■■■--

-- 1. 테이블에서 지정한 컬럼의 데이터가 
--    중복되지 않고 유일할 수 있도록 설정하는 제약조건
--    PRIMARY KEY 와 유사한 제약조건이지만, NULL 을 허용한다는 차이점이 있다.
--    내부적으로 PRIMARY KEY 와 마찬가지로 UNIQUE INDEX 가 자동 생성된다.
--                                         =========================
--    하나의 테이블 내에서 UNIQUE 제약조건은 여러 번 설정하는 것이 가능하다.
--    즉, 하나의 테이블에 UNIQUE 제약조건을 여러 개 만드는 것은 가능하다는 것이다.

-- PRIMARY KEY에서 NOT NULL 제약조건 빼면 => UNIQUE
-- UNIQUE 나 PRIMARY KEY 걸어놓으면 ORACLE 이 빨리 찾으려고 INDEX 걸어놓는 개념
-- 그래서 데이터가 많으면 많을 수록 UNIQUE 나 PRIMARY KEY 는 반드시 있어야 한다.
-- 따로 겹칠 만한 데이터가 없다고 판단하더라도 제약조건 걸어야 한다.

-- 단순히 겹치는 값 없게 하려고 PRIMARY KEY 나 UNIQUE 거는 것 아니다.
-- 사용자가 검색창에서 많이 찾겠다 할 때도 
-- 제약조건을 걸어야 하는지에 대한 적극적인 판단이 필요하다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] UNIQUE

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 UNIQUE(컬럼명, ...)


--○ UK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    UNIQUE
);
--==>> Table TBL_TEST5이(가) 생성되었습니다.


-- 제약조건 조회
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST5';
--==>>
/*
HR	SYS_C007065	TBL_TEST5	P	COL1		
HR	SYS_C007066	TBL_TEST5	U	COL2		
*/


-- 데이터 입력
INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'TEST');
--==>> 에러 발생
--     (ORA-00001: unique constraint (HR.SYS_C007065) violated)

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(1, 'ABCD');
--==>> 에러 발생
--     (ORA-00001: unique constraint (HR.SYS_C007065) violated)

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(2, 'ABCD');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(3, NULL);
--==>> 1 행 이(가) 삽입되었습니다.
-- 지금은 NULL 이 처음 들어간 거지만,
-- 고유해야 한다고 했는데, NULL이 또 들어갈 수 있을까??
-- YES → NULL은 값이 아니다. 비어있다는 상태를 표현하는 것이 NULL 이다.

INSERT INTO TBL_TEST5(COL1) VALUES(4);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST5(COL1, COL2) VALUES(5, 'ABCD');
--==>> 에러 발생
--     (ORA-00001: unique constraint (HR.SYS_C007066) violated)

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST5;
--==>>
/*
1	TEST
2	ABCD
3	(null)
4	(null)
*/


--○ UK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST6
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6이(가) 생성되었습니다.


-- 제약조건 조회(확인)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST6';
--==>>
/*
HR	TEST6_COL1_PK	TBL_TEST6	P	COL1		
HR	TEST6_COL2_UK	TBL_TEST6	U	COL2		
*/


--○ UK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST7
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST7이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>> 조회 결과 없음
-- 그냥 테이블을 만들기만 했을 때는 제약 조건 없음


-- 제약조건 추가
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1);
--     +
ALTER TABLE TBL_TEST7
ADD CONSTRAINT TEST7_COL2_UK UNIQUE(COL2);

--     ↓ (두 개 합쳐서)

ALTER TABLE TBL_TEST7
ADD ( CONSTRAINT TEST7_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST7_COL2_UK UNIQUE(COL2) );
--==>> Table TBL_TEST7이(가) 변경되었습니다.


-- 제약조건 추가 이후 다시 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST7';
--==>>
/*
HR	TEST7_COL1_PK	TBL_TEST7	P	COL1		
HR	TEST7_COL2_UK	TBL_TEST7	U	COL2		
*/


--------------------------------------------------------------------------------

--■■■ CHECK(CK:C) ■■■--

-- 1. 컬럼에서 허용 가능한 데이터의 범위나 조건을 지정하기 위한 제약조건
--    컬럼에 입력되는 데이터를 검사하여 조건에 맞는 데이터만 입력될 수 있도록 한다.
--    또한, 컬럼에서 수정되는 데이터를 검사하여
--    조건에 맞는 데이터로 수정되는 것만 허용하는 기능을 수행하게 된다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] CHECK(컬럼 조건)

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRAINT명 CHECK(컬럼 조건)


--○ CK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST8
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    
, COL3  NUMBER(3)       CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST8이(가) 생성되었습니다.
-- NUBMER(3) 하면 -999 ~ 999 까지 입력가능하지만
-- 여기서 0 ~ 100 까지만 입력가능하게 하고 싶음
-- → CHECK 제약조건 사용하면 됨

-- 데이터 입력
INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(1, '소민', 100);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '현수', 101);
--==>> 에러 발생
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 이 0 ~ 100 사이의 값이 아니기 때문에 에러 발생

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '태형', -1);
--==>> 에러 발생
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 이 0 ~ 100 사이의 값이 아니기 때문에 에러 발생

INSERT INTO TBL_TEST8(COL1, COL2, COL3) VALUES(2, '이삭', 80);
--==>> 1 행 이(가) 삽입되었습니다.

COMMIT;
--==>> 커밋 완료.


SELECT *
FROM TBL_TEST8;
--==>>
/*
1	소민	100
2	이삭	 80
*/


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST8';
--==>>
/*
    우리가 제약조건명 설정안해서
    오라클이 이름 붙인거                CHECK 가 어떤 조건으로 걸려있는지
    -----------                         ------------------------
HR	SYS_C007071	TBL_TEST8	C	COL3	COL3 BETWEEN 0 AND 100	
HR	SYS_C007072	TBL_TEST8	P	COL1		
*/


--○ CK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST9
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
, CONSTRAINT TEST9_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST9_COL3_CK CHECK(COL3 BETWEEN 0 AND 100)
);
--==>> Table TBL_TEST9이(가) 생성되었습니다.


-- 데이터 입력
INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(1, '소민', 100);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '현수', 101);
--==>> 에러 발생
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 이 0 ~ 100 사이의 값이 아니기 때문에 에러 발생

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '태형', -1);
--==>> 에러 발생
--     (ORA-02290: check constraint (HR.SYS_C007071) violated)
-- COL3 이 0 ~ 100 사이의 값이 아니기 때문에 에러 발생

INSERT INTO TBL_TEST9(COL1, COL2, COL3) VALUES(2, '이삭', 80);
--==>> 1 행 이(가) 삽입되었습니다.


-- 확인
SELECT *
FROM TBL_TEST9;
--==>>
/*
1	소민	100
2	이삭	 80
*/

COMMIT;
--==>> 커밋 완료.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST9';
--==>>
/*
HR	TEST9_COL3_CK	TBL_TEST9	C	COL3	COL3 BETWEEN 0 AND 100	
HR	TEST9_COL1_PK	TBL_TEST9	P	COL1		
*/


--○ CK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST10
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, COL3  NUMBER(3)
);
--==>> Table TBL_TEST10이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>> 조회 결과 없음


-- 제약조건 추가
ALTER TABLE TBL_TEST10
ADD ( CONSTRAINT TEST10_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST10_COL3_CK CHECK(COL3 BETWEEN 0 AND 100) );
--==>> Table TBL_TEST10이(가) 변경되었습니다.  
   
               
-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST10';
--==>>
/*
HR	TEST10_COL1_PK	TBL_TEST10	P	COL1		
HR	TEST10_COL3_CK	TBL_TEST10	C	COL3	COL3 BETWEEN 0 AND 100	
*/


--○ 실습 문제
-- 다음과 같이 TBL_TESTMEMBER 테이블을 생성하여
-- SSN 컬럼(주민번호 컬럼)에서
-- 데이터 입력 시 성별이 유효한 데이터만 입력될 수 있도록
-- 체크 제약조건을 추가할 수 있도록 한다.
-- (→ 주민번호 특정 자리에 입력 가능한 데이터를 1, 2, 3, 4 만 가능하도록 처리)
-- 또한, SID 컬럼에는 PRIMARY KEY 제약조건을 설정할 수 있도록 한다.

-- 테이블 생성
CREATE TABLE TBL_TESTMEMBER
( SID   NUMBER
, NAME  VARCHAR2(30)
, SSN   CHAR(14)        -- 데이터 입력 형태 → 'YYMMDD-NNNNNNN'
, TEL   VARCHAR2(40)
);
--==>> Table TBL_TESTMEMBER이(가) 생성되었습니다.

-- 제약조건 추가
ALTER TABLE TBL_TESTMEMBER
ADD ( CONSTRAINT TESTMEMBER_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT TESTMEMBER_SSN_CK CHECK(SUBSTR(SSN, 8, 1) IN ('1', '2', '3', '4')) );
--==>> Table TBL_TESTMEMBER이(가) 변경되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TESTMEMBER';
--==>>
/*
HR	TESTMEMBER_SID_PK	TBL_TESTMEMBER	P	SID		
HR	TESTMEMBER_SSN_CK	TBL_TESTMEMBER	C	SSN	SUBSTR(SSN, 8, 1) IN ('1', '2', '3', '4')	
*/


-- 데이터 입력 테스트
INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(1, '이호석', '961112-1234567', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(2, '양윤정', '970131-2234567', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(3, '홍수민', '000504-4234567', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(4, '김상기', '061004-3234567', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(5, '이호석', '961112-5234567', '010-1111-1111');
--==>> 에러발생
--     (ORA-02290: check constraint (HR.TESTMEMBER_SSN_CK) violated)

INSERT INTO TBL_TESTMEMBER(SID, NAME, SSN, TEL)
VALUES(6, '양윤정', '970131-6234567', '010-2222-2222');
--==>> 에러발생
--     (ORA-02290: check constraint (HR.TESTMEMBER_SSN_CK) violated)


SELECT *
FROM TBL_TESTMEMBER;
--==>>
/*
1	이호석	961112-1234567	010-1111-1111
2	양윤정	970131-2234567	010-2222-2222
3	홍수민	000504-4234567	010-3333-3333
4	김상기	061004-3234567	010-4444-4444
*/

COMMIT;
--==>> 커밋 완료.


--------------------------------------------------------------------------------

--■■■ FOREIGN KEY(FK:F:R) ■■■--

-- 1. 참조 키 또는 외래 키(FK)는 두 테이블의 데이터 간 연결을 설정하고
--    강제 적용시키는데 사용되는 열이다.
--    한 테이블의 기본 키 값이 있는 열을
--    다른 테이블에 추가하면 테이블 간 연결을 설정할 수 있다.
--    이 때, 두 번째 테이블에 추가되는 열이 외래키가 된다.

-- 2. 부모 테이블(참조받는 컬럼이 포함된 테이블)이 먼저 생성된 후
--    자식 테이블(참조하는 컬럼이 포함된 테이블)이 생성되어야 한다.
--    이 때, 자식 테이블에 FOREIGN KEY 제약조건이 설정된다.
--    ex) EMP 테이블 만들고서, DEPT 테이블 만들면 안된다는 거임 !

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명]
--                   REFERENCES 참조테이블명(참조컬럼명)
--                   [ON DELETE CASCADE | ON DELETE SET NULL]   → 추가 옵션

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입
-- CONSTRAINT CONSTRAINT명 FOREIGN KEY(컬럼명)
--              REFERENCES 참조테이블명(참조컬럼명)
--              [ON DELETE CASCADE | ON DELETE SET NULL]        → 추가 옵션


-- [ON DELETE CASCADE | ON DELETE SET NULL] 설정하지 않으면
-- 부모 테이블에서 자식 테이블이 참조하고 있는 PK 삭제 불가하다.
-- [ON DELETE CASCADE | ON DELETE SET NULL] 설정해 놓으면
-- 부모 테이블에서 자식 테이블이 참조하고 있는 PK 삭제가 가능해지고,
-- 삭제했을 때, 자식 테이블에서
-- ON DELETE CASCADE : 참조하고 있는 거 연쇄로 삭제
-- ON DELETE SET NULL : 참조하고 있는 거 NULL 로 설정
-- → 위험한 추가 옵션임..!


--※ FOREIGN KEY 제약조건을 설정하는 실습을 진행하기 위해서는
--   부모 테이블의 생성 작업을 먼저 수행해야 한다.
--   그리고 이 때, 부모 테이블에는 반드시 PK 또는 UK 제약조건이 
--   설정된 컬럼이 존재해야 한다.


-- 부모 테이블 생성
CREATE TABLE TBL_JOBS
( JIKWI_ID      NUMBER
, JIKWI_NAME    VARCHAR2(30)
, CONSTRAINT JOBS_ID_PK PRIMARY KEY(JIKWI_ID)
);
--==>> Table TBL_JOBS이(가) 생성되었습니다.


-- 부모 테이블에 데이터 입력
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(1, '사원');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(2, '대리');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(3, '과장');
INSERT INTO TBL_JOBS(JIKWI_ID, JIKWI_NAME) VALUES(4, '부장');
--==>> 1 행 이(가) 삽입되었습니다. * 4


-- 확인
SELECT *
FROM TBL_JOBS;
--==>>
/*
4	부장
3	과장
2	대리
1	사원
*/


-- 커밋
COMMIT;
--==>> 커밋 완료.


--○ FK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP1
( SID       NUMBER          PRIMARY KEY
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER          REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP1이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007080	TBL_EMP1	P	SID		
HR	SYS_C007081	TBL_EMP1	R	JIKWI_ID		NO ACTION
                           ---                  -----------
                        REFERENCE               ON DELETE CASCADE 나 
                                                ON DELETE SET NULL 이
                                                설정되어 있지 않을 때
                                                나오는 DELETE_RULE                                              
*/


-- 데이터 입력
INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(1, '이지연', 1);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(2, '신시은', 2);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(3, '이아린', 3);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(4, '정은정', 4);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '서민지', 5);
--==>> 에러 발생
--     (ORA-02291: integrity constraint (HR.SYS_C007081) violated 
--      - parent key not found) 
--     부모 테이블에 JIKWI_ID가 1~4번까지만 있기 때문에 
--     JIKWI_ID 5번으로 입력하려고 하면 에러난다.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(5, '서민지', 1);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP1(SID, NAME, JIKWI_ID) VALUES(6, '오이삭', NULL);
--==>> 1 행 이(가) 삽입되었습니다.
-- 부모 테이블에 있는 데이터들 중 하나를 선택하던지,
-- 아니면 아예 비워두는 거(NULL)는 된다.

INSERT INTO TBL_EMP1(SID, NAME) VALUES(7, '박현지');
--==>> 1 행 이(가) 삽입되었습니다
-- 534행과 같은 의미의 구문이다. 
-- (JIKWI_ID 를 NULL 로 놔두는 거)


-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3
4	정은정	4
5	서민지	1
6	오이삭	(null)
7	박현지	(null)
*/


-- 커밋
COMMIT;
--==>> 커밋 완료.


--○ FK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_EMP2
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
, CONSTRAINT EMP2_SID_PK PRIMARY KEY(SID)
, CONSTRAINT EMP2_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
             REFERENCES TBL_JOBS(JIKWI_ID)
);
--==>> Table TBL_EMP2이(가) 생성되었습니다.


-- 제약조건 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP2';
--==>>
/*
HR	EMP2_SID_PK	        TBL_EMP2	P	SID		
HR	EMP2_JIKWI_ID_FK	TBL_EMP2	R	JIKWI_ID		NO ACTION
*/


--○ FK 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_EMP3
( SID       NUMBER
, NAME      VARCHAR2(30)
, JIKWI_ID  NUMBER
);
--==>> Table TBL_EMP3이(가) 생성되었습니다.


-- 제약조건 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>> 조회 결과 없음


-- 제약조건 추가
ALTER TABLE TBL_EMP3
ADD ( CONSTRAINT EMP3_SID_PK PRIMARY KEY(SID)
    , CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
                 REFERENCES TBL_JOBS(JIKWI_ID) );
--==>> Table TBL_EMP3이(가) 변경되었습니다.


-- 제약조건 제거
-- 제약조건의 이름만 알고 있으면 된다.
ALTER TABLE TBL_EMP3
DROP CONSTRAINT EMP3_JIKWI_ID_FK;
--==>> Table TBL_EMP3이(가) 변경되었습니다.


-- 다시 FOREIGN KEY 제약조건 추가
ALTER TABLE TBL_EMP3
ADD CONSTRAINT EMP3_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID);
--==>> Table TBL_EMP3이(가) 변경되었습니다.


-- 제약조건 확인(조회)
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP3';
--==>>
/*
HR	EMP3_SID_PK	        TBL_EMP3	P	SID		
HR	EMP3_JIKWI_ID_FK	TBL_EMP3	R	JIKWI_ID		NO ACTION
*/


-- 4. FOREIGN KEY 생성 시 주의사항
--    참조하고자 하는 부모 테이블을 먼저 생성해야 한다.
--    참조하고자 하는 컬럼이 PRIMARY KEY 또는 UNIQUE 제약조건이 설정되어 있어야 한다.
--    테이블 사이에 PRIMARY KEY 와 FOREIGN KEY 가 정의되어 있으면
--    PRIMARY KEY 제약조건이 설정된 컬럼의 데이터 삭제 시
--    FOREIGN KEY 컬럼에 그 값이 입력되어 있는 경우 삭제되지 않는다.
--    (즉, 자식 테이블에 참조하는 레코드가 존재할 경우
--     부모 테이블의 참조받는 레코드는 삭제할 수 없다는 것이다.)
--    단, FK 설정 과정에서 『ON DELETE CASCADE』 나 『ON DELETE SET NULL』 옵션을
--    사용하여 설정한 경우에는 삭제가 가능하다.
--    또한, 부모 테이블을 제거하기 위해서는 자식 테이블을 먼저 제거해야 한다.


-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
4	부장
3	과장
2	대리
1	사원
*/

-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3
4	정은정	4
5	서민지	1
6	오이삭	
7	박현지	
*/


-- 정은정 부장의 직위를 사원으로 변경
UPDATE TBL_EMP1
SET JIKWI_ID = 1
WHERE SID = 4;
--==>> 1 행 이(가) 업데이트되었습니다.


-- 확인
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3
4	정은정	1
5	서민지	1
6	오이삭	
7	박현지	
*/


-- 커밋
COMMIT;
--==>> 커밋 완료.


-- 부모 테이블(TBL_JOBS)의 부장 데이터를 참조하고 있는
-- 자식 테이블(TBL_EMP1)의 데이터가 존재하지 않는 상황이다.

-- 이와 같은 상황에서 부모 테이블(TBL_JOBS)의
-- 부장 데이터 삭제 
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
-- SELECT 로 정보 확인 후, SELECT → DELETE 로 바꾸면 됨
DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 4;
--==>> 1 행 이(가) 삭제되었습니다.


-- 확인
SELECT *
FROM TBL_JOBS;
--==>>
/*
3	과장
2	대리
1	사원
*/


-- 커밋
COMMIT;
--==>> 커밋 완료.


-- 부모 테이블(TBL_JOBS)의 사원 데이터 삭제
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 1;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 1;
--==>> 에러 발생
--     (ORA-02292: integrity constraint (HR.SYS_C007081) violated 
--      child record found)
--      자식 레코드가 발견되었기 때문에 에러 발생

-- 그렇다면 데이터를 삭제하는 게 아니라, 
-- 부모 테이블(TBL_JOBS)를 구조적으로 아예 제거해보자
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     (ORA-02449: unique/primary keys in table referenced by foreign keys)


--> 딸린 자식이 있는 경우에,
--  부모 테이블이 갖고 있는 데이터도 삭제가 불가하고,
--  부모 테이블 자체를 지우는 것도 불가하다.

--※ 부모 테이블의 데이터를 자유롭게(?) 삭제하기 위해서는
--   자식 테이블의 FOREIGN KEY 제약조건 설정 시
--   『ON DELETE CASCADE』나 『ON DELETE SET NULL』 옵션 지정이 필요하다.


-- TBL_EMP1 테이블(자식 테이블)에서 FK 제약조건을 제거한 후
-- CASCADE 옵션을 포함하여 다시 FK 제약조건을 설정한다.

-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007080	TBL_EMP1	P	SID		
HR	SYS_C007081	TBL_EMP1	R	JIKWI_ID		NO ACTION
*/

-- FK 제약조건 삭제
ALTER TABLE TBL_EMP1
DROP CONSTRAINT SYS_C007081;
--==>> Table TBL_EMP1이(가) 변경되었습니다.


-- 제약조건 제거 이후 다시 확인 
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>> HR	SYS_C007080	TBL_EMP1	P	SID		


-- 『ON DELETE CASCADE』 옵션 포함된 내용으로 제약조건 다시 지정
ALTER TABLE TBL_EMP1
ADD CONSTRAINT EMP1_JIKWI_ID_FK FOREIGN KEY(JIKWI_ID)
               REFERENCES TBL_JOBS(JIKWI_ID)
               ON DELETE CASCADE;               -- CHECK~!!!
--==>> Table TBL_EMP1이(가) 변경되었습니다.


-- 제약조건 생성 이후 다시 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_EMP1';
--==>>
/*
HR	SYS_C007080	TBL_EMP1	P	SID		
HR	EMP1_JIKWI_ID_FK	TBL_EMP1	R	JIKWI_ID		CASCADE   → CHECK~!!!
                                                       ======== 
*/

--※ CASCADE 옵션을 지정한 후에는
--   참조받고 있는 부모 테이블의 데이터를
--   언제든지 자유롭게 삭제하는 것이 가능하다.
--   단, ... 부모 테이블의 데이터가 삭제될 경우...
--   이를 참조하는 자식 테이블의 데이터도 
--   모~~~~~~~~두 함께 삭제된다.        → 절대 주의할 것 ~!!!


-- 부모 테이블
SELECT *
FROM TBL_JOBS;
--==>>
/*
3	과장
2	대리
1	사원
*/


-- 자식 테이블
SELECT *
FROM TBL_EMP1;
--==>>
/*
1	이지연	1
2	신시은	2
3	이아린	3   ← 이아린 과장
4	정은정	1
5	서민지	1
6	오이삭	
7	박현지	
*/


-- 이아린 과장이 존재하는데,
-- 부모 테이블(TBL_JOBS)에서 과장 직위 데이터 삭제해보자.
SELECT *
FROM TBL_JOBS
WHERE JIKWI_ID = 3;

DELETE
FROM TBL_JOBS
WHERE JIKWI_ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.


-- 자식 테이블 조회(확인)
SELECT *
FROM TBL_EMP1;
--==>> 
/*
1	이지연	1
2	신시은	2
4	정은정	1
5	서민지	1
6	오이삭	
7	박현지	
*/
--  3	이아린	3  → 레코드가 아예 삭제되었다.
--> 이아린 과장 데이터가 삭제되었음을 확인~!!!


-- 부모 테이블 자체를 제거해보자
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     (ORA-02449: unique/primary keys in table referenced by foreign keys)
-- 현재 TBL_EMP1만 TBL_JOBS를 참조하고 있는 상황이 아니고,
-- 추가적으로 만들어놓은 자식 테이블이 있어서 에러 발생


-- TBL_EMP1 테이블 이외의 자식 테이블 제거
DROP TABLE TBL_EMP2;
--==>> Table TBL_EMP2이(가) 삭제되었습니다.

DROP TABLE TBL_EMP3;
--==>> Table TBL_EMP3이(가) 삭제되었습니다.


-- 부모 테이블 다시 제거 (현재 TBL_EMP1 테이블은 제거하지 않은 상태)
DROP TABLE TBL_JOBS;
--==>> 에러 발생
--     (ORA-02449: unique/primary keys in table referenced by foreign keys) 
-- CASCADE 옵션이 걸려있다고 하더라도,
-- 참조하고 있는 자식이 있으면, 부모테이블이 제거가 되지는 않는다.


-- TBL_EMP1 도 제거
DROP TABLE TBL_EMP1;
--==>> Table TBL_EMP1이(가) 삭제되었습니다.


-- 부모 테이블 다시 제거
DROP TABLE TBL_JOBS;
--==>> Table TBL_JOBS이(가) 삭제되었습니다.
-- 딸린 자식테이블 없으니 제거 가능


--------------------------------------------------------------------------------

--■■■ NOT NULL(NN:CK:C) ■■■--

-- 이거 CHECK 제약 조건 걸 때, 컬럼 레벨에서 NOT NULL 하면 되기 때문에

-- NOT NULL을 별도의 제약조건으로 뽑아서 공부하는 책은 별로 없다.
-- 그럼에도 따로 뽑아서 독립적으로 보는 이유는,
-- 얘만이 가진 뭔가 다른 점들이 있기 때문이다.


-- 1. 테이블에서 지정한 컬럼의 데이터가
--    NULL 인 상태를 갖지 못하도록 하는 제약조건



--※ 다른 제약 조건들은 테이블 레벨의 형식으로 더 많이 쓰이지만,
--   NOT NULL 제약 조건은 컬럼 레벨의 형식으로 더 많이 쓰인다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] NOT NULL

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입
-- 컬럼명 데이터타입
-- CONSTRAINT CONSTRAINT명 CHECK(컬럼명 IS NOT NULL)



--※ 다른 제약 조건들은 기존에 생성된 테이블에 제약조건 추가할 때,
--   ALTER 절에 ADD 를 사용했지만,
--   NOT NULL 제약 조건은 ALTER 절에 MODIFY 를 더 많이 사용한다.

-- 3. 기존에 생성되어 있는 테이블에 NOT NULL 제약조건을 추가할 경우
--    ADD 보다 MODIFY 절이 더 많이 사용된다.
-- ALTER TABLE 테이블명
-- MODIFY 컬럼명 데이터타입 NOT NULL;


--※  그냥 비어있다, 채워져있다 만으로 제약조건을 구성하다보니
--    이미 NULL 이 포함되어 있는데, 그 테이블에 NOT NULL 조건 설정하려고 하면
--    에러남으로 가장 많이 접할 수 있는 에러다.

-- 4. 기존 생성되어 있는 테이블에 
--    데이터가 이미 들어있지 않은 컬럼(→ NULL 인 상태의 컬럼)을
--    NOT NULL 제약조건을 갖게끔 수정하는 경우에는 에러 발생한다.(불가능하다)


--○ NOT NULL 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST11
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    NOT NULL        -- 이것도 일반적인 CHECK 와 다르다.
                                        -- CHECK 키워드 없이 사용가능
);
--==>> Table TBL_TEST11이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST11';
--==>>
/*          
                                         CHECK 조건처럼
                                         SEARCH_CONDITION 에 
                                         NOT NULL 조건 적혀져 있다.
                                        ------------------
HR	SYS_C007088	TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007089	TBL_TEST11	P	COL1		
*/


-- 데이터 입력
INSERT INTO TBL_TEST11(COL1, COL2) VALUES(1, 'TEST');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(2, 'ABCD');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST11(COL1, COL2) VALUES(3, NULL);
--==>> 에러 발생
--     (ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2"))

INSERT INTO TBL_TEST11(COL1) VALUES(3);
--==>> 에러 발생
--     (ORA-01400: cannot insert NULL into ("HR"."TBL_TEST11"."COL2"))


-- 확인
SELECT *
FROM TBL_TEST11;
--==>>
/*
1	TEST
2	ABCD
*/


--○ NOT NULL 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST12
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST12_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST12_COL2_NN CHECK(COL2 IS NOT NULL)
);
--==>> Table TBL_TEST12이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST12';
--==>>
/*
                                            ----------------
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
*/
-- 차이점
-- 아까 ① 의 실습에서는
-- HR	SYS_C007088	TBL_TEST11	C	COL2	"COL2" IS NOT NULL
-- 위의 구문처럼 "" 큰따옴표 안에 적혀있었는데
-- ②의 실습에서는 큰따옴표가 없다.


--○ NOT NULL 지정 실습(③ 테이블 생성 이후 제약조건 추가)
-- 테이블 생성
CREATE TABLE TBL_TEST13
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST13이(가) 생성되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 조회 결과 없음


-- 제약조건 추가
ALTER TABLE TBL_TEST13
ADD ( CONSTRAINT TEST13_COL1_PK PRIMARY KEY(COL1)
    , CONSTRAINT TEST13_COL2_NN CHECK(COL2 IS NOT NULL) );
--==>> Table TBL_TEST13이(가) 변경되었습니다.


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
*/


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST13';
--==>> 
/*
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007100	    TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/
-- COL2 에 CHECK 제약 조건이 2개 걸린 것처럼 나타난다는 특징도 관찰해두자


--※ NOT NULL 제약조건만 TBL_TEST13 테이블의 COL2 에 추가하는 경우
--   다음과 같은 방법을 사용하는 것도 가능하다.
ALTER TABLE TBL_TEST13
MODIFY COL2 NOT NULL;
--==>> Table TBL_TEST13이(가) 변경되었습니다.


-- 컬럼 레벨에서 NOT NULL 제약조건을 지정한 테이블(TBL_TEST11)
DESC TBL_TEST11;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/
-- DESCRIBE 에서 확인가능


-- 테이블 레벨에서 NOT NULL 제약조건을 지정한 테이블(TBL_TEST12)
DESC TBL_TEST12;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2          VARCHAR2(30) 
*/
-- DESCRIBE 에서 확인 불가
--> DESCRIBE 만 보고 NOT NULL 이다, 아니다 판단할 수 없음


-- 테이블 생성 이후 ADD 를 통해 NOT NULL 제약조건을 추가하였으며
-- 여기에 더하여, MODIFY 절을 통해 NOT NULL 제약조건을 추가한 테이블(TBL_TEST13)
-- DESCRIBE 를 해도 나오고, VIEW_CONSTCHECK 를 봐도 나온다.

DESC TBL_TEST13;
--==>>
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)    
COL2 NOT NULL VARCHAR2(30) 
*/


-- 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME IN ('TBL_TEST11', 'TBL_TEST12', 'TBL_TEST13');
--==>> 
/*
HR	SYS_C007088	    TBL_TEST11	C	COL2	"COL2" IS NOT NULL	
HR	SYS_C007089	    TBL_TEST11	P	COL1		
HR	TEST12_COL2_NN	TBL_TEST12	C	COL2	COL2 IS NOT NULL	
HR	TEST12_COL1_PK	TBL_TEST12	P	COL1		
HR	TEST13_COL1_PK	TBL_TEST13	P	COL1		
HR	TEST13_COL2_NN	TBL_TEST13	C	COL2	COL2 IS NOT NULL	
HR	SYS_C007100	    TBL_TEST13	C	COL2	"COL2" IS NOT NULL	
*/


--------------------------------------------------------------------------------

--■■■ DEFAULT 표현식 ■■■--

-- 1. INSERT 와 UPDATE 문에서
--    특정 값이 아닌 기본 값을 입력하도록 처리할 수 있다.

-- 2. 형식 및 구조
-- 컬럼명 데이터타입 DEFAULT 기본값

-- 3. INSERT 명령 시 해당 컬럼에 입력될 값을 할당하지 않거나,
--    DEFAULT 키워드를 활용하여 기본으로 설정된 값을 입력하도록 할 수 있다.

-- 4. DEFAULT 키워드와 다른 제약(NOT NULL 등) 표기가 함께 사용되어야 하는 경우
--    DEFAULT 키워드를 먼저 표기(작성)할 것을 권장한다.
--    ex) , COL4    DATE    NOT NULL    DEFAULT SYSDATE
--        , COL4    DATE    DEFAULT SYSDATE     NOT NULL    ← 권장!


--○ DEFAULT 표현식 적용 실습
-- 테이블 생성
CREATE TABLE TBL_BBS                        -- 게시판 테이블 생성
( SID       NUMBER          PRIMARY KEY     -- 게시물 번호 → 식별자 → 자동 증가
, NAME      VARCHAR2(20)                    -- 게시물 작성자 
, CONTENTS  VARCHAR2(200)                   -- 게시물 내용
, WRITEDAY  DATE            DEFAULT SYSDATE -- 게시물 작성일
, COUNTS    NUMBER          DEFAULT 0       -- 게시물 조회수
, COMMENTS  NUMBER          DEFAULT 0       -- 게시물 댓글 개수
);
--==>> Table TBL_BBS이(가) 생성되었습니다.


--※ SID 를 자동 증가 값으로 운영하려면 시퀀스 객체가 필요하다
--   자동으로 입력되는 컬럼은 사용자의 입력 항목에서 제외시킬 수 있다.

-- 시퀀스 생성
CREATE SEQUENCE SEQ_BBS
NOCACHE;
--==>> Sequence SEQ_BBS이(가) 생성되었습니다.


-- 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


-- 게시물 작성
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '최문정', '오라클 DEFAULT 표현식을 실습중입니다.'
     , TO_DATE('2022-02-01 15:34:10', 'YYYY-MM-DD HH24:MI:SS'), 0, 0);
--==>> 1 행 이(가) 삽입되었습니다.
-- 현재 조회수와 댓글수가 0 이라고 0을 넣지 않고,
-- 저 값을 비워두게 되면, NULL 이 들어가게 됨
-- → 누가 열람하면 조회수를 1만큼 증가시켜야 하는데 
--    NULL + 1 이 되니까, 결과값도 그냥 NULL 이 되어버림...!


INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '이호석', '계속 실습중입니다.', SYSDATE, 0, 0);
--==>> 1 행 이(가) 삽입되었습니다.
-- 사용자가 게시물 입력할 때마다 입력하는 시간 넣지 않음
-- SYSDATE의 값을 씀 → 그거 대신 DAFAULT 를 쓸 수도 있음
-- 왜?
-- 이 테이블을 만들 때, WRITEDAY의 DEFAULT 값은 SYSDATE 라고 했기 때문

INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '이연주', '열심히 실습중입니다.', DEFAULT, 0, 0);
--==>> 1 행 이(가) 삽입되었습니다.

-- 뒤에 COUNTS, COMMENTS도 DAFAULT 값을 0 으로 설정해놨기 때문에 
-- DEFAULT 로 쓸 수 있음
INSERT INTO TBL_BBS(SID, NAME, CONTENTS, WRITEDAY, COUNTS, COMMENTS)
VALUES(SEQ_BBS.NEXTVAL, '김태형', '열심히 실습중입니다.', DEFAULT, DEFAULT, DEFAULT);
--==>> 1 행 이(가) 삽입되었습니다.

-- DEFAULT로 이미 정해져있다면, 
-- WRITEDAY, COUNTS, COMMENTS를 아예 빼버릴 수 있다.
INSERT INTO TBL_BBS(SID, NAME, CONTENTS)
VALUES(SEQ_BBS.NEXTVAL, '김태형', '무진장 실습중입니다.');
--==>> 1 행 이(가) 삽입되었습니다.

-- SID, NAME, CONTENTS 만 명시해서 들어가면
-- 다른 테이블 같은 경우에는, 여기에서 명시하지 않은 건 NULL 로 들어가겠지만,
-- 그런데 DEFAULT 표현식을 쓰게 되면
-- 값을 입력하지 않아도 NULL 이 아닌 DEFAULT 설정 값으로 들어감


-- 확인
SELECT *
FROM TBL_BBS;
--==>>
/*
1	최문정	오라클 DEFAULT 표현식을 실습중입니다.	2022-02-01 15:34:10	0	0
2	이호석	계속 실습중입니다.	                    2022-03-04 14:29:44	0	0
3	이연주	열심히 실습중입니다.	                2022-03-04 14:30:46	0	0
4	김태형	열심히 실습중입니다.	                2022-03-04 14:31:29	0	0
5	김태형	무진장 실습중입니다.	                2022-03-04 14:32:33	0	0
*/


-- 해당 테이블에 어떤 DEFAULT 값이 지정되어 있는지 어떻게 확인할까?
--○ DEFAULT 표현식 확인(조회)
SELECT *
FROM USER_TAB_COLUMNS
WHERE TABLE_NAME = 'TBL_BBS';
--==>>
/*                                                          [DATA_DEFAULT]
TBL_BBS	SID	        NUMBER			 22			N	1				  
TBL_BBS	NAME	    VARCHAR2		 20			Y	2				  
TBL_BBS	CONTENTS	VARCHAR2		200			Y	3				  
TBL_BBS	WRITEDAY	DATE			  7			Y	4	8	"SYSDATE"
TBL_BBS	COUNTS	    NUMBER			 22			Y	5	2	"0"		
TBL_BBS	COMMENTS	NUMBER			 22			Y	6	2	"0"		
*/


--○ 테이블 생성 이후 DEFAULT 표현식 추가 / 변경
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT 기본값;


-- 제약조건들은 기본적으로 다 수정해서 쓰는 형태가 아님
-- 제약조건을 부여하거나, 제거하거나, 
-- 부여한 제약조건에 발동을 걸거나, 지금은 못 쓰게 브레이크 걸어두거나 하는 것
-- 제약조건에는 다 이름이 있어서, 특정 제약조건 제거 가능
-- DEFAULT 표현식은 이름을 부여해서 쓰지 않기 때문에 문법적으로 제거하는 게 없음

-- 원래 DEFAULT 안 썼을 때, 데이터 집어넣지 않으면 NULL 로 처리됨
-- 그렇게 처리되게 하면 됨 !

--○ 기존의 DEFAULT 표현식 제거 → DROP 사용할 수 없음
ALTER TABLE 테이블명
MODIFY 컬럼명 [자료형] DEFAULT NULL;


COMMIT;
--==>> 커밋 완료.

