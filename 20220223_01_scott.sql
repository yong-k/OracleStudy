SELECT USER
FROM DUAL;
--==>> SCOTT

--���� �ߴ��� Ǯ�� �̾ ����
--�� TBL_SAWON ���̺��� Ȱ���Ͽ� 
--   ������ ���� �׸���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   �����ȣ, �����, �ֹι�ȣ, ����, �Ի���
-- ��
--�� DECODE() ���
SELECT SANO �����ȣ, SANAME �����, JUBUN �ֹι�ȣ
    , DECODE(SUBSTR(JUBUN, 7, 1), '1', '��', '2', '��', '3', '��', 4, '��', '??') ����
    , HIREDATE �Ի���
FROM TBL_SAWON;

--�� CASE WHEN THEN ELSE END ���
SELECT SANO �����ȣ, SANAME �����, JUBUN �ֹι�ȣ
    , CASE SUBSTR(JUBUN, 7, 1) WHEN '1' THEN '��'
                               WHEN '2' THEN '��'
                               WHEN '3' THEN '��'
                               WHEN '4' THEN '��'
                               ELSE '??'
      END ����
    , HIREDATE �Ի���
FROM TBL_SAWON;
--==>>
/*
1001	��μ�	    9707251234567	��	2005-01-03
1002	������	    9505152234567	��	1999-11-23
1003	������	    9905192234567	��	2006-08-10
1004	�̿���	    9508162234567	��	2007-10-10
1005	���̻�	    9805161234567	��	2007-10-10
1006	������	    8005132234567	��	1999-10-10
1007	������	    0204053234567	��	2010-10-10
1008	������	    6803171234567	��	1998-10-10
1009	������	6912232234567	��	1998-10-10
1010	���켱	    0303044234567	��	2010-10-10
1011	������	    0506073234567	��	2012-10-10
1012	���ù�	    0208073234567	��	2012-10-10
1013	����	    6712121234567	��	1998-10-10
1014	ȫ����	    0005044234567	��	2015-10-10
1015	�Ӽҹ�	    9711232234567	��	2007-10-10
1016	���̰�	    0603194234567	��	2015-01-20
*/

--��
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
    , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '����'
           WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '����'
           ELSE '����Ȯ�κҰ�'
      END "����"
    , HIREDATE "�Ի���"
FROM TBL_SAWON;
--==>>
/*
1001	��μ�	9707251234567	����	    2005-01-03
1002	������	9505152234567	����	    1999-11-23
1003	������	9905192234567	����  	    2006-08-10
1004	�̿���	9508162234567	����	    2007-10-10
1005	���̻�	9805161234567	����	    2007-10-10
1006	������	8005132234567	����	    1999-10-10
1007	������	0204053234567	����	    2010-10-10
1008	������	6803171234567	����	    1998-10-10
1009	������6912232234567	����	    1998-10-10
1010	���켱	0303044234567	����	    2010-10-10
1011	������	0506073234567	����	    2012-10-10
1012	���ù�	0208073234567	����	    2012-10-10
1013	����  	6712121234567	����	    1998-10-10
1014	ȫ����	0005044234567	����	    2015-10-10
1015	�Ӽҹ�	9711232234567	����	    2007-10-10
1016	���̰�	0603194234567	����	    2015-01-20
*/


--�� TBL_SAWON ���̺��� Ȱ���Ͽ� 
--   ������ ���� �׸���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
--   �������ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���
--   , ����������, �ٹ��ϼ�, �����ϼ�, �޿�, ���ʽ���
--   ��, ���糪�̴� �⺻ �ѱ����� ������ ���� ������ �����Ѵ�.
--   ����, ������������ �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ����
--   �� ������ �Ի� ��, �Ϸ� ������ �����Ѵ�.
--   �ٹ��ϼ� (�Ի��ϰ� ���ݱ��� �󸶳� ���ߴ���)
--   �����ϼ� (���������ϱ��� �󸶳� ���Ҵ���)
--   �׸���, ���ʽ��� 1000�� �̻� 2000�� �̸� �ٹ��� ����� �� ����� ���� �ݿ� ���� 30% ����, 
--                    2000�� �̻� �ٹ��� ����� �� ����� ���� �޿� ���� 50% ������ �� �� �ֵ��� ó���Ѵ�.
--   (�� ���ʽ� : �ٹ��ϼ��� �������� ���)
--    SANO SANAME JUBUN         ���� ���糪�� �Ի���     ���������� �ٹ��ϼ� �����ϼ� SAL BONUS
--ex) 1001 ��μ� 9707251234567 ����  26      2005-01-03 2056-01-03 212121   2232323 3000 1500 

