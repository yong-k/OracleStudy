SELECT USER
FROM DUAL;
--==>> SYS

SELECT '���ڿ�'
FROM DUAL;
--==> ���ڿ�

SELECT 550 + 230
FROM DUAL;
--==>> 780

-- �ڹٿ����� ���ڿ������� �ǹ�����
-- ����Ŭ������ ������
SELECT '������' + 'ȫ����'
FROM DUAL;
--==>> ���� �߻�
--     (ORA-01722: invalid number)


--�� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ
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

-- * : ALL �� �ǹ�
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

--> ��DBA_���� �����ϴ� Oracle Data Dictionary View ��
--  ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
--  ���� ������ ��ųʸ� ������ ���� ���ص� �������.


--�� ��HR�� ����� ������ ��� ���·� ����
-- ���������� : ALTER Ű���� ���
ALTER USER HR ACCOUNT LOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.
--> USER �߿� HR �� ACCOUNT�� LOCK ���·� ALTER �Ұž�


--�� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> 
/*
    :
HR	LOCKED
    :
*/

-- (20220217_02_hr.sql  1~16�� �ۼ��ϰ� ��� Ȯ��)

--�� ��HR�� ����� ������ ��� ���� ����
ALTER USER HR ACCOUNT UNLOCK;
--==>> User HR��(��) ����Ǿ����ϴ�.
--> USER �߿� HR �� ACCOUNT�� UNLOCK ���·� ALTER �Ұž�


--�� ����� ���� ���� ��ȸ
SELECT USERNAME, ACCOUNT_STATUS
FROM DBA_USERS;
--==>> 
/*
    :
HR	OPEN
    :
*/

-- (20220217_02_hr.sql  6~7�� ���Ȯ��)
---------------------------------------------------------

--�� TABLESPACE ����

--�� TABLESPACE ��?
--> ���׸�Ʈ(���̺�, �ε���, ...)�� ��Ƶδ�(�����صδ�)
--  ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

--                TABLESPACE �̸�
--                --------
CREATE TABLESPACE TBS_EDUA              -- �����ϰڴ�. ���̺����̽���... TBS_EDUA ��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF'   -- ������ ������ ���� ��� �� �̸�
SIZE 4M                                 -- ������(�뷮)
EXTENT MANAGEMENT LOCAL                 -- '����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����'�ϵ��� �ϰڴٴ� �ǹ�
SEGMENT SPACE MANAGEMENT AUTO;          -- '���׸�Ʈ ���� ������ ����Ŭ ������ �ڵ����� ����'�ϰڴ�.
--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.

-- �������� ���� ������ �־��, ������ ������ �����ϴ�.

--�� ���̺����̽� ���� ������ �����ϱ� ����
--   �ش� ����� �������� ���͸� ������ �ʿ��ϴ�.
--   (C:\TESTDATA)


--�� ������ ���̺����̽� ��ȸ
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


--�� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
SELECT *
FROM DBA_DATA_FILES;
--==>>
/*
            :
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
            :
*/

-- ���ݱ����� �ϴ� ������ ������� ��!

-- ADMIN ��Ʈ�̱�� ������, FINAL PROJECT���� �ʿ��� �κ��̴� �� ���α�!!!
--�� ����Ŭ ����� ���� ����
CREATE USER kjy IDENTIFIED BY java006$      -- ������� ���� ; �� �����
DEFAULT TABLESPACE TBS_EDUA;                -- �ɼ� �ο�
--==>> User KJY��(��) �����Ǿ����ϴ�.
-- ��kjy�� ��� ����� ������ �����ϰڴ�.(����ڴ�.)
-- �� ����� ������ ���� ��ü��(�н�����)�� java006$ �� �ϰڴ�.
-- �� ������ ���� �����ϴ� ����Ŭ ���׸�Ʈ��
-- �⺻������ TBS_EDUA ��� ���̺����̽��� ������ �� �ֵ��� �����ϰڴ�.

--�� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)�� ���� ���� �õ�
--   �� ���� �Ұ�(����)
--      ��create session�� ������ ���� ������ ���� �Ұ�.

--�� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)�� 
--   ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO KJY;
--==>> Grant��(��) �����߽��ϴ�.


--20220217_03_KJY ���� 6~9 �� ���������� ������


--�� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
--==>>
/*
        :
KJY	CREATE SESSION	NO
        :
*/

-- ����Ŭ���� ���� ó�� �����ϸ�, �ƹ��� ���� ����
-- �⺻�����δ� �������� ���� ��Ȳ����, 
-- ���� �ϳ��� �ο������鼭 ���� �þ�� ���

--�� ���� ������ ����Ŭ ����� ������
--   ���̺� ������ �����ϵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO KJY;
--==>> Grant��(��) �����߽��ϴ�.


-- 20220217_03_kjy.sql �� �� (19~22��)
-- ���������� ������ ������
-- ���� ������, �� ���� ���� �Ҵ緮�� ���� ����,,


--�� ���� ������ ����Ŭ ����� ������
--   ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮) ����
ALTER USER KJY
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User KJY��(��) ����Ǿ����ϴ�.
-- QUOTA : �Ҵ緮
-- 1M(1�ް�), 2M(2�ް�), UNLIMITED(������)


-- 20220217_03_kjy.sql �� �� (35~38��)
-- �����ϸ� ���̺� ���������� ������

-------------------------------------------------------------------

-- scott ���� ����
CREATE USER scott
IDENTIFIED BY tiger;
--==>> User SCOTT��(��) �����Ǿ����ϴ�.

-- scott ���� ���� �ο�
GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.

-- scott�� default tablespace�� users�� ����ϰ� �Ұž�
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.

-- scott�� temporary tablespace�� TEMP �� ����ϰ� �Ұž�
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.







