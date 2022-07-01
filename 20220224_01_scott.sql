SELECT USER
FROM DUAL;
--==>> SCOTT


SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
--==>>
/*
10	2450 ┐
10	5000 │─ 8750
10	1300 ┘
20	2975 ┐
20	3000 │
20	1100 │─ 10875
20	800  │
20	3000 ┘
30	1250 ┐
30	1500 │
30	1600 │─ 9400
30	950  │
30	2850 │
30	1250 ┘
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
--==>>
/*
10	 8750
20	10875
30	 9400
*/


SELECT *
FROM EMP;

SELECT *
FROM TBL_EMP;


--○ 기존에 복사해둔 TBL_EMP 테이블 제거
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP이(가) 삭제되었습니다.


--○ 다시 EMP 테이블 복사하여 TBL_EMP 테이블 생성
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP이(가) 생성되었습니다.


SELECT *
FROM TBL_EMP;


--○ 실습 데이터 추가 입력(TBL_EMP)
INSERT INTO TBL_EMP VALUES
(8001, '홍은혜', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8002, '김상기', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8003, '이호석', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8004, '신시은', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_EMP VALUES
(8005, '김태형', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_EMP;
--==>>
/*
7369	SMITH	CLERK	    7902	1980-12-17	 800  (null)    20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	 300	30
7521	WARD	SALESMAN	7698	1981-02-22	1250	 500	30
7566	JONES	MANAGER 	7839	1981-04-02	2975  (null)    20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850  (null)	30
7782	CLARK	MANAGER	    7839	1981-06-09	2450  (null)	10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000  (null)	20
7839	KING	PRESIDENT  (null)	1981-11-17	5000  (null)	10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	   0	30
7876	ADAMS	CLERK	    7788	1987-07-13	1100  (null)	20
7900	JAMES	CLERK	    7698	1981-12-03	 950  (null)	30
7902	FORD	ANALYST	    7566	1981-12-03	3000  (null)	20
7934	MILLER	CLERK	    7782	1982-01-23	1300  (null)	10
8001	홍은혜	CLERK	    7566	2022-02-24	1500	  10  (null)	    
8002	김상기	CLERK	    7566	2022-02-24	2000	  10  (null)	
8003	이호석	SALESMAN	7698	2022-02-24	1700  (null)  (null)		
8004	신시은	SALESMAN	7698	2022-02-24	2500  (null)  (null)		
8005	김태형	SALESMAN	7698	2022-02-24	1000  (null)  (null)		
*/


--○ 커밋
COMMIT;
--==>> 커밋 완료.


SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
--==>>
/*
   20	 800   (null)	
(null)	1700   (null)	
(null)	1000   (null)	
   10	1300   (null)	
   20	2975   (null)	
   30	2850   (null)	
   10	2450   (null)	
   20	3000   (null)	
   10	5000   (null)	
(null)	2500   (null)	
   20	1100   (null)	
   30	 950   (null)	
   20	3000   (null)	
   30	1250	1400
   30	1250	 500
   30	1600	 300
(null)	1500	  10
(null)	2000	  10
   30	1500	   0
*/
--  커미션을 기준으로 내림차순 정렬했는데, NULL 이 제일 위에 있다.
--> ORACLE 에서는 NULL 을 제일 크게 간주하고 있다.

--※ 오라클에서는 NULL 을 가장 큰 값의 형태로 간주한다.
--   (ORACLE 9i 까지는 NULL 을 가장 작은 값의 형태로 간주했었다.)
--   MSSQL 은 NULL 을 가장 작은 값의 형태로 간주한다.


--○ TBL_EMP 테이블을 대상으로 부서별 급여합 조회
--   부서번호, 급여합 항목 조회
SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700   -- 부서번호가 NULL 인 직원들을 묶어서    
                -- 그 직원들의 급여합을 조회했다.
*/
-- 부서별 급여합 조회 → 일단 부서별로 GROUP BY 해줘야 한다.


--○ ROLLUP 사용
SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700   -- 부서번호가 NULL 인 직원들의 급여합 
(null)	37725   -- 모든부서 직원들의 급여합
*/
-- 부서번호가 NULL 인 직원들의 급여합과
-- 모든부서 직원들의 급여합의 부서번호가
-- 둘 다 (null)로 표현되어 있다.


-- TBL_EMP 에는 부서번호가 NULL 인게 있어서 저렇게 나오는거니까
-- 그냥 EMP 테이블로 조회
SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	29025   -- 모든부서 직원들의 급여합
*/
-- ↓
/*
---------     -------
 부서번호      급여합
---------    --------
      10	     8750
      20	    10875
      30	     9400
모든부서       	29025   -- 모든부서 직원들의 급여합
---------     -------
*/
-- 위 아래 같은 내용의 표
-- 이렇게 조회될 수 있게 쿼리문 구성해보자.

-- NVL() 활용
SELECT NVL(TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10 	 8750
     20	    10875
     30	     9400
모든부서    29025
*/

-- NVL2() 활용
SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10 	 8750
     20	    10875
     30	     9400
모든부서    29025
*/

-- 위의 방법을 TBL_EMP에 적용해보자.
-- NVL() 활용
SELECT NVL(TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10	     8750
     20	    10875
     30	     9400
모든부서	 8700
모든부서	37725
*/

-- NVL2() 활용
SELECT NVL2(DEPTNO, TO_CHAR(DEPTNO), '모든부서') "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
     10	     8750
     20	    10875
     30	     9400
모든부서	 8700
모든부서	37725
*/
-- 이렇게 될 바에야 별칭 안 붙이는게 나음,,,

-- 이거 구별해주는 방법이 있음
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
  GROUPING  부서번호     급여합
---------- ---------- ----------
         0         10       8750
         0         20      10875
         0         30       9400        -- 아래처럼 구분해서 표현해보자
         0      (null)      8700        -- 인턴
         1      (null)     37725        -- 모든부서
*/
-- GROUPING LEVEL을 볼 수 있음
-- GROUPING LEVEL 1 : 부서별로 묶어서 급여합 구한거
-- GROUPING LEVEL 2 : 그 부서별 급여합을 다 더해서 총합구한거

SELECT DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
   10	 8750
   20	10875
   30	 9400
(null)	 8700 
(null)	37725
*/

--○ 위에서 조회한 해당 내용을 
/*
      10	 8750
      20	10875
      30	 9400
    인턴	 8700 
모든부서	37725
*/
-- 이와 같이 조회될 수 있도록 쿼리문을 구성한다.

--※ 참고
SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "부서번호", SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

--※ 힌트
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN '단일부서'
                             ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
단일부서	     8750
단일부서	    10875
단일부서     9400
단일부서	     8700
모든부서	    37725
*/

-- 나
-- TO_CHAR(DEPTNO) 를 안해줘서 계속 에러났었음,,
SELECT NVL(TO_CHAR(DEPTNO), CASE GROUPING(DEPTNO) WHEN 0 THEN '인턴'
                                                  ELSE '모든부서'
       END) "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴	         8700
모든부서	    37725
*/

-- 쌤
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO 
            ELSE -1 
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
    10	 8750
    20	10875
    30	 9400
(null)   8700
    -1	37725
*/


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN DEPTNO 
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>> 에러발생
--     (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)
--     어쩔 때는 숫자 넣고, 어쩔 때는 문자넣으라고 하니까 에러나는 것


-- 모든 상황에서 다 문자 넣게 바꿈
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN TO_CHAR(DEPTNO)
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
(null)       8700
모든부서    37725
*/
--> (null) 만 인턴으로 바꿔주면 됨


-- 모든 상황에서 다 문자 넣게 바꿈
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '모든부서'
       END "부서번호"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
--==>>
/*
10	         8750
20	        10875
30	         9400
인턴         8700
모든부서    37725
*/


--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
/*
-------------------------
    성별        급여합
-------------------------
    남          XXXXX
    여          XXXXX
    모든사원   XXXXXX
-------------------------
*/
-- 나 (GROUPING 처리 안하고 풀음,,)
SELECT NVL(T.성별, '모든사원') "성별", SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        21900
여	        32100
모든사원	54000
*/

-- 쌤
SELECT CASE GROUPING(T.성별) WHEN 0 THEN T.성별
                             ELSE '모든사원'
       END "성별"
     , SUM(T.급여) "급여합"
FROM
(
    SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남' 
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
         , SAL "급여"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.성별);
--==>>
/*
남	        21900
여	        32100
모든사원	54000
*/


SELECT *
FROM VIEW_SAWON;

--○ TBL_SAWON 테이블을 대상으로
--   다음과 같이 조회될 수 있도록 연령대별 인원수를 확인할 수 있는
--   쿼리문을 구성한다.
/*
---------------------------------
    연령대         인원수
---------------------------------
       10             X
       20             X
       40             X
       50             X
       전체          XX
---------------------------------
*/
-- INLINE VIEW 1번, 2번 중첩시켜서 푸는 방법 있음

-- 나
-- INLINE VIEW 2번 중첩(①현재나이 ②연령대)
SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN T2.연령대
                                ELSE '전체'
       END "연령대"
     , COUNT(T2.연령대) "인원수"
FROM
(
    SELECT CASE TRUNC(T.현재나이, -1) WHEN 10 THEN '10'
                                      WHEN 20 THEN '20'
                                      WHEN 30 THEN '30'
                                      WHEN 40 THEN '40'
                                      WHEN 50 THEN '50'
                                      WHEN 60 THEN '60'
                                      ELSE '10~60대 외'
           END "연령대"
    FROM
    (
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE -1
               END "현재나이"
        FROM TBL_SAWON
    ) T
) T2
GROUP BY ROLLUP(T2.연령대);
--==>>
/*
연령대      인원수
-------- ----------
10                2
20               12
40                1
50                3
전체             18
*/

-- 나
-- INLINE VIEW 1번 중첩 (그냥 현재나이 구하지말고, 바로 연령대로 구해버리기)
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN T.연령대
                               ELSE '전체'
       END "연령대"
     , COUNT(T.연령대) "인원수"
FROM
(
    SELECT CASE TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                           ELSE -1
                      END, -1)
                WHEN 10 THEN '10'
                WHEN 20 THEN '20'
                WHEN 30 THEN '30'
                WHEN 40 THEN '40'
                WHEN 50 THEN '50'
                WHEN 60 THEN '60'
                ELSE '10~60대 외'
           END "연령대"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);


-- 위에처럼 안하고 아래처럼만 해줘도 됨,,,
-- 선생님 풀이보고서 위에꺼 수정함,,!!
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
                               ELSE '전체'
       END "연령대"
     , COUNT(T.연령대) "인원수"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                           WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
                           THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                           ELSE -1
                      END, -1) "연령대"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
연령대      인원수
-------- ----------
10                2
20               12
40                1
50                3
전체             18
*/

-- 쌤
-- 방법 1. → INLINE VIEW 를 두 번 중첩
--            NVL() 사용해서 연령대 구성
SELECT NVL(TO_CHAR(T2.연령대), '전체') "연령대"  -- 그냥 NVL(T2.연령대, '전체') "연령대"
                                                 -- 이렇게하면 연령대 컬럼은 
                                                 -- 현재 숫자타입인데, 
                                                 --'전체'는 문자타입이기 때문에 에러남 
     , COUNT(T2.연령대)
FROM
(
    --② 나이 이용해서 연령대 구하기
    SELECT CASE WHEN T1.나이 >= 50 THEN 50
                WHEN T1.나이 >= 40 THEN 40
                WHEN T1.나이 >= 30 THEN 30
                WHEN T1.나이 >= 20 THEN 20
                WHEN T1.나이 >= 10 THEN 10
                ELSE 0
           END "연령대"
    FROM
    (
        --① 나이 먼저 구하기
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE -1
               END "나이"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.연령대);


-- 방법 1. → INLINE VIEW 를 두 번 중첩
--            CASE, GROUPING() 사용해서 연령대 구성
SELECT CASE GROUPING(T2.연령대) WHEN 0 THEN TO_CHAR(T2.연령대)
                                ELSE '전체'
       END "연령대"
     , COUNT(*) "인원수"
FROM
(
    --② 나이 이용해서 연령대 구하기
    SELECT CASE WHEN T1.나이 >= 50 THEN 50
                WHEN T1.나이 >= 40 THEN 40
                WHEN T1.나이 >= 30 THEN 30
                WHEN T1.나이 >= 20 THEN 20
                WHEN T1.나이 >= 10 THEN 10
                ELSE 0
           END "연령대"
    FROM
    (
        --① 나이 먼저 구하기
        SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                    WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                    THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                    ELSE -1
               END "나이"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.연령대);
--==>>
/*
연령대    인원수
------- ----------
10           2
20          12
40           1
50           3
전체        18
*/

-- 방법 2. → INLINE VIEW 를 한 번 중첩
-- 그냥 바로 나이 이용해서 연령대 구함
SELECT CASE GROUPING(T.연령대) WHEN 0 THEN TO_CHAR(T.연령대)
                               ELSE '전체'
       END "연령대"
     , COUNT(*) "인원수"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                      ELSE -1
                 END, -1) "연령대"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);
--==>>
/*
연령대    인원수
------- ----------
10           2
20          12
40           1
50           3
전체        18
*/

-- 나 (복습할 때)
--중첩2번
SELECT NVL(TO_CHAR(T2.연령대), '전체'), COUNT(*) "인원수"
FROM
(
    SELECT TRUNC(T1.나이, -1) "연령대"
    FROM
    (
        SELECT 
        CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
             WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
             THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
             ELSE -1
        END "나이"
        FROM TBL_SAWON
    ) T1
) T2
GROUP BY ROLLUP(T2.연령대);


--중첩1번
SELECT NVL(TO_CHAR(T.연령대), '전체'), COUNT(*) "인원수"
FROM
(
    SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                      WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                      THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                      ELSE -1
                 END, -1) "연령대"
    FROM TBL_SAWON
) T
GROUP BY ROLLUP(T.연령대);



-- 지금까지 우리는 GROUP BY 로 하나만 묶었는데,
-- 반드시 하나만 묶어야 하는 건 아님
SELECT DEPTNO, JOB, SAL
FROM EMP;

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
--==>>
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000

20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975

30	CLERK	     950
30	MANAGER	    2850
30	SALESMAN	5600
*/
-- 1차로 부서번호 같은 사람 묶고,
-- 2차로 그 부서 안에서, 직업같은 사람끼리 묶어줌

-- 위에처럼 묶어준 내용을 ROLLUP() 하는 것도 가능함
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
    10	CLERK	     1300   -- 10번 부서 CLERK     직종의 급여합
    10	MANAGER	     2450   -- 10번 부서 MANAGER   직종의 급여함
    10	PRESIDENT	 5000   -- 10번 부서 PRESIDENT 직종의 급여함
    10	(null)	     8750   -- 10번 부서 모든 직종의 급여합        -- CHECK~!!!
    
    20	ANALYST	     6000   -- 20번 부서 ALALYST   직종의 급여합
    20	CLERK	     1900   -- 20번 부서 CLERK     직종의 급여합
    20	MANAGER	     2975   -- 20번 부서 MANAGER   직종의 급여합
    20	(null)	    10875   -- 20번 부서 모든 직종의 급여합        -- CHECK~!!!
    
    30	CLERK	      950   -- 30번 부서 CLERK     직종의 급여합
    30	MANAGER	     2850   -- 30번 부서 MANAGER   직종의 급여합
    30	SALESMAN	 5600   -- 30번 부서 SALESMAN  직종의 급여합
    30	(null)	     9400   -- 30번 부서 모든 직종의 급여합        -- CHECK~!!!
    
(null)	(null)	    29025   -- 모든 부서 모든 직종의 급여합        -- CHECK~!!!
*/


--○ CUBE() → ROLLUP() 보다 더 자세한 결과를 반환받는다.
-- 위에 했던 쿼리문에서 ROLLUP()만 CUBE()로 바꿔줌
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
    10	CLERK	     1300
    10	MANAGER	     2450
    10	PRESIDENT	 5000
    10	(null)	     8750
    
    20	ANALYST	     6000
    20	CLERK	     1900
    20	MANAGER	     2975
    20	(null)  	10875
    
    30	CLERK	      950
    30	MANAGER	     2850
    30	SALESMAN	 5600
    30	(null)  	 9400
    
(null)	ANALYST 	 6000 ┐ -- 모든 부서 ALALYST   직종의 급여합
(null)	CLERK	     4150 │ -- 모든 부서 CLERK     직종의 급여합
(null)	MANAGER	     8275 │ -- 모든 부서 MANAGER   직종의 급여합
(null)	PRESIDENT	 5000 │ -- 모든 부서 PRESIDENT 직종의 급여합
(null)	SALESMAN	 5600 ┘ -- 모든 부서 SALESMAN  직종의 급여합

(null)	(null)  	29025
*/
-- '그냥 조금 자세히 알려주나보다' 로 생각하기보다는
-- 묶음처리하는 방식이 다르다고 생각해주는게 좋음

--※ ROLLUP() 과 CUBE() 는
--   그룹을 묶어주는 방식이 다르다. (차이)

-- ex)
-- ROLLUP(A, B, C)
-- → (A, B, C) / (A, B) / (A) / ()

