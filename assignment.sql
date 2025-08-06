create database ass;
use ass;
/* 1. Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).

Write the SQL query to create the above table with all constraints.*/
# answer 1 
create table employees 
(emp_id int primary key not null,
 emp_name text(30) not null,
 age int check(age >= 18),
 email varchar(255) unique,
 salary decimal(10,2) default(30000)); 

/*
**Q 2 Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
examples of common types of constraints?**
  - Constraints in a database are rules enforced on the data columns of a table to limit the type of data that can be entered. Their primary purpose is to maintain data integrity, ensuring that the data stored in the database is accurate, consistent, and reliable. By preventing the entry of incorrect, duplicate, or inconsistent data, constraints help uphold business rules and preserve the logical structure and relationships within the database.
  Constraints contribute to data integrity by:
  - Enforcing Data Validity:They ensure that data conforms to predefined standards and formats, preventing invalid entries.
  1. Maintaining Consistency: They guarantee that data across related tables remains consistent, especially when modifications occur.
  2. Ensuring Uniqueness: They prevent duplicate entries where uniqueness is required, such as for identifiers.
  3. Preserving Relationships:They safeguard the relationships between different tables, ensuring referential integrity.
  - Common types of constraints include:
  1. PRIMARY KEY: Uniquely identifies each record in a table, ensuring no duplicate or null values in the designated column(s).
  2. FOREIGN KEY: Establishes a link between two tables by referencing the primary key of another table, enforcing referential integrity.
  3. UNIQUE: Ensures that all values in a column (or set of columns) are distinct, preventing duplicate entries.
  4. NOT NULL: Ensures that a column cannot contain NULL values, requiring a value for every entry in that column.
  5. CHECK: Defines a condition that all values in a column must satisfy, validating data against specific criteria (e.g., age must be greater than 0).
  6. DEFAULT: Specifies a default value for a column when no value is explicitly provided during data insertion.

**Q 3 Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justifyyour answer ?**
  - The NOT NULL constraint is applied to a column to ensure that it always contains a value and cannot be left empty or undefined.
  - A primary key, on the other hand, cannot contain NULL values; it must be unique and identify each record in a table, and NULL values would violate this uniqueness
  - Justification : A Not Null constraint can contain duplicate values but primary key can't contain the duplicate value because of its unique identification feature.

**Q 4 Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint?**
  - Adding or removing constraints on an existing SQL table involves using the ALTER TABLE command.
  -  example :->   
      ALTER TABLE Employees

      ADD CONSTRAINT UC_EmployeeEmail UNIQUE (Email);
  -     ALTER TABLE Employees

        DROP CONSTRAINT UC_EmployeeEmail;

**Q 5 Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.Provide an example of an error message that might occur when violating a constraint?**
  - Attempting to insert, update, or delete data in a way that violates database constraints results in the rejection of the operation and the generation of an error message. This mechanism ensures data integrity and consistency within the database. The database management system (DBMS) prevents the operation from completing, effectively rolling back any changes that would lead to an inconsistent state.
  - The specific consequences depend on the type of constraint violated:
    1. Primary Key Constraint Violation: Attempting to insert a row with a primary key value that already exists, or updating a primary key to a duplicate value, will be rejected.
    2. Unique Constraint Violation: Similar to primary keys, inserting or updating a value in a column or set of columns with a unique constraint to a value that already exists in another row will be rejected.
  - example : NOT NULL Constraint Violation: Attempting to insert or update a NULL value into a column defined with a NOT NULL constraint will be rejected.
  
  Msg 2627, Level 14, State 1, Line 1
  Violation of PRIMARY KEY constraint 'PK_Students'. Cannot insert duplicate key in object 'dbo.Students'. The duplicate key value is (S123).
  
  The statement has been terminated.

  - Error : -> This error message indicates that an attempt was made to insert a row into the Students table with a StudentID value of 'S123', but a primary key constraint named PK_Students was violated because 'S123' already exists in the StudentID column. The operation was terminated, meaning the data was not inserted


*/
/* Q 6. You created a products table without constraints as follows:

CREATE TABLE products (

    product_id INT,

    product_name VARCHAR(50),

    price DECIMAL(10, 2));  
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00 
*/
create table products
(product_id int primary key,
product_name varchar(50),
price decimal (10,2) default(50.00)
);
/*7. You have two tables:
Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
*/
select * from students;

