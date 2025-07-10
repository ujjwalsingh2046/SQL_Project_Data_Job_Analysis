/* top demanded skill
basically finding the skills with highest demands
check them for data analyst  */

select skills_dim.skills, count(*) as skill_count
from job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_postings_fact.job_title_short = 'Data Analyst'
-- and job_work_from_home = 'True'
group by skills_dim.skill_id
order by skill_count desc