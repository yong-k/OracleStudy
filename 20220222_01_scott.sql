SELECT USER
FROM DUAL;
--==>> SCOTT

-- 숫자 관련 함수들

--○ ROUND() : 반올림을 처리해주는 함수
--   2번째 파라미터 : 『n의 자리까지 표현해라』 라는 의미 
--                    → 그 자리까지 유효하게 표현하겠다는 것
--                    !! n의 자리에서 반올림해라 라는 뜻 아님!!
--> 2번째 파라미터 값이 0일 경우에는 생략 가능하다. → 정수형태로 쓰겠다.
--  생략한 형태로 많이 씀. 
-- ROUND(TARGET, N) : N+1의 자리에서 반올림해서 N의 자리까지 표현해라.
SELECT 48.678 "COL1"
     , ROUND(48.678) "COL2"
     , ROUND(48.674, 2) "COL3"
     , ROUND(48.674, 1) "COL4"
     , ROUND(48.674, 0) "COL5"  
     , ROUND(48.674) "COL6"
     , ROUND(48.674, -1) "COL7"
     , ROUND(48.674, -2) "COL8"
     , ROUND(68.674, -2) "COL9"
     , ROUND(48.674, -3) "COL10"
FROM DUAL;
--==>> 48.678	49	48.67	48.7	49	49	50	0	100	0
-- COL2 : 반올림(소숫점 이하 3번째 자리에서 발생)해서 
--        소숫점 이하 2번째 자리까지 표현해라.
-- COL5 : 반올림해서 1의 자리까지 표현해라. → 소숫점 이하 표현하지 않겠다.
-- COL6 : 2번째 파라미터 값이 0일 경우에는 생략 가능하다.
-- COL7 : 반올림해서(1의 자리에서 발생) 10의 자리까지 표현해라.
-- COL8 : 반올림해서 100의자리까지 유효하게 표현하겠다.
--        근데 10의 자리가 4라서 절삭됨
-- COL9 : 10의 자리가 5~9 중의 숫자여서 올림이 발생하는 숫자이니까
--        → 100으로 반올림됨


--○ TRUNC() : 절삭을 처리해주는 함수
--   2번째 파라미터 : 『n의 자리까지 표현해라』 라는 의미 
--                    → 그 자리까지 유효하게 표현하겠다는 것
--                    !! n의 자리에서 절삭해라 라는 뜻 아님!!
-- TRUNC(TARGET, N) : N+1의 자리에서 잘라서 N의 자리까지 표현해라.
SELECT 48.678 "COL1"
     , TRUNC(48.678) "COL2"
     , TRUNC(48.674, 2) "COL3"
     , TRUNC(48.674, 1) "COL4"
     , TRUNC(48.674, 0) "COL5"  
     , TRUNC(48.674) "COL6"
     , TRUNC(48.674, -1) "COL7"
     , TRUNC(48.674, -2) "COL8"
     , TRUNC(68.674, -2) "COL9"
     , TRUNC(48.674, -3) "COL10"
FROM DUAL;
--==>> 48.678	48	48.67	48.6	48	48	40	0	0	0


-- 자바에서의 % 
--○ MOD() : 나머지를 반환하는 함수
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1
--> 5를 2로 나눈 나머지 결과값 반환


--○ POWER() : 제곱의 결과를 반환하는 함수
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125
--> 5의 3제곱을 결과값으로 반환


--○ SQRT() : 루트 결과값을 반환하는 함수
SELECT SQRT(2) "RESULT"
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857
--> 루트 2에 대한 결과값 반환


--○ LOG() : 로그 함수
--   (오라클은 상용로그만 지원하는 반면, 
--    MSSQL 은 상용로그·자연로그 모두 지원한다.)
SELECT LOG(10, 100) "COL1"
     , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677


--○ 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/
--> 각각 싸인, 코싸인, 탄젠트 결과값을 반환한다.


