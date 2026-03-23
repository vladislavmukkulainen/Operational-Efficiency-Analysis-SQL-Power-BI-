CREATE DATABASE operational_efficiency_db;
USE operational_efficiency_db;

CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    processing_start_date DATE,
    shipped_date DATE,
    delivered_date DATE,
    promised_date DATE,
    status VARCHAR(50),
    region VARCHAR(50),
    team VARCHAR(50),
    employee VARCHAR(100),
    units INT,
    revenue DECIMAL(10,2),
    cost DECIMAL(10,2)
);

CREATE TABLE orders_staging_v2 (
    order_id NVARCHAR(50),
    order_date NVARCHAR(50),
    processing_start_date NVARCHAR(50),
    shipped_date NVARCHAR(50),
    delivered_date NVARCHAR(50),
    promised_date NVARCHAR(50),
    status NVARCHAR(50),
    region NVARCHAR(50),
    team NVARCHAR(50),
    employee NVARCHAR(100),
    units NVARCHAR(50),
    revenue NVARCHAR(50),
    cost NVARCHAR(50)
);

BULK INSERT orders_staging_v2
FROM 'C:\Users\vladi\OneDrive\Documents\Operational Efficiency\operational_efficiency_orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

SELECT TOP 10 *
FROM orders_staging_v2;

INSERT INTO orders (
    order_id,
    order_date,
    processing_start_date,
    shipped_date,
    delivered_date,
    promised_date,
    status,
    region,
    team,
    employee,
    units,
    revenue,
    cost
)
SELECT
    TRY_CAST(order_id AS INT),
    TRY_CAST(NULLIF(order_date, '') AS DATE),
    TRY_CAST(NULLIF(processing_start_date, '') AS DATE),
    TRY_CAST(NULLIF(shipped_date, '') AS DATE),
    TRY_CAST(NULLIF(delivered_date, '') AS DATE),
    TRY_CAST(NULLIF(promised_date, '') AS DATE),
    status,
    region,
    team,
    employee,
    TRY_CAST(NULLIF(units, '') AS INT),
    TRY_CAST(REPLACE(NULLIF(revenue, ''), ',', '.') AS DECIMAL(10,2)),
    TRY_CAST(REPLACE(NULLIF(cost, ''), ',', '.') AS DECIMAL(10,2))
FROM orders_staging_v2;

CREATE VIEW order_metrics AS
SELECT *,
    
    -- Time breakdown
    DATEDIFF(day, order_date, processing_start_date) AS queue_days,
    DATEDIFF(day, processing_start_date, shipped_date) AS handling_days,
    DATEDIFF(day, shipped_date, delivered_date) AS transit_days,
    DATEDIFF(day, order_date, delivered_date) AS total_delivery_days,

    -- Performance flags
    CASE 
        WHEN delivered_date <= promised_date THEN 1 
        ELSE 0 
    END AS on_time_flag,

    CASE 
        WHEN status = 'cancelled' THEN 1 
        ELSE 0 
    END AS cancelled_flag

FROM orders;

SELECT TOP 10 *
FROM order_metrics;

SELECT
    COUNT(*) AS total_orders,
    AVG(total_delivery_days) AS avg_delivery_time,
    AVG(queue_days) AS avg_queue_time,
    AVG(handling_days) AS avg_handling_time,
    AVG(transit_days) AS avg_transit_time,
    AVG(on_time_flag) AS on_time_rate,
    AVG(cancelled_flag) AS cancellation_rate,
    SUM(revenue) AS total_revenue,
    SUM(cost) AS total_cost
FROM order_metrics;

SELECT
    team,
    AVG(queue_days) AS avg_queue,
    AVG(handling_days) AS avg_handling,
    AVG(transit_days) AS avg_transit,
    AVG(total_delivery_days) AS avg_total
FROM order_metrics
GROUP BY team
ORDER BY avg_queue DESC;

SELECT
    team,
    COUNT(*) AS orders,
    AVG(total_delivery_days) AS avg_delivery_time,
    AVG(on_time_flag) AS on_time_rate,
    AVG(cancelled_flag) AS cancellation_rate
FROM order_metrics
GROUP BY team
ORDER BY orders DESC;

SELECT
    DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS month,
    COUNT(*) AS orders,
    AVG(total_delivery_days) AS avg_delivery_time,
    AVG(on_time_flag) AS on_time_rate
FROM order_metrics
GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
ORDER BY month;