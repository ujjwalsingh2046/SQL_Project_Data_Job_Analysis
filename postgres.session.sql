create table application_info ( 
 job_id int,
 application_sent_date date,
 custom_resume boolean,
 resume_file_name varchar(255),
 cover_letter_file_name varchar(255),
 cover_letter_sent boolean,
 status varchar(50)

);


insert into application_info (job_id, application_sent_date, custom_resume, resume_file_name, cover_letter_file_name, cover_letter_sent, status) values
(1, '2023-01-15', true, 'resume1.pdf', 'cover_letter1.pdf', true, 'applied'),
(2, '2023-01-16', false, 'resume2.docx', 'cover_letter2.docx', false, 'interviewed'),
(3, '2023-01-17', true, 'resume3.pdf', null, false, 'rejected'),
(4, '2023-01-18', true, 'resume4.pdf', 'cover_letter4.pdf', true, 'offered');

select *
from application_info
where custom_resume = true
  and cover_letter_sent = true
  and status = 'applied';


select 
count(*) as total_applications,
extract (month from job_posted_date) as month
from job_postings_fact
where job_title_short = 'Data Analyst'
group by month
order by total_applications desc; 

select 
job_title_short,
job_location,
case
    when job_location ='Anywhere' then 'Remote'
    when job_location = 'Onsite' then 'Onsite'
    else 'Hybrid'
    end as job_type
from job_postings_fact
where job_title_short = 'Data Analyst'


with count_skill_query as
( select distinct(skill_id), count(*) over (partition by skill_id) as count_skills
from job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
where job_postings_fact.job_work_from_home = 'True' 
order by count_skills desc
 ) 

select skills_dim.skill_id, skills, count_skills
from count_skill_query
inner join skills_dim on skills_dim.skill_id = count_skill_query.skill_id
limit 5;


select extract (MONTH from job_postings_fact.job_posted_date) as month_name
from job_postings_fact
group by month_name
order by month_name