-- ��
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
    -- ����
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
            ELSE '�Ǻ��Ұ�'
       END "����"
    -- ���糪��
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM 
        TO_DATE(SUBSTR(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') THEN CONCAT('19', JUBUN)
                            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') THEN CONCAT('20', JUBUN) END
                , 1, 4), 'YYYY')) + 1 "���糪��"
    -- �Ի���
     , HIREDATE "�Ի���"
    -- ����������
     , TO_DATE(CONCAT(EXTRACT(YEAR FROM (ADD_MONTHS(SYSDATE, 
        (60 - (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM 
            TO_DATE(SUBSTR(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') THEN CONCAT('19', JUBUN)
                                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') THEN CONCAT('20', JUBUN) END
                    , 1, 4), 'YYYY')) + 1))*12))), SUBSTR(HIREDATE, 5)), 'YYYY-MM-DD') "����������"
    -- �ٹ��ϼ�
     , TRUNC(SYSDATE - HIREDATE) "�ٹ��ϼ�"
    -- �����ϼ�
     , TRUNC(TO_DATE(CONCAT(EXTRACT(YEAR FROM (ADD_MONTHS(SYSDATE, 
        (60 - (EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM 
            TO_DATE(SUBSTR(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') THEN CONCAT('19', JUBUN)
                                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') THEN CONCAT('20', JUBUN) END
                    , 1, 4), 'YYYY')) + 1))*12))), SUBSTR(HIREDATE, 5)), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
    -- �޿�
     , SAL "�޿�"
    -- ���ʽ�
     , CASE WHEN TRUNC(SYSDATE - HIREDATE) >= 1000 AND TRUNC(SYSDATE - HIREDATE) < 2000 THEN SAL*0.3
            WHEN TRUNC(SYSDATE - HIREDATE) >= 2000                                      THEN SAL*0.5
       END "���ʽ�"
FROM TBL_SAWON;
--==>>
/*
1001	��μ�	9707251234567	��	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	9505152234567	��	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	9905192234567	��	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	9508162234567	��	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	9805161234567	��	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	8005132234567	��	43	1999-10-10	2039-10-10	8172	6437	1000	500
1007	������	0204053234567	��	21	2010-10-10	2061-10-10	4154	14473	1000	500
1008	������	6803171234567	��	55	1998-10-10	2027-10-10	8537	2054	1500	750
1009	������	6912232234567	��	54	1998-10-10	2028-10-10	8537	2420	1300	650
1010	���켱	0303044234567	��	20	2010-10-10	2062-10-10	4154	14838	1600	800
1011	������	0506073234567	��	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	���ù�	0208073234567	��	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	����	    6712121234567	��	56	1998-10-10	2026-10-10	8537	1689	2200	1100
1014	ȫ����	0005044234567	��	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	9711232234567	��	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	���̰�	0603194234567	��	17	2015-01-20	2065-01-20	2591	15671	1500	750
*/


--��
-- �����ȣ, �����, �ֹι�ȣ, ����, ���糪��, �Ի���, �޿� ... ����
-- ���糪��
-- �� 1900����(�ֹι�ȣ 7��°�� 1 OR 2)�̶��, ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1899)
-- �� 2000����(�ֹι�ȣ 7��°�� 3 OR 4)�̶��, ����⵵ - (�ֹι�ȣ�յ��ڸ� + 1999)
SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
    -- ����
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
            ELSE '����Ȯ�κҰ�'
       END "����"
    -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���) 
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1
       END "���糪��"
    -- �Ի���
     , HIREDATE "�Ի���"
    -- �޿�
     , SAL "�޿�"
FROM TBL_SAWON;


-- �� CASE WHEN THEN ELSE END
--    CASE WHEN ��� THEN �����
--         WHEN ��� THEN �����
--         ELSE �����
--    END "�÷���Ī"
--
--==>> THEN�� ELSE �ڿ� ���� ���� ������Ÿ���� ���ƾ� �Ѵ�!
--     ���� ���ϰ� �־ THEN ��������� �� ����(����Ÿ��) �����,
--     ELSE �κп� ����ó���Ѵٰ�, '�����Ǻ��Ұ�'(����Ÿ��) ������� ������
--     
--     �� �׷���쿡�� ELSE -1 �� ���� ���� �� (����Ÿ�Կ� �־ ����ó��)


-- SELECT �տ��� �����Ѱ� �ڿ��� �� ���� �ʹٴ� ������ ����� ����
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM,0) "����", ����*2 "�ι迬��"
FROM EMP;
--==>> ���� �߻�
--     (ORA-00904: "����": invalid identifier)
--==>> �տ��� ��ȸ�ߴٰ�, ���� �÷����� �� ��� ����� �� �ִ� �� �ƴ�

