CREATE CATALOG IF NOT EXISTS brightlearn;
CREATE SCHEMA IF NOT EXISTS brightlearn.q1;
CREATE OR REPLACE TABLE brightlearn.q1.orders ( 
    order_id INT,
    customer_id INT,
    order_date STRING
);

INSERT INTO brightlearn.q1.orders VALUES
(1001, 101, '2026-05-01'),
(1002, 102, '2026-05-02'),
(1003, 103, '2026-05-03'),
(1004, 104, '2026-05-04'),
(1005, 105, '2026-05-05');

SELECT *
FROM brightlearn.q1.orders;

--Q1: Return each order with the day name of the order date.

SELECT order_id,
        customer_id,
        order_date,
        DAYNAME (Order_date) AS day_name
FROM brightlearn.q1.orders; 

--Q2: Return each customer with the name of the month in which they signed up.

CREATE SCHEMA IF NOT EXISTS brightlearn.q2;
CREATE OR REPLACE TABLE brightlearn.q2.customer_signups ( 
    customer_id INT,
    customer_name STRING,
    SIGNUP_date STRING
);

INSERT INTO brightlearn.q2.customer_signups VALUES
(201, 'John', '2026-01-15'),
(202, 'Mary', '2026-02-20'),
(203, 'Peter', '2026-03-05'),
(204, 'Sarah', '2026-04-18'),
(205, 'Thabo', '2026-05-30');

SELECT *
FROM brightlearn.q2.customer_signups;

--DROP TABLE brightlearn.q2.customer_signups;

SELECT customer_id,
        customer_name,
        signup_date,
        MONTHNAME (signup_date) AS signup_month_name
FROM brightlearn.q2.customer_signups;

Q3: Return each sale with the month number extracted from sale_date

CREATE SCHEMA IF NOT EXISTS brightlearn.dateQ3;
CREATE OR REPLACE TABLE brightlearn.dateQ3.sales ( 
    sale_id INT,
    product_name STRING,
    sale_date STRING,
    amount INT
);

INSERT INTO brightlearn.dateQ3.sales VALUES
(201, 'John', '2026-01-15'),
(202, 'Mary', '2026-02-20'),
(203, 'Peter', '2026-03-05'),
(204, 'Sarah', '2026-04-18'),
(205, 'Thabo', '2026-05-30');

--DROP TABLE brightlearn.dateQ3.sales;

CREATE OR REPLACE TABLE brightlearn.dateQ3.sales ( 
    sale_id STRING,
    product_name STRING,
    sale_date STRING,
    amount INT
);

INSERT INTO brightlearn.dateQ3.sales VALUES
('S001', 'Laptop', '2026-01-10', 12000),
('S002', 'Mouse', '2026-02-15', 250),
('S003', 'Keyboard', '2026-03-20', 700),
('S004', 'Monitor', '2026-04-25', 3500),
('S005', 'Desk', '2026-05-30', 2000);

SELECT *
FROM brightlearn.dateq3.sales;

SELECT sale_id,
        product_name,
        sale_date,
        MONTH (sale_date) AS sale_month
FROM brightlearn.dateq3.sales;

--Q4: Return each transaction with the year extracted from transaction_date.

CREATE SCHEMA IF NOT EXISTS brightlearn.date;
CREATE OR REPLACE TABLE brightlearn.date.transactions ( 
    transaction_id STRING,
    customer_id INT,
    transaction_date STRING,
    amount INT
);

INSERT INTO brightlearn.date.transactions VALUES
('T001', 101, '2024-12-15', 500),
('T002', 102, '2025-01-29',1200),
('T003', 103, '2025-06-10', 800),
('T004', 104, '2026-02-05',1500),
('T005', 105, '2026-05-25',2000);

SELECT *
FROM brightlearn.date.transactions;

SELECT transaction_id,
        customer_id,
        transaction_date,
        YEAR (transaction_date) AS transaction_year
FROM brightlearn.date.transactions;

--Q5: Return each delivery with the day of the month extracted from delivery_date.

CREATE OR REPLACE TABLE brightlearn.date.deliveries ( 
    delivery_id STRING,
    customer_id INT,
    delivery_date STRING
);

INSERT INTO brightlearn.date.deliveries VALUES
('D001', 101, '2024-05-01'),
('D002', 102, '2026-05-08'),
('D003', 103, '2026-05-15'),
('D004', 104, '2026-05-22'),
('D005', 105, '2026-05-295');

