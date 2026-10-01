with duplicate_cte as 
(
select *,
 row_number() over(
 partition by company, industry, total_laid_off, percentage_laid_off, location, stage, country, funds_raised_millions, `date` ) row_num
from layoffs_staging
)
select *
from duplicate_cte 
where row_num >1;

select *
from layoffs_staging
where company = 'casper';


with duplicate_cte as 
(
select *,
 row_number() over(
 partition by company, industry, total_laid_off, percentage_laid_off, location, stage, country, funds_raised_millions, `date` ) row_num
from layoffs_staging
)
delete 
from duplicate_cte 
where row_num >1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT * 
FROM layoffs_staging2;

delete 
FROM layoffs_staging2
WHERE  row_num >1;




INSERT INTO layoffs_staging2
select *,
 row_number() over(
 partition by company, industry, total_laid_off, percentage_laid_off, location, stage, country, funds_raised_millions, `date` ) row_num
from layoffs_staging;

SELECT  company, trim(company)
FROM layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct location
from layoffs_staging2
;

update layoffs_staging2
set industry = 'crypto'
where industry like 'crypto%'
;

SELECT distinct(country)
from layoffs_staging2
order by 1;

UPDATE layoffs_staging2
SET country = 'united states'
where country like 'united states.'
;

select `date`,
str_to_date(`date`,'%m/%d/%Y')
from layoffs_staging2
;

update layoffs_staging2
set `date` = str_to_date(`date`,'%m/%d/%Y')
;

select `date`
from layoffs_staging2;

alter table layoffs_staging2
modify column`date` DATE;

select *
from layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

select *
from layoffs_staging2
WHERE industry is null
or industry = '';

update layoffs_staging2
set industry = 'travel'
where company = 'airbnb'
;

select *
from layoffs_staging2
where company = 'Bally\'s Interactive';

alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2
;

set sql_safe_updates = 0;