-- �׷� �տ��� ���� SELECT ����� ��� �Ұ�? 
-- NO. �������� ����ϸ� ��
SELECT ����*2 "�ι迬��"
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "����"
    FROM EMP
);

-- FROM �������� ���� ��Ī �ٿ����� ��� ����
SELECT T.EMPNO, T.ENAME, T.SAL, T.����
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "����"
    FROM EMP
) T;

SELECT T.*
FROM
(
    SELECT EMPNO, ENAME, SAL, COMM, SAL*12+NVL(COMM, 0) "����"
    FROM EMP
) T;


-- �� Ǯ�� �ٽ� �̾ 
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
    -- ����������
    -- ���������⵵ �� �ش� ������ ���̰� �ѱ����̷� 60���� �Ǵ� ��
    -- ���� ���̰�... 57��...  3�� ��   2022 �� 2025
    -- ���� ���̰�... 28��... 32�� ��   2022 �� 2054
    -- ADD_MONTHS(SYSDATE, �������*12)
    --                     --------
    --                     60 - ���糪��
    -- ADD_MONTHS(SYSDATE,(60 - ���糪��) * 12) �� Ư����¥
    -- TO_CHAR('Ư����¥', 'YYYY') �� �������� �⵵�� ����Ÿ������ ����
    -- TO_CHAR(�Ի���, 'MM-DD')    �� �Ի� ���ϸ� ����Ÿ������ ����
    -- TO_CHAR('Ư����¥', 'YYYY') || '-' || TO_CHAR(�Ի���, 'MM-DD') "����������"
    , TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"
    
    -- �ٹ��ϼ� = ������ - �Ի���
    , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"
    
    -- �����ϼ� = ���������� - ������
    -- �� �굵 �������� �� ����� �� ������, �ʹ� ������ϱ� �׳� �տ����� ������
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"
    
    -- �޿�
    , T.�޿�
    
    -- ���ʽ�
    -- �ٹ��ϼ��� 1000�� �̻� 2000�� �̸� �� ���� �޿��� 30% ����
    -- �ٹ��ϼ��� 2000�� �̻�             �� ���� �޿��� 50% ����
    -- ������                            �� 0
    ------------------------------------------------------------
    -- �ٹ��ϼ� 2000�� �̻�               �� T.�޿� * 0.5
    -- �ٹ��ϼ� 1000�� �̻�               �� T.�޿� * 0.3
    -- ������                             �� 0
    ------------------------------------------------------------
               -- >=2000 ���� ���ָ� �� 2000�� �̸��� ���� ���� �� �ᵵ ��
    , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
           WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
           ELSE 0
      END "���ʽ�"
FROM
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
        -- ����
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                ELSE '����Ȯ�κҰ�'
           END "����"
        -- ���糪�� = ����⵵ - �¾�⵵ + 1 (1900��� / 2000���) 
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE -1
           END "���糪��"
        -- �Ի���
         , HIREDATE "�Ի���"
        -- �޿�
         , SAL "�޿�"
    FROM TBL_SAWON
) T;
-- FROM ���� �� �����������̺����� SANO��� �÷� �������� ����
-- �츮�� ��Ī ���� �������ȣ�� �÷��� ������ !
--==>>
/*
1001	��μ�	    9707251234567	��	26	2005-01-03	2056-01-03	6260	12366	3000	1500
1002	������	    9505152234567	��	28	1999-11-23	2054-11-23	8128	11960	4000	2000
1003	������	    9905192234567	��	24	2006-08-10	2058-08-10	5676	13316	3000	1500
1004	�̿���	    9508162234567	��	28	2007-10-10	2054-10-10	5250	11916	4000	2000
1005	���̻�	    9805161234567	��	25	2007-10-10	2057-10-10	5250	13012	4000	2000
1006	������	    8005132234567	��	43	1999-10-10	2039-10-10	8172	 6437	1000	 500
1007	������	    0204053234567	��	21	2010-10-10	2061-10-10	4154	14473	1000	 500
1008	������	    6803171234567	��	55	1998-10-10	2027-10-10	8537	 2054	1500	 750
1009	������	6912232234567	��	54	1998-10-10	2028-10-10	8537	 2420	1300	 650
1010	���켱	    0303044234567	��	20	2010-10-10	2062-10-10	4154	14838	1600	 800
1011	������	    0506073234567	��	18	2012-10-10	2064-10-10	3423	15569	2600	1300
1012	���ù�	    0208073234567	��	21	2012-10-10	2061-10-10	3423	14473	2600	1300
1013	����	    6712121234567	��	56	1998-10-10	2026-10-10	8537	 1689	2200	1100
1014	ȫ����	    0005044234567	��	23	2015-10-10	2059-10-10	2328	13742	5200	2600
1015	�Ӽҹ�	    9711232234567	��	26	2007-10-10	2056-10-10	5250	12647	5500	2750
1016	���̰�	    0603194234567	��	17	2015-01-20	2065-01-20	2591	15671	1500	 750
*/

