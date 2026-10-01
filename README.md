# World Layoffs Data Cleaning (SQL Portfolio Project)

## Executive Summary
This repository contains a comprehensive Data Cleaning Portfolio Project performed on a global tech layoffs dataset using MySQL Workbench. 

The goal of this project was to transform raw, messy, and unstructured data into an accurate, standardized, and clean relational dataset ready for Exploratory Data Analysis (EDA) and business reporting.

---

## Technical Skills & SQL Concepts Applied
- Data Integrity & Staging: Built isolated staging tables (layoffs_staging, layoffs_staging2) to preserve raw data lineage.
- Window Functions & Deduplication: Employed ROW_NUMBER() OVER(PARTITION BY ...) and Common Table Expressions (CTEs) to identify and purge duplicate entries.
- String Manipulation & Standardization: Utilized TRIM(), TRIM(TRAILING ...) and LIKE operators to standardize string values, remove extra spaces, and resolve inconsistent naming conventions (e.g., standardizing variations of Crypto).
- Data Type Casting & Formatting: Applied STR_TO_DATE() to convert string date records into standard SQL DATE types (YYYY-MM-DD) followed by ALTER TABLE schema modifications.
- Null Value Imputation: Executed SELF JOIN operations to populate missing category fields (industry) based on identical company records.
- Data Reduction: Dropped rows missing primary quantitative metrics (total_laid_off and percentage_laid_off) that could not contribute to downstream analyses.

---

## Data Cleaning Workflow

### Step 1: Staging Raw Data
To adhere to database best practices, direct modification of raw data was strictly avoided. A duplicate table structure was instantiated:

`sql
CREATE TABLE layoffs_staging LIKE layoffs;
INSERT INTO layoffs_staging SELECT * FROM layoffs;
