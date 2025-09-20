# 🏥 Healthcare Data Analysis with MS SQL

## 📌 Overview

In this project I clean, explore, and analyze healthcare data. The dataset contains patient demographics, medical conditions, billing details, hospital admissions, insurance information, and treatment outcomes.

The goal of this analysis is to answer key business questions that provide insights into **hospital performance, patient care trends, insurance coverage, and cost analysis**.

---

## 🎯 Business Questions Addressed

1. Which medical condition has the highest average billing amount?
2. What’s the average length of stay per admission type?
3. Which insurance providers cover the highest cost cases?
4. What are the most common medications used per diagnosis?
5. What is the average time to discharge by hospital?

---

## Steps Taken

### 🔍 Data Exploration

* Queried dataset to understand structure and unique categories (Gender, Medical Condition, Insurance Provider, Admission Type, etc.).
* Verified column integrity and checked distributions.

### 🧹 Data Cleaning

* Standardized text fields (e.g., converted names to uppercase).
* Trimmed extra spaces in categorical columns.
* Checked for `NULL` values and replaced billing nulls with the dataset mean.
* Identified and removed duplicate records based on `ID`.
* Extracted admission year from dates for trend analysis.

### 📊 Data Analysis

* Calculated **average billing per medical condition**.
* Measured **average hospital stay length per admission type**.
* Ranked **insurance providers by total billing coverage**.
* Identified **most prescribed medications per diagnosis**.
* Computed **average discharge time per hospital**.
* Segmented patients by **age and gender** for targeted outreach.

---

## 📈 Insights

* **High-cost conditions** were identified by comparing average billing amounts.
* **Emergency admissions** typically showed longer average stay lengths than routine cases.
* A few **insurance providers** accounted for the majority of high-billing cases.
* Certain **medications were strongly linked to specific diagnoses**, suggesting treatment patterns.
* **Hospital efficiency** varied in discharge times, highlighting opportunities for operational improvements.

---

## ⚙️ Tech Stack

* **SQL Server (MS SQL)** – Data exploration, cleaning, and analysis
* **SQL Queries** – aggregations, case statements, temporary tables
* **Dataset** – Healthcare patient records (demographics, admissions, billing, insurance, treatments)

---

## 🚀 How to Run

1. Open the project in **SQL Server Management Studio (SSMS)** or any MS SQL environment.
2. Import the `healthcare` dataset into your database.
3. Run the queries in **Healthcare\_MSSQLquery.sql** step by step:

   * Data Exploration
   * Data Cleaning
   * Data Analysis
4. Review outputs and modify queries as needed for further insights.

---

## 📌 Further Analysis
* Build a **dashboard in Power BI or Tableau** for visualization.
* Incorporate **predictive modeling** (e.g., length of stay prediction) using Python or R.
* Expand insurance and medication analysis to **identify cost-saving opportunities**.
