/*Database Creation & Table Setup*/
create database coffe_shop;
show databases;
use coffe_shop;
show tables;
select* from coffe_px;
/* Check Table Structure*/
desc coffe_px;
/* Product  Table Data Cleaning & Column Modifications*( Modify Column Data Types )*/
alter table coffe_px  modify product_id varchar(30) not null;
alter table coffe_px modify product_name varchar(30) not null ;
alter table coffe_px  modify size varchar(30) ;
alter table coffe_px  modify product_category varchar(30) not null;
alter table coffe_px  modify customer_id varchar(30) not null;
/*Check for Null or Blank Values of Product Table*/
select* from coffe_px;
select *from coffe_px where product_id is null or product_id  = '';
select *from coffe_px where product_name is null or product_id  = '';
select *from coffe_px where product_category is null or product_id  = '';
select *from coffe_px where customer_id is null or product_id  = '';
update coffe_px set size = null where trim(size) ='';
/* Fill or Format Missing/Incorrect Data*/
update coffe_px set size ='Medium'where size is Null;
update coffe_px set product_category =concat ( upper(left(product_category ,1)),
lower(substring(product_category ,2))
)
where product_category is not null;
Update coffe_px set product_category ='Drink Food' where product_category ='Drink food';
update coffe_px set product_name = concat (upper(left(product_name, 1)),
lower(substring(product_name ,2))
)
where product_name is not null;
/*Check Table Structure*/
desc coffe_loy;
/*Loyalty Table Data Cleaning & Column Modifications Modify Column Data Types*/
alter table coffe_loy modify loyalty_id varchar(30) not null;
alter table coffe_loy modify loyalty_points varchar(30) not null;
alter table coffe_loy modify points_redeemed varchar(30) not null;
alter table coffe_loy modify points_balance varchar(30) not null;
alter table coffe_loy modify product_category varchar(30) not null;
alter table coffe_loy modify customer_id varchar(30) not null;
/*Check for Null or Blank Values*/
select* from coffe_loy;
select * from coffe_loy where loyalty_id is null or trim(loyalty_id) ='';
select * from coffe_loy where loyalty_points is null or trim(loyalty_points) ='';
select * from coffe_loy where points_redeemed is null or trim(points_redeemed)='';
select * from coffe_loy where points_balance is null or trim(points_balance) ='';
select * from coffe_loy where product_category is null or trim(product_category) ='';
select * from coffe_loy where customer_id is null or trim(customer_id) ='';
/* Fill or Format Missing/Incorrect Data*/
update coffe_loy set product_category =concat( upper (left(product_category,1)),
(lower(substring(product_category ,2)))
)
where product_category is not null;
update coffe_loy set product_category ='Drink Food'where product_category = 'Drink food';
/*Check Table Structure*/
desc coffe_cx;
/*Customer Table Data Cleaning & Column Modifications( Modify Column Data Types)*/
select* from coffe_cx;
alter table  coffe_cx drop column MyUnknownColumn ;
alter table  coffe_cx drop column `MyUnknownColumn_[0]`;
alter table  coffe_cx drop column `MyUnknownColumn_[2]`;
alter table  coffe_cx drop column `MyUnknownColumn_[3]`;
alter table  coffe_cx drop column `MyUnknownColumn_[4]`;
alter table  coffe_cx modify customer_id varchar(30) not null;
alter table  coffe_cx modify customer_name varchar(30) not null;
alter table  coffe_cx modify phone_number varchar(30) not null;
/*Check for Null or Blank Values*/
select * from coffe_cx where customer_id is  null or trim(customer_id)= '';
select * from coffe_cx where phone_number is  null or trim(phone_number)= '';
/*Check Table Structure*/
desc coffe_oxx;
/* Order Table Data Cleaning & Column Modifications( Modify Column Data Types)*/
select * from coffe_oxx;
alter table coffe_oxx modify order_id varchar(30) not null;
alter table coffe_oxx modify order_amount varchar(30) ;
alter table coffe_oxx modify payment_mode varchar(30)  null;
alter table coffe_oxx modify quantity int not null;
alter table coffe_oxx modify  order_date date ;
alter table coffe_oxx modify customer_id varchar(30) not null;
/*Check for Null or Blank Values*/
select * from coffe_oxx where order_amount is  null or trim(order_amount)='';
select * from coffe_oxx where payment_mode is  null or trim(payment_mode)='';
select * from coffe_oxx where order_date is  null or trim(order_date)='';
select * from coffe_oxx where customder_id is  null or trim(customer_id)='';
/* Fill or Format Missing/Incorrect Data*/
update coffe_oxx
set payment_mode =concat( 
upper(left(payment_mode ,1)),
lower(substring(payment_mode, 2))
)
where payment_mode is not null;
update  coffe_oxx set quantity ='1' where quantity ='0';
/*Customer Analysis*/
/* All Customers Records*/
select*from coffe_cx;
/* Total Customers*/
select count(customer_id) as total_customers from coffe_cx;
/*Customer Count by Payment Mode*/
select coffe_oxx.payment_mode , count(coffe_cx.customer_id) as total_customers from coffe_cx
inner join coffe_oxx on coffe_cx.customer_id =coffe_oxx.customer_id group by payment_mode;
/*Customer Count by Quantity Purchased*/
select coffe_oxx.quantity , count(coffe_cx.customer_id) as total_customers from coffe_cx
inner join coffe_oxx on coffe_cx.customer_id =coffe_oxx.customer_id group by quantity;
/*Customer Count by Product Category*/
select coffe_px.product_category , count(coffe_cx.customer_id) as total_customers from coffe_cx
inner join coffe_px on coffe_cx.customer_id =coffe_px.customer_id group by product_category;
/*Customer Count by Product Name*/
select coffe_px.product_name , count(coffe_cx.customer_id) as total_customers from coffe_cx
inner join coffe_px on coffe_cx.customer_id =coffe_px.customer_id group by product_name;
/*Product Analysis*/
/* All Product Records*/
select * from coffe_px;
/* Total Orders by Product Name*/
select product_name, count(*)  as total_orders from coffe_px group by product_name order by  total_orders desc;
 /*Total Orders by Product Category*/
