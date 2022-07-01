SELECT USER
FROM DUAL;
--==>> SYS

SELECT '문자열'
FROM DUAL;
--==> 문자열

SELECT 550 + 230
FROM DUAL;
--==>> 780

-- 자바에서는 문자열결합을 의미했음
-- 오라클에서는 에러남
SELECT '박현수' + '홍은혜'
FROM DUAL;
--==>> 에러 발생
--     (ORA-01722: invalid number)


--○ 현재 오라클 서버에 존재하는 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>>
/*
SYS	                OPEN
SYSTEM	            OPEN
ANONYMOUS	        OPEN
HR	                OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES	        LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/

-- * : ALL 을 의미
SELECT *
FROM DBA_USERS;
--==>>
/*
SYS	                0		        OPEN		        2022-08-15	            SYSTEM
SYSTEM	            5		        OPEN		        2022-08-15	            SYSTEM
ANONYMOUS	        35		        OPEN		        2014-11-25	            SYSAUX
HR	                43		        OPEN		        2022-08-15	            USERS
APEX_PUBLIC_USER	45		        LOCKED	            2014-05-29	2014-11-25	SYSTEM
FLOWS_FILES	        44		        LOCKED	            2014-05-29	2014-11-25	SYSAUX
APEX_040000	        47		        LOCKED	            2014-05-29	2014-11-25	SYSAUX
OUTLN	            9		        EXPIRED & LOCKED	2022-02-16	2022-02-16	SYSTEM
DIP	                14		        EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
ORACLE_OCM	        21		        EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
XS$NULL	            2147483638		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
MDSYS	            42		        EXPIRED & LOCKED	2014-05-29	2022-02-16	SYSAUX
CTXSYS	            32		        EXPIRED & LOCKED	2022-02-16	2022-02-16	SYSAUX
DBSNMP	            29		        EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
XDB	                34		        EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
APPQOSSYS	        30		        EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
*/

SELECT USERNAME
FROM DBA_USERS;
--==>>
/*
SYS
SYSTEM
ANONYMOUS
HR
APEX_PUBLIC_USER
FLOWS_FILES
APEX_040000
OUTLN
DIP
ORACLE_OCM
XS$NULL
MDSYS
CTXSYS
DBSNMP
XDB
APPQOSSYS
*/

SELECT USERNAME, CREATED
FROM DBA_USERS;
--==>>
/*
SYS	                2014-05-29
SYSTEM	            2014-05-29
ANONYMOUS	        2014-05-29
HR	                2014-05-29
APEX_PUBLIC_USER	2014-05-29
FLOWS_FILES	        2014-05-29
APEX_040000	        2014-05-29
OUTLN	            2014-05-29
DIP	                2014-05-29
ORACLE_OCM	        2014-05-29
XS$NULL	            2014-05-29
MDSYS	            2014-05-29
CTXSYS	            2014-05-29
DBSNMP	            2014-05-29
XDB	                2014-05-29
APPQOSSYS	        2014-05-29
*/

--> 『DBA_』로 시작하는 Oracle Data Dictionary View 는
--  오로지 관리자 권한으로 접속했을 경우에만 조회가 가능하다.
--  아직 데이터 딕셔너리 개념을 잡지 못해도 상관없다.


--○ 『HR』 사용자 계정을 잠금 상태로 설정
-- 구조적변경 : ALTER 키워드 사용
ALTER USER HR ACCOUNT LOCK;
--==>> User HR이(가) 변경되었습니다.
--> USER 중에 HR 의 ACCOUNT를 LOCK 상태로 ALTER 할거야


--○ 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> 
/*
    :
HR	LOCKED
    :
*/

-- (20220217_02_hr.sql  1~16행 작성하고 결과 확인)

--○ 『HR』 사용자 계정을 잠금 해제 설정
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR이(가) 변경되었습니다.
--> USER 중에 HR 의 ACCOUNT를 UNLOCK 상태로 ALTER 할거야


--○ 사용자 계정 상태 조회
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> 
/*
    :
HR	OPEN
    :
*/

-- (20220217_02_hr.sql  6~7행 결과확인)
---------------------------------------------------------

--○ TABLESPACE 생성

--※ TABLESPACE 란?
--> 세그먼트(테이블, 인덱스, ...)를 담아두는(저장해두는)
--  오라클의 논리적인 저장 구조를 의미한다.

--                TABLESPACE 이름
--                --------
CREATE TABLESPACE TBS_EDUA              -- 생성하겠다. 테이블스페이스를... TBS_EDUA 라는 이름으로
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF'   -- 물리적 데이터 파일 경로 및 이름
SIZE 4M                                 -- 사이즈(용량)
EXTENT MANAGEMENT LOCAL                 -- '오라클 서버가 세그먼트를 알아서 관리'하도록 하겠다는 의미
SEGMENT SPACE MANAGEMENT AUTO;          -- '세그먼트 공간 관리도 오라클 서버가 자동으로 관리'하겠다.
--==>> TABLESPACE TBS_EDUA이(가) 생성되었습니다.

