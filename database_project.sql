-- =====================================================
-- COLLEGE MANAGEMENT SYSTEM
-- SQL DATABASE PROJECT
-- =====================================================


-- =====================================================
-- 1. DATABASE CREATION
-- =====================================================
 create database college_management;
 use college_management;
 -- =====================================================
-- 2. TABLE CREATION
-- =====================================================

-- Student Table
 create table student
 (
 student_id int primary key,
 student_name varchar(50) not null,
 age int not null,
 city varchar(50),
 email varchar(100) unique
 );
 -- course table
create table course
(
course_id int primary key,
course_name varchar(100)not null,
duration_months int not null,
course_fee int
);
-- teacher table
create table teacher
(
teacher_id int primary key,
teacher_name varchar(50) not null,
email varchar(100) unique,
salary int not null,
course_id int,
foreign key (course_id) references course(course_id)
);
-- enrollment table
create table enrollment
(
enrollment_id int primary key,
student_id int,
foreign key (student_id) references student(student_id),
course_id int,
foreign key (course_id) references course(course_id),
enroll_date date
);
-- marks table
create table marks
(
marks_id int primary key,
student_id int,
foreign key (student_id) references student(student_id),
course_id int,
foreign key(course_id) references course(course_id),
marks int
);
-- =====================================================
-- 3. DATA INSERTION
-- =====================================================

-- Insert Student Records
insert into student (student_id,student_name,age,city,email) values
(7001,"abhishek",19,"rajpura","abhishek7001.bca25@chitkara.edu.in"),
(7002,"arun",19,"patiala","arun7002.bca25@chitkara.edu.in"),
(7003,"bhavna",18,"manali","bhavna7003.bca25@chitkara.edu.in"),
(7004,"chetanya",20,"patiala","chetanya7004.bca25@chitkara.edu.in"),
(7005,"daksh",19,"ratangarh","daksh7005.bca25@chitkara.edu.in"),
(7006,"farul",18,"karnal","farul7006.bca25@chitkara.edu.in"),
(7007,"garry",19,"panipat","garry7007.bca25@chitkara.edu.in"),
(7008,"henry",20,"kurukshetra","henry7008.bca25@chitkara.edu.in"),
(7009,"ishpreet",19,"delhi","ishpreet7009.bca25@chitkara.edu.in"),
(7010,"japnam",21,"jaipur","japnam7010.bca25@chitkara.edu.in"),
(7011,"kanishk",19,"delhi","kanishk7011.bca25@chitkara.edu.in"),
(7012,"lakshay",19,"rajpura","lakshay7012.bca25@chitkara.edu.in"),
(7013,"manpreet",18,"jaipur","manpreet7013.bca25@chitkara.edu.in"),
(7014,"navya",19,"kurukshetra","navya7014.bca25@chitkara.edu.in"),
(7015,"oceen",20,"panipat","oceen7015.bca25@chitkara.edu.in");
-- insert course records
INSERT INTO course
(course_id, course_name, duration_months, course_fee)
VALUES
(101, 'DBMS', 6, 5000),
(102, 'C++', 6, 4500),
(103, 'Web Development', 6, 5500),
(104, 'Operating Systems', 6, 5000),
(105, 'Computer Networks', 6, 5200);
-- insert teacher records
INSERT INTO teacher
(TEACHER_ID,TEACHER_NAME,EMAIL,SALARY,COURSE_ID)
values
(8001,"vandhana","vandhanabcaemp.25@chitkara.edu.in",45000,105),
(8002,"vikas ratan","vikasbcaemp.25@chitkara.edu.in",65000,102),
(8003,"ramandeep","ramandeepbcaemp.25@chitkara.edu.in",35000,101),
(8004,"ramneek","ramneekbcaemp.25@chitkara.edu.in",55000,103),
(8005,"simran","simranbcaemp.25@chitkara.edu.in",37000,104);
-- insert enrollment records
insert into enrollment(enrollment_id,student_id,course_id,enroll_date)
values
(9001,7001,101,'2026-06-09'),
(9002,7002,101,'2026-06-11'),
(9003,7003,102,'2026-06-09'),
(9004,7004,103,'2026-06-09'),
(9005,7005,102,'2026-06-08'),
(9006,7006,104,'2026-06-12'),
(9007,7007,105,'2026-06-16'),
(9008,7008,101,'2026-06-12'),
(9009,7009,102,'2026-06-09'),
(9010,7010,105,'2026-06-11'),
(9011,7011,104,'2026-06-13'),
(9012,7012,103,'2026-06-13'),
(9013,7013,104,'2026-06-12'),
(9014,7014,103,'2026-06-16'),
(9015,7015,104,'2026-06-08');
-- insert marks records
insert into marks(marks_id,student_id,course_id,marks)
values
(6001,7001,101,75),
(6002,7002,101,65),
(6003,7003,102,68),
(6004,7004,103,49),
(6005,7005,102,58),
(6006,7006,104,98),
(6007,7007,105,86),
(6008,7008,101,32),
(6009,7009,102,45),
(6010,7010,105,74),
(6011,7011,104,39),
(6012,7012,103,57),
(6013,7013,104,69),
(6014,7014,103,42),
(6015,7015,104,11);
-- =====================================================
-- 4. SQL QUERIES
-- =====================================================

-- Query 1:
-- Display student name, course name, and marks
-- of students who scored more than 60 marks

	select student.student_name,course.course_name,marks.marks from student
	inner join enrollment
	on student.student_id=enrollment.student_id
	inner join course
	on enrollment.course_id=course.course_id
    inner join marks
    on course.course_id=marks.course_id
    and student.student_id=marks.student_id
    where marks>60;
    
    -- Query 2:
