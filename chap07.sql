-- registration_date(가입일) 컬럼을 기준으로 내림차순(DESC) 정렬합니다.
-- 최신 날짜가 가장 위로 올라오게 됩니다.
SELECT user_id, username, registration_date
FROM USERS
ORDER BY registration_date DESC
;

-- view_count(조회수) 컬럼을 기준으로 내림차순(DESC) 정렬합니다.
-- 가장 큰 숫자가 위로 올라오게 됩니다.
SELECT post_id, user_id, view_count
FROM POSTS
ORDER BY view_count DESC
;

-- username(사용자 이름) 컬럼을 기준으로 오름차순(ASC) 정렬합니다.
-- ASC는 기본값이므로 생략해도 동일한 결과가 나옵니다.
SELECT user_id, username
FROM USERS
ORDER BY username ASC; 
-- 'ORDER BY username;' 이라고만 써도 결과는 같습니다.


-- 콤마(,)를 사용해 정렬 기준을 여러 개 지정할 수 있습니다.
-- 1차: user_id 오름차순 (ASC는 생략 가능)
-- 2차: creation_date 내림차순
SELECT user_id, post_id, creation_date
FROM POSTS
ORDER BY user_id ASC, creation_date DESC;

-- 1. user_id로 그룹을 묶고, 게시물 수를 COUNT(*)로 계산하여 post_count 라는 별칭을 부여
-- 2. ORDER BY 절에서 COUNT(*) 대신 post_count 라는 깔끔한 별칭을 사용
SELECT user_id, COUNT(*) AS post_count
FROM POSTS
GROUP BY user_id
ORDER BY post_count DESC
; -- ORDER BY COUNT(*) DESC; 와 동일하지만 훨씬 깔끔합니다.


-- 1. CASE 문으로 정렬 순서를 임의로 부여합니다. (video는 1번, 나머지는 2번)
-- 2. 이 순서를 1차 정렬 기준으로 삼고, creation_date를 2차 정렬 기준으로 삼습니다.
SELECT post_id, user_id, post_type, creation_date
FROM POSTS
ORDER BY
    CASE WHEN post_type = 'video' 
    THEN 1 
    ELSE 2 END, 
-- 1차 정렬 기준 
creation_date DESC; -- 2차 정렬 기준


-- 2번째 컬럼인 username을 기준으로 오름차순 정렬하라는 의미
SELECT user_id, username, registration_date AS RD
FROM USERS
ORDER BY 1 DESC, RD ASC; -- ORDER BY username; 과 동일


SELECT username, manager_id 
FROM USERS 
ORDER BY manager_id DESC
;