/*
 * - 데이터 딕셔너리란?
 * 데이터베이스에 저장된 데이터구조, 메타데이터 정보를 포함하는
 * 데이터베이스 객체.
 *
 * 일반적으로 데이터베이스 시스템은 데이터 딕셔너리를 사용하여
 * 데이터베이스의 테이블, 뷰, 인덱스, 제약조건 등과 관련된 정보를 저장하고 관리함.
 *
 * * USER_TABLES : 계정이 소유한 객체 등에 관한 정보를 조회 할 수 있는 딕셔너리 뷰
 * * USER_CONSTRAINTS : 계정이 작성한 제약조건을 확인할 수 있는 딕셔너리 뷰
 * * USER_CONS_COLUMNS : 제약조건이 걸려있는 컬럼을 확인하는 딕셔너리 뷰
 * */

SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONSTRAINTS; -- 제약조건
SELECT * FROM USER_CONS_COLUMNS;

-- DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
-- 객체(OBJECT)를 만들고(CREATE), 수정(ALTER)하고, 삭제(DROP) 등
-- 데이터의 전체 구조를 정의하는 언어로 주로 DB관리자, 설계자가 사용함.


-- 객체 : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE),
--        인덱스(INDEX), 사용자(USER),
--        패키지(PACKAGE), 트리거(TRIGGER)
--        프로시져(PROCEDURE), 함수(FUNCTION)
--        동의어(SYNONYM)..


----------------------------------------------------------------------


-- CREATE(생성)


-- 테이블이나 인덱스, 뷰 등 다양한 데이터베이스 객체를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 구문을 통해 제거 할 수 있음
-- DROP TABLE MEMBER;


/*
 * -- 표현식
 *
 * CREATE TABLE 테이블명 (
 *    컬럼명 자료형(크기),
 *    컬럼명 자료형(크기),
 *    ...
 * );
 *
 * */


/*
 * 자료형
 *
 * NUMBER : 숫자형(정수, 실수)
 *
 * CHAR(크기) : 고정길이 문자형 (2000 BYTE) : 데이터베이스의 기본 문자 세트(UTF-8)로 인코딩
 *    --> 바이트 수 기준.
 *    --> 영어/숫자/기호 1BYTE, 한글 3BYTE
 *    --> CHAR(10) 컬럼에 'ABC' 3BYTE 문자열만 저장해도 10BYTE 저장공간 모두 사용(남은 공간 공백으로 채움 -> 낭비)
 *
 * VARCHAR2(크기) : 가변길이 문자형 (최대 4000 BYTE) : 데이터베이스의 기본 문자 세트(UTF-8)로 인코딩
 *    --> 바이트 수 기준.
 *    --> 영어/숫자/기호 1BYTE, 한글 3BYTE
 *    --> VARCHAR2(10) 컬럼에 'ABC' 3BYTE 문자열만 저장하면 나머지 7BYTE 남은 공간 반환
 *
 * NVARCHAR2(문자수) : 가변길이 문자형 (최대 4000 BYTE -> 2000글자) : UTF-16로 인코딩
 *    --> 문자길이 수 기준.
 *    --> 모든문자 2BYTE
 *    --> NVARCHAR2(10) 컬럼에 10 글자길이 아무글자(영어,숫자,한글 등) 가능
 *    --> NVARCHAR2(10) 컬럼에 '안녕'과 같은 2글자(유니코드 문자)를 입력했을 때,
 *      나머지 8개의 문자 남은 공간 반환
 *
 * DATE : 날짜 타입
 * BLOB : 대용량 이진 데이터 (4GB)
 * CLOB : 대용량 문자 데이터 (4GB)
 *
 * */

-- 1. MEMBER 테이블 생성
CREATE TABLE "MEMBER" (
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_SSN CHAR(14), -- '940901-1234567' 14자리로 정해져있으니
	ENROLL_DATE DATE DEFAULT SYSDATE
);

-- 만든 테이블 확인
SELECT * FROM MEMBER;

