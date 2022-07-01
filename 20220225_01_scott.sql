SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ ROW_NUMBER ■■■--

SELECT ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;
--==> 결과확인하면 사원명 앞에 컬럼 앞에 우리가 데이터 몇 개인지
--    편하게 확인할 수 있도록 1~14의 숫자 써있음 → 행번호
--    실제 데이터에도 이렇게 숫자 있을까? NO. 없다
--    → 이 개념이 ROW_NUMBER


-- ROW_NUMER() OVER(행번호 뭘 기준으로 붙일건지 조건)
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP;
--==>>
/*
 1	KING	5000	1981-11-17
 2	FORD	3000	1981-12-03
 3	SCOTT	3000	1987-07-13
 4	JONES	2975	1981-04-02
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 7	ALLEN	1600	1981-02-20
 8	TURNER	1500	1981-09-08
 9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	 950	1981-12-03
14	SMITH	 800	1980-12-17
*/


-- ROW_NUMBER() OVER() 에서 쓰게되는 ORDER BY랑
-- 쿼리문 자체에서 쓰는 ORDER BY 랑 다르다.
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP
ORDER BY ENAME;
-- 행번호는 SAL DESC 기준으로 붙었지만,
-- 정렬은 ENAME 기준으로 정렬됨
--==>>
/*
12	ADAMS	1100	1987-07-13
 7	ALLEN	1600	1981-02-20
 5	BLAKE	2850	1981-05-01
 6	CLARK	2450	1981-06-09
 2	FORD	3000	1981-12-03
13	JAMES	 950	1981-12-03
 4	JONES	2975	1981-04-02
 1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
 9	MILLER	1300	1982-01-23
 3	SCOTT	3000	1987-07-13
14	SMITH	 800	1980-12-17
 8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"
     , ENAME "사원명", SAL "급여", HIREDATE "입사일"
FROM EMP
ORDER BY ENAME;
--==>>
/*
 1	ADAMS	1100	1987-07-13
 2	ALLEN	1600	1981-02-20
 3	BLAKE	2850	1981-05-01
 4	CLARK	2450	1981-06-09
 5	FORD	3000	1981-12-03
 6	JAMES	 950	1981-12-03
 7	JONES	2975	1981-04-02
 8	KING	5000	1981-11-17
 9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	 800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/


SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "테스트"
     , ENAME "사원명", DEPTNO "부서번호", SAL "급여", HIREDATE "입사일"
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;
--==>>
/*
1	ADAMS	20	1100	1987-07-13
2	FORD	20	3000	1981-12-03
3	JONES	20	2975	1981-04-02
4	SCOTT	20	3000	1987-07-13
5	SMITH	20	 800	1980-12-17
*/
-- 위에 쿼리와 결과가 쫌 다름
-- FROM에서 조건 타겟팅하고, WHERE 조건에 해당되는 애들 메모리에 퍼올리고,
-- 그 메모리에 퍼올려진 애들에 ROW_NUMBER 붙이는 거임
-- 그냥 EMP 가 가지고 있는 모든 애들한테 
-- ROW_NUMBER 부여하고 가지고 오는게 아니다 !



--※ 게시판의 게시물 번호를 SEQUENCE 나 IDENTITY 를 사용하게 되면
--   게시물을 삭제했을 경우, 삭제한 게시물의 자리에 다음 번호를 가진
--   게시물이 등록되는 상황이 발생하게 된다.
--   이는... 보안성 측면이나... 미관상... 
--   바람직하지 않은 상황일 수 있기 때문에
--   ROW_NUMBER() 의 사용을 고려해 볼 수 있다.
--   관리의 목적으로 사용할 때에는 SEQUENCE 나 IDENTITY 를 사용하지만
--   단순히 게시물을 목록화하여 사용자에게 리스트 형식으로 보여줄 때에는
--   사용하지 않는 것이 바람직하다.

-- SEQUENCE 는 ORACLE 에서 쓰는 개념이고,
-- IDENTITY 는 MSSQL  에서 쓰는 개념이다.

-- +)
-- 모든 레코드에는 식별자 형식으로 뭔가를 부여하는게 관리하기 편하다.
-- 게시물에 대한 번호를 DB상에는 물론 99.99% 있지만,
-- 그걸 클라이언트가 알게 하느냐, 아니냐에 대한 차이는 크다.
-- 그 번호를 알고 있으면, 악의적인 목적가지고 해킹도 가능해진다.
-- 보안상으로도 문제가 있을 수도 있고, 미관상 문제가 있을 수 있다.
-- 고유한 식별자로 활용하게 되는 번호들은
-- ex) 게시물 등록 예시보면,

-- 4 ... ...
-- 3 ... ...
-- 2 ...
-- 1 .... ...

--> 2번은 미니홈피 주인이 지우고, 3번은 관리자가 지움
-- 7 ...
-- 6 ... ..
-- 5 ... ..... ..
-- 4 ... ...
-- 1 .... ...

