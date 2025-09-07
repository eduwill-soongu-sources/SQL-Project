SELECT * 
FROM USERS
WHERE username = 'ryan'
;

SELECT * 
FROM USERS
WHERE user_id = 40
;

SELECT * 
FROM POSTS
WHERE user_id = 1
    AND post_type = 'video'
;

SELECT * 
FROM POSTS
WHERE user_id = 1
    OR post_type = 'video'
;

SELECT *
FROM POSTS
WHERE 
    user_id = 1 
    OR user_id = 2 
    AND post_type = 'photo'
;

SELECT *
FROM POSTS
WHERE 
    (user_id = 1 
    OR user_id = 2) 
    AND post_type = 'photo'
;

-- 2022년에 가입한 사용자만 필터링
SELECT username, REGISTRATION_DATE 
FROM USERS
WHERE REGISTRATION_DATE >= DATE '2022-01-01'
    AND REGISTRATION_DATE <= DATE '2022-12-31'
;

SELECT username, REGISTRATION_DATE 
FROM USERS
WHERE REGISTRATION_DATE 
    BETWEEN DATE '2022-01-01' AND DATE '2022-12-31'
;

SELECT username, REGISTRATION_DATE 
FROM USERS
WHERE REGISTRATION_DATE 
   NOT BETWEEN DATE '2022-01-01' AND DATE '2022-12-31'
;

-- 1, 9, 21번 사용자만 조회
SELECT * 
FROM USERS
WHERE user_id = 1 
    OR user_id = 9
    OR user_id = 21
;

SELECT * 
FROM USERS
WHERE user_id IN (1, 9, 21)
;

SELECT * 
FROM USERS
WHERE user_id NOT IN (1, 9, 21)
;


SELECT username
FROM USERS 
WHERE username LIKE 'p%'
;

SELECT username
FROM USERS 
WHERE username NOT LIKE 'p%'
;

SELECT post_id, content
FROM POSTS 
WHERE content LIKE '%일상%'
;

SELECT username
FROM USERS 
WHERE username LIKE 'ry_n'
;

SELECT * 
FROM USERS 
WHERE MANAGER_ID IS NULL
;

SELECT * 
FROM USERS 
WHERE MANAGER_ID IS NOT NULL
;

-- 문제 1 답안
SELECT * 
FROM USERS 
WHERE username = 'pikachu'
;

-- 문제 2 답안
SELECT * 
FROM POSTS
WHERE creation_date 
    BETWEEN DATE '2023-01-01' AND TIMESTAMP '2023-12-31 23:59:59';

-- 문제 3 답안
SELECT username, email 
FROM USERS 
WHERE user_id IN (1, 2, 3, 4, 5, 6, 7, 8);

-- 문제 4 답안
SELECT post_id, content 
FROM POSTS 
WHERE content LIKE '%#먹스타그램%';

-- 문제 5 답안
SELECT * 
FROM POSTS 
WHERE user_id = 1 
    AND post_type = 'photo'
;

-- 문제 6 답안 (방법 1: NOT BETWEEN)
SELECT user_id, username 
FROM USERS 
WHERE user_id NOT BETWEEN 9 AND 20;
-- 문제 6 답안 (방법 2: < OR >)
SELECT user_id, username 
FROM USERS 
WHERE user_id < 9 
    OR user_id > 20;