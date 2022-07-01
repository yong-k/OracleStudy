SELECT USER
FROM DUAL;
--==>> SCOTT

--어제 했던거 풀이 이어서 진행
--○ TBL_SAWON 테이블을 활용하여 
--   다음과 같은 항목들을 조회할 수 있도록 쿼리문을 구성한다.
--   사원번호, 사원명, 주민번호, 성별, 입사일
-- 나
--① DECODE() 사용
SELECT SANO 사원번호, SANAME 사원명, JUBUN 주민번호
    , DECODE(SUBSTR(JUBUN, 7, 1), '1', '남', '2', '여', '3', '남', 4, '여', '??') 성별
    , HIREDATE 입사일
FROM TBL_SAWON;

--② CASE WHEN THEN ELSE END 사용
SELECT SANO 사원번호, SANAME 사원명, JUBUN 주민번호
    , CASE SUBSTR(JUBUN, 7, 1) WHEN '1' THEN '남'
                               WHEN '2' THEN '여'
                               WHEN '3' THEN '남'
                               WHEN '4' THEN '여'
                               ELSE '??'
      END 성별
    , HIREDATE 입사일
FROM TBL_SAWON;
--==>>
/*
1001	김민성	    9707251234567	남	2005-01-03
1002	서민지	    9505152234567	여	1999-11-23
1003	이지연	    9905192234567	여	2006-08-10
1004	이연주	    9508162234567	여	2007-10-10
1005	오이삭	    9805161234567	남	2007-10-10
1006	이현이	    8005132234567	여	1999-10-10
1007	박한이	    0204053234567	남	2010-10-10
1008	선동렬	    6803171234567	남	1998-10-10
1009	선우용녀	6912232234567	여	1998-10-10
1010	선우선	    0303044234567	여	2010-10-10
1011	남주혁	    0506073234567	남	2012-10-10
1012	남궁민	    0208073234567	남	2012-10-10
1013	남진	    6712121234567	남	1998-10-10
1014	홍수민	    0005044234567	여	2015-10-10
1015	임소민	    9711232234567	여	2007-10-10
1016	이이경	    0603194234567	여	2015-01-20
*/

--쌤
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남성'
           WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여성'
           ELSE '성별확인불가'
      END "성별"
    , HIREDATE "입사일"
FROM TBL_SAWON;
--==>>
/*
1001	김민성	9707251234567	남성	    2005-01-03
1002	서민지	9505152234567	여성	    1999-11-23
1003	이지연	9905192234567	여성  	    2006-08-10
1004	이연주	9508162234567	여성	    2007-10-10
1005	오이삭	9805161234567	남성	    2007-10-10
1006	이현이	8005132234567	여성	    1999-10-10
1007	박한이	0204053234567	남성	    2010-10-10
1008	선동렬	6803171234567	남성	    1998-10-10
1009	선우용녀6912232234567	여성	    1998-10-10
1010	선우선	0303044234567	여성	    2010-10-10
1011	남주혁	0506073234567	남성	    2012-10-10
1012	남궁민	0208073234567	남성	    2012-10-10
1013	남진  	6712121234567	남성	    1998-10-10
1014	홍수민	0005044234567	여성	    2015-10-10
1015	임소민	9711232234567	여성	    2007-10-10
1016	이이경	0603194234567	여성	    2015-01-20
*/


--○ TBL_SAWON 테이블을 활용하여 
--   다음과 같은 항목들을 조회할 수 있도록 쿼리문을 구성한다.
--   『사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일
--   , 정년퇴직일, 근무일수, 남은일수, 급여, 보너스』
--   단, 현재나이는 기본 한국나이 계산법에 따라 연산을 수행한다.
--   또한, 정년퇴직일은 해당 직원의 나이가 한국나이로 60세가 되는 해의
--   그 직원의 입사 월, 일로 연산을 수행한다.
--   근무일수 (입사하고 지금까지 얼마나 일했는지)
--   남은일수 (정년퇴직일까지 얼마나 남았는지)
--   그리고, 보너스는 1000일 이상 2000일 미만 근무한 사원은 그 사원의 원래 금여 기준 30% 지급, 
--                    2000일 이상 근무한 사원은 그 사원의 원래 급여 기준 50% 지급을 할 수 있도록 처리한다.
--   (→ 보너스 : 근무일수를 기준으로 계산)
--    SANO SANAME JUBUN         성별 현재나이 입사일     정년퇴직일 근무일수 남은일수 SAL BONUS
--ex) 1001 김민성 9707251234567 남성  26      2005-01-03 2056-01-03 212121   2232323 3000 1500 

