-- Student distribution by Suburb
SELECT 
    student_suburb,
    COUNT(DISTINCT student_id) AS total_students
FROM tutornowdb
GROUP BY student_suburb
ORDER BY total_students DESC;

-- Tutor Supply vs Demand (by Subject & Suburb)
SELECT 
    student_suburb,
    subject,
    COUNT(*) AS total_sessions,
    COUNT(DISTINCT tutor_id) AS unique_tutors
FROM tutornowdb
WHERE session_status = 'Completed'
GROUP BY student_suburb, subject
ORDER BY total_sessions DESC;

-- Pricing Trends Subject & Experience
SELECT 
    tutor_subject_specialty,
    ROUND(AVG(tutor_hourly_rate),2) AS avg_rate,
    ROUND(AVG(session_price),2) AS avg_session_price,
    ROUND(AVG(tutor_experience_years),1) AS avg_experience
FROM tutornowdb
GROUP BY tutor_subject_specialty
ORDER BY avg_rate DESC;

-- Peak booking Days 
SELECT 
    DAYNAME(session_date) AS day_of_week,
    COUNT(*) AS total_sessions
FROM tutornowdb
WHERE session_status = 'Completed'
GROUP BY day_of_week
ORDER BY total_sessions DESC;

-- Seasonal Trends (monthly)
SELECT 
    TO_CHAR(session_date, 'YYYY-MM') AS month,
    COUNT(*) AS total_sessions
FROM tutornowdb
GROUP BY month
ORDER BY month;

-- Student Retention Rate
SELECT 
    repeat_student,
    COUNT(*) AS sessions,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM tutornowdb
GROUP BY repeat_student;

-- Tutor Performance vs Repeat Student/ Number of sessions
SELECT 
    CASE 
        WHEN tutor_rating >= 4.5 THEN 'High'
        WHEN tutor_rating >= 3.5 THEN 'Medium'
        ELSE 'Low'
    END AS rating_group,
    COUNT(*) AS sessions,
    SUM(CASE WHEN repeat_student = 'Yes' THEN 1 ELSE 0 END) AS repeat_sessions
FROM tutornowdb
GROUP BY rating_group;

-- Discount Impact on Booking success
SELECT 
    discount_applied,
    COUNT(*) AS total_sessions,
    AVG(session_price) AS avg_price
FROM tutornowdb
GROUP BY discount_applied
ORDER BY discount_applied;

-- Cancellation & No-show rates
SELECT 
    session_status,
    COUNT(*) AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(),2) AS percentage
FROM tutornowdb
GROUP BY session_status;