create table students(
student_id int,
student_name varchar(30),
class_id int);

insert into students values 
(1,"Alice",101),
(2,"Bob",102),
(3,"Charlie",103);

select * from classes;

create table classes(
class_id int,
class_name varchar(50));
insert into classes values 
(101,"Maths"),
(102,"Science"),
(103,"History");

select student_id, student_name , students.class_id, classes.class_name from students inner join classes
on students.class_id = classes.class_id ;

/* 8. Consider the following three tables
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN)5
*/
create table orders(
order_id int ,
order_date date,
customer_id int);

insert into orders values
(1,'2024-01-01',101),
(2,'2024-01-03',102);

create table customer(
customer_id int,
customer_name varchar(50));
insert into customer values
(101,"Alice"),(102,"bob");

create table Product(
product_id int,
product_name varchar(50),
order_id int);
insert into product values
(1,"laptop",1),(2,"phone",null);

select orders.order_id ,order_date,orders.customer_id,customer.customer_name,product.product_name from orders inner join customer left join product
on orders.customer_id = customer.customer_id and orders.order_id = product.order_id;
/*9 Given the following tables:
Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.
*/
create table sales(
sale_id int ,
product_id int,
amount int );
insert into sales values(1,101,500),(2,102,300),(3,101,700);
create table products1(
product_id int,
product_name varchar(50));
insert into products1 values(101,"laptop"),(102,"Phone");

SELECT p.product_name, SUM(s.amount) AS total_sales
FROM sales s
INNER JOIN products1 p ON s.product_id = p.product_id
GROUP BY p.product_name;
/*10. You are given three tables:
Write a query to display the order_id, customer_name, and the quantity of products ordered by each
customer using an INNER JOIN between all three tables.
*/
create table orders1(
order_id int,
order_date date ,
customer_id int);
insert into orders1 values(1,'2024-01-02',1),(2,'2024-01-05',2);

create table customers(
customer_id int,
customer_name varchar(50));
insert into customers values(1,"Alice"),(2,"Bob");

create table order_details(
order_id int,
product_id int ,
quantity int );
insert into order_details values (1,101,2),(1,102,1),(2,101,3);

select orders1.order_date,orders1.order_id,orders1.customer_id,
customers.customer_name,order_details.quantity
from orders1 inner join customers on orders1.customer_id = customers.customer_id
 inner join order_details on orders1.order_id = order_details.order_id; 

/***SQL Commands**
**Q 1 Identify the primary keys and foreign keys in maven movies db. Discuss the differences?**
  - Primary Keys:

- Uniquely identify each record in a table
- Cannot contain null values
- Each table can have only one primary key
- Examples in Maven Movies DB might include:
    - movie_id in the Movies table
    - customer_id in the Customers table
    - order_id in the Orders table

Foreign Keys:

- Establish relationships between tables
- Reference the primary key of another table
- Can contain null values unless explicitly defined as NOT NULL
- Examples in Maven Movies DB might include:
    - customer_id in the Orders table referencing the Customers table
    - movie_id in the OrderItems table referencing the Movies table
    - order_id in the OrderItems table referencing the Orders table

Key differences:

- Purpose: Primary keys identify records within a table, while foreign keys link records between tables.
- Uniqueness: Primary keys require unique values, whereas foreign keys can have duplicate values.
- Nullability: Primary keys cannot be null, but foreign keys can be null unless specified otherwise.
- Relationship: Primary keys define a unique identity for table records, while foreign keys establish parent-child relationships between tables.
  - **SHOW KEYS FROM actor WHERE Key_name = 'PRIMARY'**
*/
use mavenmovies;
#**Q 2 List all details of actors?**
select * from actor_info;