-- 나
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
            ELSE '판별불가'
       END "성별"
    -- 현재나이
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM 
        TO_DATE(SUBSTR(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') THEN CONCAT('19', JUBUN)
                            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') THEN CONCAT('20', JUBUN) END
                , 1, 4), 'YYYY')) + 1 "현재나이"
    -- 입사일
     , HIREDATE "입사일"
    -- 정년퇴직일
     , TO_DATE(CONCAT(EXTRACT(YEAR FROM (ADD_MONTHS(SYSDATE, 
        (60 - (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM 
            TO_DATE(SUBSTR(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') THEN CONCAT('19', JUBUN)
                                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') THEN CONCAT('20', JUBUN) END
                    , 1, 4), 'YYYY')) + 1))*12))), SUBSTR(HIREDATE, 5)), 'YYYY-MM-DD') "정년퇴직일"
    -- 근무일수
     , TRUNC(SYSDATE - HIREDATE) "근무일수"
    -- 남은일수
     , TRUNC(TO_DATE(CONCAT(EXTRACT(YEAR FROM (ADD_MONTHS(SYSDATE, 
        (60 - (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM 
            TO_DATE(SUBSTR(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') THEN CONCAT('19', JUBUN)
                                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') THEN CONCAT('20', JUBUN) END
                    , 1, 4), 'YYYY')) + 1))*12))), SUBSTR(HIREDATE, 5)), 'YYYY-MM-DD') - SYSDATE) "남은일수"
    -- 급여
     , SAL "급여"
    -- 보너스
     , CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000 THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000                                      THEN SAL*0.5
       END "보너스"
FROM TBL_SAWON;
--==>>
/*
1001	김민성	9707251234567	남	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	9505152234567	여	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	9905192234567	여	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	9508162234567	여	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	9805161234567	남	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	8005132234567	여	43	1999-10-10	2039-10-10	8172	6437	1000	500
1007	박한이	0204053234567	남	21	2010-10-10	2061-10-10	4154	14473	1000	500
1008	선동렬	6803171234567	남	55	1998-10-10	2027-10-10	8537	2054	1500	750
1009	선우용녀	6912232234567	여	54	1998-10-10	2028-10-10	8537	2420	1300	650
1010	선우선	0303044234567	여	20	2010-10-10	2062-10-10	4154	14838	1600	800
1011	남주혁	0506073234567	남	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	남궁민	0208073234567	남	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	남진	    6712121234567	남	56	1998-10-10	2026-10-10	8537	1689	2200	1100
1014	홍수민	0005044234567	여	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	9711232234567	여	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	이이경	0603194234567	여	17	2015-01-20	2065-01-20	2591	15671	1500	750
*/


--쌤
-- 사원번호, 사원명, 주민번호, 성별, 현재나이, 입사일, 급여 ... 먼저
-- 현재나이
-- → 1900년대생(주민번호 7번째가 1 OR 2)이라면, 현재년도 - (주민번호앞두자리 + 1899)
-- → 2000년대생(주민번호 7번째가 3 OR 4)이라면, 현재년도 - (주민번호앞두자리 + 1999)
SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
    -- 성별
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
            ELSE '성별확인불가'
       END "성별"
    -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 / 2000년대) 
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1
       END "현재나이"
    -- 입사일
     , HIREDATE "입사일"
    -- 급여
     , SAL "급여"
FROM TBL_SAWON;


-- ※ CASE WHEN THEN ELSE END
--    CASE WHEN 사건 THEN 결과값
--         WHEN 사건 THEN 결과값
--         ELSE 결과값
--    END "컬럼별칭"
--
--==>> THEN과 ELSE 뒤에 오는 값의 데이터타입이 같아야 한다!
--     나이 구하고 있어서 THEN 결과값으로 다 나이(숫자타입) 써놓고,
--     ELSE 부분에 예외처리한다고, '나이판별불가'(문자타입) 써놓으면 에러남
--     
--     → 그럴경우에는 ELSE -1 을 가장 많이 씀 (숫자타입에 있어서 에러처리)


-- SELECT 앞에서 선언한거 뒤에서 또 쓰고 싶다는 생각이 들었을 거임
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "연봉", 연봉*2 "두배연봉"
FROM EMP;
--==>> 에러 발생
--     (ORA-00904: "연봉": invalid identifier)
--==>> 앞에서 조회했다고, 다음 컬럼에서 그 결과 사용할 수 있는 거 아님

-- 그럼 앞에서 만든 SELECT 결과값 사용 불가? 
-- NO. 서브쿼리 사용하면 됨
SELECT 연봉*2 "두배연봉"
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "연봉"
    FROM EMP
);

