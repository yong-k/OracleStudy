SELECT USER
FROM DUAL;
--==>> SYS

--○ SCOTT 계정에 VIEW 를 생성할 수 있는 권한 부여
--               ---------------------------
--                    CREATE VIEW
GRANT CREATE VIEW TO SCOTT;
--==>> Grant을(를) 성공했습니다.


--○ SCOTT 계정으로부터 VIEW 를 생성할 수 있는 권한 박탈
REVOKE CREATE VIEW FROM SCOTT;
-- 이거는 실행 X

-- SCOTT 에게 CREATE VIEW 권한 부여했으니, 
-- 다시 SCOTT 워크시트로 돌아감(SCOTT_433줄)