-- CUBE(A, B, C)
-- → (A, B, C) / (A, B) / (A, C) / (B, C) / (A) / (B) / (C) / ()

--==>> 위에서 사용한 것(ROLLUP())은 묶음 방식이 다소 모자랄 수 있고,
--     아래에서 사용한 것(CUBE())은 묶음 방식이 다소 지나칠 수 있기 때문에
--     다음과 같은 방식의 쿼리 형태를 더 많이 사용한다.
--     다음 작성하는 쿼리는 조회하고자 하는 그룹만
--     『GROUPING SETS』를 이용하여 묶어주는 방식이다.

-- ROLLUP()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	     1300
10	        MANAGER	     2450
10	        PRESIDENT	 5000
10	        전체직종     8750

20	        ANALYST	     6000
20	        CLERK	     1900
20	        MANAGER	     2975
20	        전체직종	10875

30	        CLERK	      950
30	        MANAGER	     2850
30	        SALESMAN	 5600
30	        전체직종     9400

인턴      	CLERK	     3500
인턴	    SALESMAN	 5200
인턴	    전체직종	 8700

전체부서	전체직종	37725
*/

-- CUBE()
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
--==>>
/*
10	        CLERK	      1300
10	        MANAGER	      2450
10	        PRESIDENT	  5000
10	        전체직종	  8750

20	        ANALYST	      6000
20	        CLERK	      1900
20	        MANAGER	      2975
20	        전체직종	 10875

30	        CLERK	       950
30	        MANAGER	      2850
30	        SALESMAN	  5600
30	        전체직종	  9400

인턴	    CLERK	      3500
인턴	    SALESMAN	  5200
인턴	    전체직종      8700

전체부서	ANALYST	      6000
전체부서    CLERK	      7650
전체부서    MANAGER	      8275
전체부서	PRESIDENT	  5000
전체부서	SALESMAN	 10800

전체부서	전체직종     37725
*/

