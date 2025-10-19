SELECT
    user_id,
    creation_date AS "이번 게시물 등록일",
    LAG(creation_date, 1, NULL) 
        OVER (PARTITION BY user_id 
                ORDER BY creation_date
            ) AS "이전 게시물 등록일"
FROM
    POSTS
WHERE user_id IN (1, 2); -- 라이언과 춘식이만 예시로 볼게요



SELECT
    user_id,
    creation_date AS "이번 게시물 등록일",
    LEAD(creation_date, 2, NULL) 
        OVER (PARTITION BY user_id 
                ORDER BY creation_date
            ) AS "다음 게시물 등록일"
FROM
    POSTS
WHERE user_id IN (1, 2); -- 라이언과 춘식이만 예시로 볼게요


SELECT
    user_id,
    creation_date,
    reaction_score,
    SUM(reaction_score) OVER (
        PARTITION BY user_id
        ORDER BY creation_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW -- 여기가 프레임 절!
    ) AS "누적 반응 점수"
FROM POSTS
WHERE user_id = 1; -- 춘식이만 예시로 볼게요



SELECT
    user_id,
    creation_date,
    view_count,
    ROUND(AVG(view_count) OVER (
        PARTITION BY user_id
        ORDER BY creation_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW -- 최근 3개 행을 범위로 지정!
    )) AS "최근 3개 이동평균 조회수"
FROM POSTS
WHERE user_id = 1; -- 라이언만 예시로 볼게요


SELECT
    user_id,
    post_id,
    view_count,
    ROUND(
        RATIO_TO_REPORT(view_count) OVER (PARTITION BY user_id) * 100, 2
    ) AS "조회수 기여도(%)"
FROM POSTS
WHERE user_id IN (1, 2); -- 라이언과 춘식이만 예시로 볼게요


SELECT
    post_id,
    reaction_score,
    NTILE(4) OVER (ORDER BY reaction_score DESC) AS "반응 점수 등급"
FROM
    POSTS;