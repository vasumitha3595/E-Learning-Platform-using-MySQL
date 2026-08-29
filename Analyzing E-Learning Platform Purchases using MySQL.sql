create database online_learning_db;
use online_learing;
CREATE TABLE learners (
    learner_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price decimal(10, 2) NOT NULL
);

CREATE TABLE Purchases (
    Purchases_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    learner_id INT NOT NULL,
    quantity INT,
    purchase_date DATE NOT NULL,
    FOREIGN KEY (course_id) REFERENCES Course(Course_id),
    FOREIGN KEY (learner_id) REFERENCES learners(learner_id)
);

INSERT INTO learners (learner_id, full_name, country) VALUES
(1, 'Vihaan Singh', 'India'),
(2, 'Arun', 'India'),
(3, 'Bala', 'India'),
(4, 'Christ', 'India'),
(5, 'Deepak', 'India');

INSERT INTO Course (course_id, course_name, category,unit_price) VALUES
(101, 'Excel for beginners', 'Beginner', 5000.00),
(102,  'Powerbi', 'beginner', 5000.00),
(103, 'SQL', 'Advanced', 10000.00),
(104, 'Phython', 'intermediate', 8000.00),
(105, 'machinelearning', 'beginner', 12000.00);

INSERT INTO purchases(purchases_id, learner_id, course_id, quantity, purchase_date) VALUES
(5001, 1, 101, 2, '2026-07-01'),
(5002, 1, 102, 1, '2026-06-01'),
(5003, 2, 105, 2, '2026-05-01'),
(5004, 3, 103, 1, '2026-05-03'),
(5005, 4, 104, 3, '2026-05-12'),
(5006, 5, 101, 1, '2026-05-10'),
(5007, 5, 105, 2, '2026-08-15'),
(5008, 2, 102, 2, '2026-08-18');

SELECT * FROM learners;

SELECT * FROM Course;

SELECT * FROM purchases;

select l.full_name AS Learner_Name,
    c.course_name AS Course_Name,
    c.category AS Category,
    p.quantity AS Quantity,
    FORMAT(p.quantity * c.unit_price, 2) AS Total_Amount,
    p.purchase_date AS Purchase_Date
FROM purchases p
INNER JOIN learners l
    ON p.learner_id = l.learner_id
INNER JOIN Course c
    ON p.course_id = c.course_id
ORDER BY (p.quantity * c.unit_price) DESC;
SELECT
    l.full_name AS Learner_Name,
    c.course_name AS Course_Name,
    c.category AS Category,
    p.quantity AS Quantity,
    FORMAT(
        COALESCE(p.quantity, 0) * COALESCE(c.unit_price, 0),
        2
    ) AS Total_Amount,
    p.purchase_date AS Purchase_Date
FROM learners l
LEFT JOIN purchases p
    ON l.learner_id = p.learner_id
LEFT JOIN Course c
    ON p.course_id = c.course_id
ORDER BY Total_Amount DESC;
SELECT
    l.full_name AS Learner_Name,
    c.course_name AS Course_Name,
    c.category AS Category,
    p.quantity AS Quantity,
    FORMAT(
        COALESCE(p.quantity, 0) * COALESCE(c.unit_price, 0),
        2
    ) AS Total_Amount,
    p.purchase_date AS Purchase_Date
FROM purchases p
RIGHT JOIN Course c
    ON p.course_id = c.course_id
LEFT JOIN learners l
    ON p.learner_id = l.learner_id
ORDER BY Total_Amount DESC;
\\\Q1. Display each learner’s total spending with their country.
SELECT
    l.full_name,
    l.country,
    (SELECT SUM(p.quantity *(SELECT c.unit_price
                FROM Course c
                WHERE c.course_id = p.course_id))
        FROM purchases p
        WHERE p.learner_id = l.learner_id
    ) AS total_spending
FROM learners l;
--/// TOP 3

SELECT
    course_id,
    SUM(quantity) AS total_quantity