-- GROUPING SETS() : 어떻게 GROUP 지을 것인지를 직접 명시하는 것
SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())  
ORDER BY 1, 2;
--> CUBE() 사용한 결과와 같은 조회 결과


SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '인턴')
            ELSE '전체부서'
       END "부서번호"
     , CASE GROUPING(JOB) WHEN 0 THEN JOB
            ELSE '전체직종'
       END "직종"
     , SUM(SAL) "급여합"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())  
ORDER BY 1, 2;
--> ROLLUP() 사용한 결과와 같은 조회 결과


SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;


--○ TBL_EMP 테이블을 대상으로
--   입사년도별 인원수를 조회한다.
--   (입사년도, 인원수, 인원수총합) 보여주면 됨

-- 나
SELECT NVL(TO_CHAR(T.입사년도), '총합') "입사년도", COUNT(*) "인원수"
FROM
(
    SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
    FROM TBL_EMP
) T
GROUP BY ROLLUP(T.입사년도);
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
총합	19
*/

-- 쌤
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;


-- 에러 발생하는 몇 가지 유형 살펴보자.
-- 위에 거를, GROUP BY 하는 과정 조금 다르게
SELECT EXTRACT(YEAR FROM HIREDATE) "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 에러 발생
--     (ORA-00979: not a GROUP BY expression)
--     그럼 GROUP BY 절에서 TO_CHAR(HIREDATE, 'YYYY') 못 쓰나?

