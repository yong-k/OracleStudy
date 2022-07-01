
--1�� �ּ��� ó��(������ �ּ��� ó��)

/*
������
(������)
�ּ���
ó��
*/


--�� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ
show user
--==>> USER��(��) "SYS"�Դϴ�.
--> sqlplus ������ �� ����ϴ� ��ɾ�


--�� ������ ���� �����ϰ�� ��ҹ��� ���� X
--��from dual��: �ǹ� ���� ������
--               ��� ���̺� ������ �ʿ� ���� ��,
--               SQL ������ from ���� ����ؼ� ���
select user
from dual;
--==>> SYS

SELECT USER
FROM DUAL;
--==>> SYS

select 1 + 2
from dual;
--==>> 3

SELECT 1 + 2
FROM DUAL;
--==>> 3

-- ����, ����ᵵ ���� x
SELECT                    2 + 4
FROM            DUAL;
--==>> 6

-- BUT, �ٿ����� �ϸ� ������
SELECT 1+5
FROMDUAL;
--==>> ���� �߻�
--(ORA-00923: FROM keyword not found where expected)

SELECT �ֿ밭�ϱ������� F������
FROM DUAL;
--==>> ���� �߻�
--(ORA-00904: "�ֿ밭�ϱ�������": invalid identifier)
--SELECT���� �����Ͱ� ��ȿ���� �ʾƼ� �߻�

--�ڹٿ����� "" �ϸ� ���ڿ��� ���������, ORACLE�� x
SELECT "�ֿ밭�ϱ������� F������"
FROM DUAL;
--==>> ���� �߻�
--(ORA-00972: identifier is too long)

--ORACLE ������ ���ڿ� '' �� �����
SELECT '�ֿ밭�ϱ������� F������'
FROM DUAL;
--==>> �ֿ밭�ϱ������� F������

SELECT '�� �� �� �� ���ܿ� ����Ŭ ����'
FROM DUAL;
--==>> �� �� �� �� ���ܿ� ����Ŭ ����


-- �ڹٴ� ���꿡 �Ǽ� ������, �Ǽ� ������� ����Ǿ�����,
-- ORACLE�� ��� �����غ���
SELECT 3.14 + 3.14
FROM DUAL;
--==>> 6.28

SELECT 10 * 5
FROM DUAL;
--==>> 50

SELECT 10 * 5.0
FROM DUAL;
--==>> 50

SELECT 4 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2
FROM DUAL;
--==>> 2

SELECT 4.0 / 2.0
FROM DUAL;
--==>> 2

SELECT 5 / 2
FROM DUAL;
--==>> 2.5
-- �������� �����µ�, ����� �Ǽ�

SELECT 100 - 23
FROM DUAL;
--==>> 77

