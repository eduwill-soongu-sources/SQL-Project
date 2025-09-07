SELECT *
FROM USERS
;

SELECT * 
FROM POSTS
;

SELECT username, email
FROM USERS
;

SELECT email, username
FROM USERS
;

SELECT DISTINCT post_type
FROM POSTS
;

SELECT ALL post_type
FROM POSTS
;

SELECT 
    username AS "사용자 이름"
    , registration_date AS "가입 일자"
FROM USERS
;

SELECT 
    username "사용자 이름"
    , registration_date "가입 일자"
FROM USERS
;

SELECT 
    username 사용자이름
    , registration_date 가입일자
FROM USERS
;

SELECT username || '님, 환영합니다!' AS "환영인사"
FROM USERS
;

SELECT
    username || '(가입일: ' || registration_date || ')' AS "사용자 정보"
FROM USERS;

-- 1번 문제 
SELECT *
FROM HASHTAGS
;

-- 2번 문제
SELECT content, creation_date
FROM POSTS
;

-- 3번 문제
SELECT DISTINCT user_id
FROM LIKES
;

-- 4번 문제
SELECT 
    full_name "전체 이름"
    , bio 자기소개
FROM USER_PROFILES
;

-- 5번 문제
SELECT USER_ID || '님이 ' 
       || COMMENT_TEXT 
       || '라고 댓글을 남겼습니다.' AS "댓글 알림"
FROM COMMENTS
;