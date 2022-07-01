--■■■ UNION / UNION ALL ■■■--

--○ 실습 테이블 생성(TBL_JUMUN)
--   : 클라이언트가 주문하면, 주문한 걸 기록하는 테이블
CREATE TABLE TBL_JUMUN              -- 주문 테이블 생성
( JUNO      NUMBER                  -- 주문 번호
, JECODE    VARCHAR2(30)            -- 주문된 제품 코드
, JUSU      NUMBER                  -- 주문 수량
, JUDAY     DATE DEFAULT SYSDATE    -- 주문 일자
);
--==>> Table TBL_JUMUN이(가) 생성되었습니다.
--> 고객의 주문이 발생(접수)되었을 경우
--  주문 내용에 대한 데이터가 입력될 수 있는 테이블


--○ 데이터 입력 → 고객의 주문 발생(접수)
INSERT INTO TBL_JUMUN VALUES
(1, '빼빼로', 20, TO_DATE('2001-11-01 09:10:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(2, '거언빵', 10, TO_DATE('2001-11-01 10:20:30', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(3, '모옹쉘', 30, TO_DATE('2001-11-01 11:10:05', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(4, '눈감자', 10, TO_DATE('2001-11-02 13:20:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(5, '나아쵸', 20, TO_DATE('2001-11-05 07:30:22', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(6, '홈런볼', 70, TO_DATE('2001-11-06 15:20:34', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(7, '고래밥', 50, TO_DATE('2001-11-07 11:10:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(8, '포카칩', 20, TO_DATE('2001-11-07 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(9, '포카칩', 20, TO_DATE('2001-11-08 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(10, '포카칩', 20, TO_DATE('2001-11-09 11:12:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(11, '고래밥', 50, TO_DATE('2001-11-10 12:12:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(12, '고래밥', 40, TO_DATE('2001-11-11 08:09:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(13, '홈런볼', 60, TO_DATE('2001-11-12 09:10:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(14, '나아쵸', 20, TO_DATE('2001-11-13 10:11:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(15, '홈런볼', 70, TO_DATE('2001-11-14 11:12:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(16, '홈런볼', 80, TO_DATE('2001-11-15 12:13:14', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(17, '홈런볼', 90, TO_DATE('2001-11-16 13:14:15', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(18, '빼빼로', 10, TO_DATE('2001-11-17 14:15:16', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(19, '빼빼로', 20, TO_DATE('2001-11-19 15:16:17', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(20, '빼빼로', 30, TO_DATE('2001-11-20 16:17:18', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 1 행 이(가) 삽입되었습니다. * 20


--※ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
1	빼빼로	20	2001-11-01 09:10:12
2	거언빵	10	2001-11-01 10:20:30
3	모옹쉘	30	2001-11-01 11:10:05
4	눈감자	10	2001-11-02 13:20:11
5	나아쵸	20	2001-11-05 07:30:22
6	홈런볼	70	2001-11-06 15:20:34
7	고래밥	50	2001-11-07 11:10:13
8	포카칩	20	2001-11-07 19:42:53
9	포카칩	20	2001-11-08 19:42:53
10	포카칩	20	2001-11-09 11:12:23
11	고래밥	50	2001-11-10 12:12:23
12	고래밥	40	2001-11-11 08:09:10
13	홈런볼	60	2001-11-12 09:10:11
14	나아쵸	20	2001-11-13 10:11:12
15	홈런볼	70	2001-11-14 11:12:13
16	홈런볼	80	2001-11-15 12:13:14
17	홈런볼	90	2001-11-16 13:14:15
18	빼빼로	10	2001-11-17 14:15:16
19	빼빼로	20	2001-11-19 15:16:17
20	빼빼로	30	2001-11-20 16:17:18
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 추가 데이터 입력 → 2001년 부터 시작된 주문이 현재(2022년)까지 계속 발생~!!!
INSERT INTO TBL_JUMUN VALUES(98764, '고래밥', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98765, '빼빼로', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98766, '맛동산', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98767, '홈런볼', 40, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98768, '오감자', 50, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98769, '웨하스', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98770, '고래밥', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98771, '맛동산', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98772, '웨하스', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98773, '빼빼로', 90, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98774, '에이스', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98775, '꼬북칩', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
    1	빼빼로	20	2001-11-01 09:10:12
    2	거언빵	10	2001-11-01 10:20:30
    3	모옹쉘	30	2001-11-01 11:10:05
    4	눈감자	10	2001-11-02 13:20:11
    5	나아쵸	20	2001-11-05 07:30:22
    6	홈런볼	70	2001-11-06 15:20:34
    7	고래밥	50	2001-11-07 11:10:13
    8	포카칩	20	2001-11-07 19:42:53
    9	포카칩	20	2001-11-08 19:42:53
   10	포카칩	20	2001-11-09 11:12:23
   11	고래밥	50	2001-11-10 12:12:23
   12	고래밥	40	2001-11-11 08:09:10
   13	홈런볼	60	2001-11-12 09:10:11
   14   나아쵸	20	2001-11-13 10:11:12
   15	홈런볼	70	2001-11-14 11:12:13
   16	홈런볼	80	2001-11-15 12:13:14
   17   홈런볼	90	2001-11-16 13:14:15
   18	빼빼로	10	2001-11-17 14:15:16
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
                 :
98764	고래밥	10	2022-03-02 09:30:11
98765	빼빼로	20	2022-03-02 09:30:37
98766	맛동산	30	2022-03-02 09:31:10
98767	홈런볼	40	2022-03-02 09:31:32
98768	오감자	50	2022-03-02 09:32:00
98769	웨하스	30	2022-03-02 09:32:24
98770	고래밥	20	2022-03-02 09:33:10
98771	맛동산	20	2022-03-02 09:33:38
98772	웨하스	20	2022-03-02 09:33:56
98773	빼빼로	90	2022-03-02 09:34:19
98774	에이스	20	2022-03-02 09:34:37
98775	꼬북칩	30	2022-03-02 09:34:57
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


-- 우리가 만든 테이블 중
-- 시간이 지나면 지날수록 늘어나는 테이블도 있고,
-- 시간이 지나도 유지되는 테이블도 있다.

-- 그 중, TBL_JUMUN 은 어떤 경우?
-- → 계속 늘어나는 테이블

-- DEPT 테이블은?
-- 처음엔 4개였는데, 1년 지나니까 20개 되고, 2년 지나면 30개 됨?
-- EMP 테이블은?
-- → 둘 다 시간 지날수록 계속 늘어나는 테이블 X

-- 입력한 내용을 특정 테이블에 넣을 때,
-- 테이블이 무한정 커질 수 없는 상황이기 때문에
-- 테이블 만들다가 A 테이블 다 찼다고, 
-- A 테이블 다 찼어~ B 테이블에 데이터 넣어주세요 라고 할까?
-- NO ! 이렇게 만들지 않는다.

-- A 테이블에 데이터 가득 차게 되면, 늘어난 데이터를 다른 테이블에 백업
-- 그러고 또 데이터는 A 테이블에 차서 가득 차면, 또 백업 
-- 이런식으로 한다.


--※ 상기가 과자 쇼핑몰 운영 중...
--   TBL_JUMUN 테이블이 너무 무거워진 상황
--   어플리케이션과의 연동으로 인해 주문 내역을 다른 테이블에
--   저장될 수 있도록 만드는 것은 불가능한 상황
--   기존의 모든 데이터를 덮어놓고 지우는 것도 불가능한 상황
--   → 결과적으로...
--      현재까지 누적된 주문 데이터들 중
--      금일 발생한 주문 내역을 제외하고
--      나머지 데이터를 다른 테이블(TBL_JUMUNBACKUP)로 데이터 이관을 수행할 계획

CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--                                           -------
--                                     2022-03-02 10:09:38
--                                   ------------------------------
--                                             2022-03-02
--==>> Table TBL_JUMUNBACKUP이(가) 생성되었습니다.


SELECT *
FROM TBL_JUMUN;
-- TBL_JUMUN 테이블은 바뀐 게 없지만,

SELECT *
FROM TBL_JUMUNBACKUP;
-- TBL_JUMUNBACKUP 테이블에는 오늘을 제외한 이전 데이터들이 쭉 들어가 있음
--==>>
/*
 1	빼빼로	20	2001-11-01 09:10:12
 2	거언빵	10	2001-11-01 10:20:30
 3	모옹쉘	30	2001-11-01 11:10:05
 4	눈감자	10	2001-11-02 13:20:11
 5	나아쵸	20	2001-11-05 07:30:22
 6	홈런볼	70	2001-11-06 15:20:34
 7	고래밥	50	2001-11-07 11:10:13
 8	포카칩	20	2001-11-07 19:42:53
 9	포카칩	20	2001-11-08 19:42:53
10	포카칩	20	2001-11-09 11:12:23
11	고래밥	50	2001-11-10 12:12:23
12	고래밥	40	2001-11-11 08:09:10
13	홈런볼	60	2001-11-12 09:10:11
14	나아쵸	20	2001-11-13 10:11:12
15	홈런볼	70	2001-11-14 11:12:13
16	홈런볼	80	2001-11-15 12:13:14
17	홈런볼	90	2001-11-16 13:14:15
18	빼빼로	10	2001-11-17 14:15:16
19	빼빼로	20	2001-11-19 15:16:17
20	빼빼로	30	2001-11-20 16:17:18
*/
--==> TBL_JUMUN 테이블의 데이터들 중
--    금일 주문 내역 이외의 데이터는 모두 TBL_JUMUNBACKUP 테이블에
--    백업을 마친 상태


-- TBL_JUMUN 테이블의 데이터들 중
-- 백업을 마친 데이터들 삭제 → 즉, 금일 발생한 주문 내역이 아닌 데이터들 제거
DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> 20개 행 이(가) 삭제되었습니다.


SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	고래밥	10	2022-03-02 09:30:11
98765	빼빼로	20	2022-03-02 09:30:37
98766	맛동산	30	2022-03-02 09:31:10
98767	홈런볼	40	2022-03-02 09:31:32
98768	오감자	50	2022-03-02 09:32:00
98769	웨하스	30	2022-03-02 09:32:24
98770	고래밥	20	2022-03-02 09:33:10
98771	맛동산	20	2022-03-02 09:33:38
98772	웨하스	20	2022-03-02 09:33:56
98773	빼빼로	90	2022-03-02 09:34:19
98774	에이스	20	2022-03-02 09:34:37
98775	꼬북칩	30	2022-03-02 09:34:57
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--※ 아직 제품 발송이 이루어지지 않은 금일 주문 데이터를 제외하고
--   이전의 모든 주문 데이터들이 삭제된 상황이므로
--   테이블은 행(레코드)의 개수가 줄어들어 매우 가벼워진 상황이다.


-- 테이블이 무거워져서 테이블을 나눠놨더니 생기는 문제점,,
-- 합쳐서 연산처리 해야될 때가 있음
-- ex)
-- 국세청에서 세무조사 나옴
-- TBL_JUMUN 만 보여주면 안됨 
-- 이전데이터들도 필요함
-- → 그럴 때 써야하는게 『UNION』, 『UNION ALL』


-- 그런데, 지금까지 주문받은 내역에 대한 정보를
-- 제품별 총 주문량으로 나타내어야 할 상황이 발생하게 되었다.
-- ex) 지금까지 홈런볼은 총 몇 개를 팔았고, 고래밥은 총 몇 개를 팔았는지
--     제품별 총 주문량 필요함
-- 그렇다면, TBL_JUMUNBACKUP 테이블의 레코드(행)와
-- TBL_JUMUN 테이블의 레코드(행)를 합쳐서
-- 하나의 테이블을 조회하는 것과 같은 결과를 확일할 수 있도록
-- 조회가 이루어져야 한다.


--※ 컬럼과 컬럼의 관계를 고려하여 테이블을 결합하고자 하는 경우
--   JOIN 을 사용하지만
--   레코드와 레코드를 결합하고자 하는 경우
--   UNION / UNION ALL 을 사용할 수 있다.

-- TBL_JUMUN, TBL_JUMUNBACKUP 합쳐서 보려면
-- 사이에 『UNION』 또는 『UNION ALL』 넣으면 됨
SELECT *
FROM TBL_JUMUN;
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;


--※ UNION 은 항상 결과물의 첫 번째 컬럼을 기준으로 오름차순 정렬을 수행한다.
--   (→ 여기서는 JUNO로 정렬)
--   UNION ALL 은 결합된 순서대로(테이블을 쿼리문에서 명시한 순서대로)
--   조회한 결과를 반환한다.(즉, 정렬 기능 없음)
--   (→ 여기서는 TBL_JUMUN 테이블 → TBL_JUMUNBACKUP 테이블 순서)
--   이로 인해 UNION 이 부하가 더 크다. (리소스 소모가 더 크다.)
--   또한, UNION 은 결과물에 중복된 행이 존재할 경우
--   중복을 제거하고 1개 행만 조회된 결과를 반환하게 된다.

--   실무에서도,
--   중복 제거하지 않고 있는 그대로 더 봐야할 경우가 많기 때문에,
--   UNION 은 부하가 크기 때문에,
--   UNION 보다 UNION ALL 을 더 많이 써야 한다.


--○ 지금까지 주문받은 데이터들 통해
--   제품별 총 주문량을 조회할 수 있는 쿼리문을 구성한다.
SELECT T.JECODE "제품코드", SUM(T.JUSU) "주문수량"
FROM
(
    SELECT *
    FROM TBL_JUMUN
    UNION ALL
    SELECT *
    FROM TBL_JUMUNBACKUP
) T
GROUP BY T.JECODE;
--==>>
/*
나아쵸	 40
꼬북칩	 30
맛동산	 50
웨하스	 50
눈감자	 10
에이스	 20
오감자	 50
포카칩	 60
거언빵	 10
모옹쉘	 30
빼빼로	190
홈런볼	410
고래밥	170
*/


--○ 데이터 추가 입력
INSERT INTO TBL_JUMUN VALUES (98776, '모옹쉘', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	고래밥	10	2022-03-02
98765	빼빼로	20	2022-03-02
98766	맛동산	30	2022-03-02
98767	홈런볼	40	2022-03-02
98768	오감자	50	2022-03-02
98769	웨하스	30	2022-03-02
98770	고래밥	20	2022-03-02
98771	맛동산	20	2022-03-02
98772	웨하스	20	2022-03-02
98773	빼빼로	90	2022-03-02
98774	에이스	20	2022-03-02
98775	꼬북칩	30	2022-03-02
98776	모옹쉘	30	2022-03-02
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ INTERSECT / MINUS (→ 교집합과 차집합)

-- TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
-- 제품코드와 주문수량의 값이 똑같은 행만 추출하고자 한다.
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
모옹쉘	30
빼빼로	20
*/



--○ TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블을 대상으로
--   제품코드와 주문량의 값이 똑같은 행의 정보를
--   주문번호, 제품코드, 주문량, 주문일자 항목으로 조회
SELECT *
FROM TBL_JUMUN;


--○ 데이터 추가 입력
INSERT INTO TBL_JUMUN VALUES(98777, '모옹쉘', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98778, '빼빼로', 40, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98779, '맛동산', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98780, '모옹쉘', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98781, '빼빼로', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_JUMUN;
--==>>
/*
98778	빼빼로	40	2022-03-02
98779	맛동산	20	2022-03-02
98764	고래밥	10	2022-03-02
98765	빼빼로	20	2022-03-02
98766	맛동산	30	2022-03-02
98767	홈런볼	40	2022-03-02
98768	오감자	50	2022-03-02
98769	웨하스	30	2022-03-02
98770	고래밥	20	2022-03-02
98771	맛동산	20	2022-03-02
98772	웨하스	20	2022-03-02
98773	빼빼로	90	2022-03-02
98774	에이스	20	2022-03-02
98775	꼬북칩	30	2022-03-02
98776	모옹쉘	30	2022-03-02
98777	모옹쉘	10	2022-03-02
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--------------------------------------------------------------------------------
--※ TBL_JUMUN_scott.sql 파일을 통해 데이터 갱신~!!!
--------------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
모옹쉘	30
빼빼로	20
빼빼로	30
*/


--방법 1.
SELECT T2.JUNO "주문번호", T1.JECODE "제품코드"
     , T1.JUSU "주문수량", T2.JUDAY "주문일자"
FROM 
(
    SELECT JECODE, JUSU
    FROM TBL_JUMUNBACKUP
    INTERSECT
    SELECT JECODE, JUSU
    FROM TBL_JUMUN
) T1
JOIN
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T2
ON  T1.JECODE = T2.JECODE
AND T1.JUSU = T2.JUSU;
--==>>
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:47
98765	빼빼로	20	2022-03-02 09:30:30
98776	모옹쉘	30	2022-03-02 11:28:12
*/


--방법 2.
SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE T.JECODE IN('빼빼로', '모옹쉘')
  AND T.JUSU IN (20, 30);
--==>>
/*
    1	빼빼로	20	2001-11-01 09:10:12     ◀
    3	모옹쉘	30	2001-11-01 11:10:05     ◀
   19	빼빼로	20	2001-11-19 15:16:17     ◀
   20	빼빼로	30	2001-11-20 16:17:18     ◀   
98780	모옹쉘	20	2022-03-02 14:13:43    CHECK~!!! → 얘는 안나와야 하는데 나옴
98781	빼빼로	30	2022-03-02 14:13:47     ◀
98765	빼빼로	20	2022-03-02 09:30:30     ◀
98776	모옹쉘	30	2022-03-02 11:28:12     ◀
*/
-- 모옹쉘 20 개가 나온 이유는,
-- 제품코드, 주문수량 안에 다 포함되기 때문


SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE,T.JUSU)
    IN ('모옹쉘30', '빼빼로20', '빼빼로30');
--==>>
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:47
98765	빼빼로	20	2022-03-02 09:30:30
98776	모옹쉘	30	2022-03-02 11:28:12
*/


SELECT T.*
FROM 
(
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUNBACKUP
    UNION ALL
    SELECT JUNO, JECODE, JUSU, JUDAY
    FROM TBL_JUMUN
) T
WHERE CONCAT(T.JECODE,T.JUSU) IN (SELECT CONCAT(JECODE, JUSU)
                                  FROM TBL_JUMUNBACKUP
                                  INTERSECT
                                  SELECT CONCAT(JECODE, JUSU)
                                  FROM TBL_JUMUN
                                 );
--==>>
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:47
98765	빼빼로	20	2022-03-02 09:30:30
98776	모옹쉘	30	2022-03-02 11:28:12
*/


--+) 데베설 PPT 공부 하다, UNION ALL 절에 ORDER BY 쓰는거 예시
SELECT JECODE, JUNO, JUSU, 'PAST' "TIME" 
FROM TBL_JUMUN
UNION ALL
SELECT JECODE, JUNO, JUSU, 'NOW' "TIME"
FROM TBL_JUMUNBACKUP
ORDER BY 1;

--------------------------------------------------------------------------------
    
--○ TBL_EMP 테이블에서 급여가 가장 많은 사원의
--   사원번호, 사원명, 직종명, 급여 항목을 조회하는 쿼리문을 구성한다.
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE SAL = (SELECT MAX(SAL)
             FROM EMP);
--==>> 7839	KING	PRESIDENT	5000

--『= ANY』

--『= ALL』 

SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL = ALL(800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>> 조회 결과 없음


SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL(800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000, 1500, 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>> 7839	KING	PRESIDENT	5000


SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE SAL >= ALL (SELECT SAL
                  FROM TBL_EMP);
--==>> 7839	KING	PRESIDENT	5000


--○ TBL_EMP 테이블에서 20번 부서에 근무하는 사원 중
--   급여가 가장 많은 사원의
--   사원번호, 사원명, 직종명, 급여 항목을 조회하는 쿼리문을 구성한다.
SELECT EMPNO, ENAME, JOB, SAL
FROM TBL_EMP
WHERE DEPTNO = 20
  AND SAL >= ALL (SELECT SAL
                  FROM TBL_EMP
                  WHERE DEPTNO = 20);
--==>>
/*
7902	FORD	ANALYST	3000
7788	SCOTT	ANALYST	3000
*/


--○ TBL_EMP 테이블에서 수당(커미션: COMM)이 가장 많은 사원의
--   사원번호, 사원명, 부서번호, 직종명, 커미션 항목을 조회한다.
--①
SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM = (SELECT MAX(COMM)
              FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400

--②
SELECT EMPNO, ENAME, DEPTNO, JOB, COMM
FROM TBL_EMP
WHERE COMM >= ALL (SELECT COMM
                   FROM TBL_EMP
                   WHERE COMM IS NOT NULL);
--===>> 7654	MARTIN	30	SALESMAN	1400


--○ DISTINCT() 중복 행(레코드)을 제거하는 함수
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO = (관리자로 등록된 번호);

SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (SELECT MGR
                FROM EMP);
--==>
/*
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7788	SCOTT	ANALYST
7839	KING	PRESIDENT
7902	FORD	ANALYST
*/

--위의 코드는 아래와 같다.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (7902, 7698, 7698, 7839, 7698, 7839, 7839, 7566, NULL, 7698, 7788, 7698, 7566, 7782);
--> 번호 중복되는 거 있어서,
--  같은 건데 계속 찾게 됨

-- 그래서 쓰게 되는게
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR)
                FROM EMP);
--==>>
/*
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7788	SCOTT	ANALYST
7839	KING	PRESIDENT
7902	FORD	ANALYST
*/

--위의 코드는 아래와 같다.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (7839, NULL, 7782, 7698, 7902, 7566, 7788);


SELECT DISTINCT(JOB)
FROM EMP;
--==>>
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
*/

SELECT DISTINCT(DEPTNO)
FROM EMP;
--==>>
/*
30
20
10
*/


--------------------------------------------------------------------------------

-- 나는 데이터를 연월일 까지만 보고 싶은데,
-- 시분초까지 다 나와있다고, 
-- 원래는 세션 건드리는 거 아님! 
-- 지금은 그냥 배우니까 하는 거지
-- ALTER SESSION SET NSL_DATE_FORMAT = 'YYYY-MM-DD'; 하는게 아니라
-- TO_DATE() 사용해서 원하는 형식으로 바꿔서 봐야함


SELECT *
FROM TBL_SAWON;
--==>>
/*
1017	이호석	    9611121234567	2022-02-23	5000
1018	신시은	    9910312234567	2022-02-23	5000
1001	김민성	    9707251234567	2005-01-03	3000
1002	서민지	    9505152234567	1999-11-23	4000
1003	이지연	    9905192234567	2006-08-10	3000
1004	이연주	    9508162234567	2007-10-10	4000
1005	오이삭	    9805161234567	2007-10-10	4000
1006	이현이	    8005132234567	1999-10-10	1000
1007	박한이	    0204053234567	2010-10-10	1000
1008	선동렬	    6803171234567	1998-10-10	1500
1009	선우용녀	6912232234567	1998-10-10	1300
1010	선우선	    0303044234567	2010-10-10	1600
1011	남주혁	    0506073234567	2012-10-10	2600
1012	남궁민	    0208073234567	2012-10-10	2600
1013	남진  	    6712121234567	1998-10-10	2200
1014	홍수민	    0005044234567	2015-10-10	5200
1015	임소민	    9711232234567	2007-10-10	5500
1016	이이경	    0603194234567	2015-01-20	1500
*/

--○ TBL_SAWON 테이블 백업(데이터 위주) → 각 테이블 간의 관계나 제약조건 등은 제외
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT SANO, SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP이(가) 생성되었습니다.


--○ 데이터 활용... 관리... 여러 형태로 운용....하다가

--○ 데이터 수정할 일이 생김 → 1행 고치려다가 1800000행 다 UPDATE 해버림,,,
UPDATE TBL_SAWON
SET SANAME = '똘똘이';

COMMIT;

SELECT *
FROM TBL_SAWON;
--==>>
/*
1017	똘똘이	9611121234567	2022-02-23	5000
1018	똘똘이	9910312234567	2022-02-23	5000
1001	똘똘이	9707251234567	2005-01-03	3000
1002	똘똘이	9505152234567	1999-11-23	4000
1003	똘똘이	9905192234567	2006-08-10	3000
1004	똘똘이	9508162234567	2007-10-10	4000
1005	똘똘이	9805161234567	2007-10-10	4000
1006	똘똘이	8005132234567	1999-10-10	1000
1007	똘똘이	0204053234567	2010-10-10	1000
1008	똘똘이	6803171234567	1998-10-10	1500
1009	똘똘이	6912232234567	1998-10-10	1300
1010	똘똘이	0303044234567	2010-10-10	1600
1011	똘똘이	0506073234567	2012-10-10	2600
1012	똘똘이	0208073234567	2012-10-10	2600
1013	똘똘이	6712121234567	1998-10-10	2200
1014	똘똘이	0005044234567	2015-10-10	5200
1015	똘똘이	9711232234567	2007-10-10	5500
1016	똘똘이	0603194234567	2015-01-20	1500
*/

--○ 데이터 복원 (UPDATE) → 불완전복구
UPDATE TBL_SAWON
SET SANAME = (SELECT SANAME
              FROM TBL_SAWONBACKUP
              WHERE SANO = TBL_SAWON.SANO)
WHERE SANAME = '똘똘이';
--==>> 18개 행 이(가) 업데이트되었습니다.

SELECT *
FROM TBL_SAWON;
--==>>
/*
1017	이호석	    9611121234567	2022-02-23	5000
1018	신시은	    9910312234567	2022-02-23	5000
1001	김민성	    9707251234567	2005-01-03	3000
1002	서민지	    9505152234567	1999-11-23	4000
1003	이지연	    9905192234567	2006-08-10	3000
1004	이연주	    9508162234567	2007-10-10	4000
1005	오이삭	    9805161234567	2007-10-10	4000
1006	이현이	    8005132234567	1999-10-10	1000
1007	박한이	    0204053234567	2010-10-10	1000
1008	선동렬	    6803171234567	1998-10-10	1500
1009	선우용녀	6912232234567	1998-10-10	1300
1010	선우선	    0303044234567	2010-10-10	1600
1011	남주혁	    0506073234567	2012-10-10	2600
1012	남궁민	    0208073234567	2012-10-10	2600
1013	남진	    6712121234567	1998-10-10	2200
1014	홍수민	    0005044234567	2015-10-10	5200
1015	임소민	    9711232234567	2007-10-10	5500
1016	이이경	    0603194234567	2015-01-20	1500
*/

COMMIT;
--==>> 커밋 완료.


-- HR 로 이동