--○ 삼각함수의 역함수(범위 : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
--==>>
/*
0.8414709848078965066525023216302989996233	
0.5403023058681397174009366074429766037354	
1.55740772465490223050697480745836017308
*/
--> 각각, 어싸인, 어코싸인, 어탄젠트 결과값을 반환한다.


--○ SIGN() : 서명 부호 특징
--> 연산 결과값이 양수이면 1, 0이면 0, 음수이면 -1을 반환한다.
--  매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼 때 사용된다.
SELECT SIGN(5-2) "COL1", SIGN(5-5) "COL2", SIGN(5-8) "COL3"
FROM DUAL;
--==>> 1	0	-1


--○ ASCII(), CHR() → 서로 대응(상응)하는 함수
SELECT ASCII('A') "COL1"
     , CHR(65) "COL2"
FROM DUAL;
--==>> 65	A
--> 『ASCII()』 : 매개변수로 넘겨받은 문자의 아스키코드 값을 반환한다.
--  『CHR()』   : 매개변수로 넘겨받은 아스키코드 값으로 해당 문자를 반환한다.


--------------------------------------------------------------------------------

--※ 날짜 관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--※ 날짜 연산의 기본 단위는 DAY(일수) 이다~!!!
SELECT SYSDATE "COL1"
     , SYSDATE + 1 "COL2"
     , SYSDATE - 2 "COL3"
     , SYSDATE - 30 "COL4"
FROM DUAL;
--==>> 
/*
2022-02-22 09:43:51	
2022-02-23 09:43:51	    → 하루 뒤 
2022-02-20 09:43:51	    → 이틀 전
2022-01-23 09:43:51     → 30일 전
*/


--○ 시간 단위 연산
SELECT SYSDATE "COL1"
     , SYSDATE + 1/24 "COL2"
     , SYSDATE - 2/24 "COL3"
FROM DUAL;
--==>> 
/*
2022-02-22 09:46:11	
2022-02-22 10:46:11     → + 1시간 (한 시간 뒤)
2022-02-22 07:46:11     → - 2시간 (두 시간 전)
*/


--○ 현재 시간과... 
--   현재 시간 기준 1일 2시간 3분 4초 후를 조회하는 쿼리문을 구성한다.
/*
--------------------- ---------------------
 현재 시간              연산 후 시간
--------------------- ---------------------
2022-02-22 10:03:21     2022-02-23 12:06:25
*/
-- 나
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + (2/24) + (3/60/24) + (4/60/60/24) "연산 후 시간"
FROM DUAL;
--==>> 2022-02-22 10:17:55	2022-02-23 12:20:59


-- 쌤 _ 방법 1
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "연산 후 시간"
FROM DUAL;
--==>> 2022-02-22 10:17:52	2022-02-23 12:20:56


-- 쌤 _ 방법 2 : 모두 다 초로 환산해서 하는 방법
SELECT SYSDATE "현재 시간"
     , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "연산 후 시간"
FROM DUAL;
--==>> 2022-02-22 10:19:07	2022-02-23 12:22:11


--○ 날짜 - 날짜 = 일수
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') 
    - TO_DATE('2022-02-22', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 118
-- 결과로 알 수 있는 2가지
--① 2022년 6월 20일과 2022년 2월 22일 사이는 118일이라는 간격이 존재한다.
--② 결과값이 양수로 나옴 
-- → 앞에 있는 피연산자가 뒤에 있는 피연산자보다 크다.
-- → 앞에 있는 피연산자가 뒤에 있는 피연산자보다 미래다.


--○ 데이터 타입의 변환
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 2022-06-20 00:00:00
-- 우리가 시, 분, 초 데이터 입력하지 않았기 때문에 00:00:00 으로 나옴

SELECT TO_DATE('2022-06-35', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01847: day of month must be between 1 and last day of month)
--     그냥 피동적으로 입력한 날짜에 대해서 반환해주는 것이 아니라,
--     2022년 6월의 유효한 날짜로 바꿔주기 때문에, 
--     35일 이라는 날짜는 존재하지 않는다고 에러 발생하는 것

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01839: date not valid for month specified)
--     2022년 2월은 28일까지 있기 때문에 에러 발생한다.

SELECT TO_DATE('2022-13-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01843: not a valid month)


--※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환을 수행하는 과정에서
--   내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다.


--○ ADD_MONTHS() : 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"
     , ADD_MONTHS(SYSDATE, 2) "COL2"
     , ADD_MONTHS(SYSDATE, 3) "COL3"
     , ADD_MONTHS(SYSDATE, -2) "COL4"
     , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;
--==>> 
/*
2022-02-22 10:29:38     → 현재
2022-04-22 10:29:38     → 2개월 후
2022-05-22 10:29:38     → 3개월 후
2021-12-22 10:29:38     → 2개월 전
2021-11-22 10:29:38     → 3개월 전
*/
--> 월을 더하고 빼기


--○ MONTHS_BETWEEN()
--   첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환한다.
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> 236.723856780167264038231780167264038232

--> 개월 수의 차이를 반환하는 함수
--  결과값의 부호가 『-』로 반환되었을 경우에는
--  첫 번째 인자값에 해당하는 날짜보다 
--  두 번째 인자값에 해당하는 날짜가 『미래』라는 의미로 확인할 수 있다.


--○ NEXT_DAY()
-- 첫 번째 인자값의 날짜에서,
-- 두 번째 인자값의 요일로, 가장 빠른 해당 날짜가 언제인지 알려줌
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--==>> 2022-02-26 10:38:39	2022-02-28 10:38:39
-- 현재 날짜 2022-02-22(화)  에서 가장 빨리 돌아오는 토요일
--                          에서 가장 빨리 돌아오는 월요일


--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01846: not a valid day of the week)
--     SESSION LANGUAGE 가 ENGLISH로 되어있기 때문에 에러 발생함

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
     , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;
--==>> 2022-02-26 10:40:43	2022-02-28 10:40:43


--※ 세션 설정 다시 변경
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
     , NEXT_DAY(SYSDATE, 'MON') "COL2"
FROM DUAL;
--==>> 에러 발생
--     (ORA-01846: not a valid day of the week)
--     SESSION LANGUAGE 가 KOREAN로 되어있기 때문에 에러 발생함

SELECT NEXT_DAY(SYSDATE, '토') "COL1"
     , NEXT_DAY(SYSDATE, '월') "COL2"
FROM DUAL;
--==>> 2022-02-26 10:42:13	2022-02-28 10:42:13


-- 자바의 CALENDAR 클래스의 getActualMaximum() 과 비슷
--○ LAST_DAY()
--> 해당 날짜가 포함되어 있는 그 달의 마지막 날을 반환한다.
SELECT LAST_DAY(SYSDATE) "COL1"
     , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL2"
     , LAST_DAY(TO_DATE('2019-02-10', 'YYYY-MM-DD')) "COL3"
FROM DUAL;
--==>> 
/*
2022-02-28 10:44:44     → 평년	
2020-02-29 00:00:00     → 윤년
2019-02-28 00:00:00     → 평년
*/


--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--○ 오늘부로... 상기가 군대에 다시 끌려(?)간다...
--   복무기간은 22개월로 한다.

-- 1. 전역 일자를 구한다.

-- 2. 하루 꼬박꼬박 3끼 식사를 한다고 가정하면
--    상기가 몇 끼를 먹어야 집에 보내줄까...

-- 나
SELECT ADD_MONTHS(SYSDATE, 22) "전역 일자"
     , (ADD_MONTHS(SYSDATE, 22) - SYSDATE) * 3 "몇 끼"
FROM DUAL;
--==>> 2023-12-22	2004
-- 22개월이라고 해서 1달은 30일로 계산하면 안된다.
-- → ADD_MONTHS() 함수 사용해서 더해주면 된다.

-- 몇끼를 먹어야하는지는, 복무기간 * 3 해주면 된다.
--                       ---------
--                       (전역일자 - 현재일자)


--○ 현재 날짜 및 시각으로부터...
--   수료일(2022-06-20 18:00:00)까지
--   남은 기간을... 다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.
/*
-------------------------------------------------------------------------------
현재시각            | 수료일                | 일    | 시간   | 분  | 초
-------------------------------------------------------------------------------
2022-02-22 11:34:35 | 2022-06-20 18:00:00   | 118  |  7     | 15  | 15
-------------------------------------------------------------------------------
*/

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

--『1일 2시간 3분 4초』를... 『초』로 환산하면...
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

--『93784초』를... 다시 『일 시간 분 초』로 환산하면...
SELECT TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC(93784/60)/60), 24) "시간"
     , MOD(TRUNC(93784/60), 60) "분"
     , MOD(93784, 60) "초"