#**Q 3 List all customer information from DB?**
select * from customer_list;

#**Q 4 List different countries?**
select * from country;

#**Q 5 Display all active customers?**
select * from customer where active=1;

#**Q 6 List of all rental IDs for customer with ID 1?**
select * from rental where customer_id=1;

#**Q 7 Display all the films whose rental duration is greater than 5?**
select * from film where rental_duration >5;

#**Q 8 List the total number of films whose replacement cost is greater than 15 and less than $20?**
 SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

#**Q 9 Display the count of unique first names of actors?**
SELECT COUNT(DISTINCT first_name) FROM actor;

#**Q 10 Display the first 10 records from the customer table?**
select * from customer where customer_id between 1 and 10;

#**Q 11 Display the first 3 records from the customer table whose first name starts with ‘b'?**
select * from customer where first_name like "B%" limit 3;

#**Q 12 Display the names of the first 5 movies which are rated as ‘G’?**
select * from film where rating like "G" limit 5 ;

#**Q 13 Find all customers whose first name starts with "a"?**
select * from customer where first_name like "a%";

#**Q 14 Find all customers whose first name ends with "a"?**
select * from customer where first_name like "%a";

#**Q 15 Display the list of first 4 cities which start and end with ‘a’?**
select * from city where city like "%a" or "a%";

#**Q 16 Find all customers whose first name have "NI" in any position?**
select * from customer where first_name like "%NI%";

#**Q 17 Find all customers whose first name have "r" in the second position?**
select * from customer where first_name like "_r%";

#**Q 18 Find all customers whose first name starts with "a" and are at least 5 characters in length?**
select * from customer where first_name like "a%____";

#**Q 19 Find all customers whose first name starts with "a" and ends with "o"?**
select * from customer where first_name like "a%o";

#**Q 20 Get the films with pg and pg-13 rating using IN operator?**
select * from film where rating in("pg","pg-13") order by rating;

#**Q 21 Get the films with length between 50 to 100 using between operator?**
select * from film where length between 50 and 100;

#**Q 22 Get the top 50 actors using limit operator?**
select * from actor limit 50;

#Q 23 Get the distinct film ids from inventory table?**
select DISTINCT film_id from inventory;


# **Functions**

# **Basic Aggregate Functions:**

#**Q 1 Retrieve the total number of rentals made in the Sakila database?**
select count(*) from rental;

#**Q 2 Find the average rental duration (in days) of movies rented from the Sakila database?**
SELECT avg(DATEDIFF(return_date, rental_date))as avg_rental_duration
FROM rental;

#**Q 3 Display the first name and last name of customers in uppercase?**
use sakila;
select upper(first_name),upper(last_name) from customer;#**on the sakila data**;

#**Q 4 Extract the month from the rental date and display it alongside the rental ID.?**
use sakila;
select rental_id,month(rental_date)as month from rental;#**on the sakila data**;

#**Q 5 Retrieve the count of rentals for each customer (display customer ID and the count of rentals)?**
SELECT customer_id, COUNT(rental_id) AS rental_count FROM rental
      GROUP BY customer_id;#**on the sakila data**;

#**Q 6 Find the total revenue generated by each store?**
SELECT s.store_id, SUM(p.amount) AS total_revenue FROM store s
JOIN staff st ON s.store_id = st.store_id
JOIN payment p ON st.staff_id = p.staff_id GROUP BY s.store_id;

#**Q 7 Determine the total number of rentals for each category of movies?**
use mavenmovies;
SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN  film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name ORDER BY total_rentals DESC;

#**Q 8 Find the average rental rate of movies in each language?**
select name,avg(film.rental_rate) from language
join film on language.language_id= film.language_id
group by name;

#**Q 9 Display the title of the movie, customer s first name, and last name who rented it?**
SELECT f.title AS movie_title, c.first_name, c.last_name FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id
ORDER BY f.title;