--> 5번, 6번 미니홈피 주인이 지움
-- 7 ...
-- 4 ... ...
-- 1 .... ...

--> 이러면 이 게시판에 대한 느낌 어때?
--  이게 만약 후기, 배달어플 이런거에 관련된 거라면
--  '이거 관리자가 게시판에 대한 검열 엄청 심한거 아니야?'
--   라는 선입견 생길 수도 있음 → 미관상 좋지 않음




--★★★ 여기서부터 정신 차리고 다시~!!!! ★★★--
-- 시퀀스 실수함,,,,ㅎㅎ
-- ROLLBACK 하고 다시 한다고 시퀀스 돌아오는 거 아님,,,
-- DBA한테 시퀀스 새로 만들어달라고 얘기해야됨,,


--○ 기존 잘못 운용되던 시퀀스 삭제
DROP SEQUENCE SEQ_BOARD;
--==>> Sequence SEQ_BOARD이(가) 삭제되었습니다.


--○ SEQUENCE(시퀀스 : 주문번호) 생성
--   → 사전적인 의미 : 1.(일련의) 연속적인 사건들    2.(사건 행동 등의) 순서
-- ex) 은행에 대기표 뽑는거, 맛집가면 대기열에서 번호받는거.....
-- 게시판에 게시물 쓸 때, 우리가 직접 번호 부여해서 쓰지 않음
-- 내가 숫자 5 좋아한다고 오늘은 55번 게시물 써야지~ 한다고 그러는거 아님
-- 그냥 쓰고 보니까 부여된 번호가 55번 인거임
-- CREATE SEQUENCE 시퀀스명 → 여기까지만 쓰더라도 기본 시퀀스 생성됨
--                          (1부터 시작해서 1씩 증가해서 무한대까지가는 거 생성됨)

CREATE SEQUENCE SEQ_BOARD   -- 기본적인 시퀀스 생성 구문
START WITH 1                -- 시작값
INCREMENT BY 1                 -- 증가값
NOMAXVALUE                  -- 최댓값
NOCACHE;                    -- 캐시사용여부  
--==>> Sequence SEQ_BOARD이(가) 생성되었습니다.
-- 그냥 CREATE SEQUENCE SEQ_BOARD 까지만하면
-- 위에 쿼리문에서 NOCACHE 만 제외한 거랑 똑같은 결과로 생성됨

-- NOCACHE : 미리 사용될거 뽑아두는 개념!
--           처리해야되는거 10개 있어서 10개 미리 뽑아두면,
--           다른 사람 와서 이용할 때는 아직 앞에 10개 다 쓴 것도 아닌데 11번 해야됨,,,
-- NOCACHE
-- 장점 : 번호표 발급 받는 사람이 대기열에서 오래 안기다려도 된다.
-- 단점 : 미리 뽑아두고, 다른 업무 수행하고 있으면, 
--        다음 사람은 일련번호로 다음 번호를 뽑게 되는 게 아니라 
--        그만큼 뛰어넘고 난 번호를 쓰게 됨,,


-- 지금 이거는 테이블이랑 관련있게 만든게 아니라,
-- 독립적으로 따로 운용하는 거임


-- 밑에까지 데이터 삽입했는데,,, 실수해서 수행한거,,!!
-- ★ 기존 잘못된 데이터가 입력된 테이블 제거
DROP TABLE TBL_BOARD PURGE;
--==>> Table TBL_BOARD이(가) 삭제되었습니다.


SELECT *
FROM TAB;
--==>>
/*
BIN$Axk+pwWoSfmnxwvAP+d4Ig==$0	TABLE	
BIN$axIj+yKKRF6zdZShmlj9Cg==$0	TABLE	
BIN$oIjkpveUQhikguzRf40KDA==$0	TABLE	
    :
*/
-- 했을 때 BIN$ 어쩌고 나오는거
-- 제거했는데 휴지통에 들어있는 애들,,
-- 위에 DROP TABLE TBL_BOARD 실행하면 또 BIN$ 어쩌고로 나옴
-- 휴지통에 들어가지 않도록 하고 제거하는건 뒤에 『PURGE』 옵션 붙여주면 됨
-- WINDOWS에서도 그냥 DELETE 하면 휴지통가지면
--                    SHIFT + DELETE 하면 휴지통 가지않고 영구삭제됨


--※ 휴지통 비우기
PURGE RECYCLEBIN;
--==>> RECYCLEBIN이(가) 비워졌습니다.

-- 다시 테이블 확인
SELECT *
FROM TAB;
--==>> BIN$ 어쩌고 하는것들 다 사라져있음


-- 『PURGE』  『PURGE RECYCLEBIN』 이거 둘 다,,
-- BUT, 
-- 알아두기만 하고 쓰지는 말자
-- DB에서 휴지통 거치지 않고 삭제해버리면, 복구하기 어마어마하게 힘들어짐,,
-- 이걸 알아서 문제가 되는 경우가 더 많음,,!!


