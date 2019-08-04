/**
This trigger will ensure that a row has the last name value if the fullname is provided.
This example is an AFTER INSERT trigger, which means that it is invoked after the data has 
been inserted into the table.

Test script:
select * from tblPersonNames;
--Test lastname is not provided
Insert into tblPersonNames (FullName) values ('Kyle Westminster');
Insert into tblPersonNames (FullName) values ('Jackson, Liam');
--Test the provided lastname matches the extracted lastname from the fullname
Insert into tblPersonNames (FullName, LastName) values ('Jack London', 'London');
--Test the provided lastname does not match the extracted lastname from the fullname
Insert into tblPersonNames (FullName, LastName) values ('Hemingway, Ernest', 'Hemingwey');

*/
CREATE TRIGGER dbo.utrLastnameAfterInsertTblPersonNames ON tblPersonNames AFTER INSERT
AS
BEGIN
--Declare the local variables: @ln varchar(50), @lnExtracted varchar(50), @fullname varchar(100);
	Declare @ln varchar(50) ='', @lnExtracted varchar(50)='', @fullname varchar(100)='';
--Declare the local variable: @pid int;
	Declare @pid int =0;
--Get inserted values from inserted
	Select @ln = LastName, @fullname = fullName from inserted

--Check if Fullname is provided:
--If the fullname is provided
	If @fullname Is not null
	Begin
	--Check if lastname is provided:
	--If the lastname is provided
	  If @ln Is not null
	  Begin
			--Extract the lastname from the fullname
			Set @lnExtracted = dbo.ufnGetLastName(@fullname)
			--If the provided lastname does not match the extracted lastname,
			--we update the LastName column with the extracted lastname
			If @ln <> @lnExtracted
			Begin
				Set @pid = @@IDENTITY
				Print 'The lastNames do not match. We use the lastname from fullname';
				Update tblPersonNames Set LastName = @lnExtracted 
				Where PersonID = @pid
				Print @fullName + '''s lastname has been updated'
			End
			Else
			Begin
			--If the provided lastname matches the extracted lastname, we just print a message
				Print 'The lastNames match. We do not need to do anything';
			End
			
	  End
	--If the lastname is not provided:
	 Else
	 Begin
		--extract the lastname from the fullname and update the LastName column of the row
		Set @lnExtracted = dbo.ufnGetLastName(@fullname);
		Set @pid = @@IDENTITY;
		Update tblPersonNames Set LastName=@lnExtracted
		Where PersonID=@pid;
		Print 'Lastname is not provided. We have updated the lastName field' ;
	 End
	End
	Else
	Begin
--If the fullname is not provided, we just print a message
		Print 'Full name is not provided. We cannot ge tthe last name';
	End
END