#**Q 10 Retrieve the names of all actors who have appeared in the film "Gone with the Wind."?**
SELECT a.first_name, a.last_name FROM actors a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN films f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

#**Q 11 Retrieve the customer names along with the total amount they've spent on rentals?**
select first_name,sum(amount) from customer
join rental on rental.customer_id=customer.customer_id
join payment on payment.rental_id = rental.rental_id
group by first_name;
  
#**Q 12 List the titles of movies rented by each customer in a particular city (e.g., 'London')?**
SELECT c.first_name, c.last_name, f.title AS movie_title FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.first_name, c.last_name;

#**Q 13 Display the top 5 rented movies along with the number of times they've been rented?**
select title,count(rental_id) No_of_time_rented from film    
join inventory on inventory.film_id= film.film_id
join rental on rental.inventory_id = inventory.inventory_id
group by title limit 5;

#**Q 14 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)?**
SELECT c.customer_id, c.first_name, c.last_name FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE  r.staff_id IN (SELECT staff_id FROM staff WHERE store_id IN (1, 2))
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT r.staff_id) = 2;

# **Windows Function**

#**Q 1 Rank the customers based on the total amount they've spent on rentals?**
select customer_id ,rank() over (partition by customer_id order by amount) as rank_ from payment;

#**Q 2 Calculate the cumulative revenue generated by each film over time?**
SELECT f.title AS film_title, p.payment_date,
SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.title, p.payment_date;

#**Q 3 Determine the average rental duration for each film, considering films with similar lengths?**
SELECT f.title AS film_title, f.length AS film_length, AVG(DATEDIFF(r.return_date, r.rental_date)) AS average_rental_duration FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title, f.length
ORDER BY f.length;

#**Q 4  Identify the top 3 films in each category based on their rental counts?**
SELECT c.name AS category, f.title AS film_title, COUNT(r.rental_id) AS rental_count FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.title
ORDER BY c.name, rental_count DESC limit 3;

#**Q 5 Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers?**
WITH customer_rentals AS (SELECT c.customer_id, c.first_name, c.last_name,COUNT(r.rental_id) AS total_rentals FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name),average_rentals AS (SELECT AVG(total_rentals) AS avg_rentals FROM customer_rentals)
SELECT cr.customer_id, cr.first_name, cr.last_name, cr.total_rentals, ar.avg_rentals, cr.total_rentals - ar.avg_rentals AS rental_diff
    FROM customer_rentals crCROSS JOIN average_rentals ar ORDER BY rental_diff DESC;

#**Q 6 Find the monthly revenue trend for the entire rental store over time?**
SELECT EXTRACT(YEAR FROM rental_date) AS year,EXTRACT(MONTH FROM rental_date) AS month,SUM(amount) AS total_revenue FROM rental
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY EXTRACT(YEAR FROM rental_date),EXTRACT(MONTH FROM rental_date)
ORDER BY year,month;

#**Q 7 Identify the customers whose total spending on rentals falls within the top 20% of all customers?**
WITH customer_spending AS (SELECT c.customer_id, c.first_name, c.last_name,SUM(p.amount) AS total_spending FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name),
ranked_customers AS (SELECT customer_id, first_name, last_name,
total_spending,PERCENT_RANK() OVER (ORDER BY total_spending DESC) AS spending_percentil FROM customer_spending)
SELECT customer_id, first_name, last_name, total_spending FROM ranked_customers
WHERE spending_percentile <= 0.2;

#**Q 8 Calculate the running total of rentals per category, ordered by rental count?**
WITH category_rentals AS (SELECT c.name AS category_name, COUNT(r.rental_id) AS rental_count FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN inventory i ON fc.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name),running_total AS (SELECT category_name, rental_count,SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total FROM category_rentals)
SELECT category_name, rental_count, running_totalFROM running_total
ORDER BY rental_count DESC;