-- 그건 또 아님
-- 아래 처럼 SELECT 절도 바꾸면 정상적으로 처리됨
SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
-- SELECT 절보다 GROUP BY 절이 먼저 PARSING되고, 처리됨

-- 아래처럼 TO_CHAR() EXTRACT() 바꿔서 해도 마찬가지 결과나옴
SELECT TO_CHAR(HIREDATE, 'YYYY') "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--     (ORA-00979: not a GROUP BY expression)
--     그럼 GROUP BY 절에서 EXTRACT() 못 쓰나?

--> 단순히 이 에러를 GROUP BY 절에서 EXTRACT(), TO_CHAR() 못 쓴다고 
--  생각하면 안됨!!

-- SELECT 절보다 GROUP BY 절이 먼저 PARSING되고, 처리되는데,
-- GROUP BY 에서 처리한 것과, 
-- 위에 SELECT 절과 다른 걸 처리하겠다고 -- 된거라 그런거임!
-- GROUP BY만 해도, ROLLUP(), CUBE(), GROUPING SETS() 해도 다 똑같은 결과 나옴

-- SELECT 절에서는 GROUP BY 에서 처리된 내용을 가지고 써야 함!!!


-- 에러 발생하는 경우 조금 더 살펴보자.
-- GROUP BY 에서 처리된 내용 - GROUPING 에서 처리된내용
-- ELSE 에서 처리된 내용 - THEN 에서 처리된 내용
-- 자세히 보자!!
SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
            THEN EXTRACT(YEAR FROM HIREDATE)
            ELSE '전체' 
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 에러 발생
--     (ORA-00932: inconsistent datatypes: expected NUMBER got CHAR)
-- 에러내용 보면,
-- THEN 이하에 숫자로 처리한다고 해놓고, ELSE 에서 문자처리하니까 에러남
-- GROUP BY 에서 EXTRACT() 로 처리하고, 
-- SELECT GROUPING()에서는 TO_CHAR()로 처리함


