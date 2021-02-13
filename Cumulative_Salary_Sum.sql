-- CUMULATIVE SALARY SUM

-- The following table holds monthly salary information for several employees. 
-- Write a query to get, for each month, the cumulative sum of an employee’s salary over a period of 3 months, 
-- excluding the most recent month. The result should be ordered by ascending employee ID and month

create database if not exists practicedb;
use practicedb;

create table if not exists employee (
id integer not null, 
pay_month integer, 
salary integer);
/*
insert into employee (id, pay_month, salary)
VALUES
(1, 1, 20),
(2, 1, 20),
(1, 2, 30),
(2, 2, 30),
(3, 2, 40),
(1, 3, 40),
(3, 3, 60),
(1, 4, 60),
(3, 4, 70);
*/
select * from employee;

with t1 as (
select * , rank() over (partition by id order by pay_month desc) as rank_pay_month 
from employee
)
select id, pay_month, salary, sum(salary) over (partition by id order by pay_month) as cumulative_salary   
from t1 
where rank_pay_month > 1 
and rank_pay_month < 5 
order by id, pay_month;