--> ���� �츮�� �� ���������� ���ζ��� ��(INLINE VIEW)�� ��� �Ѵ�.


--�� TBL_SAWON ���̺� ������ �߰� �Է�
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1017, '��ȣ��', '9611121234567', SYSDATE, 5000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.


--�� Ȯ��
SELECT *
FROM TBL_SAWON;
--==>> 
/*
    :
1017	��ȣ��	9611121234567	2022-02-23	5000 
    :
*/
-- �� ������


--�� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.


--�� ������ �ۼ��� ������ �����ͼ�, ���� �߰��� '��ȣ��' ��� ������ �ֳ� Ȯ��
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
    -- ����������
    , TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"  
    -- �ٹ��ϼ�
    , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"   
    -- �����ϼ�
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"    
    -- �޿�
    , T.�޿�  
    -- ���ʽ�
    , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
           WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
           ELSE 0
      END "���ʽ�"
FROM
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
        -- ����
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                ELSE '����Ȯ�κҰ�'
           END "����"
        -- ���糪��
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE -1
           END "���糪��"
        -- �Ի���
         , HIREDATE "�Ի���"
        -- �޿�
         , SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>> 
/*
    :
1017	��ȣ��	9611121234567	��	27	2022-02-23	2055-02-23	0	12052	5000	0
    :
*/
-- '��ȣ��' �����͵� ��µǴ� �� Ȯ���� �� ����


-- ������ ó���� ������ �������
-- Ư�� �ٹ��ϼ��� ����� Ȯ���ؾ� �Ѵٰų�...
-- Ư�� ���ʽ� �ݾ��� �޴� ����� Ȯ���ؾ� �� ��찡 �߻��� �� �ִ�.
-- �̿� ���� ���... �ش� �������� �ٽ� �����ؾ� �ϴ� ���ŷο��� ���� �� �ֵ���
-- ��(VIEW)�� ����� ������ �� �� �ִ�.

-- ���̺��� ���� ������,
CREATE TABLE TBL_TEST
( COL1  NUMBER
, COL2  VARCHAR2(30)
);
-- (���� ��Ŷ� �������� ����)
-- �̰� �����ؼ� TBL_TEST ���̺� �����������,
-- �� �����ϸ� �̹� TBL_TEST ���̺� �ִµ�, �� ���鲨��? 
-- �̹� �ֱ� ������ �� ����ٰ� ���� ��

-- ���̺� ���� ��, �並 ����� �� ó��
CREATE OR REPLACE TABLE TBL_TEST
( COL1  NUMBER
, COL2  VARCHAR2(30)
);
-- �ϸ� ���� �� (ORA-00922: missing or invalid option)
-- ���̺��� �̷������� �����ϸ� �ȵǴϱ�

-- �並 ���� ������,
-- ���̺��� ���� ������ ���̺��� ����� �� ó�� � �����͸� �ִ� ���� �ƴ϶�,
-- ���̺� ��ü�� �����ߴ� �������� �־���
-- ORACLE���� �������� �����Ѵٴ� �������� VIEW �����
-- VIEW_SAWON �䰡 �̹� ��������ִ���, ���� ���Ӱ� ����� ������ ����� ��
CREATE OR REPLACE VIEW VIEW_SAWON
AS  -- �̰� ó�� ������ּ���. (���̺� ������ �� ����غ�)
SELECT T.�����ȣ, T.�����, T.�ֹι�ȣ, T.����, T.���糪��, T.�Ի���
    -- ����������
    , TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD') "����������"  
    -- �ٹ��ϼ�
    , TRUNC(SYSDATE - T.�Ի���) "�ٹ��ϼ�"   
    -- �����ϼ�
    , TRUNC(TO_DATE(TO_CHAR(ADD_MONTHS(SYSDATE,(60 - T.���糪��) * 12), 'YYYY') || '-' || TO_CHAR(T.�Ի���, 'MM-DD'), 'YYYY-MM-DD') - SYSDATE) "�����ϼ�"    
    -- �޿�
    , T.�޿�  
    -- ���ʽ�
    , CASE WHEN TRUNC(SYSDATE - T.�Ի���) >= 2000 THEN T.�޿� * 0.5
           WHEN TRUNC(SYSDATE - T.�Ի���) >= 1000 THEN T.�޿� * 0.3
           ELSE 0
      END "���ʽ�"