SELECT *
FROM brightlearn.date.deliveries;

SELECT delivery_id,
        customer_id,
        delivery_date,
        DAY (delivery_date) AS  day_of_month
FROM brightlearn.date.deliveries;


--I inseted the wrong date for customer_id 105. I am updating the date

UPDATE brightlearn.date.deliveries
SET delivery_date = '2026-05-29'
WHERE delivery_date = '2026-05-295';

-- Q6 Return all employees and add a column showing today's date.

CREATE OR REPLACE TABLE brightlearn.date.employees ( 
    employee_id INT,
    employee_name STRING,
    department STRING
);

INSERT INTO brightlearn.date.employees VALUES
(301, 'Nandi', 'Sales'),
(302, 'Brian', 'IT'),
(303, 'Lerato', 'Finance'),
(304, 'Sipho', 'HR'),
(305, 'Aisha', 'Marketing');

SELECT *
FROM brightlearn.date.employees;

SELECT employee_id,
        employee_name,
        department,
        CURRENT_DATE () AS today_date
FROM brightlearn.date.employees;

--Q7: Convert the order_date_text string column into a proper date column.

CREATE OR REPLACE TABLE brightlearn.date.online_orders ( 
    order_id INT,
    ecustomer_id INT,
    order_date_text STRING
);

INSERT INTO brightlearn.date.online_orders VALUES
(4001, 101, '2026-01-15'),
(4002, 102, '2026-02-20'),
(4003, 103, '2026-03-25'),
(4004, 104, '2026-04-10'),
(4005, 105, '2026-05-05');

SELECT *
FROM brightlearn.date.online_orders;

SELECT order_id,
        ecustomer_id,
        order_date_text,
        TRY_TO_DATE (order_date_text, 'yyyy-MM-dd') AS order_date
FROM brightlearn.date.online_orders;

--Q8 Format payment_date as a text string in the format YYYY-MM-DD

CREATE OR REPLACE TABLE brightlearn.date.payment_dates ( 
    payment_id STRING,
    customer_id INT,
    payment_date STRING
);

INSERT INTO brightlearn.date.payment_dates VALUES
('P001', 101, '2026-01-05'),
('P002', 102, '2026-02-10'),
('P003', 103, '2026-03-15'),
('P004', 104, '2026-04-20'),
('P005', 105, '2026-05-25');


SELECT * 
FROM brightlearn.date.payment_dates;

SELECT payment_id,
        customer_id,
        payment_date,
        date_format (payment_date, 'yyy-MM-dd') AS formatted_payment_date
FROM brightlearn.date.payment_dates;

--Q9: Calculate how many days have passed since each customer's last purchase. Use today's date.

CREATE OR REPLACE TABLE brightlearn.date.customer_purchases ( 
    customer_id INT,
    customer_name STRING,
    last_purchase_date STRING
);

INSERT INTO brightlearn.date. customer_purchases VALUES
(501, 'John', '2026-01-05'),
(502, 'Mary', '2026-05-10'),
(503, 'Peter', '2026-05-15'),
(504, 'Sarah', '2026-05-20'),
(505, 'Thabo', '2026-05-25');

SELECT *
FROM brightlearn.date.customer_purchases;

SELECT customer_id, 
    customer_name, 
    last_purchase_date, 
    DATEDIFF(CURRENT_DATE(), last_purchase_date) AS days_since_last_purchase
FROM brightlearn.date.customer_purchases;

--10: Calculate the expected delivery date by adding 7 days to the order_date.

CREATE OR REPLACE TABLE brightlearn.date.shipping_orders ( 
    order_id INT,
    customer_id INT,
    order_date STRING
);

INSERT INTO brightlearn.date.shipping_orders VALUES
(6001, 101, '2026-05-01'),
(6002, 102, '2026-05-03'),
(6003, 103, '2026-05-05'),
(6004, 104, '2026-05-07'),
(6005, 105, '2026-05-09');

SELECT *
FROM brightlearn.date.shipping_orders;

SELECT order_id, 
    customer_id, 
    order_date, 
    DATEADD(day, 7, order_date) AS expected_delivery_date
FROM brightlearn.date.shipping_orders;

--Q11: Extract the year, month number, and day from booking_date into three separate columns

CREATE OR REPLACE TABLE brightlearn.date.booking ( 
    booking_id STRING,
    customer_id INT,
    booking_date STRING
);