# **Q 9 Find the films that have been rented less than the average rental count for their respective categories?**
WITH category_rentals AS (SELECT c.name AS category_name, f.title AS film_title, COUNT(r.rental_id) AS rental_count FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name, f.title),average_rentals AS (SELECT category_name, AVG(rental_count) AS avg_rental_count FROM category_rentals GROUP BY category_name)
SELECT cr.category_name, cr.film_title, cr.rental_count, ar.avg_rental_count FROM category_rentals cr
JOIN average_rentals ar ON cr.category_name = ar.category_name
WHERE cr.rental_count < ar.avg_rental_count
ORDER BY cr.category_name, cr.rental_count;

# **Q 10  Identify the top 5 months with the highest revenue and display the revenue generated in each month?**
SELECT EXTRACT(YEAR FROM payment_date) AS year,EXTRACT(MONTH FROM payment_date) AS month,
    SUM(amount) AS total_revenue FROM payment
GROUP BY EXTRACT(YEAR FROM payment_date),EXTRACT(MONTH FROM payment_date)
ORDER BY total_revenue DESC LIMIT 5;

# **Normalisation & CTE**

/***Q 1 First Normal Form (1NF):Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF?**
  - After examining the Sakila database, I found that the film table has a column special_features that contains a set of values (e.g., 'Trailers', 'Commentaries', etc.) separated by commas. This column violates the First Normal Form (1NF) because it contains multiple values in a single column.

film table with special_features column:

| film_id | title | special_features |
| --- | --- | --- |
| 1 | Film1 | Trailers, Commentaries |
| 2 | Film2 | Deleted Scenes, Behind the Scenes |

Normalizing to 1NF:

To normalize the film table to achieve 1NF, we can create a new table film_special_features that contains each special feature as a separate row.

New Table:

film_special_features table:

| film_id | special_feature |
| --- | --- |
| 1 | Trailers |
| 1 | Commentaries |
| 2 | Deleted Scenes |
| 2 | Behind the Scenes |

code : CREATE TABLE film_special_features (
  
  film_id INT,
  
  special_feature VARCHAR(50),
  
  PRIMARY KEY (film_id, special_feature),
  
  FOREIGN KEY (film_id) REFERENCES film(film_id)
);

INSERT INTO film_special_features (film_id, special_feature)

SELECT film_id, special_feature

FROM film, UNNEST(STRING_TO_ARRAY(special_features, ', ')) AS special_feature;


**Q 2 Second Normal Form (2NF):Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it ?**
  - To determine whether a table in the Sakila database is in Second Normal Form (2NF), let's examine the film_actor table. This table has a composite primary key consisting of film_id and actor_id, and it contains no other columns besides these two foreign keys. Given its structure, the film_actor table is likely in 2NF because it doesn't have non-key attributes that could partially depend on only one part of the primary key.

However, consider a hypothetical table that combines film information with actor information and rental data, like this:

| film_id | actor_id | film_title | actor_name | rental_date |
| --- | --- | --- | --- | --- |

In this case, film_title depends only on film_id, and actor_name depends only on actor_id. This setup violates 2NF because non-key attributes (film_title and actor_name) depend on only a part of the composite primary key (film_id and actor_id).

Steps to Normalize to 2NF:

1. Identify Partial Dependencies: Determine which non-key attributes depend on only one part of the composite primary key. In our example, film_title depends on film_id, and actor_name depends on actor_id.

2. Create New Tables: Create separate tables for each partial dependency, with the determinant as the primary key. We would create:
    - A films table with film_id as the primary key and film_title as an attribute.
    - An actors table with actor_id as the primary key and actor_name as an attribute.

3. Reassign Dependent Attributes: Move the dependent attributes to their respective new tables. The original table would retain the composite primary key (film_id, actor_id) and any attributes that depend on the entire key, like rental_date might if it were part of this hypothetical table.

Resulting Tables:

- films table:
    - film_id (primary key)
    - film_title

- actors table:
    - actor_id (primary key)
    - actor_name

- film_actor table:
    - film_id (foreign key referencing films.film_id)
    - actor_id (foreign key referencing actors.actor_id)
    - Any other attributes that depend on the entire composite key

**Q 3 Third Normal Form (3NF):Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF?**
  - To identify a table in the Sakila database that violates Third Normal Form (3NF), let's examine the address table. This table contains columns such as address_id, address, address2, district, city_id, postal_code, and potentially others that might depend on city_id or other non-key attributes indirectly.

Potential Transitive Dependency:

If we consider a scenario where city_id determines city, and city determines additional attributes like country_id (assuming country_id is not directly in the address table but in a city table), this would represent a transitive dependency. The dependency chain would be address_id -> city_id -> city -> country_id. Here, country_id depends on city_id transitively through city.

Steps to Normalize to 3NF:

1. Identify the Transitive Dependency: Confirm the dependency chain, such as address_id -> city_id -> city -> country_id.

2. Create Separate Tables: Ensure each non-key attribute depends directly on the primary key. For the address table, we'd ideally want:
    - An address table with address_id as the primary key and direct dependencies like address, address2, district, city_id, and postal_code.
    - A city table with city_id as the primary key and city name, potentially country_id if not already separated.

3. Remove Transitive Dependencies: If city determines country_id, we'd have:
    - address table: (address_id, address, address2, district, city_id, postal_code)
    - city table: (city_id, city, country_id)
    - Potentially a country table if country_id has additional attributes.

**Q 4 Normalization Process:Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2N?**
  - The film table has the following columns:

| Column Name | Description |
| --- | --- |
| film_id | Unique identifier for the film |
| title | Title of the film |
| description | Brief description of the film |
| release_year | Release year of the film |
| language_id | Foreign key referencing the language table |
| original_language_id | Foreign key referencing the language table |
| rental_duration | Rental duration in days |
| rental_rate | Rental rate per day |
| length | Length of the film in minutes |
| replacement_cost | Cost to replace the film |
| rating | Rating of the film (e.g., G, PG, R) |
| special_features | Special features of the film (e.g., Trailers, Commentaries) |
| last_update | Timestamp for the last update |

First Normal Form (1NF):

The film table is already in 1NF because each cell contains a single value. However, the special_features column contains multiple values separated by commas, which violates 1NF.

To normalize the film table to 1NF, we can create a new table film_special_features with the following columns:

| Column Name | Description |
| --- | --- |
| film_id | Foreign key referencing the film table |
| special_feature | Special feature of the film |

1NF Tables:
film table:

| Column Name | Description |
| --- | --- |
| film_id | Unique identifier for the film |
| title | Title of the film |
| description | Brief description of the film |
| release_year | Release year of the film |
| language_id | Foreign key referencing the language table |
| original_language_id | Foreign key referencing the language table |
| rental_duration | Rental duration in days |
| rental_rate | Rental rate per day |
| length | Length of the film in minutes |
| replacement_cost | Cost to replace the film |
| rating | Rating of the film (e.g., G, PG, R) |
| last_update | Timestamp for the last update |

film_special_features table:

| Column Name | Description |
| --- | --- |
| film_id | Foreign key referencing the film table |
| special_feature | Special feature of the film |

Second Normal Form (2NF):

The film table is already in 2NF because it doesn't have a composite primary key.

However, if we consider a hypothetical table that combines film information with rental data, like this:

| Column Name | Description |
| --- | --- |
| film_id | Unique identifier for the film |
| title | Title of the film |
| rental_date | Date the film was rented |
| rental_rate | Rental rate per day |

In this case, title depends only on film_id, and rental_rate might depend on the film or the rental date. To normalize this table to 2NF, we would create separate tables for films and rentals.

2NF Tables:

film table:

| Column Name | Description |
| --- | --- |
| film_id | Unique identifier for the film |
| title | Title of the film |
| description | Brief description of the film |
| release_year | Release year of the film |
| language_id | Foreign key referencing the language table |
| original_language_id | Foreign key referencing the language table |
| rental_duration | Rental duration in days |
| rental_rate | Rental rate per day |
| length | Length of the film in minutes |
| replacement_cost | Cost to replace the film |
| rating | Rating of the film (e.g., G, PG, R) |
| last_update | Timestamp for the last update |

rental table:

| Column Name | Description |
| --- | --- |
| rental_id | Unique identifier for the rental |
| film_id | Foreign key referencing the film table |
| rental_date | Date the film was rented |
| return_date | Date the film was returned |

*/
#**Q 5 CTE Basics:Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables?**
WITH actor_film_count AS (SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name)
SELECT CONCAT(first_name, ' ', last_name) AS actor_name,film_count FROM actor_film_count
ORDER BY film_count DESC;

