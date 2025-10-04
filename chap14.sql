-- 라이언이 팔로우 하는 사람들의 목록
SELECT following_id
FROM FOLLOWS 
WHERE follower_id = 1

UNION
-- 라이언을 팔로우 하는 사람들의 목록
SELECT follower_id
FROM FOLLOWS 
WHERE following_id = 1;


-- 카카오프렌즈(1~8)가 작성한 게시물 ID 목록
SELECT post_id FROM POSTS WHERE user_id BETWEEN 1 AND 8
UNION ALL -- 정렬도, 중복 검사도 없이 그냥 다 합쳐줘!
-- 포켓몬(21~40)이 작성한 게시물 ID 목록
SELECT post_id FROM POSTS WHERE user_id BETWEEN 21 AND 40;


-- 라이언이 팔로우 하는 사람들의 목록
SELECT following_id
FROM FOLLOWS 
WHERE follower_id = 1

INTERSECT
-- 라이언을 팔로우 하는 사람들의 목록
SELECT follower_id
FROM FOLLOWS 
WHERE following_id = 1;


-- '라이언'(1)을 팔로우하는 모든 사람들 (전체 팬)
SELECT follower_id FROM FOLLOWS WHERE following_id = 1
MINUS -- 이 목록에서 아래 목록에 포함된 사람들은 '제외'해줘!
-- '라이언'(1)이 팔로우하는 사람들 (맞팔인 사람들)
SELECT following_id FROM FOLLOWS WHERE follower_id = 1;


-- '라이언'의 인맥 리스트를 user_id 오름차순으로 정렬
( 
	SELECT following_id FROM FOLLOWS WHERE follower_id = 1 
	UNION 
	SELECT follower_id FROM FOLLOWS WHERE following_id = 1
)
ORDER BY 1; -- 1은 첫 번째 컬럼을 의미합니다.


-- 연습 1

SELECT user_id FROM POSTS WHERE post_type = 'photo'
UNION
SELECT user_id FROM POSTS WHERE post_type = 'video';

-- 연습 2
SELECT user_id FROM USERS WHERE user_id BETWEEN 1 AND 8 -- 카카오프렌즈
INTERSECT
SELECT user_id FROM USERS WHERE user_id BETWEEN 21 AND 40; -- 포켓몬


-- 연습 3
-- '좋아요'를 누른 경험이 있는 모든 유저 ID
SELECT user_id FROM LIKES
MINUS
-- '댓글'을 작성한 경험이 있는 모든 유저 ID
SELECT user_id FROM COMMENTS;