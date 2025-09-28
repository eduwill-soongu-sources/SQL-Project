SELECT *
FROM USERS;

-- USERS 테이블의 전체 행 수를 셉니다.
SELECT COUNT(*) AS "전체 사용자 수"
FROM USERS;


SELECT manager_id
FROM USERS;

-- manager_id 컬럼에 값이 있는(NULL이 아닌) 행의 수만 셉니다.
SELECT COUNT(manager_id) AS "매니저가 있는 직원 수"
FROM USERS;


SELECT
    VIEW_COUNT
FROM
    POSTS;

SELECT
    MAX(view_count) AS "최고 조회수",
    MIN(view_count) AS "최저 조회수"
FROM
    POSTS;

SELECT USERNAME, REGISTRATION_DATE
FROM USERS 
;

SELECT MIN(REGISTRATION_DATE)
FROM USERS 
;



SELECT
    VIEW_COUNT
FROM
    POSTS;


-- 모든 게시물의 view_count를 합산합니다.
SELECT SUM(view_count) AS "총 조회수"
FROM POSTS;

-- view_count의 평균을 계산하고, ROUND 함수로 반올림하여 정수로 만듭니다.
SELECT ROUND(AVG(view_count)) AS "게시물 당 평균 조회수"
FROM POSTS;


SELECT * FROM POSTS;
SELECT COUNT(*) FROM POSTS;

-- 사용자 별로 게시물 수를 따로 카운팅
SELECT USER_ID, COUNT(*)
FROM POSTS
GROUP BY USER_ID --  사용자별로 
;

-- 전체 피드게시물에서 사진게시물이 몇개고, 영상게시물이 몇갠지
SELECT POST_TYPE, COUNT(*)
FROM POSTS
GROUP BY POST_TYPE --  게시물 종류별로 
;


SELECT * FROM POSTS
ORDER BY USER_ID, POST_TYPE
;

-- 유저별 피드 게시물에서 사진이 ? 영상이 ?
SELECT USER_ID, POST_TYPE, COUNT(*)
FROM POSTS
GROUP BY USER_ID, POST_TYPE --  사용자 + 게시물 종류별로 
;

SELECT
    user_id,
    COUNT(*) AS post_count
FROM
    POSTS
WHERE VIEW_COUNT >= 200
GROUP BY
    user_id
HAVING COUNT(*) >= 10
ORDER BY USER_ID
;

SELECT
    post_id,
    COUNT(*) AS like_count
FROM
    LIKES
WHERE creation_date >= TO_DATE('2024-01-01', 'YYYY-MM-DD') -- 1. (입구컷) 2024년 데이터만 먼저 고르고
GROUP BY
    post_id                                             -- 2. 게시물 ID 별로 그룹화
HAVING COUNT(*) >= 20
;                                     -- 3. (매니저) 그룹별 좋아요 수가 20개 이상인 그룹만 최종 선택!


-- 연습문제  1
SELECT
    post_type,
    COUNT(*) AS "종류별 게시물 수"
FROM
    POSTS
GROUP BY
    post_type;

-- 연습문제  2
SELECT
    post_id,
    COUNT(*) AS "댓글 수"
FROM
    COMMENTS
GROUP BY
    post_id
ORDER BY POST_ID
    ;

-- 연습문제  3
SELECT
    following_id,
    COUNT(*) AS "팔로워 수"
FROM
    FOLLOWS
GROUP BY
    following_id;


-- 연습문제  4
SELECT
    post_id,
    COUNT(*) AS "댓글 수"
FROM
    COMMENTS
GROUP BY
    post_id
HAVING
    COUNT(*) >= 5;


-- 연습문제  5
SELECT
    user_id,
    COUNT(*) AS "작성 게시물 수"
FROM
    POSTS
WHERE user_id BETWEEN 1 AND 8 -- 1. (입구컷) 먼저 카카오프렌즈만 입장시키고
GROUP BY
    user_id;                -- 2. 입장한 사용자들로 그룹을 만든다.