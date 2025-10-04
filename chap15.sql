
-- ryan이 작성한 모든 피드게시물 조회

SELECT USER_ID 
FROM USERS
WHERE USERNAME = 'ryan'
;

SELECT * 
FROM POSTS
WHERE USER_ID = 1
;

-- 한 번의 쿼리로 이 모든작업을 수행
SELECT * 
FROM POSTS
WHERE USER_ID = (
    SELECT USER_ID 
    FROM USERS
    WHERE USERNAME = 'ryan'
)
;

-- 카카오프렌즈 유저들이 작성한 피드를 조회
SELECT * 
FROM POSTS
WHERE USER_ID IN (
    SELECT USER_ID 
    FROM USERS
    WHERE USER_ID BETWEEN 1 AND 8
)
;


-- 산리오 캐릭터들이 작성한 게시물의 view_count 목록 중,
-- 그 목록의 최소값보다 큰 view_count를 가진 게시물을 찾는다.
SELECT post_id, content, view_count FROM POSTS
WHERE view_count > ANY (
                        SELECT view_count 
                        FROM POSTS 
                        WHERE user_id BETWEEN 9 AND 20
                        );

SELECT
    ROUND(AVG(post_count)) AS "사용자당 평균 게시물 수"
FROM
    -- 이 부분이 FROM 절에 들어간 서브쿼리, 즉 '인라인 뷰' 입니다.
    -- user_id 와 post_count 라는 컬럼을 가진 가상의 테이블 역할을 합니다.
    (SELECT user_id, COUNT(*) AS post_count
     FROM POSTS
     GROUP BY user_id);


SELECT
    post_id,
    view_count,
    -- 이 서브쿼리는 단 하나의 값(전체 평균 조회수)을 반환하며,
    -- 이 값이 모든 행에 반복적으로 표시됩니다.
    (SELECT ROUND(AVG(view_count)) FROM POSTS) AS "전체 평균 조회수"
FROM
    POSTS;

-- 연습 1
SELECT post_id, reaction_score
FROM POSTS
WHERE reaction_score > (
    SELECT AVG(reaction_score) 
    FROM POSTS
);


-- 연습 2
SELECT DISTINCT post_id, P.content
FROM LIKES L
INNER JOIN POSTS P
-- ON L.post_id = P.post_id
USING (post_id)
WHERE L.user_id IN 
	(
		SELECT user_id 
		FROM USERS 
		WHERE user_id BETWEEN 9 AND 20
	);

-- 연습 3
SELECT username
FROM USERS
WHERE user_id = ( -- 3. 최종적으로 찾은 user_id로 이름을 찾는다.
    -- 2. 최대 팔로워 수를 가진 user_id를 찾는다.
    SELECT following_id
    FROM FOLLOWS
    GROUP BY following_id
    HAVING COUNT(*) = (
        -- 1. '최대 팔로워 수'가 몇 명인지 계산한다.
        SELECT MAX(COUNT(*))
        FROM FOLLOWS
        GROUP BY following_id
    )
);