#**Q 6 CTE with Joins:Create a CTE that combines information from the film and language tables to display the film title,language name, and rental rate?**
WITH film_language_info AS (SELECT f.title AS film_title,l.name AS language_name,f.rental_rate FROM film f
JOIN language l ON f.language_id = l.language_id)
SELECT film_title,language_name,rental_rate FROM film_language_info
ORDER BY film_title;

#**Q 7 CTE for Aggregation:Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables?**
WITH customer_revenue AS (SELECT c.customer_id,c.first_name,c.last_name,SUM(p.amount) AS total_revenue FROM customer c    
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id,c.first_name, c.last_name)
SELECT customer_id,CONCAT(first_name, ' ', last_name) AS customer_name,total_revenue FROM customer_revenue
ORDER BY total_revenue DESC;

#**Q 8 CTE with Window Functions:Utilize a CTE with a window function to rank films based on their rental duration from the film table?**
WITH ranked_films AS (SELECT title,rental_duration,RANK() OVER (ORDER BY rental_duration DESC) AS rental_rank FROM film)
SELECT title,rental_duration,rental_rank FROM ranked_films
ORDER BY rental_rank;

#**Q 9 CTE and Filtering: Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details?**
WITH frequent_customers AS (SELECT customer_id,COUNT(rental_id) AS rental_count FROM rental
GROUP BY customer_id
HAVING COUNT(rental_id) > 2)
SELECT c.customer_id,c.first_name,c.last_name,c.email,fc.rental_count FROM customer c
JOIN frequent_customers fc ON c.customer_id = fc.customer_id
ORDER BY fc.rental_count DESC;

