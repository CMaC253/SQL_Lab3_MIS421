/**
To track the changes of Title, Salary, ReportsTo, LastName, or FirstName of an Employee,
when an employee is hired, the system should insert the record of the employee in 
both tblPSMEmployee and tblPSMEmployeeAudit table. 
This trigger automates the insertion into tblPSMEmployeeAudit table.

We can use the BEGIN TRANSACTON, COMMIT/ROLLBACK TRANSACTION to ensure both insertions
are completed; otherwise, rollback. We will not implement this in this exercise

The utrEmployeeAuditInsteadOfInsert trigger will insert every new record in
tblPSMEmployee into tblPSMEmployeeAudit. It is better to write an AFTER INSERT trigger for this purpose. 
But this is a practice for you to understand the difference between INSTEAD OF and AFTER triggers.

The utrEmployeeInsteadOfUpdate will record in the tblPSMEmployeeAudit table changes of an employee's 
Title, Salary, ReportsTo, LastName, or FirstName in the tblPSMEmployee table. 

Test script:
INSERT INTO tblPSMEmployee (FirstName,LastName, Title, Salary, BirthDate, Address, City, Region, PostalCode, Country, HomePhone, ReportsTo)
values('John', 'Smith','CFO',123433, '02/02/1975', '10 A Street', 'Seattle', 'West', '98225', 'USA','3606509333',1);

select * from tblPSMEmployee;
select * from tblPSMEmployeeAudit
*/

CREATE Trigger utrEmployeeAuditInsteadOfInsert ON dbo.tblPSMEmployee
INSTEAD OF INSERT
AS
BEGIN
--Declare @employeeID
Declare @employeeID int;

--Insert into tblPSMEmployee. We can use "INSERT INTO tblPSMEmployee Column_List SELECT Column_List FROM inserted";
INSERT INTO tblPSMEmployee(FirstName,LastName, Title, Salary, BirthDate,
						   Address, City, Region, PostalCode, Country, 
						   HomePhone, ReportsTo )
SELECT FirstName,LastName, Title, Salary, BirthDate,
						   Address, City, Region, PostalCode, Country, 
						   HomePhone, ReportsTo FROM inserted
--Do NOT include EmployeeID in the Column_List, why?

--Get the EmployeeID after the insert: Set @employeeID=@@IDENTITY;

Set @employeeID = @@IDENTITY
--Insert into tblPSMEmployeeAudit. 

--We can also use "INSERT INTO tblPSMEmployeeAudit Column_List SELECT Column_List FROM inserted"; The column
--list should include all columns in tblPSMEmployeeAudit table except InsertDate and UpdateDate. See note about 
--the two columns below:
INSERT INTO tblPSMEmployeeAudit(EmployeeID,FirstName,LastName, Title, Salary, BirthDate,
						   Address, City, Region, PostalCode, Country, 
						   HomePhone, ReportsTo)
SELECT @employeeID, FirstName,LastName, Title, Salary, BirthDate,
						   Address, City, Region, PostalCode, Country, 
						   HomePhone, ReportsTo FROM inserted
/**NOTE about InsertDate and UpdateDate columns:
If the Default value of InsertDate and UpdateDate columns were not set, you can
use the built-in function getdate() to get the current system date and make it to be
the value for the two columns. In the example, the default value of the two columns have
been set. So, you don't need to supply the value for InsertDate and UpdateDate. 
Take a look at the properties of the two columns. 
*/
--When you select the columns from the inserted table to build the column_list, replace the EmployeeID column 
--with @employeeID in the list. For example: select @employeeID, LastName, FirstName from inserted. 
--EmployeeID in tblPSMEmployeeAudit table is not an identity field, so you need to provide EmployeeID for you insert statement
END