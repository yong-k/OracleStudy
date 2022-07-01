-- TABLESPACE ����
CREATE TABLESPACE TBS_TEAM1
DATAFILE 'C:\TESTDATA\TBS_TEAM1.DBF'
SIZE 4M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;
--==>> TABLESPACE TBS_TEAM1��(��) �����Ǿ����ϴ�.


-- ��������
CREATE USER team1 IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_TEAM1;
--==>> User TEAM1��(��) �����Ǿ����ϴ�.


-- create session ���� �ο�
GRANT CREATE SESSION TO team1;
--==>> Grant��(��) �����߽��ϴ�.


-- team1 ���Ӱ�ü ����
/*
name : local_team1
������̸�: team1
��й�ȣ : java006$
��: �⺻��
*/


-- create table ���� �ο�
GRANT CREATE TABLE TO team1;
--==>> Grant��(��) �����߽��ϴ�.


-- ���� ������ ����Ŭ ����� ������ �Ҵ緮 �ο�
ALTER USER team1
QUOTA UNLIMITED ON TBS_TEAM1;
--==>> User TEAM1��(��) ����Ǿ����ϴ�.


-- create sequence ���� �ο�
GRANT CREATE SEQUENCE TO team1;
--==>> Grant��(��) �����߽��ϴ�.


-- create view ���� �ο�
GRANT CREATE VIEW TO team1;
--==>> Grant��(��) �����߽��ϴ�.


-- resource ���� �ο�
GRANT RESOURCE TO team1;
--==>> Grant��(��) �����߽��ϴ�.


-- create procedure ���� �ο�
GRANT CREATE PROCEDURE TO team1;
--==>> Grant��(��) �����߽��ϴ�.