INSERT INTO brightlearn.date.booking VALUES
('B001', 101, '2026-01-12'),
('B002', 102, '2026-02-18'),
('B003', 103, '2026-03-22'),
('B004', 104, '2026-04-09'),
('B005', 105, '2026-05-27');

--DROP TABLE brightlearn.date.booking; i made booking_id INT instead of STRING

SELECT *
FROM brightlearn.date.booking;

SELECT booking_id, 
    customer_id, 
    booking_date,
    YEAR(booking_date) AS booking_year,
    MONTH(booking_date) AS booking_month,
    DAY(booking_date) AS booking_day
FROM brightlearn.date.booking; 

--Q12: Return only orders from the year 2026.

CREATE OR REPLACE TABLE brightlearn.date.yearly_orders ( 
    order_id INT,
    customer_id INT,
    order_date STRING,
    amount INT
);

INSERT INTO brightlearn.date.yearly_orders VALUES
(7001, 101, '2024-12-15', 500),
(7002, 102, '2025-01-20', 1200),
(7003, 103, '2025-06-10',800),
(7004, 104, '2026-02-05',1500),
(7005, 105, '2026-05-25',2000);

SELECT * 
FROM brightlearn.date.yearly_orders;

SELECT order_id, 
    customer_id, 
    order_date, 
    YEAR(order_date) AS order_year, 
    amount
FROM brightlearn.date.yearly_orders
WHERE YEAR(order_date) = 2026;

--Q13: Return only orders placed in March (month number 3)

CREATE OR REPLACE TABLE brightlearn.date.subscription( 
    subscription_id STRING,
    customer_id INT,
    start_date STRING
);

INSERT INTO brightlearn.date.subscription VALUES
('SUB001', 101, '2026-01-10'),
('SUB002', 102, '2026-02-15'),
('SUB003', 103, '2026-03-20'),
('SUB004', 104, '2026-04-25'),
('SUB005', 105, '2026-05-30');

SELECT *
FROM brightlearn.date.subscription;

SELECT subscription_id, 
    customer_id, 
    start_date, 
    LAST_DAY(start_date) AS month_end_date
FROM brightlearn.date.subscription;

--Q15 Return the first day of the month for each campaign send date.

CREATE OR REPLACE TABLE brightlearn.date.campaign_sends( 
    send_id STRING,
    customer_id INT,
    send_date STRING
);

INSERT INTO brightlearn.date.campaign_sends VALUES
('C001', 101, '2026-01-12'),
('C002', 102, '2026-02-18'),
('C003', 103, '2026-03-28'),
('C004', 104, '2026-04-09'),
('C005', 105, '2026-05-27');

SELECT *
FROM brightlearn.date.campaign_sends;

SELECT send_id, 
    customer_id, 
    send_date, 
    DATE_TRUNC('month', send_date) AS month_start_date
FROM brightlearn.date.campaign_sends;

--Q16: Format invoice_date as a text string showing month name and year. Example: January 2026.

CREATE OR REPLACE TABLE brightlearn.date.invoice_dates( 
    invoice_id STRING,
    customer_id INT,
    invoice_date STRING
);

INSERT INTO brightlearn.date.invoice_dates VALUES
('INV001', 101, '2026-01-05'),
('INV002', 102, '2026-02-10'),
('INV003', 103, '2026-03-15'),
('INV004', 104, '2026-04-20'),
('INV005', 105, '2026-05-25');

SELECT *
FROM brightlearn.date.invoice_dates;

SELECT invoice_id, 
    customer_id, 
    invoice_date, 
    date_format(invoice_date, 'MMMM yyyy') AS invoice_month_year
FROM brightlearn.date.invoice_dates;

--Q17: Calculate each customer's age in years using their date of birth and today's date.

CREATE OR REPLACE TABLE brightlearn.date.customer_birthdays( 
    customer_id INT,
    customer_name STRING,
    date_of_birth STRING
);

INSERT INTO brightlearn.date.customer_birthdays VALUES
(901,'John', '1998-05-10'),
(902,'Mary', '1990-08-20'),
(903,'Peter', '2002-03-15'),
(904,'Sarah', '1985-12-01'),
(905,'Thabo', '2000-07-30');

SELECT *
FROM brightlearn.date.customer_birthdays;

