SELECT USER
FROM DUAL;
--==>> SCOTT

-- 20220314_01_scott(plsql).sql
-- Line 95 까지 작성하고 TEST 하러 옴


-- 내 풀이 TEST
-- 내가 한 걸로 TEST 후 ROLLBACK 수행해놨음
--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인

--① 출고번호가 없는 경우
EXEC PRC_출고_UPDATE(7, 5);
--==>> 에러 발생
--     (ORA-20003: 입력하신 출고번호가 존재하지 않습니다)

--② 상품재고가 부족한 경우
EXEC PRC_출고_UPDATE(1, 51);
--==>> 에러 발생
--     (ORA-20004: 재고가 부족합니다.)

--③ 정상적으로 처리되는 경우
EXEC PRC_출고_UPDATE(1, 50);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_출고_UPDATE(2, 24);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.
EXEC PRC_출고_UPDATE(3, 30);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


--○ 확인
SELECT *
FROM TBL_출고;
--==>>
/*
1	H001	2022-03-11	50	 600
2	H002	2022-03-11	24	 500
3	H003	2022-03-11	30	 500
4	H004	2022-03-11	 5	 600
5	C001	2022-03-11	10	1600
6	C002	2022-03-11	10	1600
*/

SELECT *
FROM TBL_상품;
--==>>
/*
H001	바밤바	600	 0
H002	죠스바	500	 1
H003	메로나	500	 5
H004	보석바	600	70
            :
*/


--○ 확인 완료 후, 내일 쌤 코드로 실습하기 위해 ROLLBACK; 수행
--   프로시저 만들 때 일부러 COMMIT; 구문 뺏었음
--   이거 수행한 후에는 COMMIT; 구문 추가해놓음
ROLLBACK;
--==>> 롤백 완료.


-- 20220314_01_scott(plsql).sql
-- Line 158 까지 작성하고 TEST 하러 옴


-- 쌤 풀이 TEST
--○ 확인
SELECT *
FROM TBL_상품;
--==>>
/*
H001	바밤바	 600	30
H002	죠스바	 500	20
H003	메로나	 500	30
H004	보석바	 600	70
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	50
C002	빵빠레	1700	10
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

SELECT *
FROM TBL_출고;
--==>>
/*
1	H001	2022-03-11	20	600
2	H002	2022-03-11	5	500
3	H003	2022-03-11	5	500
4	H004	2022-03-11	5	600
5	C001	2022-03-11	10	1600
6	C002	2022-03-11	10	1600
*/


--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인
EXEC PRC_출고_UPDATE(6, 20);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


--○ 프로시저 호출 이후 테이블 조회(확인)
SELECT *
FROM TBL_출고;
--==>>
/*
        :
6	C002	2022-03-11	20	1600
*/

SELECT *
FROM TBL_상품;
--==>>
/*
        :
C002	빵빠레	1700	0
        :
*/


--○ 생성한 프로시저가 제대로 작동하는지의 여부 확인
EXEC PRC_출고_UPDATE(5, 70);
--==>> 에러 발생
--     (ORA-20002: 재고가 부족합니다.)


--○ 프로시저 호출 이후 테이블 조회(확인)
SELECT *
FROM TBL_출고;
--==>>
/*
        :
5	C001	2022-03-11	10	1600
        :
*/

SELECT *
FROM TBL_상품;
--==>>
/*
        :
C001	월드콘	1600	50
        :
*/

-- 20220314_01_scott(plsql).sql 로 돌아감
-- Line 221 까지 작성하고 돌아옴

--------------------------------------------------------------------------------
-------------------PRC_입고_UPDATE(입고번호, 입고수량) 확인---------------------
--○ 프로시저 호출 이전 테이블 조회(확인)
SELECT *
FROM TBL_입고;
--==>>
/* 
        :
6	C001	2022-03-11	20	1500
7	C001	2022-03-11	20	1500
8	C001	2022-03-11	20	1500
        :
*/

SELECT *
FROM TBL_상품;
--==>> C001	월드콘	1600	50


--○ 생성한 프로시저(PRC_입고_UPDATE())가 제대로 작동하는지의 여부 확인

--① 존재하지 않는 입고번호 입력 시, 
EXEC PRC_입고_UPDATE(23, 5);
--==>> 에러 발생
--     (ORA-20004: 입력하신 입고번호가 존재하지 않습니다)

--② 현재재고수량 - 기존입고수량 + 변경할입고수량 < 0
SELECT *
FROM TBL_입고;
--==>> 3	H002	2022-03-11	25	450

SELECT *
FROM TBL_상품;
--==>> H002  죠스바	 500	20


-- 죠스바 : 재고수량(20) - 기존입고수량(25) + 변경입고수량(2) = -3 < 0
EXEC PRC_입고_UPDATE(3, 2);
--==>> 에러 발생
--     (ORA-20002: 재고가 부족합니다.)

