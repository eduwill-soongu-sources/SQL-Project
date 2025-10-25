-- 1. 새로운 사용자를 INSERT 합니다. (현재는 나에게만 보이는 '임시 작업' 상태)
INSERT INTO USERS (user_id, username, email, registration_date)
VALUES (44, 'tcl_tester', 'tcl@example.com', SYSDATE);
-- (만약 지금 다른 동료가 USERS 테이블을 조회해도, 이 데이터는 보이지 않습니다.)
-- 2. 작업을 최종 확정합니다.
COMMIT;
-- (COMMIT 완료! 이제 모든 사용자가 'tcl_tester'를 조회할 수 있습니다.)

SELECT * FROM USERS;
SELECT * FROM POSTS;

-- 1. 실수로 모든 사용자의 매니저를 '라이언(1)'으로 변경!
UPDATE USERS
SET manager_id = 1;
-- 2. 실수로 모든 게시물을 삭제!
DELETE FROM POSTS;
-- (이 시점에서 테이블들을 조회하면 데이터가 엉망진창이 되어 있습니다...
-- 하지만 아직 우리에겐 희망이 있습니다. COMMIT을 안 했으니까요!)

ROLLBACK;


SELECT * FROM COMMENTS;

-- (새로운 트랜잭션이 시작됩니다.)
-- 1. 2번 게시물의 댓글을 먼저 삭제합니다.
DELETE FROM COMMENTS WHERE post_id = 2;
-- (현재 7개 댓글이 임시 삭제된 상태)
-- 2. 'A' 라는 이름의 중간 저장 지점을 만듭니다.
SAVEPOINT A;
-- 3. 28번 게시물의 댓글을 추가로 삭제합니다.
DELETE FROM COMMENTS WHERE post_id = 28;
-- (현재 총 7+3=10개 댓글이 임시 삭제된 상태)
-- 4. 'A' 지점으로만 롤백합니다.
ROLLBACK TO SAVEPOINT A;

ROLLBACK;


update USERS
set username = '라이언'
where user_id = 1;


SELECT * FROM USERS;
ROLLBACK;

create table extra_table (
    id number
);