SELECT customer_id,
    customer_name,
    date_of_birth,
    FLOOR(DATEDIFF(CURRENT_DATE(), date_of_birth) / 365.25) AS customer_age 
FROM brightlearn.date.customer_birthdays;

--FLOOR(): Rounds down to get the exact completed age in years.
--365.25: Accounts for leap years to ensure precision.
--DATEDIFF(): Calculates the total days between birth and today.

--Q18: Classify each order as Weekend or Weekday based on the day name of the order date. Saturday and Sunday = Weekend. All others = Weekday.

CREATE OR REPLACE TABLE brightlearn.date.weekend_orders( 
    order_id INT,
    customer_id INT,
    order_date STRING
);

INSERT INTO brightlearn.date.weekend_orders VALUES
(9001,101, '2026-05-01'),
(9002,102, '2026-05-02'),
(9003,103, '2026-05-03'),
(9004,104, '2026-05-04'),
(9005,105, '2026-05-05');

SELECT *
FROM brightlearn.date.weekend_orders;

SELECT order_id,
       customer_id,
       order_date,
       date_format(order_date, 'EEEE') AS day_name,
       CASE 
           WHEN date_format(order_date, 'EEEE') IN ('Saturday', 'Sunday') THEN 'Weekend'
           ELSE 'Weekday'
       END AS day_type
FROM brightlearn.date.weekend_orders;

-- 'EEEE' = full name of the day

--Q19: Extract the quarter number from each transaction date.

CREATE OR REPLACE TABLE brightlearn.date.quarterly_transactions( 
    transaction_id STRING,
    customer_id INT,
    transcation_date STRING,
    amount INT
);

INSERT INTO brightlearn.date.quarterly_transactions VALUES
('Q001', 101,'2026-01-15',500),
('Q002', 102, '2026-03-20',1200),
('Q003',103,'2026-04-10',800),
('Q004',104,'2026-07-05',1500),
('Q005',105,'2026-10-25',2000);

SELECT *
FROM brightlearn.date.quarterly_transactions;

SELECT transaction_id, 
    customer_id, 
    transcation_date, 
    QUARTER(transcation_date) AS transaction_quarter, 
    amount
FROM brightlearn.date.quarterly_transactions;

--Q20: Return only orders that are more than 30 days old from today. Calculate days_since_order using today's date.

CREATE OR REPLACE TABLE brightlearn.date.recent_orders( 
    order_id STRING,
    customer_id INT,
    order_date STRING,
    amount INT
);

INSERT INTO brightlearn.date.recent_orders VALUES
('R001', 101,'2026-04-01',500),
('R002', 102, '2026-04-15',1200),
('R003',103,'2026-05-01',800),
('R004',104,'2026-05-10',1500),
('R005',105,'2026-05-25',2000);

SELECT *
FROM brightlearn.date.recent_orders;

SELECT order_id, 
    customer_id, 
    order_date, 
    DATEDIFF(CURRENT_DATE(), order_date) AS days_since_order, 
    amount
FROM brightlearn.date.recent_orders
WHERE DATEDIFF(CURRENT_DATE(), order_date) > 30;

--BONUS CHALLENGE
--Calculate days_since_last_purchase for each customer using CURRENT_DATE. Then use CASE to classify: ≤ 30 days = Active Customer, 31–90 days = At Risk Customer, > 90 days = Inactive Customer.

CREATE OR REPLACE TABLE brightlearn.date.customer_recency( 
    order_id INT,
    customer_name STRING,
    last_pu_date STRING,
    total_spend INT
);

INSERT INTO brightlearn.date.customer_recency VALUES
('1001','John','2026-05-25',5000),
('1002','Mary', '2026-05-10',2500),
('1003','Peter','2026-04-01',700),
('1004','Sarah','2026-02-15',15000),
('1005','Thabo','2026-12-20',300);

SELECT *
FROM brightlearn.date.customer_recency;

SELECT order_id,
        customer_name,
        last_pu_date,
        DATEDIFF(CURRENT_DATE(), last_pu_date) AS days_since_last_purchase,
    CASE
        WHEN DATEDIFF(CURRENT_DATE(), last_pu_date) <= 30 THEN 'Active Customer'
        WHEN DATEDIFF(CURRENT_DATE(), last_pu_date) BETWEEN 31 AND 90 THEN 'At Risk Customer'
        ELSE 'Inactive Customer'
    END AS customer_status
FROM brightlearn.date.customer_recency;















    








