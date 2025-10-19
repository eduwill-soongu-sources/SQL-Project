-- 1. 사용자별, 타입별 집계 (상세 내역)
SELECT user_id, post_type, COUNT(*) AS "게시물 수"
FROM POSTS GROUP BY user_id, post_type
UNION ALL
-- 2. 사용자별 소계
SELECT user_id, '소계' AS post_type, COUNT(*)
FROM POSTS GROUP BY user_id
UNION ALL
-- 3. 전체 총계
SELECT NULL AS user_id, '총계' AS post_type, COUNT(*)
FROM POSTS;



-- GROUP BY 절에 ROLLUP을 적용하기만 하면 끝!
SELECT user_id, post_type, COUNT(*) AS "게시물 수"
FROM POSTS
GROUP BY ROLLUP(user_id, post_type);


SELECT user_id, post_type, COUNT(*) AS "게시물 수"
FROM POSTS
GROUP BY CUBE(user_id, post_type);


SELECT
    CASE
        WHEN GROUPING(user_id) = 0 THEN TO_CHAR(user_id)
        ELSE '>> 모든 사용자'
    END AS user_id,
    CASE
        WHEN GROUPING(post_type) = 0 THEN post_type
        ELSE '>> 모든 타입'
    END AS post_type,
    COUNT(*) AS "게시물 수"
FROM
    POSTS
GROUP BY
    CUBE(user_id, post_type)
;



SELECT
    user_id,
    post_type,
    COUNT(*) AS "게시물 수"
FROM
    POSTS
GROUP BY
    GROUPING SETS(
        (user_id), (post_type), ()
    );

SELECT
    user_id,
    post_type,
    COUNT(*) AS "게시물 수"
FROM
    POSTS
GROUP BY
    user_id, ROLLUP(post_type); -- user_id는 일반 그룹핑, post_type만 ROLLUP!


-- 연습1
SELECT
    post_id,
    user_id,
    COUNT(*) AS "댓글 수"
FROM
    COMMENTS
GROUP BY
    ROLLUP(post_id, user_id)
ORDER BY
    post_id, user_id;


-- 연습2
SELECT
    post_id,
    user_id,
    COUNT(*) AS "댓글 수"
FROM
    COMMENTS
GROUP BY
    CUBE(post_id, user_id)
ORDER BY
    post_id, user_id;

-- 연습3
SELECT
    post_id,
    user_id,
    COUNT(*) AS "댓글 수"
FROM
    COMMENTS
GROUP BY
    GROUPING SETS(post_id, user_id)
ORDER BY
    post_id, user_id;