-- 위에 내용 복붙해서, EXTRACT() 로 되어있던거 다 TO_CHAR() 방식으로 통일시킴
SELECT CASE GROUPING(TO_CHAR(HIREDATE, 'YYYY')) WHEN 0
            THEN TO_CHAR(HIREDATE, 'YYYY')
            ELSE '전체' 
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> 정상 실행됨
-- ELSE 에서도 문자로 처리했고, THEN 이하에서도 문자타입으로 처리했음 → 이상없음
-- GROUP BY 에서 TO_CHAR() 로 처리하고
-- SELECT GROUPING() 에서 TO_CHAR()로 처리함 → 이상없음


-- 위에 내용 복붙해서, TO_CHAR() 로 되어있던거 다 EXTRACT() 방식으로 통일시킴
SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN EXTRACT(YEAR FROM HIREDATE)
            ELSE -1 
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> 정상 실행됨
-- ELSE 에서도 숫자로 처리했고, THEN 이하에서도 숫자타입으로 처리했음 → 이상없음
-- GROUP BY 에서 EXTRACT() 로 처리하고
-- SELECT GROUPING() 에서 EXTRACT()로 처리함 → 이상없음
--==>>
/*
  -1	19
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
*/

-- 위에 결과 -1 부분을 '전체'로 바꾸고 싶으면 어떻게 할까?
-- THEN 부분에 TO_CHAR() 씌어주면 됨
SELECT CASE GROUPING(EXTRACT(YEAR FROM HIREDATE)) WHEN 0
            THEN TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
            ELSE '전체'
       END "입사년도"
     , COUNT(*) "인원수"
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>>
/*
1980	 1
1981	10
1982	 1
1987	 2
2022	 5
전체	    19
*/

--※ 주의해서 쿼리작성하자!!
-- GROUP BY 절과 GROUPING 절의 데이터 타입
-- THEN 이후와 - ELSE 이후의 데이터 타입


--------------------------------------------------------------------------------

---■■■ HAVING ■■■--

--○ EMP 테이블에서 부서번호가 20, 30 인 부서를 대상으로
--   부서의 총 급여가 10000 보다 적을 경우만 부서별 총 급여를 조회한다.
-- 나
-- HAVING 절 사용 X
SELECT T.*
FROM 
(
    SELECT DEPTNO "부서번호", SUM(SAL) "부서별 총 급여"
    FROM EMP
    WHERE DEPTNO IN (20, 30)
    GROUP BY DEPTNO
    ORDER BY 1
) T
WHERE T."부서별 총 급여" < 10000;
--==>> 30	9400


