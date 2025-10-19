SELECT *
FROM (
    -- 1. PIVOT의 대상이 될 데이터만 먼저 선택합니다.
    SELECT user_id, post_type FROM POSTS
)
PIVOT (
    COUNT(*) -- 2. [무엇을] 셀에 채울 것인가? -> 게시물의 개수
    FOR post_type -- 3. [무엇을] 보고 컬럼으로 만들 것인가? -> post_type의 값
    IN ('photo' AS PHOTO_COUNT, 'video' AS VIDEO_COUNT) -- 4. [어떻게] 컬럼 이름을 정할 것인가?
)
ORDER BY user_id;


SELECT * FROM USER_YEARLY_POSTS_WIDE;


SELECT
    user_id, "YEAR", post_count
FROM
    USER_YEARLY_POSTS_WIDE
UNPIVOT (
    post_count -- 1. 값을 담을 새 컬럼 이름
    FOR "YEAR" -- 2. 이름을 담을 새 컬럼 이름 (YEAR는 예약어라 ""로 감쌈)
    IN (posts_2022 AS '2022', posts_2023 AS '2023', posts_2024 AS '2024') 
    -- 3. 펼칠 원본 컬럼들
);

-- 연습 1
SELECT *
FROM (
    SELECT
        user_id,
        EXTRACT(YEAR FROM creation_date) AS post_year,
        view_count
    FROM POSTS
)
PIVOT (
    SUM(view_count) -- [무엇을] 셀에 채울 것인가? -> 조회수의 합계
    FOR post_year IN (2022, 2023, 2024) -- [무엇을] 보고 컬럼으로 만들 것인가?
)
ORDER BY user_id;


-- 연습2 
SELECT *
FROM USER_POSTTYPE_WIDE
UNPIVOT (
    "COUNT" -- 값을 담을 새 컬럼 이름
    FOR post_type 
    IN (photo_count AS 'photo', video_count AS 'video'
    ) -- 이름을 담을 새 컬럼
);