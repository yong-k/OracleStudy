SELECT USER
FROM DUAL;
--==>> SCOTT


--■■■ 암호화 복호화 확인 실습 ■■■--

--○ 테이블 생성
CREATE TABLE TBL_EXAM
( ID    NUMBER
, PW    VARCHAR2(20)
);
--==>> Table TBL_EXAM이(가) 생성되었습니다.


--○ 데이터 입력(비암호화)
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, 'abcd1234');
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_EXAM;
--==>> 1	abcd1234


--○ 롤백
ROLLBACK;
--==>> 롤백 완료.


--○ 다시 데이터 입력(암호화)
--   암호화시키면서, KEY값을 '0518' 줬다.
INSERT INTO TBL_EXAM(ID, PW) VALUES(1, CRYPTPACK.ENCRYPT('abcd1234', '0518'));
--==>> 1 행 이(가) 삽입되었습니다.


--○ 확인
SELECT *
FROM TBL_EXAM;
--==>>1	"$F??"


--○ 데이터 조회(복호화)
--   복호화시키고, KEY값을 '1111' 줬다.
SELECT ID, CRYPTPACK.DECRYPT(PW, '1111')
FROM TBL_EXAM;
--==>> 1	?a!L
--    (잘못된 KEY값을 넣으면 계속 잘못된 값이 나온다.)

SELECT ID, CRYPTPACK.DECRYPT(PW, '2222')
FROM TBL_EXAM;
--==>> 1	?ku?o
--    (잘못된 KEY값을 넣으면 계속 잘못된 값이 나온다.)


-- 올바른 KEY값 넣은 경우, 제대로 나온다.
SELECT ID, CRYPTPACK.DECRYPT(PW, '0518')
FROM TBL_EXAM;
--==>> 1	abcd1234

