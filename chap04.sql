-- user_id가 1, 9, 21인 사용자의 username을 
-- 다양한 형태로 변환합니다.
SELECT
    username,
    UPPER(username) AS "대문자로 변환",
    LOWER(username) AS "소문자로 변환",
    INITCAP(username) AS "첫 글자만 대문자"
FROM
    USERS
WHERE
    user_id IN (1, 9, 21)
;

-- user_id가 2번, 8번인 프로필의 bio 길이와 
-- 특정 단어 위치를 찾습니다.
SELECT
    user_id,
    bio,
    LENGTH(bio) AS "자기소개 길이",
    INSTR(bio, '고양이') AS "'고양이'의 위치"
FROM
    USER_PROFILES
WHERE
    user_id IN (2, 8);

-- comment_id가 20001인 댓글을 10글자만 잘라 
-- 미리보기로 만듭니다.
SELECT
    comment_text AS "원본 댓글",
    SUBSTR(comment_text, 1, 10) || '...' AS "댓글 미리보기"
FROM
    COMMENTS
WHERE comment_id = 20001
; -- "춘식이 너무 귀여워요! >_<" 댓글 예시


SELECT
    user_id,
    LPAD(user_id, 5, '0') AS "5자리 사용자 ID",
    RPAD(username, 15, '*') AS "오른쪽 채우기 예시"
FROM
    USERS
WHERE
    user_id IN (1, 21, 40)
    ;

SELECT
    content AS "원본 내용",
    REPLACE(content, '#일상', '#데일리') AS "해시태그 교체"
FROM
    POSTS
WHERE
    post_id = 1;


-- ' ryan ' 이라는 가상의 데이터로 TRIM 함수를 테스트합니다.
SELECT
    '  ryan  ' AS "원본",
    TRIM('  ryan  ') AS "TRIM 처리 후",
    LENGTH('  ryan  ') AS "원본 길이",
    LENGTH(TRIM('  ryan  ')) AS "TRIM 처리 후 길이"
FROM DUAL; 
-- DUAL은 Oracle에서 간단한 테스트를 위해 사용하는 가상의 테이블입니다.

-- ################ 숫자 함수


-- reaction_score를 다양한 기준으로 반올림하고 버려봅니다.
SELECT
    post_id,
    reaction_score AS "원본 점수",
    ROUND(reaction_score) AS "정수로 반올림",
    TRUNC(reaction_score) AS "정수로 버림",
    ROUND(reaction_score, 1) AS "소수점 첫째자리까지"
FROM
    POSTS
WHERE
    post_id IN (2, 5); -- 점수가 있는 2번, 5번 게시물 예시


-- 양수와 음수에 대한 CEIL, FLOOR 결과 비교
SELECT
    CEIL(3.14) AS "CEIL(양수)",
    FLOOR(3.14) AS "FLOOR(양수)",
    CEIL(-3.14) AS "CEIL(음수)",
    FLOOR(-3.14) AS "FLOOR(음수)"
FROM DUAL;

-- user_id를 2로 나눈 나머지로 짝/홀수를 구분합니다.
-- (나중에 배울 CASE문을 살짝 맛보기로 사용해볼게요!)
SELECT
    user_id,
    MOD(user_id, 2) AS "나머지",
    CASE
        WHEN MOD(user_id, 2) = 0 THEN '짝수 ID 사용자'
        ELSE '홀수 ID 사용자'
    END AS "ID 유형"
FROM
    USERS
WHERE
    user_id BETWEEN 1 AND 5; -- 1~5번 사용자만 예시로 볼게요!