-- FROM 서브쿼리 절에 별칭 붙여서도 사용 가능
SELECT T.EMPNO, T.ENAME, T.SAL, T.연봉
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "연봉"
    FROM EMP
) T;

SELECT T.*
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "연봉"
    FROM EMP
) T;


-- 쌤 풀이 다시 이어서 
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    -- 정년퇴직일
    -- 정년퇴직년도 → 해당 직원의 나이가 한국나이로 60세가 되는 해
    -- 현재 나이가... 57세...  3년 후   2022 → 2025
    -- 현재 나이가... 28세... 32년 후   2022 → 2054
    -- ADD_MONTHS(SYSDATE, 남은년수*12)
    --                     --------
    --                     60 - 현재나이
    -- ADD_MONTHS(SYSDATE,(60 - 현재나이) * 12) → 특정날짜
    -- TO_CHAR('특정날짜', 'YYYY') → 정년퇴직 년도만 문자타입으로 추출
    -- TO_CHAR(입사일, 'MM-DD')    → 입사 월일만 문자타입으로 추출
    -- TO_CHAR('특정날짜', 'YYYY') || '-' || TO_CHAR(입사일, 'MM-DD') "정년퇴직일"
    , TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"
    
    -- 근무일수 = 현재일 - 입사일
    , TRUNC(SYSDATE - T.입사일) "근무일수"
    
    -- 남은일수 = 정년퇴직일 - 현재일
    -- → 얘도 서브쿼리 또 사용할 수 있지만, 너무 길어지니까 그냥 앞에내용 가져옴
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"
    
    -- 급여
    , T.급여
    
    -- 보너스
    -- 근무일수가 1000일 이상 2000일 미만 → 원래 급여의 30% 지급
    -- 근무일수가 2000일 이상             → 원래 급여의 50% 지급
    -- 나머지                            → 0
    ------------------------------------------------------------
    -- 근무일수 2000일 이상               → T.급여 * 0.5
    -- 근무일수 1000일 이상               → T.급여 * 0.3
    -- 나머지                             → 0
    ------------------------------------------------------------
               -- >=2000 먼저 써주면 → 2000일 미만에 대한 조건 안 써도 됨
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
           WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
           ELSE 0
      END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        -- 성별
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
        -- 현재나이 = 현재년도 - 태어난년도 + 1 (1900년대 / 2000년대) 
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE -1
           END "현재나이"
        -- 입사일
         , HIREDATE "입사일"
        -- 급여
         , SAL "급여"
    FROM TBL_SAWON
) T;
-- FROM 절에 쓴 서브쿼리테이블에서는 SANO라는 컬럼 존재하지 않음
-- 우리가 별칭 붙인 『사원번호』 컬럼이 존재함 !
--==>>
/*
1001	김민성	    9707251234567	남	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	서민지	    9505152234567	여	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	이지연	    9905192234567	여	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	이연주	    9508162234567	여	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	오이삭	    9805161234567	남	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	이현이	    8005132234567	여	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	박한이	    0204053234567	남	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	선동렬	    6803171234567	남	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	선우용녀	6912232234567	여	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	선우선	    0303044234567	여	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	남주혁	    0506073234567	남	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	남궁민	    0208073234567	남	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	남진	    6712121234567	남	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	홍수민	    0005044234567	여	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	임소민	    9711232234567	여	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	이이경	    0603194234567	여	17	2015-01-20	2065-01-20	2591	15671	1500	 750
*/

--> 지금 우리가 쓴 서브쿼리문 『인라인 뷰(INLINE VIEW)』 라고 한다.


--○ TBL_SAWON 테이블에 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '이호석', '9611121234567', SYSDATE, 5000);
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_SAWON;
--==>> 
/*
    :
1017	이호석	9611121234567	2022-02-23	5000 
    :
*/
-- 잘 들어가있음


--○ 커밋
COMMIT;
--==>> 커밋 완료.


--○ 위에서 작성한 쿼리문 가져와서, 새로 추가한 '이호석' 사원 데이터 있나 확인
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    -- 정년퇴직일
    , TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"  
    -- 근무일수
    , TRUNC(SYSDATE - T.입사일) "근무일수"   
    -- 남은일수
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"    
    -- 급여
    , T.급여  
    -- 보너스
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
           WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
           ELSE 0
      END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        -- 성별
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
        -- 현재나이
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE -1
           END "현재나이"
        -- 입사일
         , HIREDATE "입사일"
        -- 급여
         , SAL "급여"
    FROM TBL_SAWON
) T;
--==>> 
/*
    :
1017	이호석	9611121234567	남	27	2022-02-23	2055-02-23	0	12052	5000	0
    :
*/
-- '이호석' 데이터도 출력되는 것 확인할 수 있음


