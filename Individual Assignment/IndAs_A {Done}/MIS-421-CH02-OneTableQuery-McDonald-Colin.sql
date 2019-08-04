
--1
select * 
from Products

--2
select CategoryID, CategoryName, Description, Picture 
from Categories

--3
select Description, CategoryID 
from Categories

--4
select distinct ProductID  
from OrderDetails

--5
select * 
from Products
where UnitsInStock < 20

--6
select CategoryName,ProductName 
from Products 
where UnitsInStock = 0 AND UnitsOnOrder > 10

--7	
select CategoryName, ProductID, ProductName 
from Products  
where UnitsInStock = 0 OR UnitsOnOrder > UnitsInStock 
order by CategoryName desc 

--8
select CategoryName, ProductID, ProductName, UnitsInStock 
from Products 
where UnitsInStock Between 2 And 9

--9
select CategoryName, ProductName 
from Products 
where ProductName Like 'Ch%'

--10 
select CategoryName, ProductName 
from Products 
where ProductName Like '%Tofu%'

--11
select CategoryName, ProductName 
from Products 
where ProductName Like '____s%'

--12 
select rtrim(CategoryName) + '-' + rtrim(ProductName) as Category_Product 
from Products

--13
select SUM(UnitsInStock) as SumUnitsInStock,
	   AVG(UnitsInStock) as AvgUnitsInStock,
	   MAX(UnitsInStock) as MaxUnitsInStock,
	   MIN(UnitsInStock) as MinUnitsInStock
from Products

--14 Difference between the SQL built-in functions COUNT and SUM
	--The Difference is COUNT is counting the number of values in a column
	--Sum is adding up the range of values in the column
	
--15
select ProductID, COUNT(*) as NumOfTimesOrdered 
from OrderDetails
group by ProductID

--16
select CategoryID,CategoryName, SUM(UnitsInStock) as TotalProductsOnHand
from Products
where UnitsInStock <= 100
group by CategoryID, CategoryName
having SUM(UnitsInStock) > 200
order by TotalProductsOnHand desc

--17 Was where or having applied first?
--	'Where' comes first because it places filters on rows
--	'Having' takes place after grouping therefore can't be
--	executed before 'Where'