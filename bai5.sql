CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT,
    amount NUMERIC,
    sale_date DATE
);

INSERT INTO Sales (customer_id, amount, sale_date)
VALUES
(1, 464, '2024-04-10'),
(2, 777, '2024-04-15'),
(1, 888, '2024-04-05'),
(3, 7400, '2024-04-20'),
(2, 1700, '2024-04-01');

--1.Tạo Procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC) để tính tổng amount trong khoảng start_date đến end_date
CREATE OR REPLACE PROCEDURE calculate_total_sales(
    IN start_date DATE,
    IN end_date DATE,
    OUT total NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    SELECT SUM(amount)
    INTO total
    FROM Sales
    WHERE sale_date BETWEEN start_date AND end_date;
END;
$$;

--2.Gọi Procedure với các ngày mẫu và hiển thị kết quả
CALL calculate_total_sales('2024-04-01', '2024-04-30', NULL);

CALL calculate_total_sales('2024-04-01', '2024-04-15', NULL);
