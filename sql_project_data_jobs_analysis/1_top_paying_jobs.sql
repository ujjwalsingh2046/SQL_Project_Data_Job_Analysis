/* What will be doing inside here ? 
 1. Getting the top paying data analyst jobs
 2. identify the top 10 highest paying data analyst jobs 
 3. ensure that the jobs that we are looking at are remote jobs 
 4. ensure to omit null values as we are filtering based upon the salary 
 */

        select 
        job_id, 
        job_title,
        job_country,
        job_posted_date::date,
        salary_year_avg,
        name as company_name

        from 
        job_postings_fact
        inner join company_dim 
        on job_postings_fact.company_id = company_dim.company_id
        where 
        job_title_short = 'Data Analyst'
        and job_work_from_home = 'True'
        and salary_year_avg is not null
        order by salary_year_avg DESC
        limit 10