--○ 실습 테이블 생성
CREATE TABLE TBL_BOARD              -- TBL_BOARD 테이블 생성 구문 → 게시판 테이블
--                                                          사용자가직접작성?
( NO        NUMBER                  -- 게시물 번호           Ⅹ
, TITLE     VARCHAR2(50)            -- 게시물 제목           ○
, CONTENTS  VARCHAR2(1000)          -- 게시물 내용           ○
, NAME      VARCHAR2(20)            -- 게시물 작성자         △
, PW        VARCHAR2(20)            -- 게시물 패스워드       △ --할때도안할때도
, CREATED   DATE DEFAULT SYSDATE    -- 게시물 작성일         Ⅹ
);
--==>> Table TBL_BOARD이(가) 생성되었습니다.


--○ 데이터 입력 → 게시판에 게시물을 작성하는 액션
INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '풀숲', '전 풀숲에 있어요', '박현수', 'java006$', DEFAULT);
--     ------------------
--     'SEQ_BOARD 시퀀스의 다음 번호를 얻어내 사용하겠다' 는 의미
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '오로라', '밤하늘 좋네요', '정은정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '해변', '바람이 부네요', '양윤정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '인터뷰', '인터뷰중인데, 아이가 들어오네요', '이시우', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '살려주세요', '물에 빠졌어요', '최문정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '내가 주인공', '나만 빼고 다 블러', '김민성', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '지구정복', '지구를 정복하러 왔다', '김정용', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '당연히', '아무 이유 없다', '이아린', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 세션 설정 변경 ('연월일시분초'로)
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	풀숲	        전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:29:37
2	오로라	        밤하늘 좋네요	                정은정	java006$	2022-02-25 10:30:08
3	해변	        바람이 부네요	                양윤정	java006$	2022-02-25 10:30:20
4	인터뷰	        인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:30:36
5	살려주세요	    물에 빠졌어요	                최문정	java006$	2022-02-25 10:30:57
6	내가 주인공	    나만 빼고 다 블러	            김민성	java006$	2022-02-25 10:31:24
7	지구정복	    지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:31:35
8	당연히	        아무 이유 없다	                이아린	java006$	2022-02-25 10:31:52
*/
-- 아직 디스크 상에 저장된 거 아님


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시물 삭제
--① 일단 내용 조회 먼저 하고, 맞으면
SELECT *
FROM TBL_BOARD
WHERE NO = 2;


--② 조회내용이 삭제할 게 맞다면 
--   SELECT 를 DELETE로 바꿔줌
DELETE
FROM TBL_BOARD
WHERE NO = 2;
--==>> 1 행 이(가) 삭제되었습니다.


-- 다른 거 또 삭제
DELETE
FROM TBL_BOARD
WHERE NO = 3;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_BOARD
WHERE NO = 5;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_BOARD
WHERE NO = 6;
--==>> 1 행 이(가) 삭제되었습니다.


-- 삭제 완료하고 테이블 다시 조회
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	풀숲	    전 풀숲에 있어요	            박현수	java006$	2022-02-25 10:29:37
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:30:36
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:31:35
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:31:52
*/
-- 1, 4, 7, 8이라고 번호 나와서 정리되어 있는 느낌이 아님,,


