SELECT
    u.user_id,
    u.username
FROM
    USERS u
WHERE
    EXISTS (
        SELECT 1 
        FROM POSTS p 
        WHERE p.user_id = u.user_id
    );

SELECT
    u.user_id,
    u.username
FROM
    USERS u
;

SELECT *
        FROM POSTS p 
        WHERE p.user_id = 24;


SELECT
    u.username,
    (
        SELECT COUNT(*) 
        FROM POSTS p 
        WHERE p.user_id = u.user_id
    ) AS post_count
FROM
    USERS u;

SELECT
    u.user_id,
    u.username
FROM
    USERS u;

SELECT COUNT(*) 
FROM POSTS p 
WHERE p.user_id = 2;


-- 테이블을 합친 뒤 한 번에 집계 
SELECT u.username, COUNT(p.post_id) AS post_count 
FROM USERS u 
LEFT JOIN POSTS p 
ON u.user_id = p.user_id 
GROUP BY u.user_id, u.username
;

-- 연습 1
SELECT * FROM POSTS p
WHERE EXISTS (
    SELECT 1 FROM COMMENTS c 
    WHERE c.post_id = p.post_id
);

-- 연습 2
SELECT * FROM POSTS p
WHERE NOT EXISTS (
    SELECT 1 FROM LIKES l 
    WHERE l.post_id = p.post_id
);


-- 연습 3
SELECT p.post_id, p.content,
       (
        SELECT COUNT(*) 
        FROM COMMENTS c 
        WHERE c.post_id = p.post_id
    ) AS comment_count
FROM POSTS p;