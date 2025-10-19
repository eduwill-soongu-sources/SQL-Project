-- GROUP BY: 행을 '압축'해서 요약 결과만 보여준다.
SELECT user_id, ROUND(AVG(reaction_score)) AS "사용자별 평균 반응"
FROM POSTS
WHERE user_id IN (1, 2)
GROUP BY user_id
;

-- GROUP BY: 행을 '압축'해서 요약 결과만 보여준다.
SELECT user_id
FROM POSTS
WHERE user_id IN (1, 2)
-- GROUP BY user_id
;

-- PARTITION BY: 행은 '유지'한 채로, 분석 값만 추가한다.
SELECT user_id, post_id, reaction_score
    , ROUND(AVG(reaction_score) OVER (PARTITION BY user_id)) AS "사용자별 평균 반응"
FROM POSTS
WHERE user_id IN (1, 2);

SELECT
    user_id,
    post_id,
    reaction_score AS "내 점수",
    ROUND(
        AVG(reaction_score) OVER (PARTITION BY user_id)
    ) AS "우리 그룹 평균 점수"
FROM
    POSTS
ORDER BY
    user_id, post_id;


UPDATE POSTS 
SET VIEW_COUNT = VIEW_COUNT + 10 
WHERE POST_ID IN (10, 11);

SELECT
    user_id,
    post_id,
    view_count,
    RANK() OVER (PARTITION BY user_id ORDER BY view_count DESC) AS "RANK",
    DENSE_RANK() OVER (PARTITION BY user_id ORDER BY view_count DESC) AS "DENSE_RANK",
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY view_count DESC) AS "ROW_NUMBER"
FROM
    POSTS
WHERE user_id = 1; 


-- 연습 1
SELECT
    user_id,
    post_id,
    reaction_score,
    MAX(reaction_score) OVER (PARTITION BY user_id) AS "해당 유저의 최고점수"
FROM
    POSTS;

-- 연습 2
SELECT
    post_id,
    comment_id,
    comment_text,
    COUNT(*) OVER (PARTITION BY post_id) AS "게시물 총 댓글 수"
FROM
    COMMENTS;

SELECT
    post_id,
    COUNT(*) AS "게시물 총 댓글 수"
FROM
    COMMENTS
GROUP BY post_id
ORDER BY post_id
;

-- 연습 3
SELECT
    user_id,
    post_id,
    creation_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY creation_date DESC) AS "사용자별 최신순"
FROM
    POSTS;