-- HAVING 절 사용
SELECT DEPTNO "부서번호", SUM(SAL) "부서별 총 급여"
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
ORDER BY 1;
--==>> 30	9400


-- 쌤
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
  AND SUM(SAL) < 10000
GROUP BY DEPTNO;
--==>> 에러 발생
--     (ORA-00934: group function is not allowed here)
--     그룹 함수를 이 곳에서 사용할 수 없습니다.
-- 그룹함수 WHERE 절에서 사용할 수 없음

-- 그럴 때 쓰게 되는게, 
-- HAVING 절
-- ①
SELECT DEPTNO, SUM(SAL)
FROM EMP
WHERE DEPTNO IN (20, 30)
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000;
--==>> 30	9400

-- 종종
-- ②
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING SUM(SAL) < 10000
   AND DEPTNO IN (20, 30);
--==>> 30	9400
-- 위와 같은 결과가 나옴
-- 두 쿼리문 다른데 같은 결과 반환하고 있다.

-- 그런데,
-- FROM WHERE GROUPBY HAVING SELECT ORDERBY
-- 이렇게 SELECT 절 PARSING 하는 과정에서
-- 메모리에 1차적으로 퍼올리는 내용은
-- FROM 과 WHERE 절. 
-- 1차적으로,
-- FROM 에 해당되는 테이블에서 WHERE 의 조건에 맞는 레코드만 가지고 와서
-- 조건처리하게 됨!!
-- 이것만 신경쓰면서 해도 리소스 훨씬 절약됨

-- 그러다보니, ②번보다 ①번으로 쓰는게 부담이 적음!!!
-- 그 차이가 클라이언트가 뭔가 요구했을 때, 
-- 모래시계가 더 도느냐, 덜 도느냐의 차이를 가져오게 된다 !!


--------------------------------------------------------------------------------

--■■■ 중첩 그룹함수 / 분석함수 ■■■--

-- (복습)그룹함수에서 첫번째로 강조했던 내용
-- 처리하는 데이터 중에 NULL 이 포함되어 있다면, NULL 제외하고 계산한다.

-- 그룹 함수는 2 LEVEL 까지 중첩해서 사용할 수 있다.
-- MSSQL 은 이마저도 불가능하다.

-- 2 LEVEL 중첩이 무슨 말이냐 하면,
SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
-- 부서별로 급여 묶여서 나옴

-- 거기서,
SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 10875
-- 부서별 급여 중 최댓값

SELECT MIN(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 8750
-- 부서별 급여 중 최솟값


--○ RANK()
--   DENSE_RANK()
--> ORACLE 9i 부터 적용... MSSQL 2005 부터 적용...

-- 하위 버전에서는 RANK() 나 DENSE_RANK() 를 사용할 수 없기 때문에
-- 예를 들어... 급여 순위를 구하고자 한다면...
-- 해당 사원의 급여보다 더 큰 값이 몇 개인지 확인한 후
-- 확인한 값에 +1 을 추가 연산해 주면...
-- 그 값이 곧 해당 사원의 급여 등수가 된다.


-- RANK(), DENSE_RANK() 없이 석차, 등수 구하는 방법
SELECT ENAME, SAL
FROM EMP;
--==>>
/*
SMITH	 800
ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
TURNER	1500
ADAMS	1100
JAMES	 950
FORD	3000
MILLER	1300
*/

--○ SMITH 의 급여 등수 확인해보자
-- SMITH 보다 급여가 큰 사람들의 수를 먼저 센다. → 13명
-- 거기에 +1 하면 SMITH 의 급여 등수 → 14등
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 800;     -- SMITH 의 급여
--==>> 14            -- SMITH 의 급여 등수

-- 같은 방법으로 
--○ ALLEN 의 급여 등수 확인해보자
SELECT COUNT(*) + 1
FROM EMP
WHERE SAL > 1600;     -- ALLEN 의 급여
--==>> 7              -- ALLEN 의 급여 등수


-- 이렇게 하면 한 명씩 넣어서 확인해봐야 한다...
-- 이럴 때, 서브쿼리 사용하면 됨
-- RANK() 함수를 쓴 것처럼, 쿼리 쓸 수 있다.

--※ 서브 상관 쿼리(상관 서브 쿼리)
--   인라인뷰도 서브쿼리의 한 종류
--   서브 상관 쿼리도 서브쿼리의 한 종류

--   메인 쿼리가 있는 테이블의 컬럼이
--   서브 쿼리의 조건절(WHERE절, HAVING)에 사용되는 경우
--   우리는 이 쿼리문을 서브 상관 쿼리(상관 서브 쿼리)라고 부른다.

SELECT ENAME "사원명", SAL "급여", 1 "급여등수"
FROM EMP;
--==>>
/*
SMITH	 800	1
ALLEN	1600	1
WARD	1250	1
JONES	2975	1
MARTIN	1250	1
BLAKE	2850	1
CLARK	2450	1
SCOTT	3000	1
KING	5000	1
TURNER	1500	1
ADAMS	1100	1
JAMES	 950	1
FORD	3000	1
MILLER	1300	1
*/
-- 이렇게 하면 모든 사원의 급여등수 1로 나옴


-- 1 써놓은 자리에 SMITH의 급여 등수 구했던 쿼리를 집어넣음
-- → 모든 사원의 급여등수 모두 14로 나올 거임
SELECT ENAME "사원명", SAL "급여"
     , (SELECT COUNT(*) + 1 
        FROM EMP 
        WHERE SAL > 800) "급여등수"
FROM EMP;
--==>>
/*
SMITH	 800	14
ALLEN	1600	14
WARD	1250	14
JONES	2975	14
MARTIN	1250	14
BLAKE	2850	14
CLARK	2450	14
SCOTT	3000	14
KING	5000	14
TURNER	1500	14
ADAMS	1100	14
JAMES	 950	14
FORD	3000	14
MILLER	1300	14
*/

-- ALLEN 거 확인할 때는 800 자리에 ALLEN 의 급여 1600 넣어주면 되고,
-- WARD  거 확인할 때는 800 자리에 WARD  의 급여 1250 넣어주는 방식으로 하면 됨
-- 바깥에 있는 메인쿼리에 별칭붙임
-- 메인쿼리.급여 해주면 서브쿼리에서의 급여는 800으로 고정이 아니다.
SELECT ENAME "사원명", SAL "급여"
     , (SELECT COUNT(*) + 1 
        FROM EMP 
        WHERE SAL > E.SAL) "급여등수"
FROM EMP E
ORDER BY 3;
--==>>
/*
KING	5000	 1
FORD	3000	 2
SCOTT	3000	 2
JONES	2975	 4
BLAKE	2850	 5
CLARK	2450	 6
ALLEN	1600	 7
TURNER	1500	 8
MILLER	1300	 9
WARD	1250	10
MARTIN	1250	10
ADAMS	1100	12
JAMES	 950	13
SMITH	 800	14
*/


--○ EMP 테이블을 대상으로 
--   사원명, 급여, 부서번호, 부서내급여등수, 전체급여등수 항목을 조회한다.
--   단, RANK() 함수를 사용하지 않고 서브상관쿼리를 활용할 수 있도록 한다.
SELECT E.ENAME "사원명", E.SAL "급여", E.DEPTNO "부서번호"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL
          AND DEPTNO = E.DEPTNO) "부서내급여등수"
     , (SELECT COUNT(*) + 1
        FROM EMP
        WHERE SAL > E.SAL) "전체급여등수"