FROM
(
    SELECT SANO "�����ȣ", SANAME "�����", JUBUN "�ֹι�ȣ"
        -- ����
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
                WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
                ELSE '����Ȯ�κҰ�'
           END "����"
        -- ���糪��
         , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
                WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
                THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
                ELSE -1
           END "���糪��"
        -- �Ի���
         , HIREDATE "�Ի���"
        -- �޿�
         , SAL "�޿�"
    FROM TBL_SAWON
) T;
--==>> ���� �߻�
--     (ORA-01031: insufficient privileges) 
--     �� SCOTT ���� VIEW �� ���� �� �ִ� ���� ����

--> SYS ����Ŭ���ؼ� ������ 
--  SCOTT ���� VIEW ���� �� �ִ� ���� �ο��ϰ� ��

-- �׷��� ���� CREATE OR REPLACE VIEW �� �����ϴ�
--==>> View VIEW_SAWON��(��) �����Ǿ����ϴ�.

-- �̷��� ������� VIEW�� �Ϲ� TABLE ó�� ��ȸ�� �� �ִ�.
SELECT *
FROM VIEW_SAWON;

-- �Ʊ� �� ���̺� �� �ۼ��ؼ� Ȯ���ϴ� �� �ƴϰ�,
-- VIEW ���� ���Ǽ����ؼ� ��ȸ�ϸ� ������~!
SELECT *
FROM VIEW_SAWON
WHERE �ٹ��ϼ� >= 6000;

SELECT *
FROM VIEW_SAWON
WHERE �����ϼ� >= 15000;

SELECT *
FROM VIEW_SAWON
WHERE ���ʽ� >= 2000;

-- VIEW_SAWON ������ TABLE �� �����ϴ� �� �ƴ�����,
-- TABLE �� �����ϴ� ��ó�� ��ȸ����


--�� VIEW ���� ���� TBL_SAWON ���̺� ������ �߰� �Է�
INSERT INTO TBL_SAWON(SANO, SANAME, JUBUN, HIREDATE, SAL)
VALUES(1018, '�Ž���', '9910312234567', SYSDATE, 5000);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

-- VIEW ���� ���Ŀ�, TBL_SAWON ���̺� ������ �߰��Ѱǵ���,
-- VIEW_SAWON ���̺��� '�Ž���' ������ ������
SELECT *
FROM VIEW_SAWON;
--==>> 
/*
    :
1018	�Ž���	9910312234567	��	24	2022-02-23	2058-02-23	0	13148	5000	0
    :
*/


--�� ���������� Ȱ���Ͽ� (VIEW ����ϴ� �� �ƴ�)
--   TBL_SAWON ���̺��� ������ ���� ��ȸ�� �� �ֵ��� �Ѵ�.
/*
--------------------------------------------
�����   ����   ���糪��   �޿�   ���̺��ʽ�
--------------------------------------------

��, ���� ���ʽ��� ���� ���̰� 50�� �̻��̸� �޿��� 70%
                              40�� �̻� 50�� �̸��̸� �޿��� 50%
                              20�� �̻� 40�� �̸��̸� �޿��� 30%

����, �ϼ��� ��ȸ ������ ����
VIEW_SAWON2 ��� �̸��� ��(VIEW) �� �����Ѵ�.
*/
SELECT T.*
     , CASE WHEN T.���糪�� >= 50 THEN T.�޿� * 0.7
            WHEN T.���糪�� >= 40 THEN T.�޿� * 0.5
            WHEN T.���糪�� >= 20 THEN T.�޿� * 0.3
            ELSE 0
       END "���̺��ʽ�"
FROM 
(
SELECT SANAME "�����"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
            ELSE '����Ȯ�κҰ�'
       END "����"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1
       END "���糪��"
     , SAL "�޿�"
FROM TBL_SAWON
) T;


-- VIEW_SAWON2 ��� �̸��� ��(VIEW) �� ����
CREATE OR REPLACE VIEW VIEW_SAWON2
AS
SELECT T.*
     , CASE WHEN T.���糪�� >= 50 THEN T.�޿� * 0.7
            WHEN T.���糪�� >= 40 THEN T.�޿� * 0.5
            WHEN T.���糪�� >= 20 THEN T.�޿� * 0.3
            ELSE 0
       END "���̺��ʽ�"
FROM 
(
SELECT SANAME "�����"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
            ELSE '����Ȯ�κҰ�'
       END "����"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4') 
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2)) + 1999)
            ELSE -1
       END "���糪��"
     , SAL "�޿�"