-- 위에서 처리한 내용을 기반으로
-- 특정 근무일수의 사원을 확인해야 한다거나...
-- 특정 보너스 금액을 받는 사원을 확인해야 할 경우가 발생할 수 있다.
-- 이와 같은 경우... 해당 쿼리문을 다시 구성해야 하는 번거로움을 줄일 수 있도록
-- 뷰(VIEW)를 만들어 저장해 둘 수 있다.

-- 테이블을 만들 때에는,
CREATE TABLE TBL_TEST
( COL1  NUMBER
, COL2  VARCHAR2(30)
);
-- (예시 든거라 실행하지 않음)
-- 이거 실행해서 TBL_TEST 테이블 만들어졌으면,
-- 또 실행하면 이미 TBL_TEST 테이블 있는데, 또 만들꺼야? 
-- 이미 있기 때문에 못 만든다고 에러 뜸

-- 테이블 만들 때, 뷰를 만드는 것 처럼
CREATE OR REPLACE TABLE TBL_TEST
( COL1  NUMBER
, COL2  VARCHAR2(30)
);
-- 하면 에러 남 (ORA-00922: missing or invalid option)
-- 테이블은 이런식으로 관리하면 안되니까

-- 뷰를 만들 때에는,
-- 테이블을 만들 때에는 테이블을 만드는 것 처럼 어떤 데이터를 넣는 것이 아니라,
-- 테이블 자체를 구성했던 쿼리문을 넣어줌
-- ORACLE에서 쿼리문을 저장한다는 느낌으로 VIEW 사용함
-- VIEW_SAWON 뷰가 이미 만들어져있더라도, 내가 새롭게 만드는 것으로 덮어쓰기 됨
CREATE OR REPLACE VIEW VIEW_SAWON
AS  -- 이거 처럼 만들어주세요. (테이블 복사할 때 사용해봄)
SELECT T.사원번호, T.사원명, T.주민번호, T.성별, T.현재나이, T.입사일
    -- 정년퇴직일
    , TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD') "정년퇴직일"  
    -- 근무일수
    , TRUNC(SYSDATE - T.입사일) "근무일수"   
    -- 남은일수
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.현재나이) * 12), 'YYYY') || '-' || TO_CHAR(T.입사일, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "남은일수"    
    -- 급여
    , T.급여  
    -- 보너스
    , CASE WHEN TRUNC(SYSDATE - T.입사일) >= 2000 THEN T.급여 * 0.5
           WHEN TRUNC(SYSDATE - T.입사일) >= 1000 THEN T.급여 * 0.3
           ELSE 0
      END "보너스"
FROM
(
    SELECT SANO "사원번호", SANAME "사원명", JUBUN "주민번호"
        -- 성별
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
                ELSE '성별확인불가'
           END "성별"
        -- 현재나이
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE -1
           END "현재나이"
        -- 입사일
         , HIREDATE "입사일"
        -- 급여
         , SAL "급여"
    FROM TBL_SAWON
) T;
--==>> 에러 발생
--     (ORA-01031: insufficient privileges) 
--     → SCOTT 한테 VIEW 를 만들 수 있는 권한 없음

--> SYS 더블클릭해서 접속함 
--  SCOTT 한테 VIEW 만들 수 있는 권한 부여하고 옴

-- 그러고서 위에 CREATE OR REPLACE VIEW 문 실행하니
--==>> View VIEW_SAWON이(가) 생성되었습니다.

-- 이렇게 만들어진 VIEW는 일반 TABLE 처럼 조회할 수 있다.
SELECT *
FROM VIEW_SAWON;

-- 아까 그 테이블 다 작성해서 확인하는 거 아니고,
-- VIEW 에서 조건설정해서 조회하면 가능함~!
SELECT *
FROM VIEW_SAWON
WHERE 근무일수 >= 6000;

SELECT *
FROM VIEW_SAWON
WHERE 남은일수 >= 15000;

SELECT *
FROM VIEW_SAWON
WHERE 보너스 >= 2000;

-- VIEW_SAWON 형태의 TABLE 이 존재하는 건 아니지만,
-- TABLE 이 존재하는 것처럼 조회가능


--○ VIEW 생성 이후 TBL_SAWON 테이블에 데이터 추가 입력
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1018, '신시은', '9910312234567', SYSDATE, 5000);
--==>> 1 행 이(가) 삽입되었습니다.

