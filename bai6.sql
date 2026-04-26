CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price NUMERIC,
    category_id INT
);

INSERT INTO Products (name, price, category_id)
VALUES
('Áo', 100000, 1),
('Quần', 200000, 1),
('Giày', 900000, 2),
('Dép', 300000, 2),
('Nón', 150000, 3);

--1Tạo Procedure update_product_price(p_category_id INT, p_increase_percent NUMERIC) để tăng giá tất cả sản phẩm trong một category_id theo phần trăm
--2.Sử dụng biến để tính giá mới cho từng sản phẩm trong vòng lặp
CREATE OR REPLACE PROCEDURE update_product_price(
    IN p_category_id INT,
    IN p_increase_percent NUMERIC
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_product_id INT;
    v_price NUMERIC;
    v_new_price NUMERIC;
BEGIN
    FOR v_product_id, v_price IN
        SELECT product_id, price
        FROM Products
        WHERE category_id = p_category_id
    LOOP
        v_new_price := v_price + (v_price * p_increase_percent / 100);

        UPDATE Products
        SET price = v_new_price
        WHERE product_id = v_product_id;
    END LOOP;
END;
$$;

--3.Thử gọi Procedure với các tham số mẫu và kiểm tra kết quả trong bảng Products
CALL update_product_price(1, 10);

SELECT * FROM Products;