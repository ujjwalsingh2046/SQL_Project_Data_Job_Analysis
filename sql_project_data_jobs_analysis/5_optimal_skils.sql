/* the goal is to find skills that are high demand and high in salary 
    1. find the most popular skills (high demand)
    2. find the skills that are high in salary (high salary)
    3. find the skills that are both high in demand and high in salary
    basically find an intersection of the two sets 
    */

    -- finding the skils that are in high demand 

    with high_demand_skills as (
    select  skills_dim.skills, 
    count(*) as skill_count
    -- using window function to count the number of occurrences of each skill 
    from job_postings_fact as jp
    inner join skills_job_dim on jp.job_id  =skills_job_dim.job_id 
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
   -- where jp.job_title_short = 'Data Analyst' --uncomment to see for specific role
   -- and jp.job_work_from_home = 'True' -- uncomment this if you want to filter for remote jobs
    group by skills_dim.skill_id
    order by skill_count desc
    )


    --finding the skills that are high in salary 

   , high_pay_skills as (
    select skills_dim.skills, avg(jp.salary_year_avg) as avg_salary
    from job_postings_fact as jp
    inner join skills_job_dim on jp.job_id = skills_job_dim.job_id
    inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    where salary_year_avg is not null
    group by skills_dim.skill_id
    order by avg_salary desc
   )

   select hds.skills, hds.skill_count, hps.avg_salary
   from high_demand_skills as hds
   inner join high_pay_skills as hps
    on hds.skills = hps.skills
    
   order by hds.skill_count DESC