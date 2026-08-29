# 🎓 Analyzing E-Learning Platform Purchases using MySQL

📊 Data Analytics — Module-End Assignment 3

## 🚀 Overview

- 📌 Uses MySQL to design, populate, and query a database for an online learning platform
- 📌 Models learners, courses, and purchases
- 📌 Answers business questions about sales trends, learner behavior, and popular categories
- 📌 Covers joins, subqueries, CTEs, CASE expressions, NULL handling, and a view

## 🗃️ Dataset Summary

| Table       | Rows | Description                               |
|-------------|------|--------------------------------------------|
| `learners`  | 5    | Learner ID, name, country                  |
| `Course`    | 5    | Course ID, name, category, unit price      |
| `purchases` | 8    | Purchase ID, learner, course, quantity, date |

- 📅 Sample period: May 2026 – August 2026
- 🎯 Total revenue across the sample: **₹1,12,000**

## 📁 Files in This Project

| File | Description |
|---|---|
| `Analyzing_E-Learning_Platform_Purchases_using_MySQL.sql` | Full SQL script |
| `E-Learning_Purchases_Report_with_Query_Answers.pdf` | Report with insights, recommendations, and query outputs |
| `E-Learning_Purchases_Summary_Report.docx` | One-page Word summary report |
| `README.md` | This file |

```sql
create database online_learning_db;
use online_learning_db;     
```

## ▶️ How to Run

1. 🖥️ Open the `.sql` file in MySQL Workbench (or run via CLI)
2. 🔧 Fix the `USE` statement typo shown above
3. 🏗️ Run the script top to bottom to create tables and insert sample data
4. 🔍 Run each query block individually to see joins, aggregations, subqueries, CTEs, CASE logic, and NULL handling
5. 👁️ Add the `CREATE VIEW category_performance_view` statement if not already present

```sql
SELECT * FROM category_performance_view;
```

## ✅ What's Covered

- 🏗️ **Schema design** — `learners`, `Course`, `purchases` with primary/foreign keys
- 🔗 **Joins** — INNER, LEFT, RIGHT with formatted currency and aliases
- 📈 **Q1–Q5** — spending by learner, top 3 courses, category revenue, multi-category buyers, unpurchased courses
- 🧩 **Q6–Q8** — subqueries and correlated subqueries
- 🧮 **Q9–Q12** — CTE, CASE classification, NULL handling, view

## 🏆 Key Findings

- 🥇 **Beginner** category drives ~70% of revenue (₹78,000 of ₹1,12,000)
- 🤖 **Machine Learning** is the top course by units sold and revenue
- 🔀 No learner has purchased across more than one category yet
