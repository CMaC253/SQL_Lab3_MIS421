/**
The tblPSMOrder table does not have a column for the grand total with discount of all ordered products. 
Create a function that calculates the grand total with discount of all purchased products in an order.
a.	Name the function as ufnGetOrderGrandTotalWithDiscount
b.	The function takes this parameter: @OrderID int
c.	Note this function use both tblPSMOrder and tblPSMOrderDetail tables.
d.	This function uses a cursor to process each product in an order

Test script:
select * from tblPSMOrder;
select * from tblPSMOrderDetail;
select OrderID, dbo.ufnGetOrderGrandTotalWithDiscount(OrderID) as 'Grand Total with discount' from tblPSMOrder;
*/
CREATE FUNCTION dbo.ufnGetOrderGrandTotalWithDiscount (@orderID int)
returns float
AS
BEGIN
--Declare local variables: 
--@grandTotal float, @unitPrice float, @quantity int, @discount float
DECLARE @grandTotal float, @unitPrice float, @quantity int, @discount float
--Initiate the local variables
SET @grandTotal=0;
SET @unitPrice=0;
SET @quantity=0;
SET @discount=0;
--Declare a cursor to get all products from an order
DECLARE cs CURSOR FOR select UnitPrice, Quantity, Discount from tblPSMOrderDetail where OrderID=@orderID;
--Open the cursor
 OPEN cs;
--Fetch UnitPrice, Quantity, and Discount into @unitPrice, @quantity, and @discount
FETCH next from cs INTO @unitPrice, @quantity, @discount
--Use @@FETCH_STATUS to check if there are more records in the cursor
--@@FETCH_STATUS=0 --> it successfully fetched a row; @@FETCH_STATUS=-1 --> no more
WHILE @@FETCH_STATUS=0
BEGIN
	--calculate the grand total without discount
	SET @grandTotal = @grandTotal + @unitPrice * @quantity * (1-@discount)
	--fetch next row from the OrderDetail table with the same OrderID
	FETCH next from cs INTO @unitPrice, @quantity, @discount
END
--close the cursor
CLOSE cs;
--deallocate the cursor in memory
DEALLOCATE cs;
--return @grandTotal
RETURN @grandTotal
END