-- VIEW 생성 이후에, TBL_SAWON 테이블에 데이터 추가한건데도,
-- VIEW_SAWON 테이블에도 '신시은' 데이터 들어가있음
SELECT *
FROM VIEW_SAWON;
--==>> 
/*
    :
1018	신시은	9910312234567	여	24	2022-02-23	2058-02-23	0	13148	5000	0
    :
*/


--○ 서브쿼리를 활용하여 (VIEW 사용하는 것 아님)
--   TBL_SAWON 테이블을 다음과 같이 조회할 수 있도록 한다.
/*
--------------------------------------------
사원명   성별   현재나이   급여   나이보너스
--------------------------------------------

단, 나이 보너스는 현재 나이가 50세 이상이면 급여의 70%
                              40세 이상 50세 미만이면 급여의 50%
                              20세 이상 40세 미만이면 급여의 30%

또한, 완성된 조회 구문을 통해
VIEW_SAWON2 라는 이름의 뷰(VIEW) 를 생성한다.
*/
SELECT T.*
     , CASE WHEN T.현재나이 >= 50 THEN T.급여 * 0.7
            WHEN T.현재나이 >= 40 THEN T.급여 * 0.5
            WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
            ELSE 0
       END "나이보너스"
FROM 
(
SELECT SANAME "사원명"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
            ELSE '성별확인불가'
       END "성별"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1
       END "현재나이"
     , SAL "급여"
FROM TBL_SAWON
) T;


-- VIEW_SAWON2 라는 이름의 뷰(VIEW) 를 생성
CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.*
     , CASE WHEN T.현재나이 >= 50 THEN T.급여 * 0.7
            WHEN T.현재나이 >= 40 THEN T.급여 * 0.5
            WHEN T.현재나이 >= 20 THEN T.급여 * 0.3
            ELSE 0
       END "나이보너스"
FROM 
(
SELECT SANAME "사원명"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '남'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '여'
            ELSE '성별확인불가'
       END "성별"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1
       END "현재나이"
     , SAL "급여"
FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON2이(가) 생성되었습니다.


-- 생성한 뷰(VIEW) 확인(조회)
SELECT *
FROM VIEW_SAWON2;
--==>>
/*
이호석	    남	27	5000	1500
신시은	    여	24	5000	1500
김민성	    남	26	3000	 900
서민지	    여	28	4000	1200
이지연	    여	24	3000	 900
이연주	    여	28	4000	1200
오이삭	    남	25	4000	1200
이현이	    여	43	1000	 500
박한이	    남	21	1000	 300
선동렬	    남	55	1500	1050
선우용녀	여	54	1300	 910
선우선	    여	20	1600	 480
남주혁	    남	18	2600	   0
남궁민	    남	21	2600	 780
남진  	    남	56	2200	1540
홍수민	    여	23	5200	1560
임소민	    여	26	5500	1650
이이경	    여	17	1500	   0
*/


--------------------------------------------------------------------------------

-- 분석함수
-- 자기데이터만으로 결정되는 것이 아니라, 
-- 다른 데이터로 인해 등수 결정됨
--○ RANK() → 등수(순위)를 반환하는 함수
--   RANK() OVER() 
-->> 공동 1등이 2명있으면, 그 다음 순위는 2위가 아니라 3위!
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"
FROM EMP;
-- SAL을 내림차순 정렬해서 RANK() 매기면 "전체급여순위" 얻어낼 수 있다.
--==>>
/*
7839	KING	10	5000	 1
7902	FORD	20	3000	 2
7788	SCOTT	20	3000	 2
7566	JONES	20	2975	 4
7698	BLAKE	30	2850	 5
7782	CLARK	10	2450	 6
7499	ALLEN	30	1600	 7
7844	TURNER	30	1500	 8
7934	MILLER	10	1300	 9
7521	WARD	30	1250	10
7654	MARTIN	30	1250	10
7876	ADAMS	20	1100	12
7900	JAMES	30	950	    13
7369	SMITH	20	800	    14
*/


-- PARTITION BY 컬럼명
-- ---------
--    분할
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
     , RANK() OVER(ORDER BY SAL DESC) "전체급여순위"     
FROM EMP
ORDER BY DEPTNO;
-- RANK() OVER(PARTITION BY DEPTNO   ORDER BY SAL DESC)
--            부서번호별로 구별해서, 급여내림차순으로 정렬
-- 한 걸로, 순위 매긴다.
--==>>
/*
7839	KING	10	5000	 1	 1
7782	CLARK	10	2450	 2	 6
7934	MILLER	10	1300	 3	 9

7902	FORD	20	3000	 1	 2
7788	SCOTT	20	3000	 1	 2
7566	JONES	20	2975	 3	 4
7876	ADAMS	20	1100	 4	12
7369	SMITH	20	 800	 5	14

7698	BLAKE	30	2850	 1	 5
7499	ALLEN	30	1600	 2	 7
7844	TURNER	30	1500	 3	 8
7654	MARTIN	30	1250	 4	10
7521	WARD	30	1250	 4	10
7900	JAMES	30	 950	 6	13
*/


--○ DENSE_RANK() → 서열을 반환하는 함수
-->> 공동 1등이 2명있어도, 그 다음 순위는 3위가 아니라 2위!
SELECT EMPNO "사원번호", ENAME "사원명", DEPTNO "부서번호", SAL "급여"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "부서별급여순위"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "전체급여순위"     
FROM EMP
ORDER BY DEPTNO;
--==>>
/*
7839	KING	10	5000	1	 1
7782	CLARK	10	2450	2	 5
7934	MILLER	10	1300	3	 8

7902	FORD	20	3000	1	 2
7788	SCOTT	20	3000	1	 2
7566	JONES	20	2975	2	 3
7876	ADAMS	20	1100	3	10
7369	SMITH	20	 800	4	12

7698	BLAKE	30	2850	1	 4
7499	ALLEN	30	1600	2	 6
7844	TURNER	30	1500	3	 7
7654	MARTIN	30	1250	4	 9
7521	WARD	30	1250	4	 9
7900	JAMES	30	 950	5	11
*/


--○ EMP 테이블의 사원 데이터를 
--   사원명, 부서번호, 연봉, 부서내연봉순위, 전체연봉순위 항목으로 조회한다.
--   단, 여기에서 연봉은 앞서 구성했던 연봉의 정책과 동일하다.

--나
--① 서브쿼리 쓰지 않고
SELECT ENAME "사원명", DEPTNO "부서번호"
     , COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "연봉"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY COALESCE(SAL*12+COMM, SAL*12, COMM, 0) DESC) "부서내연봉순위"
     , RANK() OVER(ORDER BY COALESCE(SAL*12+COMM, SAL*12, COMM, 0) DESC) "전체연봉순위"
