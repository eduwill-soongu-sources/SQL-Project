SELECT A.USER_ID, A.USERNAME, B.USERNAME AS MANAGER_NAME
FROM USERS A
LEFT JOIN USERS B
ON A.MANAGER_ID = B.USER_ID
ORDER BY A.USER_ID
;


SELECT A.USER_ID, A.USERNAME, B.USERNAME AS MANAGER_NAME
FROM USERS A, USERS B
WHERE A.MANAGER_ID = B.USER_ID
ORDER BY A.USER_ID
;

-- 연습 1
SELECT
    child.comment_text AS "대댓글 내용",
    parent.comment_text AS "원본 댓글 내용"
FROM
    COMMENTS child -- '대댓글' 역할
INNER JOIN
    COMMENTS parent 
ON child.parent_comment_id = parent.comment_id; -- '원본 댓글' 역할

-- 연습 2
SELECT
    m.username AS "피카츄의 관리자"
FROM
    USERS e -- 직원 역할
INNER JOIN
    USERS m 
ON e.manager_id = m.user_id -- 관리자 역할
WHERE
    e.username = 'pikachu';


-- 연습 3
SELECT
    e.username AS "라이언의 부하 직원"
FROM
    USERS e -- 직원 역할
INNER JOIN
    USERS m ON e.manager_id = m.user_id -- 관리자 역할
WHERE
    m.username = 'ryan';