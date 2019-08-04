/**
This trigger will record in tblPSMEmployeeAudit table changes in an employee's 
Title, Salary, ReportsTo, LastName, or FirstName in the tblPSMEmployee table. 
We can also develop an after insert triger for tblPSMEmployee to ensure any newly inserted
row in tblPSMEmployee is also inserted into tblPSMEmployeeAudit table

If you haven't created the tables for the exercise, load In-Class Example-Exercise Preparation.sql
into SSMS from Canvas in Module 7 and execute it against your individual database

The utrEmployeeAuditInsteadOfInsert trigger will insert every new record in
tblPSMEmployee into tblPSMEmployeeAudit

Test script
Select * from tblPSMEmployee;
Select * from tblPSMEmployeeAudit;
--No recording in tblPSMEmployeeAudit
UPDATE tblPSMEmployee SET City='Kirkland', Address='111 A Street' WHERE EmployeeID=1;
--New recording in tblPSMEmployeeAudit
UPDATE tblPSMEmployee SET Title='Senior Sales Representative', Salary=55500 WHERE EmployeeID=1;

*/

CREATE Trigger utrEmployeeAuditInsteadOfUpdate ON dbo.tblPSMEmployee
INSTEAD OF UPDATE
AS
BEGIN
--Declare the EmployeeID variable
DECLARE @employeeID int;
--Declare five local variables for new data
DECLARE @newTitle nvarchar(50), @newSalary money, @newReportsTo int, @newLastName nvarchar(50), @newFirstName nvarchar(50);
--Declare five local variables for prior data
DECLARE @priorTitle nvarchar(50), @priorSalary money, @priorReportsTo int, @priorLastName nvarchar(50), @priorFirstName nvarchar(50);
--Get the EmployeeID from either inserted or deleted table
SELECT @employeeID=EmployeeID from inserted;
--Get the new data from the inserted table
Select @newTitle =Title, @newSalary = Salary, @newReportsTo = ReportsTo, @newLastName = LastName, @newFirstName = FirstName from inserted
--Get the prior data from the deleted table
Select @priorTitle =Title, @priorSalary = Salary, @priorReportsTo = ReportsTo, @priorLastName = LastName, @priorFirstName = FirstName from deleted


--PRINT OUT all values for debugging
PRINT '-----------New Values-----------------'
PRINT 'Employee ID			:' + CAST(@employeeID as varchar(50));
PRINT 'New LastName		:' + @newLastName;
PRINT 'New FirstName		:' + @newFirstName;
PRINT 'New Title			:' + @newTitle;
PRINT 'New Salary			:' + CAST(@newSalary as varchar(50));
PRINT 'New ReportsTo		:' + CAST(@newReportsTo as varchar(50));
PRINT '-----------prior Values-----------------'
PRINT 'Employee ID			:' + CAST(@employeeID as varchar(50));
PRINT 'Prior LastName		:' + @priorLastName;
PRINT 'Prior FirstName		:' + @priorFirstName;
PRINT 'Prior Title			:' + @priorTitle;
PRINT 'Prior Salary			:' + CAST(@priorSalary as varchar(50));
PRINT 'Prior ReportsTo		:' + CAST(@priorReportsTo as varchar(50));
--Compare the new values with the prior values. If any pair of values is different,
--insert a record in tblPSMEmployeeAudit, then update tblPSMEmployee table
IF @newTitle<>@priorTitle OR @newSalary<>@priorSalary OR @newReportsTo<>@priorReportsTo
OR @newLastName<>@priorLastName OR @newFirstName<>@priorFirstName
BEGIN
	--INSERT the new values into tblPSMEmployeeAudit table. We don't need to provide
	--the value for UpdateDate column in the insert statement. After we run the test script, a new record will be created 
	--in the tblPSMEmployeeAudit table with the value of UpdateDate = current system date. Think 
	--about what makes the UpdateDate column being populate a value automatically.
	Insert Into tblPSMEmployeeAudit (EmployeeID, LastName, FirstName,Title,ReportsTo,Salary)
	Values (@employeeID,@newLastName,@newFirstName,@newTitle,@newReportsTo,@newSalary)
	--UPDATE the values in tblPSMEmployee table
	Update tblPSMEmployee Set LastName=@newLastName, FirstName=@newFirstName,Title=@newTitle,Salary=@newSalary, 
	ReportsTo=@newReportsTo Where EmployeeID =@employeeID;
	
END
ELSE
BEGIN
	PRINT 'No change in LastName, FirstName, Title, Salary, or ReportsTo. No recording in tblPSMEmployeeAudit';
	PRINT 'But we still need to update the other columns in tblPSMEmployee';
	Update tblPSMEmployee Set tblPSMEmployee.TitleOfCourtesy=i.TitleOfCourtesy,tblPSMEmployee.Address=i.Address,
	tblPSMEmployee.BirthDate=i.BirthDate,tblPSMEmployee.HireDate=i.HireDate,tblPSMEmployee.City=i.City,
	tblPSMEmployee.Region=i.Region,tblPSMEmployee.PostalCode=i.PostalCode,tblPSMEmployee.Country=i.Country,
	tblPSMEmployee.HomePhone=i.HomePhone,tblPSMEmployee.Extension=i.Extension,tblPSMEmployee.Photo=i.Photo, 
	tblPSMEmployee.Notes=i.Notes,tblPSMEmployee.PhotoPath=i.PhotoPath
	From inserted As i Where i.EmployeeID=tblPSMEmployee.EmployeeID;
END
END