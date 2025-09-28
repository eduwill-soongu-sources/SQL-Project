-- '라이언'의 가입일을 기준으로 다양한 날짜를 계산합니다.
-- (오늘 날짜는 2025-09-14 이라고 가정합니다)
SELECT
    registration_date AS "라이언 가입일",
    ADD_MONTHS(registration_date, 6) AS "가입 6개월 기념일",
    MONTHS_BETWEEN(SYSDATE, registration_date) AS "총 활동 개월 수",
    LAST_DAY(registration_date) AS "가입한 달의 마지막 날",
    NEXT_DAY(registration_date, '금요일') AS "가입 후 첫 금요일"
FROM
    USERS
WHERE
    username = 'ryan';


SELECT
    username,
    registration_date AS "가입일",
    TRUNC(registration_date, 'MM') AS "가입 월 (버림)",
    ROUND(registration_date, 'MM') AS "가입 월 (반올림)"
FROM
    USERS
WHERE
    username IN ('ryan', 'choonsik');


-- 1번 게시물이 등록된 시점을 기준으로 날짜 연산을 해봅시다.
SELECT
    creation_date AS "게시물 등록 시각",
    creation_date + 1 AS "24시간 뒤 (하루 뒤)",
    creation_date + (1/24) AS "1시간 뒤",
    SYSDATE - creation_date AS "등록 후 흐른 시간 (일 단위)"
FROM
    POSTS
WHERE
    post_id = 1;


-- '라이언'의 가입일을 TO_CHAR로 보기 좋게 변환합니다.
SELECT
    username,
    registration_date AS "원본 날짜",
    TO_CHAR(registration_date, 'YYYY"년" MM"월" DD"일"') AS "가입일 (상세)",
    TO_CHAR(registration_date, 'YYYY-MM-DD (DY)') AS "가입일 (요일포함)"
FROM
    USERS
WHERE
    username = 'ryan';


-- view_count가 높은 게시물을 찾아 TO_CHAR로 가독성을 높입니다.
SELECT
    post_id,
    view_count AS "원본 조회 수",
    TO_CHAR(view_count * 12345674, '999,999,999,999') AS "스타일링 된 조회 수"
FROM
    POSTS
WHERE
    view_count > 150; -- 조회수가 150 이상인 게시물만 예시로 볼게요.


-- WHERE 절에서 TO_DATE 함수를 사용해 문자열과 날짜를 비교합니다.
SELECT
    post_id,
    content,
    creation_date
FROM
    POSTS
WHERE
--    creation_date > TO_DATE('20240520', 'YYYYMMDD')
    creation_date > TO_DATE('2024년05월20일', 'YYYY"년"MM"월"DD"일"')
;


-- OUTER JOIN을 이용해 프로필이 없는 사용자도 결과에 포함시킵니다.
-- (+) 기호는 Oracle에서 사용하는 약식 OUTER JOIN 표현입니다.
SELECT
    u.username,
    p.bio AS "원본 자기소개",
    NVL(p.bio, '자기소개가 없습니다.') AS "NVL 처리 후"
FROM
    USERS u, USER_PROFILES p
WHERE
    u.user_id = p.user_id(+) AND u.user_id IN (2, 14);


SELECT
    u.username,
    NVL2(p.bio, '프로필 있음', '프로필 없음') AS "프로필 상태"
FROM
    USERS u, USER_PROFILES p
WHERE
    u.user_id = p.user_id(+) AND u.user_id IN (2, 14);

SELECT
    u.username,
    p.full_name,
    -- full_name이 있으면 그걸 쓰고, 없으면(NULL이면) username을 쓴다.
    COALESCE(p.full_name, u.username) AS "최종 표시 이름"
FROM
    USERS u, USER_PROFILES p
WHERE
    u.user_id = p.user_id(+) AND u.user_id IN (1, 14);

-- WITH 절을 이용해 가상의 테이블을 만듭니다.
WITH POST_STATS AS (
    SELECT 1 AS post_id, 50 AS like_count, 1000 AS view_count FROM DUAL
    UNION ALL
    SELECT 2 AS post_id, 0 AS like_count, 0 AS view_count FROM DUAL
)
SELECT
    post_id,
    like_count,
    view_count,
    -- 만약 view_count가 0이면 NULL로 바꿔서 오류를 방지한다.
    like_count / NULLIF(view_count, 0) AS "안전한 참여율"
FROM POST_STATS;

SELECT
    username,
    registration_date,
    CASE
        WHEN registration_date >= TO_DATE('20230101', 'YYYYMMDD') THEN '새싹 유저'
        WHEN registration_date >= TO_DATE('20210101', 'YYYYMMDD') THEN '기존 유저'
        ELSE '고인물 유저'
    END AS "유저 등급"
FROM
    USERS
WHERE
    user_id IN (1, 4, 38); -- 라이언, 리틀어피치, 팽도리 예시

SELECT
    post_id,
    post_type AS "원본 타입",
    CASE post_type
        WHEN 'photo' THEN '사진'
        WHEN 'video' THEN '릴스'
        ELSE '기타'
    END AS "게시물 종류"
FROM
    POSTS
WHERE
    user_id = 1 AND ROWNUM <= 5; -- 라이언의 게시물 5개만 예시로 볼게요.

SELECT
    post_id,
    post_type AS "원본 타입",
    CASE 
        WHEN post_type = 'photo' THEN '사진'
        WHEN post_type = 'video' THEN '릴스'
        ELSE '기타'
    END AS "게시물 종류"
FROM
    POSTS
WHERE
    user_id = 1 AND ROWNUM <= 5; -- 라이언의 게시물 5개만 예시로 볼게요.