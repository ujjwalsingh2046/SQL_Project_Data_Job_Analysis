/* what are the top skills based upon salary ? 
   1. find the top paying jobs
   2. find the skills associated with these jobs
   3. calculate the average salary for each skill
   4. sort the skills by average salary in descending order
*/

with top_paying_jobs as (
select job_id, job_title_short, salary_year_avg
from job_postings_fact
where salary_year_avg is not null 
order by salary_year_avg desc )

select skills.skill_id, skills.skills, round(avg(salary_year_avg),0) as avg_salary_on_skill
from top_paying_jobs
inner join skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
inner join skills_dim as skills on skills_job_dim.skill_id = skills.skill_id
--where top_paying_jobs.job_title_short = 'Data Analyst' -- ensuring the values are true for data analyst role
group by skills.skill_id
order by avg_salary_on_skill desc