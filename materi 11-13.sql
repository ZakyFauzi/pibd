/* single table */
/* select statemant */

select *
from customers;

select customernumber, customername
from customers
where customernumber = 103;

select *
from customers
where customername = 'Atelier graphique';

select customernumber AS ID, customername "NAME"
from customers
where customernumber=103;


/* arithmetic expressions */
select customernumber, customername, creditlimit, creditlimit*1.1
from customers;

select customernumber, customername, creditlimit, creditlimit+(creditlimit*0.1)
from customers;

select creditLimit, creditLimit*2+1, creditLimit+1*2
from customers;

select creditLimit, creditLimit*2/3, creditLimit/3*2
from customers;

select max(creditLimit) 
from customers;

select count(*) "Total Order Produk"
from orderdetails
where orderNumber = 10100;

/* fungsi string */ 
select customername, lower(customerName), upper(customerName), substr(customerName,5), substr(customerName,2,5), substr(customerName,-5)
from customers;

/* fungsi date */ 
select orderDate, ADDDATE(orderdate,2), ADDTIME(orderdate,070000), MONTHNAME(orderdate), DAYOFMONTH(orderdate)
from orders;

/* wildcards */
select *
from orderdetails;

select *
from orderdetails
where productcode like 'S18%';

select *
from orderdetails
where quantityordered like '_';

/* komparasi */
select *
from orders
where customernumber < 200;

select *
from orders
where orderdate > '2003-12-29';

/* nilai null */
select *
from customers
where state is null;

select *
from customers
where state is not null;

/* operator boolean */
select *
from orderdetails
where productcode like 'S18%' or quantityOrdered<=10;

select *
from orderdetails
where productcode like 'S18%' and quantityOrdered<=10;

select *
from orderdetails
where productcode like 'S18%' or productcode like 'S10%' and quantityOrdered<=10;

select *
from orderdetails
where (productcode like 'S18%' or productcode like 'S10%') and quantityOrdered<=10;

/* between */
select *
from orderdetails
where quantityOrdered between 5 and 10;

select *
from orderdetails
where quantityOrdered not between 5 and 10;

/* distinct */
select orderNumber 
from orderdetails;

select distinct orderNumber 
from orderdetails;

/* in dan not in */
select customerName, city, country 
from customers
where country IN ("UK", "USA");

select customerName, city, country 
from customers
where country not IN ("UK", "USA");

/* order by */
select customerName, city, country 
from customers
where country IN ("UK", "USA")
order by city, customerName;

select customerName, city, country 
from customers
where country IN ("UK", "USA")
order by customerName desc;

/* group by */
select country, count(customernumber)
from customers
group by country;

/* having */
select country, count(customernumber)
from customers
group by country
having count(customernumber)>10;

/* kombinasi semua */
select country, count(customernumber)
from customers
group by country
having count(customernumber)>10
order by country desc;

/* multiple table */
/* cross join */
select *
from customers
join orders;

/* Natural Join */
select *
from customers
natural join orders;

/* Equi Join */
select *
from customers
join orders
using(customerNumber);

select *
from customers
join orders
on customers.customerNumber = orders.customerNumber;

/* inner join */
select c.customerNumber, c.customerName, o.customerNumber, o.orderNumber
from customers c 
inner join orders o
on c.customerNumber = o.customerNumber;

/* Outer Join */
/* left join */
select c.customerNumber, c.customerName, c.salesRepEmployeeNumber, e.employeeNumber, e.jobTitle
from customers c 
left join employees e 
on c.salesRepEmployeeNumber = e.employeeNumber;

/* right join */
select c.customerNumber, c.customerName, c.salesRepEmployeeNumber, e.employeeNumber, e.jobTitle
from customers c 
right join employees e 
on c.salesRepEmployeeNumber = e.employeeNumber;

/* full outer join (dengan union) */
select c.customerNumber, c.customerName, c.salesRepEmployeeNumber, e.employeeNumber, e.jobTitle
from customers c 
left join employees e 
on c.salesRepEmployeeNumber = e.employeeNumber
UNION 
select c.customerNumber, c.customerName, c.salesRepEmployeeNumber, e.employeeNumber, e.jobTitle
from customers c 
right join employees e 
on c.salesRepEmployeeNumber = e.employeeNumber;

/* self join */
select e.employeeNumber, e.firstName "EmployeeName", e.jobTitle , e2.firstName  "ManagerName", e2.jobTitle "JobManager"
from employees e 
join employees e2 
on e.reportsTo = e2.employeeNumber;

/* join 4 tabel */
select c.customerNumber, c.customerName, c.addressLine1, c.city, c.state, 
o.orderNumber, o.orderDate, p.productName, p.buyPrice, o2.quantityOrdered
from customers c join orders o join orderdetails o2 join products p 
on c.customerNumber = o.customerNumber
and o.orderNumber = o2.orderNumber
and o2.productCode = p.productCode;

/* join vs subquery */
select *
from customers
join orders 
using (customerNumber)
where orderNumber=10123;

select *
from customers
where customerNumber = 
(select customerNumber from orders where ordernumber=10123 );

/* subquery dalam where */
select *
from products
where buyprice =
(select max(buyprice) from products);

/* subquery dalam from */
select m.employeeNumber "Manager Number", e.employeeNumber , e.firstName, e.jobTitle
from (select employeeNumber from employees where jobTitle like '%Manager%') as m
join employees e 
on m.employeeNumber = e.reportsTo; 

/* subquery dalam select */
SELECT c.customerNumber, c.customerName , c.creditlimit,
(select avg(creditlimit) from customers) as avgCreditLimit
from customers c;

/* subquery berkorelasi */
SELECT c.customerNumber, c.customerName ,
(select count(*) from orders o where o.customernumber = c.customernumber) as Total
from customers c;

/* kombinasi subquery */
/* union */
select * from products where productCode like 'S18%' or productCode like 'S24%'
union
select * from products where productCode like 'S18%' or productCode like 'S32%';

/* intersect */
select * from products where productCode like 'S18%' or productCode like 'S24%'
INTERSECT 
select * from products where productCode like 'S18%' or productCode like 'S32%';