FROM purchases
GROUP BY course_id
ORDER BY total_quantity DESC
LIMIT 3;

Total revenur and unique learner
SELECT
    c.category,
    (SELECT SUM(p.quantity * c2.unit_price)
     FROM purchases p, Course c2
     WHERE p.course_id = c2.course_id
       AND c2.category = c.category) AS total_revenue,

    (SELECT COUNT(DISTINCT p.learner_id)
     FROM purchases p, Course c3
     WHERE p.course_id = c3.course_id
       AND c3.category = c.category) AS unique_learners

FROM Course c
GROUP BY c.category;
////// List learners who purchased from more than one category.
select l. learner_id, l.full_name
from learners l
Inner join 
purchases p
on l.learner_id = p.learner_id
inner join course c
on c.course_id = p.course_id
GROUP BY
    l.learner_id,
    l.full_name
HAVING COUNT(DISTINCT c.category) > 1;
Not purchasedd 
SELECT
    c.course_id,
    c.course_name
FROM Course c
LEFT JOIN purchases p
    ON c.course_id = p.course_id
WHERE p.course_id IS NULL;
 abve totl spending
 SELECT full_name
FROM learners l
WHERE (
    SELECT SUM(p.quantity * 
        (SELECT unit_price
         FROM Course c
         WHERE c.course_id = p.course_id)
    )
    FROM purchases p
    WHERE p.learner_id = l.learner_id
) > (
    SELECT AVG(total_spending)
    FROM (
        SELECT SUM(p.quantity *
            (SELECT unit_price
             FROM Course c
             WHERE c.course_id = p.course_id)
        ) AS total_spending
        FROM purchases p
        GROUP BY p.learner_id
    ) x
);
ANY - beginner
SELECT course_name, unit_price
FROM Course
WHERE unit_price > ANY
(
    SELECT unit_price
    FROM Course
    WHERE category = 'Beginner'
);

above average
SELECT l.full_name
FROM learners l
WHERE
(
    SELECT SUM(p.quantity * 
        (SELECT c.unit_price
         FROM Course c
         WHERE c.course_id = p.course_id)
    )
    FROM purchases p
    WHERE p.learner_id = l.learner_id
)
>
(
    SELECT AVG(total_spending)
    FROM
    (
        SELECT SUM(p2.quantity *
            (SELECT c2.unit_price
             FROM Course c2
             WHERE c2.course_id = p2.course_id)
        ) AS total_spending
        FROM purchases p2
        WHERE p2.learner_id IN
        (
            SELECT l2.learner_id
            FROM learners l2
            WHERE l2.country = l.country
        )
        GROUP BY p2.learner_id
    ) x
);
 // Null handling
SELECT
    c.course_id,
    c.course_name,
    COALESCE(COUNT(p.purchases_id), 0) AS purchase_count
FROM Course c
LEFT JOIN purchases p
    ON c.course_id = p.course_id
GROUP BY
    c.course_id,
    c.course_name;
    
    CASE
    SELECT
    full_name,
    total_spending,
    CASE
        WHEN total_spending > 15000 THEN 'High Value'
        WHEN total_spending >= 8000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS spending_category
FROM
(
    SELECT
        l.full_name,
        SUM(p.quantity * c.unit_price) AS total_spending
    FROM learners l
    JOIN purchases p
        ON l.learner_id = p.learner_id
    JOIN Course c
        ON p.course_id = c.course_id
    GROUP BY l.learner_id, l.full_name
)x;

With spendingbylearner as
(SELECT
        l.full_name,
        SUM(p.quantity * c.unit_price) AS total_spending
    FROM learners l
    JOIN purchases p
        ON l.learner_id = p.learner_id
    JOIN Course c
        ON p.course_id = c.course_id
    GROUP BY l.learner_id, l.full_name)
    SELECT
    full_name,
    total_spending
FROM spendingbylearner
WHERE total_spending > 10000;