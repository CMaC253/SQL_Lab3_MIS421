
select * from tblPersonLanguage_IMPORT where LastName = 'Perry';
select * from tblPerson where LastName = 'Perry';
select * from tblPersonLanguageSTAGING;
select * from tblFluency;
select * from tblLanguage;
select * from tblPersonLanguageFluency;
select * from tblPersonLanguage_IMPORT;



--Step 1: Checking for empty records
--Then deleting empty records if needed
select * from tblPersonLanguage_IMPORT where Language1 = ''
delete from tblPersonLanguage_IMPORT where Language1 = ''

--Step 2: Migrate PersonID where the conditions meet
UPDATE tblPersonLanguage_IMPORT
SET PersonID = P.PersonID 
FROM tblPersonLanguage_IMPORT AS PI INNER JOIN tblPerson AS P 
ON (PI.FirstName=P.FirstName) 
AND (PI.MidName=P.MidName) 
AND (PI.LastName=P.LastName) 
AND (PI.AreaCode=P.AreaCode) 
AND (PI.Phone=P.Phone) 
AND (PI.EMail=P.EMail)
WHERE PI.PersonID IS NULL; 

--Narrow the search down by removing some conditions
UPDATE tblPersonLanguage_IMPORT
SET PersonID = P.PersonID 
FROM tblPersonLanguage_IMPORT AS PI INNER JOIN tblPerson AS P 
ON  (PI.LastName=P.LastName) 
AND (PI.AreaCode=P.AreaCode) 
AND (PI.Phone=P.Phone) 
AND (PI.EMail=P.EMail)
WHERE PI.PersonID IS NULL; 

--This checks for null PersonIDs from the target table
select PersonID from tblPersonLanguage_IMPORT 
where PersonID is not null;

--This checks for duplicate values given the count
select PersonID from tblPersonLanguage_IMPORT
group by PersonID
Having COUNT(PersonID) > 1;

--This section is updating the null values where there are errors

-- Don't use this one
update tblPersonLanguage_IMPORT
set tblPersonLanguage_Import.PersonID = p.PersonID,
	tblPersonLanguage_Import.Phone = p.Phone,
	tblPersonLanguage_Import.AreaCode = p.AreaCode,
	tblPersonLanguage_Import.EMail = p.Email
from tblPerson as p
	where tblPersonLanguage_Import.PersonID is null
	and tblPersonLanguage_Import.LastName = 'Perry';
--

--Use this ONE! since we are updating using
--an inner join so we can change only the data
--we need to manipulate from tblPerson
UPDATE tblPersonLanguage_IMPORT
set tblPersonLanguage_Import.PersonID = P.PersonID,
	tblPersonLanguage_Import.Phone = P.Phone,
	tblPersonLanguage_Import.AreaCode = P.AreaCode,
	tblPersonLanguage_Import.EMail = P.Email
FROM tblPersonLanguage_IMPORT AS PI INNER JOIN tblPerson AS P 
ON (PI.FirstName=P.FirstName) 
AND (PI.LastName=P.LastName) 
WHERE PI.PersonID IS NULL; 

--Step 3
--We decided to do individual insert statements to save time via Copy & Paste
insert into tblFluency (FluencyRanking, FluencyCode, FluencyDescription)
values	(10, 'WP', 'Words and Phrases Only');

insert into tblFluency (FluencyRanking, FluencyCode, FluencyDescription)
values	(20, 'LC', 'Light Conversation');

insert into tblFluency (FluencyRanking, FluencyCode, FluencyDescription)
values	(30, 'FF', 'Fluent Foreign Speaker');

insert into tblFluency (FluencyRanking, FluencyCode, FluencyDescription)
values	(40, 'NS', 'Native Speaker');

insert into tblFluency (FluencyRanking, FluencyCode, FluencyDescription)
values	(50, 'PT', 'Professional Translator');

insert into tblFluency (FluencyRanking, FluencyCode, FluencyDescription)
values	(0, 'FNK', 'Fluency level Not Known');


---Step 4
--We are using the WHERE clause because we are setting very specific conditions
--If we left the WHERE clause 
INSERT INTO tblPersonLanguageSTAGING (PersonID, Language, FluencyCode)
(SELECT DISTINCT PersonID, Language1, L1FluencyCode FROM tblPersonLanguage_IMPORT
WHERE Language1 <> ''       AND L1FluencyCode <> '' 
AND Language1 IS NOT NULL AND L1FluencyCode IS NOT NULL);

INSERT INTO tblPersonLanguageSTAGING (PersonID, Language, FluencyCode)
(SELECT DISTINCT PersonID, Language2, L2FluencyCode FROM tblPersonLanguage_IMPORT
WHERE Language2 <> ''       AND L2FluencyCode <> '' 
AND Language2 IS NOT NULL AND L2FluencyCode IS NOT NULL);

INSERT INTO tblPersonLanguageSTAGING (PersonID, Language, FluencyCode)
(SELECT DISTINCT PersonID, Language3, L3FluencyCode FROM tblPersonLanguage_IMPORT
WHERE Language3 <> ''       AND L3FluencyCode <> '' 
AND Language3 IS NOT NULL AND L3FluencyCode IS NOT NULL);

INSERT INTO tblPersonLanguageSTAGING (PersonID, Language, FluencyCode)
(SELECT DISTINCT PersonID, Language4, L4FluencyCode FROM tblPersonLanguage_IMPORT
WHERE Language4 <> ''       AND L4FluencyCode <> '' 
AND Language4 IS NOT NULL AND L4FluencyCode IS NOT NULL);


--5 Populate tblLanguage with distinct languages
INSERT INTO tblLanguage (Language)
SELECT DISTINCT Language 
FROM tblPersonLanguageSTAGING;

--6 Six and Seven are updating the Staging table for
--the bulk insert to come
update tblPersonLanguageSTAGING
set tblPersonLanguageSTAGING.LanguageID = tblLanguage.LanguageID
from tblLanguage
where tblPersonLanguageSTAGING.Language = tblLanguage.Language;

--7 
update tblPersonLanguageSTAGING
set tblPersonLanguageSTAGING.FluencyID= tblFluency.FluencyID
from tblFluency
where tblPersonLanguageSTAGING.FluencyCode = tblFluency.FluencyCode;

--This is to check if there are duplicate Languages per person
--Thankfully with the problems I've had with this lab, this 
--works  (>^o^)>
select PersonID, LanguageID, count(LanguageID) as LangCombo
from tblPersonLanguageSTAGING
group by PersonID, LanguageID
Having COUNT(LanguageID) > 1;

--8
INSERT INTO tblPersonLanguageFluency (PersonID, LanguageID, FluencyID)
SELECT PersonID, LanguageID, FluencyID 
FROM tblPersonLanguageSTAGING;