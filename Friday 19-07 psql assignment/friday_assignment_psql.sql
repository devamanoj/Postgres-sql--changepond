-- Create database if not exists
CREATE DATABASE IF NOT EXISTS university_db;
\c university_db;

-- Drop tables if they exist to start fresh
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;

-- Create students table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    age INTEGER,
    email VARCHAR(100),
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(50)
);

-- Create courses table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INTEGER
);

-- Create enrollment table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
);

-- Insert sample data into students table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
    ('Devanathan', 24, 'Devanathan@hotmail.com', 55, 57, NULL),
    ('Ajith', 22, 'Ajith@hotmail.com', 34, 45, NULL),
    ('Rahul', 23, 'rahul@hotmail.com', 60, 59, NULL),
    ('Manoj', 22, 'Manoj@gmail.com', 40, 49, NULL),
    ('Vasanth', 24, 'Vasanth@gmail.com', 45, 34, NULL),
    ('Dhanesh', 22, 'mailto:dhanesh@gmail.com', 46, 42, NULL);

-- Insert sample data into courses table
INSERT INTO courses (course_name, credits)
VALUES
    ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

-- Insert sample data into enrollment table
INSERT INTO enrollment (student_id, course_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);

-- Query 1: Insert a new student record
-- Replace with your actual details
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Devanathan A', 23, 'Devanathanmanoj@gmail.com', 95, 85, NULL);

-- Query 2: Retrieve names of students enrolled in 'Next.js'
SELECT student_name
FROM students
WHERE student_id IN (SELECT student_id FROM enrollment WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'Next.js'));


SELECT s.student_name
FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';


-- Query 3: Update status of student with highest total mark to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM (
        SELECT student_id, (frontend_mark + backend_mark) AS total_mark
        FROM students
        ORDER BY total_mark DESC
        LIMIT 1
    ) AS highest_mark
);

-- Query 4: Delete all courses that have no students enrolled
DELETE FROM courses
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM enrollment);

-- Query 5: Retrieve names of students using LIMIT and OFFSET
SELECT student_name
FROM students
ORDER BY student_id
LIMIT 2 OFFSET 2;

-- Query 6: Retrieve course names and number of students enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Query 7: Calculate and display average age of all students
SELECT AVG(age) AS average_age
FROM students;

-- Query 8: Retrieve names of students whose email addresses contain 'hotmail.com'
SELECT student_name
FROM students
WHERE email LIKE '%hotmail.com';

