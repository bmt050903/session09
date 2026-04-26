CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    sale_date DATE,
    amount NUMERIC
);

INSERT INTO Sales (customer_id, product_id, sale_date, amount)
VALUES
(1, 101, '2024-04-10', 500),
(1, 102, '2024-04-15', 800),
(2, 103, '2024-04-21', 400),
(2, 104, '2024-04-25', 900),
(3, 105, '2024-04-24', 1500);

--1.Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
CREATE VIEW CustomerSales AS
SELECT
    customer_id,
    SUM(amount) AS total_amount
FROM Sales
GROUP BY customer_id;


--2.Viết truy vấn SELECT * FROM CustomerSales WHERE total_amount > 1000; để xem khách hàng mua nhiều
SELECT *
FROM CustomerSales
WHERE total_amount > 1000;


--.3Thử cập nhật một bản ghi qua View và quan sát kết quả
UPDATE Sales
SET amount = 1200
WHERE sale_id = 1;