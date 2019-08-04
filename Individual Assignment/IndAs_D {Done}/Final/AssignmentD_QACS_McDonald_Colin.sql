--Colin McDonald

--Table creations
create table tblCustomerQACS (
CustomerID			Int				Not Null Identity(1,1) Primary Key,
LastName			Nvarchar(250)	Null,
FirstName			Nvarchar(250)	Null,
Address				Nvarchar(250)	Null,
City				Nvarchar(250)	Null,
State				Nvarchar(250)	Null,
Zip					Nvarchar(250)	Null,
Phone				Nvarchar(250)	Null,
Email				Nvarchar(250)	Null,
Constraint			tblCustomerAK	Unique(Email)

)	;

create table tblEmployee (
EmployeeID			Int				Not Null Identity(1,1) Primary Key,
LastName			Nvarchar(250)	Null,
FirstName			Nvarchar(250)	Null,
Phone				Nvarchar(250)	Null,
Email				Nvarchar(250)	Null,
Constraint			tblEmployeeAK	Unique(Email)

)	;


create table tblVendor (
VendorID			Int				Not Null Identity(1,1) Primary Key,
CompanyName			Nvarchar(250)	Null,
ContactLastName		Nvarchar(250)	Not Null,
ContactFirstName	Nvarchar(250)	Not Null,
Address				Nvarchar(250)	Null,
City				Nvarchar(250)	Null,
State				Nvarchar(250)	Null,
Zip					Nvarchar(250)	Null,
Phone				Nvarchar(250)	Null,
Fax					Nvarchar(250)	Null,
Email				Nvarchar(250)	Null,
Constraint			tblVendorAK		Unique(Email)

)	;		

create table tblSale (
SaleID				Int				Not Null Identity(1,1) Primary Key,
CustomerID			Int				Not Null,
EmployeeID			Int				Not Null,
SaleDate			Date			Null,
SubTotal			Money			Null,
Tax					Money			Null,
Total				Money			Null,
Constraint			tblCustomerFK	Foreign Key(CustomerID)
										References tblCustomerQACS(CustomerID)
											On Update Cascade
											On Delete No Action,
Constraint			tblEmployeeFK	Foreign Key(EmployeeID)
										References tblEmployee(EmployeeID)
											On Update Cascade
											On Delete No Action

)	;	


create table tblItem (
ItemID				Int				Not Null Identity(1,1) Primary Key,
ItemDescription		Nvarchar(Max)	Null,
PurchaseDate		Date			Null,
ItemCost			Money			Null,
ItemPrice			Money			Null,
VendorID			Int				Not Null,	
Constraint			tblVendorFk		Foreign Key(VendorID)
										References tblVendor(VendorID)
											On Update Cascade
											On Delete Cascade,
)	;

create table tblSaleItem (
SaleItemID			Int				Not Null,
SaleID				Int				Not Null,
ItemID				Int				Not Null,
ItemPrice			Money			Not Null,
Constraint			tblSaleItemPK	Primary Key(SaleItemID,SaleID),
Constraint			tblSaleFK		Foreign Key(SaleID)
										References tblSale(SaleID)
											On Update Cascade
											On Delete Cascade,
Constraint			tblItemFK		Foreign Key(ItemID)
										References tblItem(ItemID)
											On Update Cascade
											On Delete No Action
)	;

--Bulk Inserts
Insert into tblCustomerQACS (LastName, FirstName, Address, City, State, Zip, Phone, Email)
Select LastName, FirstName, Address, City, State, Zip, Phone, Email from tblCustomer_original

Insert into tblEmployee(LastName, FirstName, Phone, Email)
Select LastName, FirstName, Phone, Email from tblEmployee_original

Insert Into tblVendor(CompanyName, ContactLastName, ContactFirstName, Address, City,
State, Zip, Phone, Fax, Email)
Select CompanyName, ContactLastName, ContactFirstName, Address, City,
State, Zip, Phone, Fax, Email From tblVendor_original

Insert Into tblItem(ItemDescription, PurchaseDate, ItemCost, ItemPrice, VendorID)
Select ItemDescription, PurchaseDate, ItemCost, ItemPrice, VendorID from tblItem_original

Insert Into tblSale(CustomerID, EmployeeID, SaleDate, SubTotal, Tax, Total)
Select CustomerID, EmployeeID, SaleDate, SubTotal, Tax, Total 
From tblSale_original

Insert Into tblSaleItem(SaleID, SaleItemID, ItemID, ItemPrice)
Select SaleID, SaleItemID, ItemID, ItemPrice From tblSaleItem_original
