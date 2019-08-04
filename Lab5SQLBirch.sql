
--Create Committee Table
create table tblCommittee(
CommitteeID			  Int				Not Null Identity(1,1) Primary Key,
CommitteeName		  Nvarchar(250)	    Null,
MeetingTime			  Nvarchar(250)	    Null,
BudgetedExpenditures  Money				Null,
Expenditures		  Money				Null,
CommitteeType		  Char(1)			Not Null,		
Constraint			  tblCommitteeAK	Unique(CommitteeID, CommitteeType),
Constraint			  CommitteeTypeCheck Check(CommitteeType='C' or CommitteeType='S')
);

--Create SisterCityCommittee Table
create table tblSisterCityCommittee (
SisterCityCommitteeID Int			    Not Null Primary Key,
SisterCityID		  Int				Not Null,
TopProject			  Nvarchar(250)		Null,
LastVisitToCity		  Date				Null,
LastVisitFromCity	  Date				Null,
NextVisitToCity		  Date				Null,
NextVisitFromCity	  Date				Null,
CommitteeType		  Char(1)			Not Null Default 'C',
Constraint			  SisterCityCommitteeFK1	Foreign Key(SisterCityCommitteeID,CommitteeType)
													References tblCommittee(CommitteeID,CommitteeType)
													On Update Cascade
													On Delete Cascade,
Constraint			  SisterCityCommitteeFK2	Foreign Key(SisterCityID)
													References tblSisterCity(SisterCityID)
													On Update Cascade
													On Delete Cascade,
Constraint			  SisterCityCommitteeCheck	Check (CommitteeType = 'C')
);

--Create SupportCommittee
create table tblSupportCommittee(
SupportCommitteeID    Int				Not Null Primary Key,
CityContact			  Nvarchar(250)		Not	Null,
MissionStatement	  Nvarchar(max)		Not Null,
CommitteeType		  Char(1)			Not Null Default 'S'
Constraint			  SupportCityCommitteeFK	 Foreign Key(SupportCommitteeID, CommitteeType)
													References tblCommittee(CommitteeID, CommitteeType)
														On Update Cascade
														On Delete Cascade,
Constraint			  SupportCommitteeCheck		 Check (CommitteeType = 'S')
);


select * from tblCommitteeIMPORT

Alter Table tblCommitteeIMPORT ADD CommitteeID Int NULL
Alt
er Table tblCommitteeIMPORT ADD CommitteeType char(1) NULL	
Alter Table tblCommitteeIMPORT ADD SisterCityID Int NULL

UPDATE tblCommitteeIMPORT 
set tblCommitteeIMPORT.CommitteeType = 'S'
where AffiliatedCity is NULL

UPDATE tblCommitteeIMPORT 
set tblCommitteeIMPORT.CommitteeType = 'C'
where AffiliatedCity is  NOT NULL

UPDATE tblCommitteeIMPORT
set tblCommitteeIMPORT.SisterCityID = tblSisterCity.SisterCityID
from tblSisterCity
where tblCommitteeIMPORT.AffiliatedCity = tblSisterCity.SisterCityName

Insert Into tblCommittee(CommitteeName, MeetingTime, BudgetedExpenditures, Expenditures, CommitteeType)
Select  CommitteeName, MonthlyMeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType
From tblCommitteeIMPORT

UPDATE tblCommitteeIMPORT
set tblCommitteeIMPORT.CommitteeID = tblCommittee.CommitteeID
from tblCommittee
where tblCommitteeIMPORT.CommitteeName = tblCommittee.CommitteeName

Insert Into tblSupportCommittee(CityContact, MissionStatement, CommitteeType)
Select  CityContact, MissionStatement, CommitteeType
From tblCommitteeIMPORT

Insert Into tblSisterCityCommittee(SisterCityID, TopProject, LastVisitToCity, LastVisitFromCity, NextVisitToCity,NextVisitFromCity)
Select  SisterCityID, TopProject, MostRecentVisitToCity, MostRecentVisitFromCity, NextVisitToCity,NextVisitFromCity
From tblCommitteeIMPORT;

Create View vueAllCommittees_5_20 As
Select c.CommitteeID, CommitteeName, MeetingTime, BudgetedExpenditures,
Expenditures, c.CommitteeType, TopProject, LastVisitToCity, LastVisitFromCity,
NextVisitToCity, NextVisitFromCity
From tblCommittee As c
Left Outer Join tblSupportCommittee As s On c.CommitteeID = s.SupportCommitteeID
Left Outer Join tblSisterCityCommittee As sc On c.CommitteeID = sc.SisterCityCommitteeID;

Create View vueCityCommittees_5_22 As
Select c.CommitteeID, CommitteeName, MeetingTime, BudgetedExpenditures,
Expenditures, c.CommitteeType, TopProject, LastVisitToCity, LastVisitFromCity,
NextVisitToCity, NextVisitFromCity
From tblCommittee As c left outer join tblSisterCityCommittee As sc
on c.CommitteeID = sc.SisterCityCommitteeID left outer join tblSisterCity As s
on sc.SisterCityID = s.SisterCityID
Where c.CommitteeType = 'C';

Create View vueCommitteeFinances_5_24 As
Select CommitteeName, BudgetedExpenditures, Expenditures,
(BudgetedExpenditures - Expenditures)
As AmountAvailableToSpend
From tblCommittee