SELECT USER
FROM DUAL;
--==>> SYS

--�� SCOTT ������ VIEW �� ������ �� �ִ� ���� �ο�
--               ---------------------------
--                    CREATE VIEW
GRANT CREATE VIEW TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.


--�� SCOTT �������κ��� VIEW �� ������ �� �ִ� ���� ��Ż
REVOKE CREATE VIEW FROM SCOTT;
-- �̰Ŵ� ���� X

-- SCOTT ���� CREATE VIEW ���� �ο�������, 
-- �ٽ� SCOTT ��ũ��Ʈ�� ���ư�(SCOTT_433��)