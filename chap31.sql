-- POSTS 테이블에 is_ad 라는 새로운 컬럼을 VARCHAR2(1) 타입으로 추가합니다.
ALTER TABLE POSTS ADD (is_ad VARCHAR2(1));

SELECT * FROM POSTS;

ALTER TABLE POSTS DROP COLUMN is_ad;

-- 실습용 임시 테이블 생성
CREATE TABLE TEMP_TABLE (id NUMBER, name VARCHAR2(10));

SELECT * FROM TEMP_TABLE;



-- 테이블을 데이터베이스에서 완전히 삭제합니다.
DROP TABLE TEMP_TABLE;