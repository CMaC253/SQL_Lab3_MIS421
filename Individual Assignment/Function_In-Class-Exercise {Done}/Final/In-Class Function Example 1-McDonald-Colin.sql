/**
Test script:
Select FullName, dbo.ufnGetLastName(FullName) AS LastName from tblPersonNames;
*/

/**
If you ran this script and created the function in the database, you need to change Create
to ALTER to make modifications to the function.

You can also run the following statement to drop the function, then re-create it:
IF OBJECT_ID('dbo.ufnGetLastName', 'FN') IS NOT NULL
DROP FUNCTION dbo.ufnGetLastName;
*/


Create FUNCTION dbo.ufnGetLastName (@fullname varchar(100))
returns varchar(50)
AS
BEGIN
--declare the local variable: lastName
DECLARE @lastName varchar(50);
--declare the index variable to find the index of the separator that separates last name from first name
DECLARE @separatorIndex int;
--get the separator index value
--check if the default separator (,) exists
SET @separatorIndex = CHARINDEX(',', @fullname); 
--if it does, use the substring function to find the last name
IF @separatorIndex > 0 
	BEGIN
		SET @lastName = SUBSTRING(@fullname, 1, @separatorIndex-1);
	END
--if it does not, let's assume the space is the separator and the full name format is FirstName LastName
--find the index for the space, then find the last name
ELSE
	BEGIN
		SET @separatorIndex = CHARINDEX(' ', @fullname)
		SET @lastName = SUBSTRING(@fullname, @separatorIndex+1, (LEN(@fullname)-@separatorIndex));
	END
--return the last name
RETURN @lastName
END