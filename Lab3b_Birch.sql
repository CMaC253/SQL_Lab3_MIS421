--
--
--
--
--
select * from tblPersonSTAGING
select * from tblMembership
select * from tblMembershipType
select * from tblPerson


--[3.10a]
--Insert distinct membershipType data to the empty table
insert into tblMembershipType (MembershipType)
select distinct (MembershipType)
from [dbo].[tblPersonSTAGING];

--bulk update to fill membershipTypeID field in the 
-- personStaging able
update tblPersonSTAGING set
tblPersonStaging.MembershipTypeID = mt.MembershipTypeID
from tblMembershipType As mt
where tblPersonSTAGING.MembershipType = mt.MembershipType

--
update tblPersonSTAGING set
tblPersonStaging.MembershipTypeID = mt.MembershipTypeID
from tblMembershipType As mt
	inner join tblPersonSTAGING pStgng
on mt.MembershipType = pStgng.MembershipType


--individually update each membership type
update tblMembershipType
	set AnnualFee = 250, isGroup = 1
	where MembershipType = 'Corporate'

update tblMembershipType
	set AnnualFee = 100, isGroup = 0
	where MembershipType = 'Patron'

update tblMembershipType
	set AnnualFee = 50, isGroup = 1
	where MembershipType = 'Family'

update tblMembershipType
	set AnnualFee = 25, isGroup = 0
	where MembershipType = 'Individual'

update tblMembershipType
	set AnnualFee = 10, isGroup = 0
	where MembershipType = 'Student'


insert into tblMembershipType (MembershipType, isGroup, AnnualFee)
values ('Patron', 0, 100)

insert into tblMembershipType (MembershipType, isGroup, AnnualFee)
values ('Student', 0, 10)


--[3.10b]
-- Distinct membership
insert into tblMembership (MembershipNumber,isCurrent,MembershipTypeID)
select distinct MembershipNumber,isCurrentMember,MembershipTypeID
from [dbo].[tblPersonSTAGING];

--Bulk Update to fill MembershipID
update tblPersonSTAGING set
tblPersonStaging.MembershipID = mem.MembershipID 
from tblMembership As mem
where tblPersonSTAGING.MembershipNumber = mem.MembershipNumber


--[3.10c]
--Populate tblPerson
insert into tblPerson 
(FirstName,MidName, LastName, Address, City, State, Zip,
AreaCode, Phone, Email, MembershipID)
select FirstName,MidName, LastName, Address, City, State, Zip,
AreaCode, Phone, Email, MembershipID
from tblPersonSTAGING

