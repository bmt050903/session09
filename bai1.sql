CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount NUMERIC
);

INSERT INTO Orders (customer_id, order_date, total_amount)
SELECT
    (RANDOM() * 1000)::INT,
    CURRENT_DATE - ((RANDOM() * 365)::INT),
    (RANDOM() * 1000000)::NUMERIC
FROM generate_series(1,1000000);

SELECT * FROM Orders

--2.Thực hiện truy vấn SELECT * FROM Orders WHERE customer_id = X; trước và sau khi tạo Index, so sánh thời gian thực hiện
EXPLAIN ANALYZE
SELECT * FROM Orders
WHERE customer_id = 500;

--1.Tạo một B-Tree Index trên cột customer_id
CREATE INDEX idx_orders_customer_id
ON Orders(customer_id);