FROM EMP E
ORDER BY 3, 4;
--==>>
/*
KING	5000	10	1	 1
CLARK	2450	10	2	 6
MILLER	1300	10	3	 9

SCOTT	3000	20	1	 2
FORD	3000	20	1	 2
JONES	2975	20	3	 4
ADAMS	1100	20	4	12
SMITH	 800	20	5	14

BLAKE	2850	30	1	 5
ALLEN	1600	30	2	 7
TURNER	1500	30	3	 8
MARTIN	1250	30	4	10
WARD	1250	30	4	10
JAMES	 950	30	6	13
*/


SELECT *
FROM EMP;

--○ EMP 테이블을 대상으로 다음과 같이 조회될 수 있도록 쿼리문을 구성한다.
--------------------------------------------------------------------------------
-- 사원명  부서번호    입사일       급여    부서내입사별급여누적
--------------------------------------------------------------------------------
--                              :                                    
-- SMITH     20     1980-12-17      800                    800  
-- JONES     20     1981-04-02     2975                   3775
-- FORD      20     1982-01-23     3000                   6775
--                              :
--------------------------------------------------------------------------------

-- 나 : 못 풀었음,,
SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , 0 + (SELECT E.SAL
        FROM EMP
        WHERE DEPTNO = 20
        GROUP BY DEPTNO) "부서내입사별급여누적"
FROM EMP E
ORDER BY 2, 3;

-- SUM() OVER() 사용 --> 입사일 같은거 처리 안됨,,,
SELECT ENAME "사원명", DEPTNO "부서번호", HIREDATE "입사일", SAL "급여"
     , SUM(SAL) OVER(PARTITION BY DEPTNO ORDER BY HIREDATE) "부서내입사별급여누적"
FROM EMP;


-- 쌤
SELECT EMP.ENAME, DEPTNO, HIREDATE, SAL, (1) "부서내입사별급여누적"
FROM SCOTT.EMP
ORDER BY 2, 3;


SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL "급여"
     , (1) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;

--이제 부서내입사별급여누적 쿼리 작성해보자
SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL "급여"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;
--> 그냥 전체 급여합 쏟아져나옴

SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL "급여"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;
--> 부서별 급여합 나옴

-- 같은 부서 안에서,
-- MILLER 입장에서는 KING 이 입사일이 더 먼저
-- KING 입장에서는 CLARK 이 입사일 더 먼저
-- 내 앞에 것들의 합 조회하면 됨
SELECT E1.ENAME "사원명", E1.DEPTNO "부서번호", E1.HIREDATE "입사일", E1.SAL "급여"
     , (SELECT SUM(E2.SAL)
        FROM EMP E2
        WHERE E2.DEPTNO = E1.DEPTNO
          AND E2.HIREDATE <= E1.HIREDATE) "부서내입사별급여누적"
