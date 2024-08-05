select * FROM moviesdb.movies; #to show the whole table
select title,industry FROM moviesdb.movies; #to show specific columns
USE moviesdb; #kind of like setting specfic schema so that we would not have to mention it again and again
SELECT * FROM movies WHERE industry="bollywood"; #for a specified situation
select distinct industry FROM movies; #to get unique values under any column
#That just means that the word between the % sign, any title that has that name anywhere
select * FROM movies where title like "%THOR%"; 
#to get movies who rating is greater than 6 but smaller than 8, "IMDB_RATING Between 6 and 8" can be used but wont have include 6 and 8
select * from movies where imdb_rating>=6 AND imdb_rating<=8;
#and if we want to show movies of specific years but any chosen year works
select * from movies where release_year=2019 or release_year=2022;
select * from movies where release_year in (2019,2022,2018); #the things inside the bracket will be considered in an OR way
#to show null values, and to show not null values wrie "not null"
select * from movies where imdb_rating is null;
#to get certain kind of order , by default it gives ascending, if u want descending just write "order by imdb_rating desc" 
SELECT * FROM movies WHERE industry="bollywood" order by imdb_rating;
#to show only specific number of rows
SELECT * FROM movies WHERE industry="bollywood" order by imdb_rating limit 5;
#offset is for number of rows to skip
SELECT * FROM movies WHERE industry="bollywood" order by imdb_rating limit 5 offset 2;
#maximum valvue and minimum values
SELECT MIN(imdb_rating) FROM movies WHERE industry="bollywood";
SELECT max(imdb_rating) FROM movies WHERE industry="bollywood";
#round is for averaging the ansqwer to two decimal points, "as avg_rating" is for the name of column that shows the value
SELECT round(avg(imdb_rating),2) as avg_rating FROM movies WHERE studio="marvel studios";
#for counting we use count(*)
SELECT studio , count(*) from movies group by studio;
#for arranging the count numbers
SELECT studio , count(*) as cnt from movies group by studio order by cnt desc;
#grouping the categories under a column
select industry, count(industry) from movies group by industry;
#for inserting more descriptive columns of the selected column
select industry, count(industry) as cnt, avg(imdb_rating) as avgg from movies group by industry;
select industry, count(*) as cnt, avg(imdb_rating) as avgg from movies group by industry;
# i think writing count both these ways are the same, we just write it for clarity

#to remove blank values from the table
select studio, count(studio) as cnt, round(avg(imdb_rating),1) as avgg from movies 
where studio!="" group by studio order by avgg desc;

#putting a condition-print the years when more than 2 movies were released
select release_year ,count(release_year) as cnt from movies group by release_year having cnt>2 ;
#the order that is followed is = from -> where -> group by -> having -> order by, also where can use columns that are not mentioned in select
 
 #for computation of things requir current dat and year and stuff
 select curdate();
 select year(curdate());
 # now lets try to find out the age of actors:-
 select *, year(curdate())-birth_year as age from actors;
 select *,(revenue-budget) as profit from financials;
#converting all currency to inr- if(condition,true,false)
select *, if (currency="USD", revenue*77, revenue) as rev_inr from financials;
# when we have multiple cases to consider
select *,
   case 
       when unit="thousands" then revenue/1000 #commas are not needed
       when unit="Billions" then revenue*1000
	   when unit="Millions" then revenue #to keep it as it is, can be written like this too - "else revenue"
       end as rev_mil #end signifies the end of cases
 from financials;    
#lets look into inner join, j oins are by default inner join, inner join only takes common records into account
select m.movie_id,title,budget,revenue,currency,unit  #we had to clarify kis table ka movie id are we talking about
from movies m join financials f on m.movie_id=f.movie_id;
#to show every record present in one table u do left join
select m.movie_id,title,budget,revenue,currency,unit 
from movies m left join financials f on m.movie_id=f.movie_id; #table given in from is the left table
#here we are using right join and movie id present in financials will be included even if they are not in movies table,
#also, right now the rows with financials exclusive are not showing movie_id because in query movie id acc to movies is selected to print
select f.movie_id,title,budget,revenue,currency,unit 
from movies m right join financials f on m.movie_id=f.movie_id; 
#to show all rows of both tables being joined:-
select m.movie_id,title,budget,revenue,currency,unit 
from movies m left join financials f on m.movie_id=f.movie_id
union
select f.movie_id,title,budget,revenue,currency,unit 
from movies m right join financials f on m.movie_id=f.movie_id;
#all the other joins other than the inner joins are called outer joins 
#there is another clause called using, which is pretty smart:-
select movie_id,title,budget,revenue,currency,unit 
from movies left join financials using (movie_id)