FROM TBL_SAWON
) T;
--==>> View VIEW_SAWON2��(��) �����Ǿ����ϴ�.


-- ������ ��(VIEW) Ȯ��(��ȸ)
SELECT *
FROM VIEW_SAWON2;
--==>>
/*
��ȣ��	    ��	27	5000	1500
�Ž���	    ��	24	5000	1500
��μ�	    ��	26	3000	 900
������	    ��	28	4000	1200
������	    ��	24	3000	 900
�̿���	    ��	28	4000	1200
���̻�	    ��	25	4000	1200
������	    ��	43	1000	 500
������	    ��	21	1000	 300
������	    ��	55	1500	1050
������	��	54	1300	 910
���켱	    ��	20	1600	 480
������	    ��	18	2600	   0
���ù�	    ��	21	2600	 780
����  	    ��	56	2200	1540
ȫ����	    ��	23	5200	1560
�Ӽҹ�	    ��	26	5500	1650
���̰�	    ��	17	1500	   0
*/


--------------------------------------------------------------------------------

-- �м��Լ�
-- �ڱⵥ���͸����� �����Ǵ� ���� �ƴ϶�, 
-- �ٸ� �����ͷ� ���� ��� ������
--�� RANK() �� ���(����)�� ��ȯ�ϴ� �Լ�
--   RANK() OVER() 
-->> ���� 1���� 2��������, �� ���� ������ 2���� �ƴ϶� 3��!
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"
FROM EMP;
-- SAL�� �������� �����ؼ� RANK() �ű�� "��ü�޿�����" �� �� �ִ�.
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


-- PARTITION BY �÷���
-- ---------
--    ����
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"     
FROM EMP
ORDER BY DEPTNO;
-- RANK() OVER(PARTITION BY DEPTNO   ORDER BY SAL DESC)
--            �μ���ȣ���� �����ؼ�, �޿������������� ����
-- �� �ɷ�, ���� �ű��.
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


--�� DENSE_RANK() �� ������ ��ȯ�ϴ� �Լ�
-->> ���� 1���� 2���־, �� ���� ������ 3���� �ƴ϶� 2��!
SELECT EMPNO "�����ȣ", ENAME "�����", DEPTNO "�μ���ȣ", SAL "�޿�"
     , DENSE_RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL DESC) "�μ����޿�����"
     , DENSE_RANK() OVER(ORDER BY SAL DESC) "��ü�޿�����"     
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


--�� EMP ���̺��� ��� �����͸� 
--   �����, �μ���ȣ, ����, �μ�����������, ��ü�������� �׸����� ��ȸ�Ѵ�.
--   ��, ���⿡�� ������ �ռ� �����ߴ� ������ ��å�� �����ϴ�.

--��
--�� �������� ���� �ʰ�
SELECT ENAME "�����", DEPTNO "�μ���ȣ"
     , COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "����"
     , RANK() OVER(PARTITION BY DEPTNO ORDER BY COALESCE(SAL*12+COMM, SAL*12, COMM, 0) DESC) "�μ�����������"
     , RANK() OVER(ORDER BY COALESCE(SAL*12+COMM, SAL*12, COMM, 0) DESC) "��ü��������"
FROM EMP
ORDER BY DEPTNO;

--�� �������� �Ἥ
SELECT T.*
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ�����������"
     , RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
FROM 
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ"
         , COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "����"
    FROM EMP
) T
ORDER BY T.�μ���ȣ;
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

-- ��
SELECT T.*
     , RANK() OVER(PARTITION BY T.�μ���ȣ ORDER BY T.���� DESC) "�μ�����������"
     , RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
FROM 
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
    FROM EMP
) T
ORDER BY T.�μ���ȣ;
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


--�� EMP ���̺��� ��ü ���� ���(����)�� 1����� 5�������...
--   �����, �μ���ȣ, ����, ��ü�������� �׸����� ��ȸ�Ѵ�.

-- ���� Ǯ�ٰ� �� Ǭ��,,
SELECT T.*
     , RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ"
         , COALESCE(SAL*12+COMM, SAL*12, COMM, 0) "����"
    FROM EMP
) T
WHERE RANK() OVER(ORDER BY T.���� DESC) <= 5;
-- ��ü������������ �ζ��κ�(��������)�� �־ Ǯ����� �ߴ�,,,!

-- ���������� ���������� �ٽ� �õ��غ��� ��V��
SELECT T2.*
FROM 
(
    SELECT T.*, RANK() OVER(ORDER BY T.���� DESC) "��ü��������"
    FROM
    (
        SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
        FROM EMP
    ) T
) T2    
WHERE ��ü�������� <= 5;