--○ 게시물 추가 작성
INSERT INTO TBL_BOARD 
VALUES (SEQ_BOARD.NEXTVAL, '형광등', '조명이 좋아요', '우수정', 'java006$', SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_BOARD;
--==>>
/*
1	풀숲	    전 풀숲에 있어요                박현수	java006$	2022-02-25 10:29:37
4	인터뷰	    인터뷰중인데, 아이가 들어오네요	이시우	java006$	2022-02-25 10:30:36
7	지구정복	지구를 정복하러 왔다	        김정용	java006$	2022-02-25 10:31:35
8	당연히	    아무 이유 없다	                이아린	java006$	2022-02-25 10:31:52
9	형광등	    조명이 좋아요	                우수정	java006$	2022-02-25 10:40:32
*/
-- 새로 작성된 건 중간으로 들어가는 거 아니고,
-- 그냥 9번으로 나옴


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 게시판의 게시물 리스트를 보여주는 쿼리문 구성
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>>
/*
5	형광등	    우수정	2022-02-25 10:40:32
4	당연히	    이아린	2022-02-25 10:31:52
3	지구정복    	김정용	2022-02-25 10:31:35
2	인터뷰	    이시우	2022-02-25 10:30:36
1	풀숲	        박현수	2022-02-25 10:29:37
*/
-- 앞에 있는 숫자는 게시물의 직접적인 번호가 아님
-- 가장 최근에 쓴 글이 가장 위에 보여짐
-- 클라이언트가 보는 입장에서는 이게 훨씬 보기 좋음


--○ 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_BOARDLIST
AS
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "글번호"
     , TITLE "제목", NAME "작성자", CREATED "작성일"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>> View VIEW_BOARDLIST이(가) 생성되었습니다.


--○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_BOARDLIST;
--==>>
/*
5	형광등	    우수정	2022-02-25 10:40:32
4	당연히	    이아린	2022-02-25 10:31:52
3	지구정복	김정용	2022-02-25 10:31:35
2	인터뷰	    이시우	2022-02-25 10:30:36
1	풀숲	    박현수	2022-02-25 10:29:37
*/

-- ROW_NUMBER() 왜 쓰는지
-- SEQUENCE 주의사항 등 잘 파악해야 함!!


--------------------------------------------------------------------------------

--■■■ JOIN(조인) ■■■--

-- SMITH의 부서를 확인하려면 2가지 과정을 거쳐야 한다.
SELECT *
FROM EMP;
--==>> 7369	SMITH	CLERK	7902	1980-12-17 00:00:00	800		20
-- 아, 20번 부서구나

SELECT *
FROM DEPT;
--==>>
/*
10	ACCOUNTING	NEW YORK
20	RESEARCH	DALLAS
30	SALES	    CHICAGO
40	OPERATIONS	BOSTON
*/
-- 아 20번 부서는 RESEARCH 부서구나

--> SMITH는 RESEARCH 부서

-- 그냥 EMP 테이블 저기 부서번호 뒤에, 부서명/부서전화번호/부서최고관리자....
-- 다 나오게 조회하면 좋을텐데,,!
-- 뒤에 SALGRADE 테이블에 있는 SMITH 에 해당되는 급여등급도 1등급 나오게 
-- 테이블 한 번에 보여지게 하면 좋을 거 같다.

-- BUT, 그 전에
-- 얘네를 왜 나눠놨을까? 에 먼저 접근해보자
-- EMP 테이블을
--①
SELECT *
FROM EMP;

--②
SELECT ENAME
FROM EMP;

--③
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP;

-- 이거 중 메모리 가장 많이 쓰는 건 
-- ①번 아니라!!!
-- ** 다 똑같다 **
-- ★★ EMP 테이블을 몽땅 다 메모리에 퍼올린 다음에 처리되기 때문에 ★★
-- SELECT 는 CPU가 뭐를 보여줄 지 선택하는 거

-- 내가 한 컬럼만 조회한다고 하더라도,
-- 해당 테이블이 100개의 컬럼이 있다면
-- 그래도 무조건 100개의 컬럼값들이 다 메모리에 올라갈 수 밖에 없다....

-- 그렇기 때문에 테이블을 나눠놓은 것이다.
-- 나눠져 있어야 2개 중 하나만 조회한다고 해도
-- 100개 모두가 메모리에 올라가는 일이 없기 때문에 !!

-- DB서버의 메모리 낭비를 막기 위해서
-- 하나의 테이블을 여러개로 나누는 게 → 『정규화』
-- → 테이블이 여러개로 흩어져 있고, 그 아이들이 관계를 맺게끔 처리되어 있음
--    나눠진 테이블을 원래대로 복원해서 볼 수도 있어야 하기 때문에


-- 1. SQL 1992 CODE

--○ CROSS JOIN : 모든 경우의 수를 다 뽑아내야한다.
SELECT *
FROM EMP, DEPT;
--> 수학에서 말하는 데카르트 곱(CARTESIAN PRODUCT)
--  EMP, DEPT 두 테이블을 결합한 모든 경우의 수가 다 나온다.
--  ex)
--  10번 부서와 결합되어 있는 SMITH
--  20번 부서와 결합되어 있는 SMITH
--  30번 부서와 결합되어 있는 SMITH 
--  가 다 나온다.


--○ EQUI JOIN : 서로 정확히 일치하는 것들끼리 연결하여 결합시키는 결합 방법
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- 이제는 20번 부서인 SMITH 만 나온다.
-- 두 테이블의 관계를 통해서 데이터를 완성해가는 구조
-- EQUI JOIN 이 JOIN 안에서 가장 많이 쓰인다.


-- 위에 쿼리는
-- 별칭 형식으로 아래처럼도 가능하다.
SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;


--○ NO EQUI JOIN : 범위 안에 적합한 것들끼리 연결하여 결합시키는 결합 방법
-- 정확하게 딱 일치하는 게 아니라, 어느 범위 안에 들어가 있는 것들 끼리 
-- SMITH 의 SAL : 800  → SALGRADE 1 (LOSAL 700 ~ HISAL 1200)
-- SALGRADE 안에 800에 정확하게 일치하는 레코드는 없다.
-- 그 범위 안에 들어가 있는 걸 찾는 거다.
SELECT *
FROM EMP;
SELECT *
FROM SALGRADE;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;
-- 정확하게 일치하지 않지만, 
-- SALGRADE의 LOSAL~HISAL 의 범위 안에 들어가 있는 걸 찾음


