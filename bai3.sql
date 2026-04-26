CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    category_id INT,
    price NUMERIC,
    stock_quantity INT
);

INSERT INTO Products (category_id, price, stock_quantity)
SELECT
    (RANDOM() * 50)::INT,
    (RANDOM() * 1000000)::NUMERIC,
    (RANDOM() * 500)::INT
FROM generate_series(1,1000000);

SELECT * FROM Products

--1.Tạo Clustered Index trên cột category_id
CREATE INDEX idx_products_category
ON Products(category_id);

CLUSTER Products USING idx_products_category

--2.Tạo Non-clustered Index trên cột price
CREATE INDEX idx_products_price
ON Products(price);

--3.Thực hiện truy vấn SELECT * FROM Products WHERE category_id
--= X ORDER BY price; và giải thích cách Index hỗ trợ tối ưu
EXPLAIN ANALYZE
SELECT *
FROM Products
WHERE category_id = 10
ORDER BY price;

