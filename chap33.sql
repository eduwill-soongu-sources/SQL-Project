
SELECT * FROM USERS;

INSERT INTO USERS 
    (user_id, username, email, REGISTRATION_DATE, MANAGER_ID) 
VALUES 
    (43, '먹고자', 'munchlax@example.com', SYSDATE, 26)
;

-- DDL 사용시에는 자동 커밋이 되니 주의!
CREATE TABLE HEAVY_USERS (
    user_id NUMBER,
    username VARCHAR2(50),
    post_count NUMBER
);

INSERT INTO HEAVY_USERS (user_id, username, post_count)
SELECT
    u.user_id,
    u.username,
    COUNT(p.post_id)
FROM
    USERS u
JOIN
    POSTS p ON u.user_id = p.user_id
GROUP BY
    u.user_id, u.username
HAVING
    COUNT(p.post_id) >= 10;
    


SELECT * FROM HEAVY_USERS;


SELECT * FROM USER_PROFILES WHERE user_id = 1;

UPDATE USER_PROFILES
SET
    bio = '카카오프렌즈의 믿음직한 리더!'
WHERE
    user_id = 1; -- '라이언'만 콕 집어서 수정! 이게 없으면 큰일납니다.


SELECT view_count FROM POSTS;

-- SET 절에서 서브쿼리를 사용하여 동적인 값으로 업데이트합니다.
UPDATE POSTS
SET view_count = view_count + 
    (SELECT ROUND(AVG(view_count)) FROM POSTS);
-- (강의가 끝나면 원래대로 되돌리기 위해 ROLLBACK을 꼭 해주세요!)

ROLLBACK;

SELECT * FROM USERS;

DELETE FROM USERS 
WHERE user_id = 43;

COMMIT;


-- NOT IN과 서브쿼리를 사용하여 삭제할 대상을 동적으로 지정합니다.
DELETE FROM POSTS
WHERE post_id NOT IN ( 
	SELECT DISTINCT post_id FROM LIKES
);
-- (강의 후 원래대로 되돌리기 위해 ROLLBACK 필요)

SELECT * FROM POSTS;
ROLLBACK;