--○ EQUI JOIN 시 (+) 를 활용한 결합 방법
SELECT *
FROM TBL_EMP;
--> 19명의 사원 있음
--  19명의 사원 중에 부서번호를 갖지 못한 사원들은 5명

SELECT *
FROM TBL_DEPT;
--> 5개의 부서 있음
--  5개의 부서 중 소속사원을 갖지 못한 부서는 2개 (40번, 50번 부서)


-- 서로 연결되는 것들끼리만 결합 한 거
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> 총 14건의 데이터가 결합되어 조회된 상황
--  즉, 부서번호를 갖지 못한 사원들(5명) 모두 누락
--  또한, 소속 사원을 갖지 못한 부서(2개) 모두 누락

-- 그런데, 이 때 
-- D.DEPTNO 뒤에 (+)를 사용하게 되면
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> 총 19건의 데이터가 결합되어 조회된 상황

-- E.DEPTNO 뒤에 (+)를 사용하게 되면
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> 총 16건의 데이터가 결합되어 조회된 상황
--  D.DEPTNO 먼저 다 구성해놓고,
--  거기에 연결되는 E.DEPTNO 내용 가져오는 것!
--> 부서를 갖지못한 5명의 사원들 내용은 나오지 않음

-- (+) 얘로 인해서 처리되는 내용은
-- (+) 이게 없는 쪽의 데이터를 먼저 구성한 다음에
-- 거기에 맞는 아이들을 찾아서 추가하는 형식임
-- → 즉, (+)가 없는 쪽이 주인공, (+)가 붙어있는 애는 거기에 맞춰가는 애

-- 먼저 기본으로 (+) 없는 부분 한 다음에, 
-- 먼저 처리한 내용을 바탕으로 (+) 붙어있는 것과 맞는 거 있으면 
-- 추가 처리한다는 의미


--※ (+) 가 없는 쪽 테이블의 데이터를 모두 메모리에 먼저 적재한 후
--   (+) 가 있는 쪽 테이블의 데이터를 하나하나 확인하여 결합시키는 형태로
--   JOIN 이 이루어지게 된다.

--   이와 같은 이유로...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+);
--==>> 에러 발생
--     (ORA-01468: a predicate may reference only one outer-joined table)
-->>   이건 기준 없이 그냥 양쪽에서 첨가만 하겠다는 내용

--   양쪽에 다 (+) 붙여놓은 위와 같은 쿼리문은 존재하지 않는다.
--   이런 형식의 JOIN 은 존재하지 않는다.


-- **위에 있는 SQL 1992 CODE 도 기억해놔야 한다.
--   지금도 굉장히 많이 쓰이고 있음
-- 여러 문제점이 발견되서, 코드가 개선이 된 것
-- 1992 CODE 에서 1999 CODE 로 넘어오면서 
-- 시각적으로 제일 바뀐 것은 
-- 1992 CODE 에서는 『JOIN』 이라는 키워드가 없음
-- 1999 CODE 부터는 『JOIN』 이라는 키워드가 등장하게 된다.
-- 그리고 어떤 유형의 『JOIN』 인지 명시해서 쓰게 해 놓았다.
-- WHERE 에 대한 조건이 
-- JOIN 에 대한 조건인지 조회에 대한 선택 조건인지에 대한 애매함이 있음
-- 그래서 『ON』 키워드도 등장하게 되었다.

-- 2. SQL 1999 CODE (ANSI SQL) 
-- 1992 CODE 에서 EQUI JOIN 이 
-- 1999 CODE 에서 INNER JOIN 으로 바뀜
--    → 『JOIN』 키워드 등장 → 『JOIN』(결합)의 유형 명시 
--    → 『ON』   키워드 등장 → 결합 조건은 WHERE 대신 『ON』으로

--○ CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;


--○ INNER JOIN
SELECT *
FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

-- 위에서 사용했던 EQUI JOIN 구문과 비교를 해보면,
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;
-- , 로 사용했던 걸 『JOIN』 키워드에, 
-- JOIN 방식도 명시하기로 했으므로 『INNER JOIN』
-- 결합조건이므로 WHERE 대신 『ON』

-- 별칭 사용
SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

-- INNER JOIN 에서는 INNER 생략 가능
SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;


--○ OUTER JOIN
-- 1992 CODE 에서 (+) 붙여서 수행했던 것이 
-- 1999 CODE 에서는 OUTER JOIN 으로 바뀜

-- 1922 CODE 를 보면,
-- WHERE 절에서 『(+)』 붙여서 사용했다.
SELECT *
FROM TBL_EMP, TBL_DEPT
WHERE TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO(+);

-- 위에 코드는 여러가지 문제가 있었다.
--> JOIN 이 등장해야하고, JOIN 유형도 명시
--> WHERE 절 대신에 ON 이 등장해야함
--> (+)는 (+) 안 붙은 쪽이 주인공인데, (+) 붙은 거에 눈이 더 갔었음,,
--> 그래서   왼편이 주인공이면 『LEFT OUTER JOIN』
-->        오른편이 주인공이면 『RIGHT OUTER JOIN』 
--  로 바꾸기로 했다.

