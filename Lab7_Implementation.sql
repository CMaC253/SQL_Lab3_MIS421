--Lab 7 Implementation
--Birch

select * from tblCommittee

Insert Into tblSisterCity (SisterCityName, Country, Population, Description, Mayor, Website)
Values ('Sidney BC', 'Canada', 11483,'Sidney is located at the southeast end of Vancouver Island, 
									  just north of Victoria and adjacent to the world famous Butchart Gardens.',
									 'Steve Price', 'http://www.sidney.ca/');

Insert Into tblCommittee (CommitteeName, MeetingTime, BudgetedExpenditures, ExpendituresToDate, CommitteeType)
Values ('Summer Music Festival at the Bay', '1st Monday 3pm', 5000, 1000, 'S'),
	   ('Sidney','3rd Tuesday 2pm',1000,500, 'C');

Insert Into tblSupportCommittee(SupportCommitteeID, CityContact, MissionStatement, CommitteeType)
Values (15, 'Parks and Rec. Dir.', 'Promote Bellingham through music events', 'S')
	   
Insert Into tblSisterCityCommittee(SisterCityCommitteeID, SisterCityID, TopProject, LastVisitToCity, LastVisitFromCity,
								   NextVisitToCity, NextVisitFromCity,CommitteeType)
Values (16, 7, 'Establish relationship', '2015-5-10', '2015-4-24', '2015-6-16', '2015-7-17', 'C') 	  


Delete from tblSisterCity
where SisterCityName = 'Sidney BC';

Delete from tblCommittee
Where CommitteeName = 'Sidney';

Delete from tblSisterCityCommittee
Where SisterCityCommitteeID = 16;

Alter Database S19_MIS421_Birch SET MULTI_USER;