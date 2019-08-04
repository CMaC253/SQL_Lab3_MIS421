--Colin McDonald
--MIS 421
--Individual Assigment C
--4/30/19

--1)
select Products.ProductID, ProductName,
	Warehouse.WarehouseID, WarehouseCity, WarehouseState
from Products join Warehouse
	on Products.WarehouseID = Warehouse.WarehouseID
where WarehouseCity = 'Westboro' or WarehouseCity = 'Boston'

--2)
select Products.ProductID, ProductName,
	Warehouse.WarehouseID, WarehouseCity, WarehouseState
from Products join Warehouse
	on Products.WarehouseID = Warehouse.WarehouseID
where Warehouse.WarehouseCity not in ('Westboro' ,'Boston');

--3)
select rtrim(Products.ProductName) + 
	   ' is in a warehouse in ' +
	   rtrim(Warehouse.WarehouseCity)
	   as ProductLocation
from Products join Warehouse
	on Products.WarehouseID = Warehouse.WarehouseID;

--4)
select ProductID, ProductName, WarehouseID 
from Products
where WarehouseID in
	(select WarehouseID from Warehouse
	 where ManagerName = 'Margaret Peacock');

--5)
select ProductID, ProductName, 
	   Warehouse.WarehouseCity 
from Products join Warehouse
	on Products.WarehouseID = Warehouse.WarehouseID
	 where ManagerName = 'Anne Dodsworth';

--6)
select ProductID, ProductName,
	   Warehouse.WarehouseCity
from Products, Warehouse
where Products.WarehouseID = Warehouse.WarehouseID
and ManagerName='Anne Dodsworth';	

--7) Why can't we use a subquery?
-- Because a subquery can only be used to retrieve
-- data from the outer table.

--8)
select WarehouseID,
	   sum(UnitsInStock) as TotalproductsInStock,
	   avg(UnitsOnOrder) as AvergaeUnitsOnOrder
from Products
where WarehouseID in
	(select WarehouseID from Warehouse
	 where ManagerName = 'Robert King')
	 group by WarehouseID;

--9) 
select Products.WarehouseID,
	   sum(UnitsInStock) as TotalproductsInStock,
	   avg(UnitsOnOrder) as AvergaeUnitsOnOrder
from Products join Warehouse
	on Products.WarehouseID = Warehouse.WarehouseID
	 where ManagerName = 'Robert King'
	 group by Products.WarehouseID;

--10)
select p.WarehouseID, WarehouseCity,
	   sum(UnitsInStock) as TotalProductsInStock,
	   sum(UnitsOnOrder) as TotalProductsOnOrder
from Products as p
left outer join Warehouse as w
on p.WarehouseID = w.WarehouseID
group by p.WarehouseID, WarehouseCity
order by p.WarehouseID asc;

--11)
select * from Warehouse as w
left outer join Products as p
on w.WarehouseID = p.WarehouseID;

--12)
--Via the data provided, the following 4 warehouses
--Columbia, Atlanta, Chicago and Denver did not have
--products

--13)
select ProductID, ProductName from Products
where not exists (select * from
OrderDetails where OrderDetails.ProductID =
Products.ProductID);

--14)
--Show orderId and Order date from Orders and OrderDetails
--not sure about this
select Orders.OrderID, OrderDate, count(Quantity) as NumberOfProducts
from OrderDetails join Orders
	on Orders.OrderID = OrderDetails.OrderID
	group by orders.OrderID, OrderDate
	having count(Quantity) > 3
	order by count(Quantity);

--15)
--Include records that exists 
select LastName, FirstName, Address, City,
	   PostalCode, Country, Phone
from IndividualCustomers 
union
select LastName, FirstName, Address, City,
	   PostalCode, Country, HomePhone
from Employees;

--16)
select LastName, FirstName, Address, City,
	   PostalCode, Country, Phone
from IndividualCustomers 
intersect
select LastName, FirstName, Address, City,
	   PostalCode, Country, HomePhone
from Employees;

--17)
select LastName, FirstName, Address, City,
	   PostalCode, Country, Phone
from IndividualCustomers 
except
select LastName, FirstName, Address, City,
	   PostalCode, Country, HomePhone
from Employees;