SELECT *
FROM TBL_EMP E LEFT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- 그리고, 1992 CODE에서는 양 쪽에 둘 다 (+) 붙일 수 없었음
-- 둘 다 서브로 만들 수는 없어서,,,
-- 1999 CODE 에서는 RIGHT, LEFT 가 방향을 나타내므로
-- 둘 다 주인공으로 만들 수 있게 되었다. 
-- → 『FULL OUTER JOIN』 : 이건 1999 CODE에서 새로 만들어진 것
SELECT *
FROM TBL_EMP E FULL OUTER JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;


-- OUTER JOIN 에서 OUTER 도 생략 가능하다.
SELECT *
FROM TBL_EMP E LEFT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E RIGHT JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM TBL_EMP E FULL JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- INNER, OUTER 생략하면... INNER 인지 OUTER 인지 어떻게 구별해?
-- → 방향성이 붙어있으면 OUTER !!
-- → 방향성 없이 그냥 『JOIN』만 있으면 INNER JOIN


--○ NATURAL JOIN
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	 800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	 950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

-- 어떤 컬럼을 가지고 JOIN 시켜달라고 명시하지 않음
-- DEPTNO 는 EMP, DEPT TABLE 둘 다 있어서 소속 테이블 명시해야 함
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT;
--==>> 에러 발생
--     (ORA-00905: missing keyword)


-- 위에 쿼리에 『NATURAL JOIN』 으로 변경해주면, 에러 발생하지 않음
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/  
--> 적극적으로 쓰는 건,,, 쌤 입장에서는 권장하지 않음
--  이런 문법이 있다는 것 정도는 알아두기


-- DBA들이 사용
SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
--> DEPTNO 를 사용해서 JOIN 해줘
--==>>
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

--------------------------------------------------------------------------------

--※ 주의해야 할 점
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO;

-- 여기서 직종이 CLERK 인 사원만 조회해봐야지~
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
--> 이와 같은 방법으로 쿼리문을 구성해도
--  조회 결과를 얻는 과정에 문제는 없다.

-- 그렇지만, 위에처럼 하지말고
SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
--  이렇게 하자.
--> 결과는 같지만
--  이와 같이 구성하여 조회하는 것을 권장한다.
/*
-- ON 이라는 키워드가 등장한 배경이
-- 결합 조건과 선택 조건을 구분하기 위해서인데,
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
이렇게 쓰면
결합조건으로 쓰게 되어버리는 것이기 때문에

ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
구분해서 쓰는 걸 권장한다.

1992 CODE 를 쓰는 경우에는,
결합조건 자체도 WHERE 이기 때문에 어쩔 수 없음
*/

--------------------------------------------------------------------------------

--○ EMP 테이블과 DEPT 테이블을 대상으로
--   직종이 MANAGER 와 CLERK 인 사원들만 조회한다.
--   부서번호, 부서명, 사원명, 직종명, 급여 항목을 조회한다.

-- 나
-- 먼저 조회부터
SELECT *
FROM EMP;

SELECT *
FROM DEPT;
-- 나머지 조회항목은 다 EMP 에 있지만
-- 부서명은 DEPT 에만 있으므로
-- EMP와 DEPT JOIN 해야 한다.

-- 쿼리문 작성
SELECT D.DEPTNO "부서번호", D.DNAME "부서명"
     , E.ENAME "사원명", E.JOB "직종명", E.SAL "급여"
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN ('MANAGER', 'CLERK');
--==>>
/*
10	ACCOUNTING	MILLER	CLERK	1300
10	ACCOUNTING	CLARK	MANAGER	2450
20	RESEARCH	ADAMS	CLERK	1100
20	RESEARCH	JONES	MANAGER	2975
20	RESEARCH	SMITH	CLERK	 800
30	SALES	    JAMES	CLERK	 950
30	SALES	    BLAKE	MANAGER	2850
*/
-- PARSING 순서
-- FROM 에서 ON에 맞게 결합되게 만드는 거임
-- 그러므로 
-- WHERE 조건절보다 ON 이 먼저 처리된다.
-- FROM EMP 테이블과 DEPT 테이블
-- 거기에 ON에 맞게 처리!
-- 그리고 WHERE에 맞게 처리하게 됨


-- 쌤
SELECT *
FROM EMP;
SELECT *
FROM DEPT;


SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>>
/*
ACCOUNTING	CLARK	MANAGER	    2450
ACCOUNTING	KING	PRESIDENT	5000
ACCOUNTING	MILLER	CLERK	    1300
RESEARCH	JONES	MANAGER	    2975
RESEARCH	FORD	ANALYST	    3000
RESEARCH	ADAMS	CLERK	    1100
RESEARCH	SMITH	CLERK	     800
RESEARCH	SCOTT	ANALYST	    3000
SALES	    WARD	SALESMAN	1250
SALES	    TURNER	SALESMAN	1500
SALES	    ALLEN	SALESMAN	1600
SALES	    JAMES	CLERK	     950
SALES	    BLAKE	MANAGER	    2850
SALES	    MARTIN	SALESMAN	1250
*/


SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 에러 발생
--     (ORA-00918: column ambiguously defined)
--     DEPTNO 때문에 발생하는 에러 (위에처럼 DEPTNO 없이 조회하면 에러발생 X)
--     DNAME은 DEPT 에만 있으니 DEPT 가져오면 되고,
--     ENAME, JOB, SAL 은 EMP 에만 있으니 EMP에서 가져오면 되는데
--     DEPTNO 는 EMP 와 DEPT TABLE 둘 다 모두 갖고 있으니
--     어디에서 가져와야 하는지 몰라서 발생하는 에러..!

--     두 테이블 간 중복되는 컬럼(DEPTNO) 에 대한 
--     소속 테이블을 정해줘야(명시해줘야)한다!


SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> 위에 두 쿼리 모두 같은 결과
/*
10	ACCOUNTING	CLARK	MANAGER	    2450
10	ACCOUNTING	KING	PRESIDENT	5000
10	ACCOUNTING	MILLER	CLERK	    1300
20	RESEARCH	JONES	MANAGER	    2975
20	RESEARCH	FORD	ANALYST	    3000
20	RESEARCH	ADAMS	CLERK	    1100
20	RESEARCH	SMITH	CLERK	     800
20	RESEARCH	SCOTT	ANALYST	    3000
30	SALES	    WARD	SALESMAN	1250
30	SALES	    TURNER	SALESMAN	1500
30	SALES	    ALLEN	SALESMAN	1600
30	SALES	    JAMES	CLERK	     950
30	SALES	    BLAKE	MANAGER	    2850
30	SALES	    MARTIN	SALESMAN	1250
*/

-- 소속 테이블을 명시해주면 에러발생 X
-- 둘 다 결과 동일하니,
-- 그럼 EMP, DEPT 중 아무거나 써도 괜찮을까?
-- NO

-- ※ 두 테이블 간 중복되는 컬럼에 대해 소속 테이블을 명시하는 경우
--    부모 테이블의 컬럼을 참조할 수 있도록 처리해야 한다.

--    즉, EMP 와 DEPT 중 둘 중 누가 부모냐에 따라서
--    EMP  가 부모 테이블이면, E.DEPTNO
--    DEPT 가 부모 테이블이면, D.DEPTNO
--    라고 해야 한다.

-- 어떤게 부모테이블인지, 자식테이블인지 어떻게 알아??
-- 두 테이블에 먼저 연결고리 컬럼이 있는지 확인하기
-- 둘 사이에 연결지을 컬럼 하나도 없다면 → 서로 관계없는 테이블
-- 연결고리 컬럼 있다면 → 부모-자식 성립할 수 있는 가능성 매우 높음!
--
-- 지금 여기서의
-- 연결고리 컬럼 → DEPTNO

-- 두 개의 테이블 조회 했을 때
SELECT *
FROM EMP;
SELECT *
FROM DEPT;
-- 연결고리 컬럼 DEPTNO를 봤을 때,
-- EMP  테이블에는 DEPTNO 값이 같은 컬럼이 여러개가 있음
-- DEPT 테이블에는 DEPTNO 값이 동일한 게 없음
-- 두 테이블 모두 DEPTNO 값 동일한게 여러개 있는 경우라면 → 신뢰성 깨짐
-- → 무결성 깨짐

-- DEPT에서는 DEPTNO 30번이 하나만 있어야 하지만,
-- EMP 에서는 DEPTNO 30번이 여러개가 있어도 되는 상황
-- → 『1:다』 상황

-- DEPT 테이블의 DEPTNO 30번을 
-- EMP  테이블에서 여러명의 사원이 참조하고 있는 상황

-- (부모 한 명에 여러명의 자식은 가능하니까)
-- DEPT 가 부모 테이블
-- EMP  가 자식 테이블


-- 왜 꼭 부모테이블을 참조하라고 했을까?
-- 하나는 E.DEPTNO를 하고, 하나는 D.DEPTNO를 참조하는데
-- OUTER JOIN 을 수행할 것이다.
-- 맨 마지막 15번째 줄에 둘이 차이가 있음
SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--==>>
/*
    :
(null)	OPERATIONS  (null)  (null)  (null)			    
*/
-- OPRATIONS 의 부서번호(DEPTNO) 가 보이지 않음

SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--==>>
/*
    :
    40	OPERATIONS  (null)  (null)  (null)			
*/
-- OPRATIONS 의 부서번호(DEPTNO) 가 보임

