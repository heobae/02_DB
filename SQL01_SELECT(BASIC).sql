SELECT * FROM TB_DEPARTMENT;

-- 1.
SELECT DEPARTMENT_NAME "학과명", CATEGORY "계열"
FROM TB_DEPARTMENT;

-- 2.
SELECT DEPARTMENT_NAME, '의','정원은', CAPACITY,'명 입니다.'
FROM TB_DEPARTMENT;

-- 3. 
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE TB_STUDENT.DEPARTMENT_NO = 001 
AND TB_STUDENT.ABSENCE_YN = 'Y'
AND TB_STUDENT.STUDENT_SSN LIKE '_______2%';

-- 4.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NAME DESC;

-- 5.
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;

-- 6.
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE TB_STUDENT.DEPARTMENT_NO IS NULL;

-- 8.
SELECT CLASS_NO
FROM TB_CLASS
WHERE TB_CLASS.PREATTENDING_CLASS_NO IS NOT NULL;

-- 9.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

-- 10.
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE (STUDENT_ADDRESS LIKE '%전주%') 
AND (TB_STUDENT.ENTRANCE_DATE BETWEEN '2002-01-01' AND '2002-12-31')
AND (TB_STUDENT.ABSENCE_YN = 'N');