FROM EMP
ORDER BY DEPTNO;

--② 서브쿼리 써서
SELECT T.*
     , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내연봉순위"
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
FROM 
(
    SELECT ENAME "사원명", DEPTNO "부서번호"
         , COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "연봉"
    FROM EMP
) T
ORDER BY T.부서번호;
--==>>
/*
KING	10	60000	1	 1
CLARK	10	29400	2	 6
MILLER	10	15600	3	10
FORD	20	36000	1	 2
SCOTT	20	36000	1	 2
JONES	20	35700	3	 4
ADAMS	20	13200	4	12
SMITH	20	9600	5	14
BLAKE	30	34200	1	 5
ALLEN	30	19500	2	 7
TURNER	30	18000	3	 8
MARTIN	30	16400	4	 9
WARD	30	15500	5	11
JAMES	30	11400	6	13
*/

-- 쌤
SELECT T.*
     , RANK() OVER(PARTITION BY T.부서번호 ORDER BY T.연봉 DESC) "부서내연봉순위"
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
FROM 
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉"
    FROM EMP
) T
ORDER BY T.부서번호;
--==>>
/*
KING	10	60000	1	 1
CLARK	10	29400	2	 6
MILLER	10	15600	3	10
FORD	20	36000	1	 2
SCOTT	20	36000	1	 2
JONES	20	35700	3	 4
ADAMS	20	13200	4	12
SMITH	20	9600	5	14
BLAKE	30	34200	1	 5
ALLEN	30	19500	2	 7
TURNER	30	18000	3	 8
MARTIN	30	16400	4	 9
WARD	30	15500	5	11
JAMES	30	11400	6	13
*/


--○ EMP 테이블에서 전체 연봉 등수(순위)가 1등부터 5등까지만...
--   사원명, 부서번호, 연봉, 전체연봉순위 항목으로 조회한다.

-- 내가 풀다가 못 푼거,,
SELECT T.*
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호"
         , COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "연봉"
    FROM EMP
) T
WHERE RANK() OVER(ORDER BY T.연봉 DESC) <= 5;
-- 전체연봉순위까지 인라인뷰(서브쿼리)에 넣어서 풀었어야 했다,,,!

