/* Analyzing the top paying skills for the top data analyst jobs 
    1. Identify the top paying data analyst jobs ( from the previous query)
    2. Find the skills associated with these jobs
    3. Calculate the average salary for each skill
    4. Sort the skills by average salary in descending order
    */

       with top_paying_jobs as ( 
        select job_id, job_title, job_country, job_posted_date::date, salary_year_avg, name as company_name
        from job_postings_fact
        inner join company_dim on job_postings_fact.company_id = company_dim.company_id
        where job_title_short = 'Data Analyst'
        and job_work_from_home = 'True'
        and salary_year_avg is not null
        order by salary_year_avg DESC )

    -- the above cte is a copy of the previous query to find out the top paying jobs 

    select top_paying_jobs.job_id, job_title, salary_year_avg, skills_dim.skill_id, skills_dim.skills, 
    count(*) over (partition by skills_dim.skill_id) as skill_count -- window function to count the number of occurance of each skill
    from top_paying_jobs
    -- using inner join as some jobs might not have the skills associated with them 
    inner join skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    order by salary_year_avg desc
    