--> 이런 상황이면 부서번호(DEPTNO)가 보이게 조회해야 하는게 맞음
--  그러므로,
--  자식테이블을 참조하는 게 아니라, 부모테이블 것을 참조해야 한다.

-- 그러면, 나머지 컬럼 같은 경우에는 
-- 소속 테이블이 없더라도 문제가 생기지 않는다.
-- 그래도! 명시해주는 걸 당부한다.
SELECT D.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 위에처럼 작성하지 말고,
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

-- 소속 테이블 명시하지 않으면
-- DNAME은 DEPT 테이블에 가서 ORACLE 에 가서 찾아옴
-- ENAME, JOB, SAL 은 EMP 테이블에 가서 ORACLE 이 찾아옴

-- ORACLE이 한 군데에 먼저 들어가서 찾는다면,
-- DEPTNO 에도 DEPT 테이블 명시하지 않아도 됐을 거다.
-- 왜냐면, ORACLE 이 DEPT TABLE이나 EMP TABLE 중 먼저 도착한 곳에서 가져오면 되니까

-- 그런데 DEPTNO라고 소속 테이블 명시하지 않았을 때, 에러가 생긴다는 것은
-- ORACLE이 DEPT TABLE과 EMP TABLE 둘 다 가본다는 것이다.

-- 소속 테이블이 명시되지 않으면
-- 해당 컬럼이 DEPT TABLE 에만 있다고 하더라도,
-- ORACLE은 DEPT TABLE, EMP TABLE 둘 다에 갔다 온다.
-- 그런데 우리가 정확하게 D.DNAME 으로 명시해놓는다면
-- ORACLE은 DEPT TABLE에만 갔다오면 된다.

--> ORACLE을 조금 더 배려하고, 조금 더 빠르게 실행하기 위해서!!

--※ 두 테이블에 모두 포함되어 있는 중복된 컬럼이 아니더라도
--   조인하는 과정에서 컬럼의 소속 테이블을 명시해줄 수 있도록 권장한다.


-- 최종적으로 쌤 문제 해결
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
  AND E.JOB IN ('CLERK', 'MANAGER');
--==>>
/*
10	ACCOUNTING	CLARK	MANAGER	    2450
10	ACCOUNTING	MILLER	CLERK	    1300
20	RESEARCH	ADAMS	CLERK	    1100
20	RESEARCH	JONES	MANAGER	    2975
20	RESEARCH	SMITH	CLERK	     800
30	SALES	    BLAKE	MANAGER	    2850
30	SALES	    JAMES	CLERK	     950
*/


--○ SELF JOIN (자기 조인)

-- EMP 테이블의 데이터를 다음과 같이 조회할 수 있도록
-- 쿼리문을 구성한다.
---------------------------------------------------------
-- 사원번호 사원명 직종명  관리자번호 관리자명 관리자직종명
---------------------------------------------------------
--   ex)
--   7369   SMITH  CLERK   7902      FORD     ANALYST
---------------------------------------------------------
SELECT *
FROM EMP;

-- 나 : KING 누락된거 찾아내지 못했음
-- ★★★ 문제 풀고서, 결과 제대로 나왔는지, 누락된 내용 없는지(null 관련)
--        꼭 테이블 조회해보면서 확인해보자 !!! ★★★
SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명", E1.MGR "관리자번호"
     , E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
*/
-- KING 누락된거 찾아내지 못했음
-- 틀린거!!


-- 쌤
---------------------------------------------------------
-- 사원번호 사원명 직종명  관리자번호 관리자명 관리자직종명
---------------------------------------------------------
--   7369   SMITH  CLERK   7902      FORD     ANALYST
--    |       |      |       |        |          |
--   EMP1    EMP1   EMP1  EMP1(MGR)  EMP2       EMP2
--                           OR
--                        EMP2(EMPNO)

SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명"
     , E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
*/
-- 여기서 끝이 아니다.
-- KING 이 누락되었음
-- KING 이 누락된 이유는?? 
-- KING 은 피라미드 정점에 있기 때문에, (JOB : PRESIDENT)
-- 회장님을 관리할 관리자가 없고,
-- 관리자 기반으로 묶은 SELF JOIN 에서 연결고리가 없기 때문에
-- 조회결과에서 누락됨,,,


-- 그러면
-- 1999 CODE 기반
SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명"
     , E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1 LEFT JOIN EMP E2
ON E1.MGR = E2.EMPNO;
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT  (null)  (null)	(null)	
*/
-- LEFT JOIN 해서,
-- 관리자번호 없지만 나오게 해줘야 한다!!


-- 위에 쿼리를 1992 CODE 기반으로 보자
SELECT E1.EMPNO "사원번호", E1.ENAME "사원명", E1.JOB "직종명"
     , E2.EMPNO "관리자번호", E2.ENAME "관리자명", E2.JOB "관리자직종명"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+);
--==>>
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST	    7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT  (null)  (null)	(null)	
*/


-- HR 로 접속함

