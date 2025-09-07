select 'hello oracle!' as greeting from dual;

-- 1) 실습 전용 사용자 생성 (PDB: XEPDB1에 접속한 SYSTEM으로 실행)
CREATE USER sqld IDENTIFIED BY sqld
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp;

-- 2) 최소 권한 및 테이블스페이스 할당
GRANT CREATE SESSION TO sqld;
GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE, CREATE PROCEDURE, DROP ANY TABLE TO sqld;
ALTER USER sqld QUOTA UNLIMITED ON users;