FROM DUAL;

-- 수료일까지 남은 기간 확인 (단위 : 일수)
SELECT 수료일자 - 현재일자
FROM DUAL;

SELECT TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)
FROM DUAL;
--==>> 118


-- 수료일까지 남은 기간 확인 (단위 : 초)
SELECT TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60))
FROM DUAL;
--==>> 10205862


--내가 그냥 한거
SELECT SYSDATE "현재시각"
     , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     , TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60/60/24) "일"
     , TRUNC(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60/60, 24)) "시간"
     , TRUNC(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60, 60)) "분"
     , TRUNC(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "초"
FROM DUAL;


--쌤 정리
SELECT SYSDATE "현재시각"
     , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     , TRUNC(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE)* (24*60*60)/60)/60)/24) "일"
     , MOD(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60)/60), 24) "시간"
     , MOD(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60)/60), 60) "분"
     , TRUNC(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') - SYSDATE) * (24*60*60), 60)) "초"
FROM DUAL;


-- << 카페에 올리기 >>
--○ 각자 태어난 날짜 및 시각으로부터... 현재까지
--   얼마만큼의 시간을 살고 있는지...
--   다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.
/*
-------------------------------------------------------------------------------
현재시각            | 생년월일              | 일    | 시간   | 분  | 초
-------------------------------------------------------------------------------
2022-02-22 11:34:35 | 1996-06-08 12:00:00   | XX    |  XX    | XX  | XX
-------------------------------------------------------------------------------
*/


SELECT SYSDATE 현재시각
     , TO_DATE('1996-06-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS') 생년월일
     , TRUNC((SYSDATE - TO_DATE('1996-06-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)/60/60/24) 일
     , TRUNC(MOD((SYSDATE - TO_DATE('1996-06-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)/60/60, 24)) 시간
     , TRUNC(MOD((SYSDATE - TO_DATE('1996-06-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60)/60, 60)) 분
     , MOD((SYSDATE - TO_DATE('1996-06-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60), 60) 초
FROM DUAL;


-- 지금까지는
-- TRUNC() 날짜에 쓴 거 아니라, 초로 환산한 숫자 데이터에 쓴 거임

--○ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.


--※ 날짜 데이터를 대상으로 반올림, 절삭 등의 연산을 수행할 수 있다.

--○ 날짜 반올림 : ROUND()
SELECT SYSDATE "COL1"
     , ROUND(SYSDATE, 'YEAR') "COL2"
     , ROUND(SYSDATE, 'MONTH') "COL3"
     , ROUND(SYSDATE, 'DD') "COL4"
     , ROUND(SYSDATE, 'DAY') "COL5"
FROM DUAL;
--==>> 2022-02-22	2022-01-01	2022-03-01	2022-02-23	2022-02-20
-- COL2 : 년도까지 유효한 데이터
--        8월 정도에 조회했으면 2023년으로 나올거임
--        기준 : 상반기(내림)/하반기(올림)
-- COL3 : 월까지 유효한 데이터
--        기준 : 15일
-- COL4 : 일까지 유효한 데이터
--        기준 : 정오 (낮 12시 지나면 올림)
-- COL5 : 일까지 유효한 데이터
--        기준 : 수요일 정오 (수요일 정오 이전에는, 그 전 일요일 반환)
--                           (목요일에 조회하면,    그 다음 일요일 반환)
-- 그냥 ROUND(SYSDATE) 하게 되면,
-- ROUND(SYSDATE, 'DD')와 같은 결과로 나오게 된다.


--○ 날짜 절삭 : TRUNC()
SELECT SYSDATE "COL1"
     , TRUNC(SYSDATE, 'YEAR') "COL2"
     , TRUNC(SYSDATE, 'MONTH') "COL3"
     , TRUNC(SYSDATE, 'DD') "COL4"
     , TRUNC(SYSDATE, 'DAY') "COL5"
FROM DUAL;
--==>> 2022-02-22	2022-01-01	2022-02-01	2022-02-22	2022-02-20
-- 무조건 버리는 거라 기준 필요 없음
-- COL2 : 년도까지 유효한 데이터
-- COL3 : 월까지 유효한 데이터
-- COL4 : 일까지 유효한 데이터
-- COL5 : 그 전 주에 해당하는 일요일이 무조건 반환됨
 

--------------------------------------------------------------------------------

--■■■ 변환 함수 ■■■--

-- TO_CHAR()    : 숫자나 날짜 데이터를 문자 타입으로 변환시켜주는 함수
-- TO_DATE()    : 문자 데이터를 날짜 타입으로 변환시켜주는 함수
-- TO_NUMBER()  : 문자 데이터를 숫자 타입으로 변환시켜주는 함수

--※ 날짜나 통화 형식이 맞지 않을 경우...
--   설정값을 통해 세션을 설정하여 사용할 수 있다.

-- 아래는 따로 실행할 필요는 없음. 그냥 예시 보여준거임
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\';   -- 화폐라 역슬러시가 아니라 '원'표시임
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';


--○ 날짜형 → 문자형
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "COL1"
     , TO_CHAR(SYSDATE, 'YYYY') "COL2"
     , TO_CHAR(SYSDATE, 'YEAR') "COL3"
     , TO_CHAR(SYSDATE, 'MM') "COL4"
     , TO_CHAR(SYSDATE, 'MONTH') "COL5"
     , TO_CHAR(SYSDATE, 'MON') "COL6"
     , TO_CHAR(SYSDATE, 'DD') "COL7"
     , TO_CHAR(SYSDATE, 'MM-DD') "COL8"
     , TO_CHAR(SYSDATE, 'DAY') "COL9"
     , TO_CHAR(SYSDATE, 'DY') "COL10"
     , TO_CHAR(SYSDATE, 'HH24') "COL11"
     , TO_CHAR(SYSDATE, 'HH') "COL12"
     , TO_CHAR(SYSDATE, 'HH AM') "COL13"
     , TO_CHAR(SYSDATE, 'HH PM') "COL14"
     , TO_CHAR(SYSDATE, 'MI') "COL15"
     , TO_CHAR(SYSDATE, 'SS') "COL16"
     , TO_CHAR(SYSDATE, 'SSSSS') "COL17"
     , TO_CHAR(SYSDATE, 'Q') "COL18"
FROM DUAL;
--==>>
/*
2022-02-22      -- COL1 : 2022년 2월 22일이 아니라, '2022-02-22'인 문자열이다.
2022	-- YYYY
TWENTY TWENTY-TWO	-- YEAR
02      -- MM
2월 	    -- MONTH
2월 	    -- MON
22	    -- DAY가 DD로 표현된다.
02-22	-- MM-DD (월-일)
화요일	-- DAY 는 날짜가 아니라 요일이다.
화	    -- DAY를 줄여서 DY라고 하면 '화요일'도 줄여서 '화'라고 나옴
16	    -- HH24 
04	    -- HH → 결과값이 오전 04인지, 오후 04인지 모름
04 오후	-- HH AM    → AM을 쓰든, PM을 쓰든, 오전에 쓰면 AM 
04 오후	-- HH PM                            오후에 쓰면 PM 나옴   
19	    -- 분은 MM이 아니라 MI 
12	    -- SS (초)
58752	-- SSSSS : 오늘 날짜의 자정(00:00:00)부터 지금까지 흘러온 전체 초
1    -- Q[QUARTER(분기)] : 1분기[1,2,3] 2분기[4,5,6] 3분기[7,8,9] 4분기[10,11,12]
*/
-- 숫자모양으로 반환된 것도 실제 숫자가 아니라, 문자타입이다.
-- 결과 출력시,
-- 숫자 → 우측 정렬
-- 문자 → 좌측 정렬
SELECT 7 "COL1"
     , '7' "COL2"
     , TO_CHAR(7) "COL3"
     FROM DUAL;
--==>> 7	7	7
--> TO_CHAR() 로 출력된 모든 결과는 문자타입이다.
--> 조회 결과가 좌측 정렬인지 우측 정렬인지 확인 ~!!!

SELECT '4' "COL1"
     , TO_NUMBER('4') "COL2"
     , 4 "COL3"
     , TO_NUMBER('04') "COL4"
FROM DUAL;
--==>> 4	4	4	4
-- 오라클에서는 맨 앞에 0이 있는데, 숫자로 바뀌면 0이 탈락한다.


-- 오늘 날짜에서 연도(2022)를 숫자로 얻고 싶으면?
-- 바로 숫자타입으로는 못 바꿈
-- TO_NUMBER()  : 문자 데이터를 숫자 타입으로 변환시켜주는 함수
--               =============
-- → 날짜데이터를 문자데이터로 먼저 만들어야 함
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) "RESULT"
FROM DUAL;
--==>> 2022


-- 날짜데이터 바로 추출해서 숫자로 바꿔주는 거 있음
--○ EXTRACT()
--   ※ 주의 : DAY가 요일이 아니라 일을 나타냄 !!
--   연, 월, 일 이외의 다른 항목은 불가~!!!
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"
     , TO_CHAR(SYSDATE, 'MM') "COL2"
     , TO_CHAR(SYSDATE, 'DD') "COL3"
     , EXTRACT(YEAR FROM SYSDATE) "COL4"    -- CHECK~!!!
     , EXTRACT(MONTH FROM SYSDATE) "COL5"   -- CHECK~!!!
     , EXTRACT(DAY FROM SYSDATE) "COL6"     -- CHECK~!!!
FROM DUAL;
--==>> 
-- COL1 : 2022 (문자형) → 연도를 추출하여 문자 타입으로 반환
-- COL2 : 02   (문자형) → 월을 추출하여 문자 타입으로 반환
-- COL3 : 22   (문자형) → 일을 추출하여 문자 타입으로 반환
-- COL4 : 2022 (숫자형) → 연도를 추출하여 숫자 타입으로 반환
-- COL5 : 2    (숫자형) → 월을 추출하여 숫자 타입으로 반환
-- COL6 : 22   (숫자형) → 일을 추출하여 숫자 타입으로 반환


--○ TO_CHAR() 활용 → 형식 맞춤 표기 결과값 반환
SELECT 60000 "COL1"
     , TO_CHAR(60000, '99,999') "COL2"
     , TO_CHAR(60000, '$99,999') "COL3"
     , TO_CHAR(60000, 'L99,999') "COL4"   -- L : 그 나라에서 쓰는 통화로 표현됨
     , LTRIM(TO_CHAR(60000, 'L99,999')) "RESULT"
FROM DUAL;
--==>> 60000	 60,000	 $60,000	        ￦60,000	￦60,000
-- TO_CHAR() 로 반환되면 문자타입인데, COL4 왜 우측 정렬?
-- 우측 정렬된거 NO. 단순 공백임. 공간 넓혀보면 좌측정렬 된거임
-- 세계의 여러 통화단위를 담기 위해 여유공간을 확보해놓은 것
--> 그래서 통화 표시할 때는 공백제거함수(LTRIM()) 같이 이용함


--※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.


--○ 현재 시간을 기준으로 1일 2시간 3분 4초 후를 조회한다.
SELECT SYSDATE "현재 시간"
     , SYSDATE + 1 + (2/24) + (3/(24*60)) + (4/(24*60*60)) "1일2시간3분4초후"
FROM DUAL;
--==>> 2022-02-22 16:47:49	2022-02-23 18:50:53


--○ 현재 시간을 기준으로 1년 2개월 3일 4시간 5분 6초 후를 조회한다.
--   개월 수를 더하는 함수 이용해서 더해야 함..(윤년,평년 구별해서)
--   → TO_YMINTERVAL(), TO_DSINTERVAL()
--         --               --
--         YEAR,MONTH       DAY,SECOND
--   문자로 된 값을('') 매개변수로 넘겨야 한다.
-- ex)
-- TO_YMINTEVAL('01-02') : 1년 2개월
-- T0_DSINTERVAL('003 04:05:06') : 3일 4시간 5분 6초
--                ---> 일은 크기 때문에 3자리로 전달
SELECT SYSDATE "현재 시간"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06') "연산 시간"
FROM DUAL;
/*
2022-02-22 17:05:27	
2023-04-25 21:10:33
*/


--------------------------------------------------------------------------------

--○ CASE 구문(조건문, 분기문)
/*
CASE
WHEN
THEN
ELSE
END
-- 지금은 CASE문이라고 하지 말고, CASE-WHEN-THEN-ELSE-END 구문 이라고 부르기
*/

SELECT CASE 5+2 WHEN 4 THEN '5+2=4' ELSE '5+2는몰라요' END
FROM DUAL;
--==>> 5+2는몰라요
-- 5+2 의 결과가 4 이면, '5+2=4' 로 하겠다.
--              그 외라면, '5+2는 몰라요' 로 하겠다.

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2=6' END
FROM DUAL;
--==>> 5+2=7

SELECT CASE 1+1 WHEN 2 THEN '1+1=2' 
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                WHEN 2 THEN '혹시2?' -- 여기까지 보러 안 옴
                ELSE '난산수싫어'
       END "RESULT"
FROM DUAL;
--==>> 1+1=2
-- 1+1이 2여서 WHEN 2로 들어가면, 밑에 WHEN절은 안 봄
-- 밑에 WHEN 2가 또 있어도 처리 x


-- CASE에서 조건 제시하고, WHEN 에서 답을 제시해서
-- 둘이 합쳐진 결과값이 TRUE/FALSE를 반환하기만 하면 됨
SELECT CASE WHEN 5+2=4 THEN '5+2=4'
            WHEN 6-3=2 THEN '6-3=2'
            WHEN 7*1=8 THEN '7*1=8'
            WHEN 6/2=3 THEN '6/2=3'
            ELSE '모르겠네'
       END "RESULT"
FROM DUAL;
--==>> 6/2=3


-- CASE와 같은 기능을 하는 함수
--○ DECODE() : 매개변수 개수 제한 없음 
SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '5-2는 몰라요') "RESULT"
FROM DUAL;
--==>> 5-2=3
/*
5-2 수행한 결과가 1이면 '5-2=1' 이라고 할래
                  2이면, '5-2=2' 이라고 할래
                  3이면, '5-2=3' 이라고 할래
                  다 아니면, '5-2는 몰라요'라고 할래
*/              


--○ CASE WHEN THEN ELSE END (조건문, 분기문) 활용
SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '5와 2는 비교불가'
       END "RESULT"
FROM DUAL;
--==>> 5>2


-- CASE WHEN THEN ELSE END 쓰면서 많이 쓰는게 '논리연산자'
-- 논리연산자 쓰면서 잘 사용해야한다.
-- 답이 잘못되게 나올 수 있어서 훨씬 더 위험하다.

SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
       END "RESULT"
FROM DUAL;
--==>> 은혜만세
/*
① WHEN 5<2 OR 3>1 AND 2=2
        ---    ---
        F   OR  T
        ---------      ---
            TRUE  AND  TRUE
            ---------------
               TRUE
--> 여기까지 해서 TRUE니까 밑에 다른 건 안 보고 끝남                     
*/

SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'
       END "RESULT"
FROM DUAL;
--==>> 현수만세
/*
① WHEN 3<1 AND 5<2 OR 3>1 AND 2=2
        ---    ---
        F   AND  F
        ---------      ---
            FLASE  OR TRUE
            ---------------    ----
               TRUE       AND  TRUE
               --------------------
                   TRUE
--> 여기까지 해서 TRUE니까 밑에 다른 건 안 보고 끝남                     
*/

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'
       END "RESULT"
FROM DUAL;
--==>> 태형만세

--------------------------------------------------------------------------------
SELECT *
FROM TBL_SAWON;


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