-- 물리적인 저장 공간이 있어야, 논리적인 저장이 가능하다.

--※ 테이블스페이스 생성 구문을 실행하기 전에
--   해당 경로의 물리적인 디렉터리 생성이 필요하다.
--   (C:\TESTDATA)


--○ 생성된 테이블스페이스 조회
SELECT *
FROM DBA_TABLESPACES;
--==>>
/*
SYSTEM	    8192	65536		    1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
SYSAUX	    8192	65536		    1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
UNDOTBS1	8192	65536		    1	2147483645	2147483645		65536	ONLINE	UNDO	LOGGING	NO	LOCAL	SYSTEM	NO	MANUAL	DISABLED	NOGUARANTEE	NO	HOST	NO	
TEMP	    8192	1048576	1048576	1	            2147483645	0	1048576	ONLINE	TEMPORARY	NOLOGGING	NO	LOCAL	UNIFORM	NO	MANUAL	DISABLED	NOT APPLY	NO	HOST	NO	
USERS	    8192	65536		    1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
TBS_EDUA	8192	65536		    1	2147483645	2147483645		65536	ONLINE	PERMANENT	LOGGING	NO	LOCAL	SYSTEM	NO	AUTO	DISABLED	NOT APPLY	NO	HOST	NO	
*/


--○ 파일 용량 정보 조회(물리적인 파일 이름 조회)
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
            :
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
            :
*/

-- 지금까지는 일단 공간만 만들어진 것!

-- ADMIN 파트이기는 하지만, FINAL PROJECT에서 필요한 부분이니 잘 봐두기!!!
--○ 오라클 사용자 계정 생성
CREATE USER kjy IDENTIFIED BY java006$      -- 여기까지 쓰고 ; 찍어도 실행됨
DEFAULT TABLESPACE TBS_EDUA;                -- 옵션 부여
--==>> User KJY이(가) 생성되었습니다.
-- 『kjy』 라는 사용자 계정을 생성하겠다.(만들겠다.)
-- 이 사용자 계정에 대한 정체성(패스워드)는 java006$ 로 하겠다.
-- 이 계정을 통해 생성하는 오라클 세그먼트는
-- 기본적으로 TBS_EDUA 라는 테이블스페이스에 생성할 수 있도록 설정하겠다.

--※ 생성된 오라클 사용자 계정(각자 본인 이름 이니셜 계정)을 통해 접속 시도
--   → 접속 불가(실패)
--      『create session』 권한이 없기 때문에 접속 불가.

--○ 생성된 오라클 사용자 계정(각자 본인 이름 이니셜 계정)에 
--   오라클 서버 접속이 가능하도록 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO KJY;
--==>> Grant을(를) 성공했습니다.


--20220217_03_KJY 에서 6~9 행 실행했지만 에러남


--○ 각자 생성한 오라클 사용자 계정의 시스템 관련 권한 조회
SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
        :
KJY	CREATE SESSION	NO
        :
*/

-- 오라클에서 계정 처음 생성하면, 아무런 권한 없음
-- 기본적으로는 자유롭지 못한 상황에서, 
-- 권한 하나씩 부여받으면서 동선 늘어나는 방식

--○ 각자 생성한 오라클 사용자 계정에
--   테이블 생성이 가능하도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO KJY;
--==>> Grant을(를) 성공했습니다.


-- 20220217_03_kjy.sql 로 감 (19~22행)
-- 실행했지만 여전히 에러남
-- 땅은 있지만, 그 땅에 대한 할당량이 없는 상태,,


--○ 각자 생성한 오라클 사용자 계정에
--   테이블 스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량) 지정
ALTER USER KJY
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User KJY이(가) 변경되었습니다.
-- QUOTA : 할당량
-- 1M(1메가), 2M(2메가), UNLIMITED(무제한)


-- 20220217_03_kjy.sql 로 감 (35~38행)
-- 실행하면 테이블 정상적으로 생성됨

-------------------------------------------------------------------

-- scott 계정 생성
CREATE USER scott
IDENTIFIED BY tiger;
--==>> User SCOTT이(가) 생성되었습니다.

-- scott 에게 권한 부여
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant을(를) 성공했습니다.

-- scott의 default tablespace는 users를 사용하게 할거야
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT이(가) 변경되었습니다.

-- scott의 temporary tablespace는 TEMP 를 사용하게 할거야
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT이(가) 변경되었습니다.







