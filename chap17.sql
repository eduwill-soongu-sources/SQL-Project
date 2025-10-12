SELECT
    post_id,
    username,
    content,
    reaction_score
FROM (
    SELECT
        p.post_id,
        u.username,
        p.content,
        p.reaction_score
    FROM
        POSTS p
    JOIN
        USERS u ON p.user_id = u.user_id
    ORDER BY
        p.reaction_score DESC NULLS LAST
)
WHERE ROWNUM <= 5;


-- 복잡한 JOIN 쿼리를 V_USER_POSTS 라는 이름으로 저장!
CREATE OR REPLACE VIEW V_USER_POSTS AS
SELECT u.username, p.content, p.creation_date, p.post_type
FROM USERS u
JOIN POSTS p ON u.user_id = p.user_id;
-- --- 뷰 생성 완료! ---


SELECT * FROM V_USER_POSTS
WHERE USERNAME = 'kuromi'
;

-- email 등 민감한 정보는 제외하고 뷰를 생성합니다.
CREATE OR REPLACE VIEW V_PUBLIC_USERS AS
SELECT user_id, username, last_login_date
FROM USERS;

SELECT * FROM V_PUBLIC_USERS;

DROP VIEW V_PUBLIC_USERS;

-- 1. WHERE 조건과 함께 WITH CHECK OPTION을 붙여 뷰를 생성합니다.
CREATE OR REPLACE VIEW V_KAKAO_FRIENDS AS
SELECT user_id, username, email
FROM USERS
WHERE user_id BETWEEN 1 AND 8
WITH CHECK OPTION;


-- 2. 이제 이 뷰를 통해 WHERE 조건에 맞지 않는 데이터를 INSERT 해봅시다.
-- user_id 9번은 VIEW의 WHERE 조건(1~8)에 맞지 않으므로,
-- WITH CHECK OPTION 때문에 에러가 발생합니다!
INSERT INTO V_KAKAO_FRIENDS (user_id, username, email, registration_date)
VALUES (9, 'hello_kitty', 'kitty@example.com', SYSDATE);
-- 결과: ORA-01402: view WITH CHECK OPTION where-clause violation


-- 연습 1
CREATE OR REPLACE VIEW V_POST_COMMENT_COUNT AS
SELECT
    p.post_id,
    p.content,
    COUNT(c.comment_id) AS comment_count
FROM
    POSTS p
LEFT JOIN -- 댓글이 없는 게시물도 포함해야 하므로 LEFT JOIN
    COMMENTS c ON p.post_id = c.post_id
GROUP BY
    p.post_id, p.content;


SELECT * FROM V_POST_COMMENT_COUNT;

-- 연습 2
CREATE OR REPLACE VIEW V_SANRIO_PROFILES AS
SELECT
    u.username,
    up.bio
FROM
    USERS u
JOIN
    USER_PROFILES up ON u.user_id = up.user_id
WHERE
    u.user_id BETWEEN 9 AND 20;


SELECT * FROM V_SANRIO_PROFILES;