ROLLBACK;

--③ 정상 작동 하는 경우,
EXEC PRC_입고_UPDATE(7, 77);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


--○ 프로시저 호출 이후 테이블 조회(확인)
SELECT *
FROM TBL_입고;
--==>>
/*
        :
6	C001	2022-03-11	20	1500
7	C001	2022-03-11	77	1500
8	C001	2022-03-11	20	1500
        :
*/

SELECT *
FROM TBL_상품;
--==>> C001	월드콘	1600	107

ROLLBACK;

--------------------------------------------------------------------------------
-----------------------PRC_입고_DELETE(입고번호) 확인---------------------------

--○ 프로시저 호출 이전 테이블 조회(확인)
SELECT *
FROM TBL_입고;
--==>>
/* 
        :
6	C001	2022-03-11	20	1500
7	C001	2022-03-11	20	1500
8	C001	2022-03-11	20	1500
        :
*/

SELECT *
FROM TBL_상품;
--==>> C001	월드콘	1600	50


--○ 생성한 프로시저(PRC_입고_DELETE())가 제대로 작동하는지의 여부 확인

--① 존재하지 않는 입고번호 입력 시, 
EXEC PRC_입고_DELETE(11);
--==>> 에러 발생
--     (ORA-20004: 입력하신 입고번호가 존재하지 않습니다)

--② 현재 재고가 입고할 당시의 입고수량보다 부족한 경우,
-- 부족하게 만들기 위해 UPDATE 문 실행
UPDATE TBL_상품
SET 재고수량 = 5
WHERE 상품코드 = 'C001';

SELECT *
FROM TBL_상품;
--==>> C001	월드콘	1600	5

EXEC PRC_입고_DELETE(6);
--==>> 에러 발생
--     (ORA-20002: 재고가 부족합니다.)

ROLLBACK;


--③ 정상 작동 하는 경우,
EXEC PRC_입고_DELETE(6);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


--○ 프로시저 호출 이후 테이블 조회(확인)
SELECT *
FROM TBL_입고;
--==>> 입고번호 6번 없어졌음
/*
1	H001	2022-03-11	30	400
2	H001	2022-03-11	20	500
3	H002	2022-03-11	25	450
4	H003	2022-03-11	35	450
5	H004	2022-03-11	75	520
7	C001	2022-03-11	20	1500
8	C001	2022-03-11	20	1500
9	C002	2022-03-11	10	1500
10	C002	2022-03-11	10	1500
*/

SELECT *
FROM TBL_상품;
--==>> C001	월드콘	1600	30

ROLLBACK;
--------------------------------------------------------------------------------
-----------------------PRC_출고_DELETE(출고번호) 확인---------------------------

--○ 프로시저 호출 이전 테이블 조회(확인)
SELECT *
FROM TBL_출고;
--==>> 1	H001	2022-03-11	20	600

SELECT *
FROM TBL_상품;
--==>> H001	바밤바	600	30


--○ 생성한 프로시저(PRC_출고_DELETE())가 제대로 작동하는지의 여부 확인

--① 존재하지 않는 출고번호 입력 시, 
EXEC PRC_출고_DELETE(10);
--==>> 에러 발생
--     (ORA-20005: 입력하신 출고번호가 존재하지 않습니다)

--② 정상 작동 하는 경우,
EXEC PRC_출고_DELETE(1);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.


--○ 프로시저 호출 이후 테이블 조회(확인)
SELECT *
FROM TBL_출고;
--==>> 출고번호 1번 없어졌음 (바밤바)

SELECT *
FROM TBL_상품;
--==>> H001	바밤바	600	50

ROLLBACK;
--------------------------------------------------------------------------------
-- Line 740까지 작성하고 돌아옴

--■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업에 대한 이벤트 기록을 남길 때 주로 사용한다.

--○ 실습을 위한 준비 → 테이블 생성
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

-- TBL_TEST1은 오픈해놓고 만든 테이블이고,
-- TBL_EVENTLOG 테이블을 몰래 만든다고 해보자
--○ 실습을 위한 준비 → 테이블 생성
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.


--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회 결과 없음

-- 20220314_01_scott(plsql).sql 로 돌아감
-- Line 768 까지 작성하고 돌아옴

-- TBL_EVENTLOG는 건드리는 거 아님
--○ 생성한 TRIGGER 작동 여부 확인
-- 프로시저 작동 확인하기 위해 → 프로시저 실행했음 (EXEC)
-- 트리거는
-- → TBL_TEST1 테이블을 대상으로 INSERT, UPDATE, DELETE 수행
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '홍은혜', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '이호석', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '임소민', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1
SET NAME = '임대민'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.

UPDATE TBL_TEST1
SET NAME = '임중민'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.


