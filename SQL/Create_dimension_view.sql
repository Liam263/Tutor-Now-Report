CREATE OR REPLACE VIEW fact_sessions AS
SELECT
    session_id,
    student_id,
    tutor_id,
    subject,
    session_date,
    session_price,
    session_status,
    repeat_student
FROM tutor_now.public.tutornowdb;

CREATE OR REPLACE VIEW dim_students AS
SELECT DISTINCT
    student_id,
    student_age,
    student_level,
    student_suburb
FROM tutornowdb;

CREATE OR REPLACE VIEW dim_tutors AS
SELECT DISTINCT
    tutor_id,
    tutor_experience_years,
    tutor_rating,
    tutor_suburb,
    tutor_subject_specialty,
    tutor_hourly_rate
FROM tutornowdb;