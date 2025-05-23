SELECT * FROM TB_CLASS;
SELECT * FROM TB_CLASS_PROFESSOR;
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_GRADE;
SELECT * FROM TB_PROFESSOR;
SELECT * FROM TB_STUDENT;

-- 1.
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY 1, 2, 3 ;

-- 2.
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE TB_PROFESSOR.PROFESSOR_NAME NOT LIKE '___';

-- 3. X
SELECT PROFESSOR_NAME "교수 이름", SUBSTR(PROFESSOR_SSN, 1, INSTR(PROFESSOR_SSN, '-') -1, - TO_CHAR(SYSDATE, 'YY')), 
TO_CHAR(SYSDATE, 'YY') "나이"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN, 8, 1) IN (1)
ORDER BY PROFESSOR_SSN DESC; 

-- 4.
SELECT SUBSTR(PROFESSOR_NAME, 2) "이름"
FROM TB_PROFESSOR;

-- 5.
SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
WHERE TO_DATE(ENTRANCE_DATE, 'YYMMDD');
