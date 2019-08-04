/**
This trigger will ensure that a row has the first name value if the fullname is provided.
This example is an AFTER INSERT trigger, which means that it is invoked after the data has 
been inserted into the table.

Test script:
select * from tblPersonNames;
--Test firstname is not provided
Insert into tblPersonNames (FullName) values ('Kyle Westminster');
Insert into tblPersonNames (FullName) values ('Jackson, Liam');
--Test the provided firstname matches the extracted firstname from the fullname
Insert into tblPersonNames (FullName, FirstName) values ('Jack London', 'Jack');
--Test the provided firstname does not match the extracted firstname from the fullname
Insert into tblPersonNames (FullName, FirstName) values ('Hemingway, Ernest', 'Eeenest');

*/
CREATE TRIGGER dbo.utrFirstnameAfterInsertTblPersonNames ON tblPersonNames AFTER INSERT
AS
BEGIN
	--Declare variables @fn varchar(50), @fnExtracted varchar(50), @fullname varchar(100), @pid int
	DECLARE @fn varchar(50)='', @fnExtracted varchar(50)='', @fullname varchar(100)='', @pid int=0;
	--Get inserted values of @fn and @fullname from the inserted table;
	Select @fn = FirstName, @fullname =fullName from inserted
--Check if Fullname is provided:
--If the fullname is provided
	If @fullname IS NOT NULL
	Begin
	--Check if the firstname is provided:
	--If the firstname is provided
		If @fn IS NOT NULL
		Begin
		--Extract the firstname from the fullname using dbo.ufnGetFirstName function you created before
		Select @fnExtracted =dbo.ufnGetFirstName(@fullname)
		--If the provided firstname does not match the extracted firstname, 
		--we update the firstname column with the extracted firstname
		--ELSE, we just print a message 'The firstnames match. We do not need to do anything'
		If @fn <> @fnExtracted
		Begin
			Set @pid = @@IDENTITY
			Print 'The firstNames do not match. We use the firstname from fullname';
			Update tblPersonNames Set FirstName = @fnExtracted
			Where PersonID = @pid
			Print @fullName + '''s firstname has been updated'
		End
		Else
		Begin
			Print 'The firstNames match. We do not need to do anything';
		End
	End
	--If the firstname is not provided:
	Else
	Begin
		--Extract the firstname from the fullname
		--Set @pid with @@Identity
		--Update the firstname column for the person with the @pid
		Set @fnExtracted = dbo.ufnGetFirstName(@fullname)
		Set @pid = @@IDENTITY
		Update tblPersonNames Set FirstName = @fnExtracted
		Where PersonID = @pid
		Print 'FirstName is not provided. We ahve updated the lastName field';
	End
   End
   Else
   Begin 
	Print 'Full name is not provided. We do nothing';
   End
--If the fullname is not provided
	--PRINT a message: 'Full name is not provided. We do nothing';
	

END