# **Q 10 CTE for Date Calculations: Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from  the rental table?**
WITH monthly_rentals AS (
  SELECT YEAR(rental_date) AS rental_year,MONTH(rental_date) AS rental_month,COUNT(rental_id) AS total_rentals FROM rental
  GROUP BY YEAR(rental_date),MONTH(rental_date))
SELECT rental_year,rental_month,total_rentals FROM monthly_rentals
ORDER BY rental_year,rental_month;

#**Q 11 CTE and Self-Join:Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table?**
SELECT a1.first_name AS actor1_first_name,a1.last_name AS actor1_last_name,a2.first_name AS actor2_first_name,a2.last_name AS actor2_last_name,f.title AS film_title FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
    JOIN actor a1 ON fa1.actor_id = a1.actor_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
    JOIN film f ON fa1.film_id = f.film_id
    ORDER BY f.title;

#**Q 12 CTE for Recursive Search:Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column?**
WITH RECURSIVE employee_hierarchy AS (
  -- Anchor query: select the manager
  SELECT 
    staff_id,
    first_name,
    last_name,
    reports_to,
    0 AS level
  FROM 
    staff
  WHERE 
    staff_id = ?  -- specify the manager's staff_id

  UNION ALL

  -- Recursive query: select employees who report to the manager or their subordinates
  SELECT 
    s.staff_id,
    s.first_name,
    s.last_name,
    s.reports_to,
    level + 1
  FROM 
    staff s
  JOIN 
    employee_hierarchy m ON s.reports_to = m.staff_id
)
SELECT 
  staff_id,
  first_name,
  last_name,
  reports_to,
  level
FROM 
  employee_hierarchy
ORDER BY 
  level;