-- Display course name and average marks for courses
-- having average marks greater than 60

    select course.course_name,avg(marks.marks) from course
    inner join marks
    on course.course_id=marks.course_id
    group by course.course_name
    having avg(marks.marks)>60;
    
    -- Query 3:
-- Display the student name and marks of the
-- highest-scoring student
   
   select student.student_name,marks.marks from student
   inner join marks
   on student.student_id=marks.student_id
   order by marks.marks desc
   limit 1;
   
   -- Query 4:
-- Display the number of students enrolled in each course

   select count(student.student_name),course.course_name from student
   inner join enrollment
   on student.student_id=enrollment.student_id
   inner join course
   on enrollment.course_id=course.course_id
   group by course.course_name;
   
   -- Query 5:
-- Display the highest marks scored in each course

   
   select course.course_name,max(marks.marks)
   from course
   inner join marks
   on course.course_id=marks.course_id
   group by course.course_name;
   
   -- Query 6:
-- Display the lowest marks in each course
-- and show only courses having minimum marks below 40
   
   select course.course_name,min(marks.marks)
   from course
   inner join marks
   on course.course_id=marks.course_id
   group by course.course_name
   having min(marks.marks)<40;
   
   -- Query 7:
-- Display student name, marks, and city of students
-- who scored more than the overall average marks

 select student.student_name,marks.marks,city from student
 inner join marks
 on student.student_id=marks.student_id
where marks.marks>
(select avg(marks.marks)
from marks
);

-- Query 8:
-- Display student name and marks of students
-- who scored less than the highest marks

select student.student_name,marks.marks from student
 inner join marks
 on student.student_id=marks.student_id
where marks.marks<
(select max(marks.marks)
from marks
);

-- Query 9:
-- Display student name, course name, and marks
-- of students who scored more than the overall average marks

select student_name,course.course_name,marks.marks from student
inner join enrollment
on student.student_id=enrollment.student_id
inner join course
on enrollment.course_id=course.course_id
inner join marks
on student.student_id=marks.student_id
and course.course_id=marks.course_id
where marks.marks>
(select avg(marks.marks)
from marks
);

-- Query 10:
-- Display teacher name, course name, and salary

select teacher.teacher_name,course.course_name,teacher.salary
from course
inner join teacher
on course.course_id=teacher.course_id;

-- Query 11:
-- Display the number of teachers assigned to each course


select count(teacher.teacher_name),course.course_name
from course
inner join teacher
on course.course_id=teacher.course_id
group by course.course_name;

-- Query 12:
-- Display student name and enrollment date of students
-- who enrolled after June 10, 2026

select student_name,enroll_date from student
inner join enrollment
on student.student_id=enrollment.student_id
where enroll_date>'2026-06-10';

-- Query 13:
-- Display student name, enrollment date, and city
-- of students who enrolled between June 9 and June 13, 2026

select student_name,enroll_date,city from student
inner join enrollment
on student.student_id=enrollment.student_id
where enroll_Date between '2026-06-09' and'2026-06-13';

-- Query 14:
-- Display city and number of students from each city
-- and show only cities having more than one student

select city,count(student_name) from student
group by city
having count(student_name)>1;

-- Query 15:
-- Display course name and course fee
-- sorted from highest fee to lowest fee

select course_name,course_fee from course
order by course_fee desc;

-- Query 16:
-- Display student name, course name, and marks
-- of the top 3 highest-scoring students

select student.student_name,course.course_name,marks.marks from student
	inner join enrollment
	on student.student_id=enrollment.student_id
	inner join course
	on enrollment.course_id=course.course_id
    inner join marks
    on course.course_id=marks.course_id
    and student.student_id=marks.student_id
    order by marks.marks desc
    limit 3;

-- Query 17:
-- Display teacher name and salary of teachers
-- whose salary is greater than the average teacher salary

    select teacher_name,salary from teacher
    where salary>
    (select avg(salary) from teacher);

-- Query 18:
-- Display course name and number of enrolled students
-- sorted from highest student count to lowest

 select course.course_name,count(student.student_name) from student
 inner join enrollment
 on student.student_id=enrollment.student_id
 inner join course
 on enrollment.course_id=course.course_id
 group by course.course_name
 order by count(student.student_name) desc;
 
 -- Query 19:
-- Display student name, course name, and marks
-- of students who scored below 40 marks
 
 select student.student_name,course.course_name,marks.marks from student
	inner join enrollment
	on student.student_id=enrollment.student_id
	inner join course
	on enrollment.course_id=course.course_id
    inner join marks
    on course.course_id=marks.course_id
    and student.student_id=marks.student_id
    where marks<40;
-- =====================================================
-- 5. DATA UPDATE OPERATIONS
-- =====================================================

-- Query 20:
-- Update the marks of student ID 7015 to 35

    update marks
    set marks=35
    where student_id=7015;
    select * from marks;
    
-- =====================================================
-- 6. DATA DELETE OPERATIONS
-- =====================================================

    -- Query 21:
-- Delete the marks record of student ID 7015

    delete from marks
    where student_id=7015;
    
    
-- =====================================================
-- 7. DATA RESTORATION
-- =====================================================

-- Query 22:
-- Reinsert the deleted marks record of student ID 7015

INSERT INTO marks (marks_id, student_id, course_id, marks)
VALUES (6015, 7015, 104, 35);





 

   







 