-- ��
SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
     , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0) DESC) "��ü��������"
FROM EMP   
WHERE RANK() OVER(ORDER BY T.���� DESC) <= 5;
--==>> ���� �߻�
--     (ORA-30483: window  functions are not allowed here)
--     �� �ָ��ؾ��ϴ� ����
--        �������Լ��� ���⼭ ����� �� �����ϴ�.
--        ----------
--        �м��Լ���
--        �� �м��Լ����� WHERE ������ ��� �Ұ�

--�� ���� ������ RANK() OVER() �� ���� �м� �Լ��� WHERE ������ ����� ����̸�...
--   �� �Լ��� WHERE ���������� ����� �� ���� ������ �߻��ϴ� �����̴�.
--   �� ���, �츮�� INLINE VIEW �� Ȱ���ؼ� Ǯ���ؾ� �Ѵ�.
--                  =================== (�ݵ��!!)

SELECT T.*
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM, 0) "����"
         , RANK() OVER(ORDER BY (SAL*12+NVL(COMM, 0)) DESC) "��ü��������"
    FROM EMP  
) T
WHERE T.��ü�������� <= 5;
-- LINE �ȿ��� VIEW �� �ִ� ��ó�� Ȱ���ϱ� ������ �� INLINE VIEW
--==>>
/*
KING	10	60000	1
SCOTT	20	36000	2
FORD	20	36000	2
JONES	20	35700	4
BLAKE	30	34200	5
*/

-- Ư�� ���̺� ��Ī ���̴� ��, �������������� ������ �� �ƴϴ�.
-- �׳� ���̺� �� ĭ ��� ��Ī �ٿ��ָ� ��� ����
-- ��.���� �Ҽ��� ��Ÿ��
-- +)
SELECT ENAME, JOB, SAL
FROM SCOTT.EMP;
--> �̷��� �ص� ��ȸ��

SELECT EMP.ENAME, EMP.JOB, EMP.SAL
FROM SCOTT.EMP;
--> �̷��� �ص� ��ȸ��

SELECT T.ENAME, T.JOB, T.SAL
FROM SCOTT.EMP T;
--> SCOTT.EMP ���̺� T��� ��Ī���̰�, T�� ��ȸ�� ����


--�� EMP ���̺��� �� �μ����� ��������� 1����� 2������� ��ȸ�Ѵ�.
--   �����, �μ���ȣ, ����, �μ����������, ��ü�������
--   �׸��� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.

-- ó���� Ʋ���� Ǭ ��
SELECT T.* 
     , RANK() OVER(ORDER BY T.���� DESC) "��ü�������"
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "�μ����������"
    FROM EMP
) T
WHERE T.�μ���������� <= 2
ORDER BY T.�μ���ȣ, T.�μ����������;
--==>> 
/*
KING	10	60000	1	1
CLARK	10	29400	2	5
SCOTT	20	36000	1	2
FORD	20	36000	1	2
BLAKE	30	34200	1	4
ALLEN	30	19500	2	6
*/
---> �̷��� �ع����� �׳� �μ��� 1, 2�� �ȿ����� ��ü������� �Űܹ�����
--   ��� Ʋ���� ����!!!!

-- �ٽ� Ǭ ��
SELECT T.* 
FROM
(
    SELECT ENAME "�����", DEPTNO "�μ���ȣ", SAL*12+NVL(COMM,0) "����"
         , RANK() OVER(PARTITION BY DEPTNO ORDER BY SAL*12+NVL(COMM,0) DESC) "�μ����������"
         , RANK() OVER(ORDER BY SAL*12+NVL(COMM,0) DESC) "��ü�������"
    FROM EMP
) T
WHERE T.�μ���������� <= 2;
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

--���� �׷� �Լ� ����--

-- SUM() ��, AVG() ���, COUNT() ī��Ʈ, MAX() �ִ�, MIN() �ּڰ�
-- VARIANCE() �л�, STDDEV() ǥ������

--�� �׷� �Լ��� ���� ū Ư¡
--   ó���ؾ� �� �����͵� �� NULL �� �����Ѵٸ�(���ԵǾ� �ִٸ�)
--   �� NULL �� ������ ���·� ������ �����Ѵٴ� ���̴�.
--   ��, �׷� �Լ��� �۵��ϴ� �������� NULL �� ������ ��󿡼� ���ܵȴ�.

-- �⺻������꿡���� NULL ���� ������ ��� NULL �� ����
-- �� NULL �� ���꿡 ���ԵǾ� ������ ��� NULL ��
-- �׷��� �׷� �Լ������� NULL �� �����ϰ� ������


--�� SUM() ��
--   EMP ���̺��� ������� ��ü ������� �޿� ������ ��ȸ�Ѵ�.
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
--> EMP���̺�� �����ϰ� ��� ���ڵ� 14�� ����

SELECT SUM(SAL)
FROM EMP;
--==>> 29025
--> ��ȯ�Ǵ� ���ڵ� 1����


SELECT ENAME, SUM(SAL)
FROM EMP;
--==>> ���� �߻�
--     (ORA-00937: not a single-group group function)
-- ENAME�� ������ ����� ����ִ� 14��
-- SUM(SAL) �� 1��
-- �÷��� ������ ���� �ʾƼ� ������


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
-- NULL �����ϰ� ����


-- NULL �˾Ƽ� ���ܵǴϱ� �ʹ� ���ϰڴ�~ ��� �ϰ� ���� �ȵ�

--�� COUNT() : ��(���ڵ�)�� ���� ��ȸ �� �����Ͱ� �� ������ Ȯ��...
SELECT COUNT(ENAME)
FROM EMP;
--==>> 14

SELECT COUNT(COMM)  -- COMM �÷� ���� ���� ��ȸ �� NULL �� ����~!!!
FROM EMP;
--==>> 4
-- ���ڵ� �����δ� 14���ε�, ���ڵ� 4�ǹۿ� ���ٰ� ����,,,


-- COUNT() �� �Ϲ������� ���� ������ ������ �ϴ� ���̱� ������ 
-- ���� COUNT(*) �̷������� ����.
SELECT COUNT(*)
FROM EMP;
--==>> 14


--�� AVG() : ��� ��ȯ
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
-- SAL ���� NULL �� ���� ������ RESULT1, RESULT2, RESULT3 ��� ���� ���̴�.

-- ���ڵ尪�� NULL �� ���ԵǾ��ִ� COMM �� ��츦 ����,,
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
--�� �ڵ����� NULL ���༭ ���ϴٰ� �Ժη� ���� �ȵǰ�,
--   ������ ��� �Ѵ�...!!!!

--�� �����Ͱ� NULL �� �÷��� ���ڵ�� ���� ��󿡼� ���ܵǱ� ������
--   �����Ͽ� ���� ó���ؾ� �Ѵ�.


--�� VARIANCE() : �л�     [ǥ�������� ����]
--�� STDDEV()   : ǥ������ [�л��� ������]

SELECT VARIANCE(SAL), STDDEV(SAL)
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1182.503223516271699458653359613061928508
*/

-- ����� �´��� Ȯ���غ���
-- ���� Ȯ���� �� �� �ִ�.
SELECT POWER(STDDEV(SAL), 2) "RESULT1"
     , VARIANCE(SAL) "RESULT2"
FROM EMP;
--==>>
/*
1398313.87362637362637362637362637362637	
1398313.87362637362637362637362637362637
*/

-- ������ Ȯ���� �� �� �ִ�.
SELECT SQRT(VARIANCE(SAL)) "RESULT1"
     , STDDEV(SAL) "RESULT2"
FROM EMP;     
--==>>
/*
1182.503223516271699458653359613061928508	
1182.503223516271699458653359613061928508
*/


--�� MAX() : �ִ�
--�� MIN() : �ּڰ�
SELECT MAX(SAL) "RESULT1"
     , MIN(SAL) "RESULT2"
FROM EMP;
--==>> 5000	800


--�� ����
SELECT ENAME, SUM(SAL)
FROM EMP;
--==> ���� �߻�
--    (ORA-00937: not a single-group group function)
-- �̷����ϸ� ���̺� ���������� �������� �� ����!

-- �μ����� �׷��� ���� �� ���� ����
SELECT DEPTNO, SUM(SAL)
FROM EMP;
--==> ���� �߻�
--    (ORA-00937: not a single-group group function)
-- �̰͵� �Ȱ��� ��������.


-- �̷� �� ����ϴ� �� �� GROUP BY
SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>> 
/*
30	9400
20	10875
10	8750
*/
-- PARSING ���� ��, 
-- SELECT ����, GROUP BY �� �����̱� ������
-- GROUP BY DEPTNO �ϰ� SELECT DEPTNO �ϸ� ���� �߻����� ����


SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
--==>>
/*
10	2450 ��
10	5000 ���� 8750
10	1300 ��
20	2975 ��
20	3000 ��
20	1100 ���� 10875
20	 800 ��
20	3000 ��
30	1250 ��
30	1500 ��
30	1600 ���� 9400
30	 950 ��
30	2850 ��
30	1250 ��
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

