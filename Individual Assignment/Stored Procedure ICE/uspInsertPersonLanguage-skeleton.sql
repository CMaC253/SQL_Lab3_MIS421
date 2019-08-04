/**
This is a stored procedure that will insert a person's information into tblPerson and tblPersonLanguageFluency tables.
It first checks if the person already exists in the tblPerson table. If it does, we do not proceed. If it does not, 
check if the passed in language name with which the person speaks natively exists in the tblLanguage table. If it does not
exist in the tblLanguage table, we do not proceed. If it does exist, we start a transaction to insert the person's information
to tblPerson table. Then, we get the PersonID using the @@Identity; we also get the language ID for the passed in language name 
from the tblLanguage table and the fluency ID for the fluency level of 'Native Speaker' from tblFluency table, 
then we insert a new record into the tblPersonLanguageFluency table.

Show data in the tables:
Select * from tblPerson;
Select * from tblLanguage;
Select * from tblPersonLanguageFluency
Test script:
--the person exists
DECLARE @resultCode int, @message varchar(250)
--Parameters: @firstName, @lastName, @address, @city, @state, @zip, @languageName, @ResultCode, @message
EXECUTE dbo.uspInsertPersonLanguage 'Richard', 'Byrd', '5697 Mt Baker Hwy', 'Deming',
'WA', '98224', 'English', @resultCode OUTPUT, @message OUTPUT
SELECT @resultCode, @message;

--the language name does not exist
DECLARE @resultCode int, @message varchar(250)
EXECUTE dbo.uspInsertPersonLanguage 'Annie', 'Miller', '234 15th Street', 'Bellingham',
'WA', '98225', 'Dadjo', @resultCode OUTPUT , @message OUTPUT  
SELECT @resultCode, @message;

--everything is fine
DECLARE @resultCode int, @message varchar(250)
EXECUTE dbo.uspInsertPersonLanguage 'Nikki', 'Jones', '123 14th Street', 'Bellingham',
'WA', '98225', 'English', @resultCode OUTPUT , @message OUTPUT 
SELECT @resultCode, @message;


*/
--Colin McDonald!

CREATE PROCEDURE dbo.uspInsertPersonLanguage (@firstName varchar(250), @lastName varchar(250), @address varchar(250),
@city varchar(250), @state varchar(250), @ZIP varchar(250), @languageName varchar(250), @resultCode int OUTPUT, @message varchar(250) OUTPUT)
AS
BEGIN
	Begin Try --Use inclusive Begin/End Try..Catch
		PRINT '----INPUT PARAMETER VALUES';
		PRINT 'First name:			' + @firstName;
		PRINT 'Last name:			' + @lastName;
		PRINT 'Address:				' + @address;
		PRINT 'City:				' + @city;
		PRINT 'State:				' + @state;
		PRINT 'ZIP:					' + @ZIP;
		PRINT 'Language:			' + @languageName;
		--Check if the person with @firstName, @lastName, @address, @city, and @state exists in the tblPerson table. 
		SELECT * FROM tblPerson WHERE FirstName=@firstName and LastName=@lastName 
		and Address=@address and City=@city and State=@state;
		/**
		If the person exists in the table, set @resultCode=-1 and @message='The person exists in the database'
		then RETURN
		*/
		Declare @count int;
		Set @count = @@ROWCOUNT

		If @count > 0
		Begin
			Set @resultCode = -1;
			Set @message = 'The person exists in the database';
			Return;
		End

		/**
		Check if @language exists in the tblLanguage table
		If the langauge does NOT exist in the table, set @resultCode=-2 and @message='The language does not exist in the database'
		then, RETURN
		*/
		Select * from tblLanguage where LanguageName = @languageName;
		Set @count = @@ROWCOUNT

		If @count <= 0
		Begin
			Set @resultCode = -2;
			Set @message = 'The language does not exist in the database';
			Return;
		End

		--Start a transaction: BEGIN TRANSACTION
		BEGIN TRANSACTION
			/**
			Insert the record into tblPerson. Enclose the insert statement in a BETGIN TRY...BEGIN CATCH block.
			In the BEGIN CATCH block, set @resultCode=-3 and @message='Issue in inserting into tblPerson'.
			Also print the message 'Issue in inserting into tblPerson' in the BEGIN CATCH block. 
			ROLLBACK TRANSACTION in the BEGIN CATCH block and RETURN.
			*/
			Begin Try
				Insert Into tblPerson(FirstName,LastName, Address, City, State, ZipCode)
				Values(@firstName, @lastName, @address, @city, @state, @ZIP)
			
				Declare @personID int;
				Set @personID = @@IDENTITY;

			End Try
			Begin Catch
				Set @resultCode = -3;
				Set @message = 'Issue in inserting in to tblPerson';
				Print 'Issue in inserting into tblPerson';
				Rollback Transaction;
				Return;
			End Catch
		
			/**
			Declare a variable @langagueID as int and set the @languageID equal to the LanguageID from 
			tblLanguage table where the LanguageName matches the @languageName
			*/
			Declare @languageID int
			Select @languageID = LanguageID from tblLanguage Where LanguageName = @languageName

			/**
			Declare a variable @fluencyID as int and set the @fluencyID equal to the FluencyID from 
			tblFluency table where the Fluencydescription = 'Native Speaker'
			*/
			Declare @fluencyID int
			Select @fluencyID = FluencyID from tblFluency Where FLUENCYDESCRIPTION = 'Native Speaker'

			/**
			Insert the record into tblPersonLanguageFluency. Enclose the insert statement in a BETGIN TRY...BEGIN CATCH block.
			In the BEGIN CATCH block, set @resultCode=-4 and @message='Issue in inserting into tblPersonLanguageFluency'.
			Also print the message 'Issue in inserting into tblPersonLanguageFluency' in the BEGIN CATCH block. 
			ROLLBACK TRANSACTION and RETURN in the BEGIN CATCH block .
			*/
			Begin Try
				Insert Into tblPersonLanguageFluency(PersonID, LanguageID, FluencyID)
				Values (@personID, @languageID, @fluencyID)
			End Try
			Begin Catch
				Set @resultCode = -4;
				Set @message = 'Issue in inserting into tblPersonLanguageFluency';
				Print 'Issue in inserting into tblPersonLanguageFluency';
				Rollback Transaction;
				Return;
			End Catch
		
			/**
			PRINT a message 'Succeeded!'.
			SET @resultCode=1 and @message='Succeeded'.
			Then, COMMIT the transaction.
			*/

			Print 'Succeeded!';
			Set @resultCode = 1;
			Set @message = 'Succeeded';
			Commit Transaction;

	End Try --End inclusive try
	Begin Catch
		Set @resultCode = -5;
		Set @message = ERROR_MESSAGE();
		Print 'Unexpected Error: ' + ERROR_MESSAGE();
	End Catch
		
END
GO