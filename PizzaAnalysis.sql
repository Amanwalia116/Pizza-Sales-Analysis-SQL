create database project;
use project;

create table pizzas(
pizz_id varchar(20),
pizz_type_id varchar(20),
size varchar(4),
price decimal(6,2)
);
select * from pizzas;

create table pizzas_type(
pizz_type_id varchar(50),
name varchar(50),
category varchar(50),
ingredients varchar(140)
);
select * from pizzas_type;

create table orders(
order_id int(10),
date1 date,
time1 time);
select * from orders where order_id = 21350;

create table order_details_id(
order_details_id int(10),
order_id int(10),
pizza_id varchar(20),
quantity int(10));
select * from order_details_id;
select * from pizzas;
select * from pizzas_type;
select * from orders;
select * from order_details_id where order_details_id = 48620;


-- 1. Retrieve the total number of orders placed
select count(order_details_id) as Total_orders from order_details_id

-- 2. Calculate the total revenue generated from pizza sales.
select sum(s.quantity * p.price) as revenue from order_details_id s
join pizzas p on s.pizza_id = p.pizz_id;

-- 3. Identify the highest-priced pizza.
select name, price from pizzas_type p join pizzas s on p.pizz_type_id = s.pizz_type_id
order by price desc limit 1;

-- 4. Identify the most common pizza size ordered
select p.size, count(*) as total from order_details_id s join pizzas p on s.pizza_id =p.pizz_id
group by p.size order by total desc limit 1;

select p.size, sum(s.order_id) as total from order_details_id s join pizzas p on s.pizza_id =p.pizz_id
group by p.size order by total desc limit 1;

-- 5. List the top 5 most ordered pizza types along with their quantities
select t.pizz_type_id, sum(q.quantity) as total from order_details_id q join pizzas t 
on q.pizza_id =t.pizz_id group by pizz_type_id order by total desc limit 5;

-- 6. Join the necessary tables to find the total quantity of each pizza category ordered.
select pt.category as pizzaname, sum(q.quantity) as total from order_details_id q join pizzas t
on q.pizza_id =t.pizz_id join pizzas_type pt on t.pizz_type_id = pt.pizz_type_id
group by pizzaname order by total desc limit 5;


 -- 7. Determine the distribution of orders by hour of the day.
SELECT HOUR(time1) AS order_hour, COUNT(order_id) AS total_orders
FROM orders GROUP BY order_hour ORDER BY order_hour;


-- 8. Join relevant tables to find the category-wise distribution of pizzas?
SELECT pizzas_type.category AS Category, SUM(order_details_id.quantity) AS Total_quantity
FROM order_details_id JOIN pizzas ON order_details_id.pizza_id = pizzas.pizz_id
join pizzas_type ON pizzas_type.pizz_type_id = pizzas.pizz_type_id
GROUP BY Category order by Total_quantity DESC;

-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.

select date(orders.date1) as ordered_date, avg(order_details_id.quantity) as Average_orders FROM
orders JOIN order_details_id on orders.order_id = order_details_id.Order_id
GROUP BY ordered_date order by Average_orders desc limit 3;

-- 10. determine the top 3 most ordered pizza types based on revenue?
SELECT pizzas_type.name AS PIZZA_TYPES, SUM(order_details_id.quantity * pizzas.price) AS Revenue
FROM order_details_id JOIN pizzas ON order_details_id.pizza_id = pizzas.pizz_id JOIN pizzas_type ON
pizzas_type.pizz_type_id = pizzas.pizz_type_id GROUP BY PIZZA_TYPES ORDER BY revenue DESC LIMIT 3;
