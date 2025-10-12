SELECT LEVEL, user_id, manager_id, username
FROM USERS
START WITH manager_id IS NULL  -- 전개 출발지 지정
CONNECT BY PRIOR user_id = manager_id -- 전개 조건 (순방향)
;


SELECT
    LEVEL,
    LPAD(' ', (LEVEL-1) * 3) || username AS "조직도"
FROM
    USERS
START WITH
    manager_id IS NULL
CONNECT BY
    PRIOR user_id = manager_id;


SELECT
    LEVEL,
    LPAD(' ', (LEVEL-1) * 3) || username AS "조직도"
FROM
    USERS
START WITH
    manager_id IS NULL
CONNECT BY
    PRIOR user_id = manager_id
ORDER BY username
;


SELECT
    LEVEL,
    LPAD(' ', (LEVEL-1) * 3) || username AS "조직도"
FROM
    USERS
START WITH
    manager_id IS NULL
CONNECT BY
    PRIOR user_id = manager_id
ORDER SIBLINGS BY username;
-- 형제 노드들(같은 매니저를 둔 직원들) 사이에서만 정렬!



SELECT
    LEVEL,
    LPAD(' ', (LEVEL-1) * 3) || username AS "보고 라인"
FROM
    USERS
START WITH -- 출발역: 'choonsik'
    user_id = 2
CONNECT BY -- 환승규칙: 나의 user_id가 '이전 행'의 manager_id다 (거슬러 올라가기)
    user_id = PRIOR manager_id;


SELECT user_id, manager_id
FROM USERS;




-- 연습 1
SELECT LEVEL, LPAD(' ', (LEVEL-1)* 4) || COMMENT_TEXT
FROM COMMENTS
START WITH post_id = 67 AND parent_comment_id IS NULL
CONNECT BY PRIOR COMMENT_ID = PARENT_COMMENT_ID
;

-- 연습 2
SELECT
    LEVEL,
    username,
    manager_id
FROM
    USERS
START WITH -- 출발점: 'pikachu'
    user_id = 21
CONNECT BY -- 연결 규칙: 나의 user_id가 '이전 행'의 manager_id다 (역방향)
    user_id = PRIOR manager_id;


-- 연습 3
SELECT username
FROM (
    SELECT LEVEL AS lvl, username
    FROM USERS
    START WITH manager_id IS NULL
    CONNECT BY PRIOR user_id = manager_id
)
WHERE lvl = 3;