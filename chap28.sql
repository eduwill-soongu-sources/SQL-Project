-- !!! 잘못된 쿼리 예시입니다 !!!
SELECT post_id, content, view_count, ROWNUM
FROM POSTS
WHERE ROWNUM <= 5
ORDER BY view_count DESC;


SELECT post_id, content, view_count, ROWNUM
FROM (
    -- 1. 먼저 이 안에서 완벽하게 정렬을 끝낸다!
    SELECT post_id, content, view_count
    FROM POSTS
    ORDER BY view_count DESC
)
WHERE ROWNUM <= 5; -- 2. 정렬된 결과에 번호표를 붙여 5등까지만 자른다!


SELECT post_id, content, view_count, ROWNUM
FROM (
    SELECT post_id, content, view_count
    FROM POSTS
    ORDER BY view_count DESC
)
WHERE ROWNUM BETWEEN 6 AND 10
;

SELECT *
FROM ( -- 3. 이제 rn은 일반 컬럼이므로, 자유롭게 범위를 지정할 수 있다!
    SELECT p.*, ROWNUM AS rn
    FROM ( -- 2. 정렬된 결과에 ROWNUM으로 번호표(rn)를 붙인다.
		    -- 1. 먼저 이 안에서 완벽하게 정렬을 끝낸다!
        SELECT post_id, content, view_count
        FROM POSTS
        ORDER BY view_count DESC
    ) p
)
WHERE rn BETWEEN 6 AND 10
;


SELECT post_id, content, view_count
FROM POSTS
ORDER BY view_count DESC
OFFSET 0 ROWS        -- 0개를 건너뛰고 (즉, 처음부터)
FETCH NEXT 5 ROWS ONLY;  -- 5개 행만 가져온다.


SELECT post_id, content, view_count
FROM POSTS
ORDER BY view_count DESC
OFFSET 5 ROWS        -- 5개를 건너뛰고 
FETCH NEXT 5 ROWS ONLY;  -- 5개 행만 가져온다.


-- 연습 1
SELECT username, registration_date, ROWNUM
FROM (
    SELECT username, registration_date
    FROM USERS
    ORDER BY registration_date DESC
)
WHERE ROWNUM <= 3;


-- 연습 2
-- 1. 인라인 뷰를 사용해 사용자별 팔로워 수를 먼저 계산하고 정렬합니다.
SELECT following_id, follower_count
FROM ( 
	SELECT following_id, COUNT(*) AS follower_count 
	FROM FOLLOWS 
	GROUP BY following_id 
	ORDER BY follower_count DESC
)
-- 2. 정렬된 결과에 OFFSET과 FETCH를 적용합니다.
OFFSET 3 ROWS -- 1,2,3등은 건너뛰고
FETCH NEXT 3 ROWS ONLY; -- 4,5,6등을 가져온다.