-- DML 구문 수행했으니까, 커밋
COMMIT;
--==>> 커밋 완료.


-- 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>Session이(가) 변경되었습니다.


--○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음
-- INSERT, UPDATE, DELETE 난리쳤었지만 지금은 고-요함
-- 이것만 보고 뭔 일이 일어났었는지 모름

SELECT *
FROM TBL_EVENTLOG;
--==>>
/*
INSERT 쿼리가 실행되었습니다.	2022-03-14 15:28:46
INSERT 쿼리가 실행되었습니다.	2022-03-14 15:28:46
INSERT 쿼리가 실행되었습니다.	2022-03-14 15:28:46
UPDATE 쿼리가 실행되었습니다.	2022-03-14 15:29:45
UPDATE 쿼리가 실행되었습니다.	2022-03-14 15:30:09
DELETE 쿼리가 실행되었습니다.	2022-03-14 15:30:56
DELETE 쿼리가 실행되었습니다.	2022-03-14 15:31:16
DELETE 쿼리가 실행되었습니다.	2022-03-14 15:31:42
*/
-- 언제, 몇시몇분몇초에 일어났는지 다 알 수 있음
-- 이게 TRIGGER
-- TRIGGER 중에서 → AFTER STATEMENT TRIGGER


-- 20220314_01_scott(plsql).sql 로 돌아감

--------------------------------------------------------------------------------
-- Line 809 까지 작성하고 돌아옴

--■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■--
-- ※ DML 작업 수행 전에 작업에 대한 가능 여부 확인
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '한충희', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '최선하', '010-5555-5555');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(6, '정은정', '010-6666-6666');
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1 
SET NAME = '정금정'
WHERE ID = 6;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 5;
--==>> 1 행 이(가) 삭제되었습니다.


--------------------------------------------------------------------------------
------------------------ 오라클 서버의 시스템 시간 변경 ------------------------
------------------------- 원래 16:14 → 19:14 로 변경 --------------------------
--------------------------------------------------------------------------------
-- 서버 시간 바꿀거임 → 현재 우리는 각자 PC에 깔려있으니까
-- 우리 PC의 시간 오후 7시 13분으로 변경
-- 이 상태에서 다시 DML 구문 실행

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(7, '이연주', '010-7777-7777');
--==>> 에러 발생
--     (ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.)

UPDATE TBL_TEST1
SET NAME = '정은정'
WHERE ID = 6;
--==>> 에러 발생
--     (ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.)

DELETE 
FROM TBL_TEST1
WHERE ID = 4;
--==>> 에러 발생
--     (ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.)


-- 날짜 원래대로 변경함
-- 20220314_01_scott(plsql).sql 로 돌아감

--------------------------------------------------------------------------------
-- Line 811 까지 작성하고 돌아옴

--■■■ BEFORE ROW TRIGGER 상황 실습 ■■■--
-- ※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

--○ 실습 환경 구성을 위한 테이블 생성 → TBL_TEST2
CREATE TABLE TBL_TEST2
( CODE  NUMBER
, NAME  VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.


--○ 실습 환경 구성을 위한 테이블 생성 → TBL_TEST3
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
             REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.


--○ 실습 관련 데이터 입력
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '텔레비전');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(4, '건조기');
--==>> 1 행 이(가) 삽입되었습니다. * 4


SELECT *
FROM TBL_TEST2;
--==>>
/*
1	텔레비전
2	냉장고
3	세탁기
4	건조기
*/

COMMIT;
--==>> 커밋 완료.


--○ 실습 관련 데이터 입력
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 1, 50);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 1, 60);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 3, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 2, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 3, 30);

--==>> 1 행 이(가) 삽입되었습니다. * 12


SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	30
2	1	50
3	1	60
4	1	30
5	2	20
6	3	30
7	2	30
8	2	20
9	2	30
10	3	30
11	3	20
12	3	30
*/

COMMIT;
--==> 커밋 완료.


--○ 부모 테이블(TBL_TEST2)의 데이터 삭제 시도
DELETE
FROM TBL_TEST2
WHERE CODE = 1;
--==>> 에러 발생
--     (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found)
-- 자식테이블에 1번을 참조하고 있는 레코드들이 있기 때문에!

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 에러 발생
--     (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found)
-- 자식테이블에 2번을 참조하고 있는 레코드들이 있기 때문에!

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 에러 발생
--     (ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found)
-- 자식테이블에 3번을 참조하고 있는 레코드들이 있기 때문에!

DELETE
FROM TBL_TEST2
WHERE CODE = 4;
--==>> 1 행 이(가) 삭제되었습니다.
-- 4번이 건조기인데, 
-- 자식테이블에 [4번-건조기]를 참조하고 있는 레코드가 없기 때문에 삭제됨


