CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    email VARCHAR(100),
    username VARCHAR(100)
);

INSERT INTO Users (email, username)
SELECT
    'user' || g || '@gmail.com',
    'user_' || g
FROM generate_series(1,1000000) AS g;

--1.Tạo Hash Index trên cột email
CREATE INDEX idx_users_email_hash
ON Users USING HASH(email);

--2.Viết truy vấn SELECT * FROM Users WHERE email = 'example@example.com'; và kiểm tra kế hoạch thực hiện bằng EXPLAIN
INSERT INTO Users (email, username)
VALUES ('example@example.com', 'example_user');

EXPLAIN
SELECT *
FROM Users
WHERE email = 'example@example.com';