-- 서브쿼리의 서브쿼리로 다시 시도해보기 ㅎVㅎ
SELECT T2.*
FROM 
(
    SELECT T.*, RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉순위"
    FROM
    (
        SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
        FROM EMP
    ) T
) T2    
WHERE 전체연봉순위 <= 5;


-- 쌤
SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
     , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0) DESC) "전체연봉순위"
FROM EMP   
WHERE RANK() OVER(ORDER BY T.연봉 DESC) <= 5;
--==>> 에러 발생
--     (ORA-30483: window  functions are not allowed here)
--     → 주목해야하는 에러
--        윈도우함수를 여기서 사용할 수 없습니다.
--        ----------
--        분석함수들
--        → 분석함수들은 WHERE 절에서 사용 불가

--※ 위의 내용은 RANK() OVER() 와 같은 분석 함수를 WHERE 절에서 사용한 경우이며...
--   이 함수는 WHERE 조건절에서 사용할 수 없기 때문에 발생하는 에러이다.
--   이 경우, 우리는 INLINE VIEW 를 활용해서 풀이해야 한다.
--                  =================== (반드시!!)

SELECT T.*
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM, 0) "연봉"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "전체연봉순위"
    FROM EMP  
) T
WHERE T.전체연봉순위 <= 5;
-- LINE 안에서 VIEW 가 있는 것처럼 활용하기 때문에 → INLINE VIEW
--==>>
/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/

-- 특정 테이블에 별칭 붙이는 건, 서브쿼리에서만 가능한 거 아니다.
-- 그냥 테이블에 한 칸 띄고 별칭 붙여주면 사용 가능
-- 『.』은 소속을 나타냄
-- +)
SELECT ENAME, JOB, SAL
FROM SCOTT.EMP;
--> 이렇게 해도 조회됨

SELECT EMP.ENAME, EMP.JOB, EMP.SAL
FROM SCOTT.EMP;
--> 이렇게 해도 조회됨

SELECT T.ENAME, T.JOB, T.SAL
FROM SCOTT.EMP T;
--> SCOTT.EMP 테이블에 T라는 별칭붙이고, T로 조회도 가능


--○ EMP 테이블에서 각 부서별로 연봉등수가 1등부터 2등까지만 조회한다.
--   사원명, 부서번호, 연봉, 부서내연봉등수, 전체연봉등수
--   항목을 조회할 수 있도록 쿼리문을 구성한다.

-- 처음에 틀리게 푼 거
SELECT T.* 
     , RANK() OVER(ORDER BY T.연봉 DESC) "전체연봉등수"
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내연봉등수"
    FROM EMP
) T
WHERE T.부서내연봉등수 <= 2
ORDER BY T.부서번호, T.부서내연봉등수;
--==>> 
/*
KING	10	60000	1	1
CLARK	10	29400	2	5
SCOTT	20	36000	1	2
FORD	20	36000	1	2
BLAKE	30	34200	1	4
ALLEN	30	19500	2	6
*/
---> 이렇게 해버리면 그냥 부서별 1, 2등 안에서만 전체연봉등수 매겨버려서
--   결과 틀리게 나옴!!!!

-- 다시 푼 거
SELECT T.* 
FROM
(
    SELECT ENAME "사원명", DEPTNO "부서번호", SAL*12+NVL(COMM,0) "연봉"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "부서내연봉등수"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "전체연봉등수"
    FROM EMP
) T
WHERE T.부서내연봉등수 <= 2;
--==>>
/*
KING	10	60000	1	1
CLARK	10	29400	2	6
FORD	20	36000	1	2
SCOTT	20	36000	1	2
BLAKE	30	34200	1	5
ALLEN	30	19500	2	7
*/


--------------------------------------------------------------------------------

--■■■ 그룹 함수 ■■■--

-- SUM() 합, AVG() 평균, COUNT() 카운트, MAX() 최댓값, MIN() 최솟값
-- VARIANCE() 분산, STDDEV() 표준편차

--※ 그룹 함수의 가장 큰 특징
--   처리해야 할 데이터들 중 NULL 이 존재한다면(포함되어 있다면)
--   이 NULL 은 제외한 상태로 연산을 수행한다는 것이다.
--   즉, 그룹 함수가 작동하는 과정에서 NULL 은 연산의 대상에서 제외된다.

-- 기본산술연산에서는 NULL 과의 연산결과 모두 NULL 로 나옴
-- → NULL 이 연산에 포함되어 있으면 결과 NULL 됨
-- 그래서 그룹 함수에서는 NULL 을 제외하고 연산함


