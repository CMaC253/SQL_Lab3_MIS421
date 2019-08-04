--Colin McDonald
--4/22/19
--MIS 421
--Individual Assigment B


--tblArtist Inserts

insert into tblArtist (LastName,FirstName,YearOfBirth,YearDeceased)
values ('Qi', 'Baishi', 1864,1957), 
('Kandinsky', 'Wassily', 1866,1944),
('Klee', 'Paul', 1879,1940),
('Matisse', 'Henri', 1869,1954),
('Chagall', 'Marc', 1887,1985);

--tblCustomer Inserts

insert into tblCustomer (CustomerID, LastName, FirstName, 
						Street, City, State, Zip, 
						Country, Phone, Email)
values (1000,'Chen', 'Jeffrey','123 W. Elm St', 'Renton', 'WA',
		'98055','USA', '543-2345','Jeffrey.Chen@vgr.com'),
(1001,'Smith', 'David','813 Tumbleweed Lane', 'Loveland', 'CO',
		'81201','USA', '654-9876','David.Smith@vgr.com'),
(1015,'Smith', 'Tiffany','88 1st Avenue', 'Langley', 'WA',
		'98260','USA', '765-5566','Tiffany.Smith@vgr.com'),
(1033,'George', 'Fred','10899 88th Ave', 'Bainbridge Island', 'WA',
		'98110','USA', '876-9911','Fred.George@vgr.com'),
(1034,'Frederickson', 'Mary Beth','25 South Lafayette', 'Denver', 'CO',
		'80201','USA', '513-8822','MaryBeth.Frederickson@vgr.com'),
(1036,'Warning', 'Selma','205 Burnaby', 'Vancouver', 'BC',
		'V6Z 1W2','Canada', '988-0512','Selma.Warning@vgr.com');

-- tblArtistWork Insert

insert into tblArtistWork (ArtistID, WorkID, Title, Copy, Medium, Description)
values (1,521, 'The Tilled Field', '788/1000', 'High Quality Limited Print', 'Early Surrealist style'),
(1,522, 'La Lecon de Ski', '353/500', 'High Quality Limited Print', 'Surrealist style'),
(2,523, 'On White II', '435/500', 'High Quality Limited Print', 'Bauhaus style of Kandinsky'),
(4,524, 'Woman with a Hat', '596/750', 'High Quality Limited Print', 'A very colorful Impressionist piece'),
(2,551, 'Der Blaue Reiter', '236/1000', 'High Quality Limited Print', 'The Blue Rider-Early Pointilism influence '),
(5,562, 'The Fiddler', '251/1000', 'High Quality Limited Print', 'Shows Belarusian folk-life themes and symbology');

		 

--Updates
update tblCustomer
	set Email = 'Selma.warning@wwu.edu'
	where LastName = 'Warning' and FirstName='Selma';

update tblArtistWork
	set Copy = '800/1000'
	where ArtistID = 1 and WorkID=521;
	
update tblArtist
	set Nationality = 'Germany'
	where LastName ='Klee' and FirstName = 'Paul';
	
--Deletions
delete from tblArtistWork
	where ArtistID=5 and WorkID=562;

delete from tblArtist
	where ArtistID =5;