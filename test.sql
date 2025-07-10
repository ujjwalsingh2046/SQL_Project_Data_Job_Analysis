alter table application_info
add column contact varchar(255);
-- This adds a new column 'contact' to the 'application_info' table.

--update application_info
update application_info
set contact ='Name 1'
where job_id = 1;

-- This updates the 'contact' column for the row with job_id = 1.
update application_info
set contact = 'Name 2'  
where job_id = 2;                                                                   
-- This updates the 'contact' column for the row with job_id = 2.
update application_info
set contact = 'Name 3'
where job_id = 3;
-- This updates the 'contact' column for the row with job_id = 3.
update application_info
set contact = 'Name 4'
where job_id = 4;
-- This updates the 'contact' column for the row with job_id = 4.

select * from application_info

-- renaming a column 

alter table application_info 
rename column contact to contact_name;

-- changing the data type of the column 
alter table application_info
alter column contact_name type text;

-- deleting a column 

alter table application_info 
drop column contact_name

 INTO application_info (
    job_id,
    application_sent_date,
    custom_resume,
    resume_file_name,
    cover_letter_file_name,
    cover_letter_sent,
    status
  )
VALUES (
    job_id:integer,
    'application_sent_date:date',
    custom_resume:boolean,
    'resume_file_name:character varying',
    'cover_letter_file_name:character varying',
    cover_letter_sent:boolean,
    'status:character varying'
  );

  drop table application_data