--○ SUM() 합
--   EMP 테이블을 대상으로 전체 사원들의 급여 총합을 조회한다.
SELECT SAL
FROM EMP;
--==>>
/*
800
1600
1250
2975
1250
2850
2450
3000
5000
1500
1100
950
3000
1300
*/
--> EMP테이블과 동일하게 결과 레코드 14건 나옴

SELECT SUM(SAL)
FROM EMP;
--==>> 29025
--> 반환되는 레코드 1건임


SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> 에러 발생
--     (ORA-00937: not a single-group group function)
-- ENAME은 각각의 결과가 들어있는 14건
-- SUM(SAL) 은 1건
-- 컬럼의 개수가 맞지 않아서 에러남


SELECT SUM(SAL) --> 800 + 1600 + 1250 + ... + 1300
FROM EMP;
--==>> 29025


SELECT COMM
FROM EMP;
--==>>
/*
(null)
300
500
(null)
1400
(null)
(null)
(null)
(null)
0
(null)
(null)
(null)
(null)
*/

SELECT SUM(COMM) --> 300 + 500 + 1400 + 0
FROM EMP;
--==>> 2200
-- NULL 제외하고 계산됨


-- NULL 알아서 제외되니까 너무 편하겠다~ 라고만 하고 쓰면 안됨

--○ COUNT() : 행(레코드)의 개수 조회 → 데이터가 몇 건인지 확인...
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)  -- COMM 컬럼 행의 개수 조회 → NULL 은 제외~!!!
FROM EMP;
--==>> 4
-- 레코드 실제로는 14건인데, 레코드 4건밖에 없다고 나옴,,,


-- COUNT() 는 일반적으로 행의 개수를 쓰려고 하는 것이기 때문에 
-- 보통 COUNT(*) 이런식으로 쓴다.
SELECT COUNT(*)
FROM EMP;
--==>> 14


--○ AVG() : 평균 반환
SELECT SUM(SAL) / COUNT(SAL) "RESULT1"
     , AVG(SAL) "RESULT2"
     , SUM(SAL) / COUNT(*) "RESULT3"
FROM EMP;
--==>>
/*
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286	
2073.214285714285714285714285714285714286
*/
-- SAL 값에 NULL 이 없기 때문에 RESULT1, RESULT2, RESULT3 결과 같은 것이다.

-- 레코드값에 NULL 이 포함되어있는 COMM 의 경우를 보면,,
SELECT SUM(COMM) / COUNT(COMM) "RESULT1"
     , AVG(COMM) "RESULT2"
     , SUM(COMM) / COUNT(*) "RESULT3"
FROM EMP;
--==>>
/*
550	
550	
157.142857142857142857142857142857142857
*/
--※ 자동으로 NULL 빼줘서 편하다고 함부로 쓰면 안되고,
--   조심히 써야 한다...!!!!

--※ 데이터가 NULL 인 컬럼의 레코드는 연산 대상에서 제외되기 때문에
--   주의하여 연산 처리해야 한다.


--○ VARIANCE() : 분산     [표준편차의 제곱]
--○ STDDEV()   : 표준편차 [분산의 제곱근]

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

-- 결과값 맞는지 확인해보자
-- 제곱 확인해 볼 수 있다.
SELECT POWER(STDDEV(SAL), 2) "RESULT1"
     , VARIANCE(SAL) "RESULT2"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

-- 제곱근 확인해 볼 수 있다.
SELECT SQRT(VARIANCE(SAL)) "RESULT1"
     , STDDEV(SAL) "RESULT2"
FROM EMP;     
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


--○ MAX() : 최댓값
--○ MIN() : 최솟값
SELECT MAX(SAL) "RESULT1"
     , MIN(SAL) "RESULT2"
FROM EMP;
--==>> 5000	800


--※ 주의
SELECT ENAME, SUM(SAL)
FROM EMP;
--==> 에러 발생
--    (ORA-00937: not a single-group group function)
-- 이렇게하면 테이블 구조적으로 에러나서 못 쓴다!

-- 부서별로 그룹의 합을 볼 수도 있음
SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==> 에러 발생
--    (ORA-00937: not a single-group group function)
-- 이것도 똑같이 에러난다.


-- 이럴 때 사용하는 게 → GROUP BY
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>> 
/*
30	9400
20	10875
10	8750
*/
-- PARSING 순서 상, 
-- SELECT 보다, GROUP BY 가 먼저이기 때문에
-- GROUP BY DEPTNO 하고서 SELECT DEPTNO 하면 에러 발생하지 않음


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
20	 800 │
20	3000 ┘
30	1250 ┐
30	1500 │
30	1600 │─ 9400
30	 950 │
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