-- 20220314_01_scott(plsql).sql 로 돌아가서 TRG_TEST2_DELETE 트리거 작성
-- Line 877 까지 작성하고 돌아옴


--○ TRIGGER(트리거) 생성 이후 실습
SELECT *
FROM TBL_TEST2;
--==>>
/*
1	텔레비전
2	냉장고
3	세탁기
*/

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	30
2	1	50
3	1	60
4	1	30
5	2	20  ◀ 냉장고
6	3	30
7	2	30  ◀ 냉장고
8	2	20  ◀ 냉장고
9	2	30  ◀ 냉장고
10	3	30
11	3	20
12	3	30
*/

-- 원래는 이렇게 냉장고를 참조하는 데이터가 있으면
-- 부모테이블에서 삭제 불가하다.

-- 그러나 TRIGGER 만들어놓은 지금은, 수행된다.
DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 1 행 이(가) 삭제되었습니다.


SELECT *
FROM TBL_TEST2;
--==>>
/*
1	텔레비전
3	세탁기
*/

SELECT *
FROM TBL_TEST3;
--==>>
/*
1	1	30
2	1	50
3	1	60
4	1	30
6	3	30
10	3	30
11	3	20
12	3	30
*/


-- 20220314_01_scott(plsql).sql 로 돌아감
--------------------------------------------------------------------------------
 
--■■■ AFTER ROW TRIGGER 상황 실습 ■■■--
-- ※ 참조 테이블 관련 트랜잭션 처리

UPDATE TBL_상품
SET 재고수량 = 0;
--==>> 18개 행 이(가) 업데이트되었습니다.

TRUNCATE TABLE TBL_입고;
--==>> Table TBL_입고이(가) 잘렸습니다.

TRUNCATE TABLE TBL_출고;
--==>> Table TBL_출고이(가) 잘렸습니다.

SELECT *
FROM TBL_상품;
--==>>
/*
H001	바밤바	 600	0
H002	죠스바	 500	0
H003	메로나	 500	0
H004	보석바	 600	0
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/
-- 리스트 그대로 있는데 재고수량만 모두 0임

SELECT *
FROM TBL_입고;
--==>>조회 결과 없음

SELECT *
FROM TBL_출고;
--==>>조회 결과 없음


-- 20220314_01_scott(plsql).sql 로 돌아감
-- Line 917 까지 작성하고 돌아옴


--○ 트리거(TRIGGER) 생성 이후 실습 테스트
INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1, 'H001', SYSDATE, 40, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(2, 'H001', SYSDATE, 60, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(3, 'H002', SYSDATE, 50, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_입고;
--==>>
/*
1	H001	2022-03-14 17:41:18	40	1000
2	H001	2022-03-14 17:41:49	60	1000
3	H002	2022-03-14 17:42:07	50	1000
*/

SELECT *
FROM TBL_상품;
--==>>
/*
H001	바밤바	 600	100
H002	죠스바	 500	50
H003	메로나	 500	0
H004	보석바	 600	0
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/


-- 20220314_01_scott(plsql).sql 로 돌아감
-- Line 946 까지 작성하고 돌아옴

-- 생성 이전 확인
SELECT *
FROM TBL_입고;
--==>>
/*
1	H001	2022-03-14	40	1000
2	H001	2022-03-14	60	1000
3	H002	2022-03-14	50	1000
*/

SELECT *
FROM TBL_상품;
--==>> 
/*
H001	바밤바	 600	100
H002	죠스바	 500	50
H003	메로나	 500	0
H004	보석바	 600	0
H005	쌍쌍바	 600	0
H006	수박바	 500	0
H007	빠삐코	 500	0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

--○ 트리거(TRIGGER) 생성 이후 실습 테스트
-- INSERT
INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(4, 'H003', SYSDATE, 20, 400);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(5, 'H003', SYSDATE, 15, 400);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_입고;
--==>> 
/*
4	H003	2022-03-15	20	400
5	H003	2022-03-15	15	400
*/
SELECT *
FROM TBL_상품;
--==>> H003	메로나	500	35


-- UPDATE
UPDATE TBL_입고
SET 입고수량 = 40
WHERE 입고번호 = 4;
--==>> 1 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_입고;
--==>> 4	H003	2022-03-15	40	400
SELECT *
FROM TBL_상품;
--==>> H003	메로나	500	55


-- DELETE
DELETE 
FROM TBL_입고
WHERE 입고번호 = 5;

SELECT *
FROM TBL_입고;
--==>> 5번 없음
SELECT *
FROM TBL_상품;
--==>> H003	메로나	500	40

DELETE 
FROM TBL_입고
WHERE 입고번호 = 4;

SELECT *
FROM TBL_입고;
--==>> 4번 없음
SELECT *
FROM TBL_상품;
--==>> H003	메로나	500	0

ROLLBACK;