-- 2. 컬럼에 주석 달기
-- [표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.MEMBER_SSN IS '회원 주민등록번호';
COMMENT ON COLUMN MEMBER.ENROLL_DATE IS '회원 가입일';

-- MEMBER 테이블에 샘플 데이터 삽입
-- INSERT INTO 테이블명 VALUES(값1, 값2..);
INSERT INTO "MEMBER" VALUES('MEM01', '123ABC', '홍길동', '940901-1234567', DEFAULT);

-- * INSERT/UPDATE 시 컬럼값으로 DEFAULT 작성하면
-- 테이블 생성 시 해당 컬럼에 지정된 DEFAULT 값으로 삽입이 된다! *

-- 데이터 삽입 확인
SELECT * FROM MEMBER;

COMMIT;

-- 추가 샘플 데이터 삽입
-- 가입일 -> SYSDATE 로 삽입
INSERT INTO "MEMBER" VALUES('MEM02', 'QWER1234', '김영희', '000123-1234567', SYSDATE);
-- DEFAULT 설정된 컬럼이라고 삽입/수정 시 DEFAULT 만 작성해야하는 것 아님!
-- 컬럼 데이터타입에 맞춘 데이터 삽입/수정 가능

SELECT * FROM MEMBER;


-- 가입일 -> INSERT 시 미작성 하는 경우 DEFAULT 값이 반영되는지 확인
-- INSERT INTO 테이블명 (컬럼명1, 컬럼명2) VALUES(값1, 값2);
INSERT INTO "MEMBER" (MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES ('MEM03', '1Q2W3E', '이지연');

SELECT * FROM MEMBER; -- DEFAULT로 SYSDATE 넣어놨기 때문에 값을 설정하지 않아도 나옴

-- ** NUMBER 타입의 문제점 **
-- MEMBER2 테이블(아이디, 비밀번호, 이름, 전화번호)
CREATE TABLE "MEMBER2"(
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_TEL NUMBER
);

INSERT INTO "MEMBER2" VALUES('MEM01', 'PASS01', '고길동', 01012341234);

SELECT * FROM MEMBER2;

-- NUMBER 타입 컬럼에 데이터 삽입 시
-- 제일 앞에 0이 있으면 0을 자동으로 제거함
-- 그러므로 전화번호, 주민번호처럼 숫자로만 되어있는 데이터라도
-- 0으로 시작될 가능성이 있으면 CHAR, VARCHAR2같은 문자열 타입으로 사용해라

COMMIT;

--------------------------------------------------------------

-- 제약 조건 (CONSTRAINTS)


/*
 * 사용자가 원하는 조건의 데이터만 유지하기 위해서 특정 컬럼에 설정하는 제약.
 * 데이터 무결성 보장을 목적으로 함.
 *  -> 중복 데이터 X
 *
 * + 입력 데이터에 문제가 없는지 자동으로 검사하는 목적
 * + 데이터의 수정/삭제 가능 여부 검사등을 목적으로 함.
 *    --> 제약조건을 위배하는 DML 구문은 수행할 수 없다.
 *
 *
 * 제약조건 종류
 * PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY.
 *
 *
 * */

-- 1. NOT NULL
-- 해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
-- 삽입/수정 시 NULL 값을 허용하지 않도록 컬럼레벨에서 제한

-- * 컬럼레벨 : 테이블 생성 시 컬럼을 정의하는 부분에 작성하는 것

CREATE TABLE USER_USED_NN(
	USER_NO NUMBER NOT NULL, -- 사용자번호 (모든 사용자는 사용자 번호가 있어야한다!)
													 -- 컬럼 레벨 제약조건 설정
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(20),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50)
	-- 테이블 레벨
);

INSERT INTO USER_USED_NN VALUES (
1, 'USER01', 'PASS01', '홍길동', '남자',
'010-1234-5678', 'hong_gd@or.kr');
-- SQL Error [1400] [23000]: ORA-01400: NULL을 ("KH"."USER_USED_NN"."USER_NO") 안에 삽입할 수 없습니다.
--> NOT NULL 제약조건 위배되어 오류 발생

SELECT * FROM USER_USED_NN;

--------------------------------------------------------------

-- 2. UNIQUE 제약조건
-- 컬럼에 입력값에 대해서 중복을 제한하는 제약조건
-- 컬럼 레벨에서 설정가능, 테이블 레벨에서 설정가능
-- 단, UNIQUE 제약조건이 설정된 컬럼에 NULL 값은 중복 삽입 가능.


-- * 테이블 레벨 : 테이블 생성 시 컬럼 정의가 끝난 후 마지막에 작성


-- * 제약조건 지정 방법
-- 1) 컬럼 레벨   : [CONSTRAINT 제약조건명] 제약조건
-- 2) 테이블 레벨 : [CONSTRAINT 제약조건명] 제약조건(컬럼명)

-- UNIQUE 제약조건 테이블 생성
CREATE TABLE USER_USED_UK(
	USER_NO NUMBER NOT NULL,
-- USER_ID VARCHAR2(20) UNIQUE, -- 컬럼레벨 (제약조건명 미지정)
-- USER_ID VARCHAR2(20) CONSTRAINT USER_ID_U UNIQUE -- 컬럼레벨 (제약조건명 지정)
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(20),
	USER_NAME VARCHAR2(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(30),
	EMAIL VARCHAR2(50), -- 테이블레벨 제약조건 주려면 마지막에도 콤마 해줘야 함
	-- 테이블 레벨
-- UNIQUE(USER_ID) -- 테이블레벨(제약조건명 미지정)
	CONSTRAINT USER_ID_U UNIQUE(USER_ID) -- 테이블레벨(제약조건명 지정)
);