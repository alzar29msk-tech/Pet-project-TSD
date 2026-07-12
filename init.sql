-- 1. Создание таблицы "Товар"
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_description TEXT,
    measurement VARCHAR(50) NOT NULL, -- (piece или kg)
    availability NUMERIC(10, 3) NOT NULL DEFAULT 0          -- (остаток на складе)
);

-- 2. Создание таблицы "Заказ"
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_number VARCHAR(100) NOT NULL UNIQUE,
    order_status VARCHAR(100) NOT NULL DEFAULT 'pending'
);

-- 3. Создание промежуточной таблицы "Товар в заказе"
CREATE TABLE product_order (
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id) ON DELETE RESTRICT,
    quantity_plan NUMERIC(10, 3) NOT NULL CHECK (quantity_plan > 0),
    quantity_fact NUMERIC(10, 3) NOT NULL DEFAULT 0 CHECK (quantity_fact >= 0),
    product_status VARCHAR(100) NOT NULL DEFAULT 'pending',
    PRIMARY KEY (order_id, product_id)
);
