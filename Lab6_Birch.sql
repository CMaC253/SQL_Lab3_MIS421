
--[Req 6.05]
select * from tblCommittee
select * from tblSupportCommittee

--[Req 6.05a]
Insert into tblCommittee (CommitteeName, MeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType)
Values ('Programs', '3rd Friday 7pm', 500.00, 50, 'S')

--[Req 6.05b]
Insert Into tblSupportCommittee (SupportCommitteeID,CityContact, MissionStatement, CommitteeType)
Values (14,'Parks and Rec. Dir.', 'Coordinate the programs offered by the various city committees', 'S')


--[Req 6.10]
create table tblPosition(
PositionID				int					Not Null Identity(1,1) Primary Key,
JobTitle				nvarchar(250)		Null,
);

create table tblAuthorizedCommitteePosition(
CommitteeID				int					Not Null,
PositionID				int					Not Null,
ApprovedDate			date				Not Null,
Constraint				tblACP_PK			Primary Key(CommitteeID, PositionID),
Constraint				tblACP_FK		Foreign Key(PositionID)
												References tblPosition(PositionID),
Constraint				tblACP_FK2		Foreign Key(CommitteeID)
												References tblCommittee(CommitteeID)
);

create table tblServiceHistory(
PersonID				int					Not Null,
CommitteeID				int					Not Null,
PositionID				int					Not Null,
StartDate				date				Not Null,
EndDate					date				Null,
Constraint				tblSH_PK			Primary Key(PersonID, CommitteeID, PositionID, StartDate)		,
Constraint				tblSH_FK			Foreign Key(PersonID)
												References tblPerson(PersonID),
Constraint				tblSH_FK2			Foreign Key(CommitteeID)
												References tblCommittee(CommitteeID),
Constraint				tblSH_FK3			Foreign Key(PositionID)
												References tblPosition(PositionID)					
);

--Import Checks
select * from tblCommitteeOfficers_IMPORT;
--Delete from tblCommitteeOfficers_IMPORT
--where Committee IS NULL;

--Alter Tables Part 2 from Migration Map
ALTER TABLE tblCommitteeOfficers_IMPORT Drop Column F10
ALTER TABLE tblCommitteeOfficers_IMPORT Drop Column F11
ALTER TABLE tblCommitteeOfficers_IMPORT ADD PersonID Int NULL
ALTER TABLE tblCommitteeOfficers_IMPORT ADD PositionID Int NULL
ALTER TABLE tblCommitteeOfficers_IMPORT ADD CommitteeID Int NULL
ALTER TABLE tblCommitteeOfficers_IMPORT ADD AuthorizedPositionID Int NULL

--Updates Migration Table Part 3
UPDATE tblCommitteeOfficers_IMPORT 
SET tblCommitteeOfficers_IMPORT.PersonID = tblPerson.PersonID
from tblPerson
where tblCommitteeOfficers_IMPORT.Firstname = tblPerson.FirstName
and  tblCommitteeOfficers_IMPORT.lastname = tblPerson.LastName


UPDATE tblCommitteeOfficers_IMPORT
SET tblCommitteeOfficers_IMPORT.PersonID = tblPerson.PersonID
From tblPerson
where tblCommitteeOfficers_IMPORT.LastName LIKE '___________384%' AND tblPerson.Phone = '3845171'

UPDATE tblCommitteeOfficers_IMPORT
SET tblCommitteeOfficers_IMPORT.PersonID = tblPerson.PersonID
From tblPerson
where tblCommitteeOfficers_IMPORT.LastName LIKE '___________371%' AND tblPerson.Phone = '3712131'

--4)a INSERT AuthorizedPosition
Update tblCommitteeOfficers_IMPORT
Set AuthorizedCommitteePositions = NULL
Where AuthorizedCommitteePositions = 'Summer 2018 only - special appointment'

INSERT INTO tblPosition (JobTitle)
select distinct AuthorizedCommitteePositions  
from  tblCommitteeOfficers_IMPORT
where AuthorizedCommitteePositions IS NOT NULL AND
	  Committee IS NOT NULL 


--4)b Update AuthorizePositionID
UPDATE  tblCommitteeOfficers_IMPORT 
SET AuthorizedPositionID =tblPosition.PositionID
from tblPosition
where AuthorizedCommitteePositions=tblPosition.JobTitle;

--4)c Update PositionID
UPDATE tblCommitteeOfficers_IMPORT
SET tblCommitteeOfficers_IMPORT.PositionID = tblPosition.PositionID
from tblPosition
WHERE tblCommitteeOfficers_IMPORT.Office = tblPosition.JobTitle	;

--5)
UPDATE tblCommitteeOfficers_IMPORT
SET tblCommitteeOfficers_IMPORT.CommitteeID = tblCommittee.CommitteeID
FROM tblCommittee
WHERE  tblCommitteeOfficers_IMPORT.Committee = tblCommittee.CommitteeName;


--6a
Insert Into tblAuthorizedCommitteePosition (CommitteeID, ApprovedDate, PositionID)
Select CommitteeID, ApprovedOn, AuthorizedPositionID
From tblCommitteeOfficers_IMPORT
Where AuthorizedCommitteePositions IS NOT NULL And CommitteeID IS NOT NULL;


--6b
Insert Into tblServiceHistory (PersonID, PositionID, CommitteeID, StartDate,EndDate)
Select PersonID, PositionID, CommitteeID, StartDate, EndDate
From tblCommitteeOfficers_IMPORT
Where PersonID Is Not Null And PositionID Is Not Null And CommitteeID Is Not Null And StartDate Is Not Null ;

--6.30
create view vueCountPositionByCommittee_6_30 As
Select Count(*) As 'Number Of', 'authorized position(s) for ' + c.CommitteeName As 'Committee Positions' 
from tblAuthorizedCommitteePosition As ac
inner join tblCommittee As c on ac.CommitteeID = c.CommitteeID
Group by CommitteeName
