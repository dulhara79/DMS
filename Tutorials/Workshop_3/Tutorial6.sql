--1. Create a view to show the title of the movie being shown, theater name, country and city for shows 
--which the theater is fully booked.
			create view displayDetails
			as
			select s.movieTitle, t.theaterName, t.country, t.city
			from Theater t, Show s
			where t.theaterName = s.theaterName and t.capacity = s.spectators

			select * from displayDetails

--2. Create a view to show the name, country, and number of movies each actor has starred in.
			create view displayStarDetails(StarName, StarCountry, TotalMovies)
			as
			select ms.name, ms.country, count(si.movieTitle)
			from MovieStar ms, StarsIn si
			where ms.name = si.starname
			group by ms.name, ms.country

			select * from displayStarDetails

--3. Create a function which returns the total earning given a movie title.
			create function getTotalEarnings(@mTitle char(25)) returns int
			as
				begin
					declare @totalE int

					select @totalE = sum(ticketPrice * spectators)
					from Show
					where movieTitle = @mTitle

					return @totalE
				end

				declare @result int

				exec  @result = getTotalEarnings 'Spider-man'
				print 'Spider-man' 
				print @result

				exec  @result = getTotalEarnings 'Avengers'
				print 'Avengers' 
				print @result

				exec  @result = getTotalEarnings 'Passengers'
				print 'Passengers' 
				print @result
				                    
				select * from Show

--4. Create a function which returns the number of remaining seats in a given show.
			create function getRemainingSeats(@sID int) returns int
			as
				begin
					declare @rSeats int

					select @rSeats = t.capacity - s.spectators
					from Theater t, Show s
					where t.theaterName = s.theaterName and s.showId = @sID

					return @rSeats
				end

			declare @result2 int
			exec @result2 = getRemainingSeats 1
			print @result2

			exec @result2 = getRemainingSeats 2
			print @result2

--5. Create a stored procedure which is capable of inserting a booking to the booking table. The procedure
--should accept the show id, customer name and number of tickets as the parameters and it should update
--the number of spectators in the show table.
			create procedure insertUpdateDetails(@sID int, @cName char(50), @nTickets int)
			as
				begin
				declare @remSeats int
				exec @remSeats = getRemainingSeats @sID
					if (@remSeats >= @nTickets)
						begin
							insert into Booking values (@sID, @cName, @nTickets)
							update Show
							set spectators = spectators + @nTickets
							where showId = @sID
						end
						else
						begin
							print 'Sorry there has no enough space available'
							print 'Remaining seat count is'
							print @remSeats
						end
				end

--drop procedure insertUpdateDetails

			exec insertUpdateDetails 3, 'Browny' , 10

			exec insertUpdateDetails 1, 'Anna' , 3

			select * from Booking
			select * from Show
			select * from Theater

--6. Assume that each movie star is assigned with a rank based on the number of lead roles he/she had played.
--Create a procedure to update a rank attribute added to the MovieStar table for each movie star.
--7. Create a trigger to ensure that the number of spectators in the show table does not exceed the capacity
--of the theater its shown in.
--8. Assuming that the Movie Star table already store the rank of each movie star based on the criteria in 5,
--write a trigger to update the rank when the movie star appears in a new movie.