select product_category, count(*)  as total_orders from coffe_px group by product_category order by  total_orders desc;
/*Total Orders by Product Size */
select size, count(*)  as total_orders from coffe_px group by size order by  total_orders desc;
/* Order Analysis * ( Revenue & Quantity Overview) */
/* All Order  Records*/
select * from coffe_oxx;
/* Total Revenue Generated*/
select sum(order_amount) as total_revenue from coffe_oxx;
/* Average Revenue Per Order*/
select avg(order_amount) as Average_revenue from coffe_oxx;
/*Total Quantity of Items Ordered*/
select sum(quantity) as total_quantity from coffe_oxx;
/*Average Quantity Per Order*/
select avg(quantity) as average_quantity from coffe_oxx;
/* Revenue by Payment Mode*/
/* Total Revenue by Payment Mode*/
select payment_mode, sum(order_amount) as total_orders from coffe_oxx group by payment_mode;
/* Average Revenue by Payment Mode*/
select payment_mode, avg(order_amount) as average_orders from coffe_oxx group by payment_mode;
/* Total Revenue by Quantity*/
select quantity, sum(order_amount) as total_orders from coffe_oxx group by quantity;
/* Average Revenue by Quantity */
select quantity, avg(order_amount) as average_orders from coffe_oxx group by quantity;
/* Recent Orders & Trends */
/*Orders in the Last 30 Days*/
select * from coffe_oxx where order_date >= curdate() -interval 30 day;
/* Number of Orders by Date */
select order_date ,count(order_id) from coffe_oxx group by order_date order  by order_date;
/*Order Frequency and Value by Date*/
select order_date, order_amount, count(order_id) from coffe_oxx group by order_date, order_amount  order  by order_date, order_amount desc;
/* Customer Spending Insights*/
/* Top Spending Customer*/
select customer_id, sum(order_amount) as total_spent from coffe_oxx group by  customer_id order by total_spent desc limit 1;
/* Least Spending Customer */
select customer_id, sum(order_amount) as total_spent from coffe_oxx group by  customer_id order by total_spent asc limit 1;
/* Loyalty Program Overview*/
/* All Loyalty Records*/
select * from coffe_loy;
/*Total Number of Loyalty Customers*/
select  count(loyalty_id) as total_loyalty_customers from coffe_loy ;
/* Points Redeemed Analysis*/
/*Total Points Redeemed by Each Customer*/
select loyalty_id, sum(points_redeemed) from coffe_loy group by loyalty_id order by loyalty_id desc;
/*Top 5 Customers by Points Redeemed */
select loyalty_id, sum(points_redeemed) from coffe_loy group by loyalty_id order by loyalty_id desc limit 5;
/*Points Balance Analysis*/
/*Total Points Balnce by Each Customer*/
select loyalty_id, sum(points_balance) from coffe_loy group by loyalty_id order by loyalty_id desc;
/* Top 5 Customers by Points Balance */
select loyalty_id, sum(points_balance) from coffe_loy group by loyalty_id order by loyalty_id desc limit 5;
/* Category-Wise Points Analysis */
/*Points Balance by Customer and Category*/
select loyalty_id, product_category, sum(points_balance) from coffe_loy group by loyalty_id,product_category order by loyalty_id , 
product_category desc ;
/*Top 5 Records of Points Balance by Customer and Category*/
select loyalty_id, product_category, sum(points_balance) from coffe_loy group by loyalty_id,product_category order by loyalty_id , 
product_category desc limit 5;
/*Points Redeemed by Customer and Category*/
select loyalty_id, product_category, sum(points_redeemed) from coffe_loy group by loyalty_id,product_category order by loyalty_id , 
product_category desc ;
/* Top 5 Records of Points Redeemed by Customer and Category*/
select loyalty_id, product_category, sum(points_redeemed) from coffe_loy group by loyalty_id,product_category order by loyalty_id , 
product_category desc limit 5;
/* Ranking  Analysis */
/* Top Customers by Total Spending (Ranked)*/
select customer_id, sum(order_amount) as total_amount,
rank() over (order by sum(order_amount) desc) as rank_by_spending_amount
from coffe_oxx group by customer_id;
/*Top Payment Modes by Revenue*/
select payment_mode, sum(order_amount) as total_amount,
rank() over (order by sum(order_amount) desc) as rank_by_spending_amount
from coffe_oxx group by payment_mode;
/* Top Customers by Loyalty Points Earned*/
select customer_id, sum(loyalty_points) as total_loyalty_points,
rank() over (order by sum(loyalty_points) desc) as rank_loyalty_points
from coffe_loy group by customer_id;
/* Product Categories with Most Loyalty Points Earned*/
select product_category, sum(loyalty_points) as total_loyalty_points,
rank() over (order by sum(loyalty_points) desc) as rank_loyalty_points
from coffe_loy group by product_category;
/* Top Customers by Points Redeemed*/
select customer_id, sum(points_redeemed) as total_points_redeemed,
rank() over (order by sum(points_redeemed) desc) as rank_by_points_redeemed
from coffe_loy group by customer_id;
/*  Top Product Categories by Points Redeemed*/
select product_category, sum(points_redeemed) as total_points_redeemed,
rank() over (order by sum(points_redeemed) desc) as rank_by_points_redeemed
from coffe_loy group by product_category;
/*Product Categories with Highest Points Balance*/
select product_category, sum(points_balance) as total_points_balance,
rank() over (order by sum(points_redeemed) desc) as rank_by_points_balance
from coffe_loy group by product_category;
/* Customers with Highest Points Balance*/
select customer_id, sum(points_balance) as total_points_balance,
rank() over (order by sum(points_redeemed) desc) as rank_by_points_balance
from coffe_loy group by customer_id;
/* Most Ordered Products*/
select product_name, count(*) as total_orders,
rank() over (order by count(*) desc) as rank_by_total_orders
from coffe_px  group by product_name;
/* High Revenue Days (Sales > ₹500)  CTE (Common Table Expression)*/
with daily_sales AS (
  select  order_date, sum(order_amount) AS total_sales
  from coffe_oxx group by order_date
)
select  * from daily_sales where  total_sales > 500;
/* Loyalty Analysis with Conditions*/
select customer_id , sum(points_redeemed) as total_redeemed, 
case
when sum(points_redeemed) > 100 then 'Highly Redeemer'
else 'Regular'
end as loyalty_segment 
from coffe_loy group by customer_id;