/*
			Consider the following relations in a movie database.
			Movie (title:char(25), year:int, length:float, language:char(15), type:char(1), directorName: char(30))
			MovieStar (name: char (15), country:varchar(40), gender:char(1), birthdate: date)
			StarsIn (movieTitle:char(25), movieYear:int, starname:char(15), role:varchar(15))
			Theater (theaterName: char (20), country: varchar (40), city: varchar (20), capacity: int)
			Show (movieTitle: char (25), theaterName: char (20), datetime: datetime, ticketPrice: real, spectators: int)
*/

				select * from Booking
				select * from Movie
				select * from MovieStar
				select * from Show
				select * from StarsIn
				select * from Theater

/*

The attributes of the Movie relation are title of the movie, year it was made, language, filmtype which may
be ‘F’ or ‘D’ for feature or documentary respectively and the name of the director of the movie. The
MovieStar relation has attributes to record the name, country, gender (‘M’ or ‘F’), and birthday of stars.
StarsIn relation associates the movie with stars that acted in them and contains the role (‘lead’, ‘support’, or
‘other’) they played. The Theater relation has attributes to store the name, country, city and the capacity of
theaters. Show relation stores information movies shown in theaters. It stores the title of the movie shown,
theater where the movie is shown, price of the ticket to see the movie and the number of specters who are
there to see the movie. The primary keys of all relations are underlined.

*/

--Write SQL statements to answer the following queries

--1. Find the names of the directors who had worked with American stars. Assume that if an actor/actress
--stars in a movie the directed by a director the actor/actress works with that director.
			select m.DirectorName
			from Movie m, StarsIn s, MovieStar ms
			where m.title = s.movieTitle and ms.name = s.starname and ms.country = 'America'

--2. Find the movies in English for which all seats are booked in a theater.
			select m.title
			from Theater t, Show s, Movie m
			where t.theaterName = s.theaterName and s.movieTitle = m.title and 
				t.capacity = s.spectators and m.language = 'English'

			select m.title
			from Movie m inner join Show s on m.title = s.movieTitle 
				 inner join Theater t on t.theaterName = s.theaterName 
			where m.language = 'English' and t.capacity = s.spectators

			select m.title
			from Movie m left outer join Show s on m.title = s.movieTitle
				 left outer join Theater t on t.theaterName = s.theaterName
			where t.capacity = s.spectators and m.language = 'English'

--3. Display the names of stars who have acted in 3 or more movies in any year between 2017 and 2018.
			select ms.name
			from MovieStar ms, StarsIn s
			where s.movieYear between 2017 and 2019 and ms.name = s.starname
			group by ms.name
			having count(s.movieTitle) >= 3

			select ms.name
			from MovieStar ms inner join StarsIn s on ms.name = s.starname
			where s.movieYear between 2017 and 2019
			group by ms.name
			having count(s.movieTitle) >= 3

--4. Find the names of male stars who had only starred in lead roles in 2018.
			select ms.name, s.movieTitle
			from MovieStar ms left outer join StarsIn s on ms.name = s.starname
			where s.role = 'lead' and s.movieYear = 2018

			select ms.name, s.movieTitle
			from MovieStar ms, StarsIn s
			where  ms.name = s.starname and s.role = 'lead' and s.movieYear = 2018

--5. Find the names of the stars who has appeared in same movie with ‘Robert Downey’.
			select ms.name, s.movieTitle, s.movieYear
			from MovieStar ms inner join StarsIn s on ms.name = s.starname
			where s.movieTitle in (select s.movieTitle
								 from MovieStar ms inner join StarsIn s on ms.name = s.starname
								 where ms.name = 'Robert Downey');

			select s.movieTitle
			from MovieStar ms, StarsIn s
			where ms.name = s.starname and ms.name = 'Robert Downey'

--6. Find the names of feature movies which is viewed by at least 1 Million spectators in total.
/*

						?

*/

--7. Find the total income of each movie shown in theaters in America
			select movieTitle, sum(spectators)*ticketPrice as 'Total Income'
			from Show
			group by movieTitle, ticketPrice

--8. Find the name of the theaters located in ‘New York’ which shows both ‘The Passenger’ and ‘Jurassic
--World’ on 1st January-2018.
			select t.theaterName, s.movieTitle, s.datetime
			from Theater t inner join Show s on t.theaterName = s.theaterName
			where t.city = 'New York' and s.movieTitle in ('Passengers', 'Jurrasic World') and 
				  s.datetime = '01-Jan-2018'

--9. Find the feature movies for which all shows have more than 200 spectators.
			select s.showId, s.movieTitle
			from Show s
			where s.spectators > 200

--10. Find the name of the most popular movie. 
-- The most popular movie is the movie viewed by most spectators.
			create view sumOfSpectators as
			select s.movieTitle as 'movieTitle', sum(s.spectators) as 'sumOfSpectators'
			from Show s
			group by s.movieTitle;

			drop view sumOfSpectators

			select movieTitle, max(sumOfSpectators) as 'MostPopularMovie'
			from sumOfSpectators sm

			select max(sm.sumOfSpectators) as 'MostPopularMovie'
			from sumOfSpectators sm

			select * from sumOfSpectators                