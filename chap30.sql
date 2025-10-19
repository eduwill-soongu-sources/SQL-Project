SELECT username
FROM USERS
WHERE REGEXP_LIKE(username, '\d'); -- '\d'는 숫자를 의미하는 메타 캐릭터

SELECT email
FROM USERS
WHERE REGEXP_LIKE(email, '^c.*com$');


 SELECT
    content,
    REGEXP_SUBSTR(content, '#\w+') AS "첫번째_해시태그"
FROM
    POSTS
WHERE
    -- 해시태그가 있는 게시물만 필터링해서 봅시다.
    REGEXP_LIKE(content, '#\w+');


-- 연습 1
SELECT username
FROM USERS
WHERE REGEXP_LIKE(username, '_');

-- 연습 2
-- 기본적으로 대소문자를 구분하므로, 소문자 a, e, i, o, u로 시작하는 경우만 찾습니다.
SELECT username
FROM USERS
WHERE REGEXP_LIKE(username, '^[aeiou]');