FROM EMP E1
ORDER BY 2, 3;
--==>>
/*
CLARK	10	1981-06-09	2450	 2450
KING	10	1981-11-17	5000	 7450
MILLER	10	1982-01-23	1300	 8750
SMITH	20	1980-12-17	 800	  800
JONES	20	1981-04-02	2975	 3775
FORD	20	1981-12-03	3000	 6775
SCOTT	20	1987-07-13	3000	10875  -- 같은 날짜에 입사한거라
ADAMS	20	1987-07-13	1100	10875  -- 이렇게 처리된거
ALLEN	30	1981-02-20	1600	 1600
WARD	30	1981-02-22	1250	 2850
BLAKE	30	1981-05-01	2850	 5700
TURNER	30	1981-09-08	1500	 7200
MARTIN	30	1981-09-28	1250	 8450
JAMES	30	1981-12-03	 950	 9400
*/


--○ EMP 테이블을 대상으로
--   입사한 사원의 수가 가장 많았을 때의
--   입사년월과 인원수를 조회할 수 있도록 쿼리문을 구성한다.
--------------------------------
-- 입사년월    인원수
--------------------------------

-- 나
-- 여기까지 했음,,
SELECT SUBSTR(HIREDATE, 1, 7) "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY SUBSTR(HIREDATE, 1, 7)
ORDER BY 1;
--==>>
/*
입사년월       인원수
--------     ----------
1980-12          1
1981-02          2
1981-04          1
1981-05          1
1981-06          1
1981-09          2
1981-11          1
1981-12          2
1982-01          1
1987-07          2
*/
 
SELECT SUBSTR(HIREDATE, 1, 7) "입사년월"
     , (SELECT COUNT(*)
        FROM EMP E2
        GROUP BY SUBSTR(HIREDATE, 1, 7)
        HAVING E1.MAX(COUNT(*)) <= E2.COUNT(*)) "인원수"
FROM EMP E1
ORDER BY 1;

SELECT SUBSTR(HIREDATE, 1, 7) "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY SUBSTR(HIREDATE, 1, 7)
HAVING COUNT(*) = MAX(COUNT(*))
ORDER BY 1;


-- 쌤
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1981-05	    1
1981-12 	2   ←
1982-01	    1
1981-09 	2   ←
1981-02 	2   ←
1981-11	    1
1980-12	    1
1981-04	    1
1987-07	    2   ←
1981-06	    1
*/

SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP
WHERE COUNT(*) = 2
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 에러 발생
--     (ORA-00934: group function is not allowed here)


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = 2     -- 년월로 묶어서 가장 많은 인원 수의 입사 카운트
ORDER BY 1;
--==>>
/*
1981-02	    2
1981-09	    2
1981-12	    2
1987-07	    2
*/

-- 이제 위의 쿼리문에 COUNT(*) = 2에서 『2』 자리에
-- 오라클이 직접 『2』를 구할 수 있도록 쿼리 만들자.

-- 각 년,월 보고 거기에 맞는 인원 수 얻는 쿼리문
SELECT COUNT(*)
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>>
/*
1
2
1
2
2
1
1
1
2
1
*/

-- 년월로 묶어서 가장 많은 인원 수의 입사 카운트
SELECT MAX(COUNT(*))
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM');
--==>> 2

-- 『2』자리에 위의 쿼리 넣어주기
SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "입사년월"
     , COUNT(*) "인원수"
FROM EMP
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (
                    SELECT MAX(COUNT(*))
                    FROM EMP
                    GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
                  )
ORDER BY 1;
--==>>
/*
1981-02	2
1981-09	2
1981-12	2
1987-07	2
*/


--------------------------------------------------------------------------------
-- 추가 공부하다가 필기
-- +) 데베설 PPT 3장: LISTAGG 함수
--ex.
SELECT BUSEO "부서"
     , LISTAGG(NAME, '->') WITHIN GROUP(ORDER BY NUM) "LISTAGG"
FROM TBL_INSA
GROUP BY BUSEO;
--==>>
/*
개발부	이순애->이기자->장인철->황진이->이상헌->엄용수->이성길->홍길남->정영희->채정희->이기상->이미성->임수봉->김신애->양윤정
기획부	홍길동->이영숙->김말자->지재환->이정석->권옥경->김신제
영업부	김정훈->김종서->유관순->김인수->우재옥->김숙남->김미나->손인수->고순정->양미옥->지수환->홍원신->산마루->권영미->정한나->전용재
인사부	나윤균->박문수->이남신->박세열
자재부	유영희->심심해->이재영->문길수->김싱식->이미경
총무부	이순신->한석봉->이현숙->김영길->김말숙->정정해->허경운
홍보부	김영년->정한국->조미숙->최석규->이미인->정상호
*/

--+) 필요없는 공백 제거하기 위해서 
--   MAX(), MIN() 등 그룹합수 사용해도 됨
--   → 그룹함수는 공백(NULL) 을 자동제거한다.






