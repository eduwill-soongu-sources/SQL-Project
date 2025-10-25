-- (DBA 권한이 있는 계정으로 실행해야 합니다)
-- 1. 'new_intern' 이라는 이름의 사용자를 만들고 비밀번호를 '1234'로 설정합니다.
CREATE USER new_intern IDENTIFIED BY 1234;
-- 2. 'new_intern' 에게 데이터베이스에 접속할 수 있는 권한을 부여합니다.
GRANT CREATE SESSION TO new_intern;

GRANT SELECT ON sqld.POSTS TO new_intern;

REVOKE SELECT ON sqld.POSTS FROM new_intern;

SELECT * FROM sqld.POSTS;
DELETE FROM sqld.POSTS;

SELECT * FROM sqld.USERS;


CREATE USER senior_dev IDENTIFIED BY 1234;
GRANT CREATE SESSION TO senior_dev;

GRANT SELECT ON sqld.COMMENTS 
TO senior_dev WITH GRANT OPTION;

SELECT * FROM sqld.COMMENTS;

GRANT SELECT ON sqld.COMMENTS TO new_intern;

REVOKE SELECT ON sqld.COMMENTS FROM senior_dev;