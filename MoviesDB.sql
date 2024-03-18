1. How many Bollywood and Hollywood  movies are present in the dataset ?
  
  SELECT industry, COUNT(*) as Movies_Count
  FROM movies
  GROUP BY industry;

2. How many movies were released in each year respectively and  in which year maximum no of movies produced ?
  
  SELECT Release_Year, COUNT(*) as Movies_Count 
  FROM movies
  GROUP BY Release_Year
  ORDER BY Release_Year DESC;

3. Give all the details of the movies having movie ids  105, 117 & 128  ?
  
  SELECT  * 
  FROM movies 
  WHERE movie_id IN (105, 117, 128);

4. What is the average rating of all the movies  ?
  
  SELECT  
  ROUND (AVG(IMDB_Rating),2)
  FROM movies;

5. Which are highest and lowest rated movies ?
       
       SELECT * 
       FROM movies
       WHERE imdb_rating IN
               (
                    (SELECT min(imdb_rating) FROM movies), 
                    (SELECT max(imdb_rating) FROM movies)
               );

6. How many movies were produced by each studio and which studio produced maximum No of Movies?
     
     SELECT studio,
      COUNT(*) as Movies_Count
      FROM movies
      GROUP BY studio
      ORDER BY Movies_Count DESC; 

7. Give a list of Actor’s Name and show how many movies they acted in ?
      
      SELECT 
                  a.name, 
                  GROUP_CONCAT(m.title SEPARATOR ' | ') as movies,
                  COUNT(m.title) as movies_count
      FROM actors a
      JOIN movie_actor ma ON a.actor_id=ma.actor_id
      JOIN movies m ON ma.movie_id=m.movie_id
      GROUP BY a.actor_id
      ORDER BY movies_count DESC;

8. What are the names of the movies released after the year 2000 and that made profit more than 500 million $ or  more ?
      
      WITH profit AS
         (
              SELECT title, release_year, (revenue-budget) as profit
              FROM movies m
              JOIN financials f
              ON m.movie_id=f.movie_id
              WHERE release_year>2000 and industry="hollywood"
         )
             SELECT * FROM profit WHERE profit>500;

9. Find profit of all Bollywood movies and sort them by profit amount (profit should be in millions for better comparisons) ?

SELECT 
    	    m.movie_id, m.title, f.revenue, f.currency, f.unit, 
             CASE 
                      WHEN f.unit = "Thousands" THEN ROUND ((f.revenue - f.budget) / 1000, 2)
                      WHEN f.unit = "Billions"   THEN ROUND ((f.revenue - f.budget) * 1000, 2)
                      ELSE f.revenue - f.budget
             END AS profit_mln
FROM movies m
JOIN financials f 
ON m.movie_id = f.movie_id
WHERE m.industry = "Bollywood"
ORDER BY profit_mln DESC;

10. Name the Top 10 most profitable movies of all time ?

WITH cte as (
SELECT
           movie_id, budget, revenue, currency,  unit,
           IF (currency='USD', (revenue-budget)*83,(revenue-budget)) as profit_inr, 
           IF (unit  = "BILLIONS",1000,1) as Millions  
FROM financials
)
    SELECT
          c.movie_id, m.Title, m.Industry, budget, revenue, currency, unit,
          ROUND(profit_inr*Millions,1) as profit_Mln_inr
    FROM  
          cte c
    JOIN 
         movies m
    ON
        m.Movie_id=c.movie_id
    ORDER BY profit_Mln_inr desc
    LIMIT 10;

11. which movies made 500% profit or more whose imdb rating is less than the average rating of all the movies  ?

WITH  X as 
	      (
          SELECT *, 
                 ROUND((revenue-budget)*100/budget,2) as pct_profit
                 FROM financials
                       ),
  Y as 
	      (
          SELECT * FROM movies
                 WHERE imdb_rating < (SELECT AVG(imdb_rating)
                 FROM movies)
                       )
SELECT 
         X.movie_id, Y.title, X.pct_profit, Y.imdb_rating
	FROM X
	JOIN Y  ON X.movie_id = Y.movie_id
	WHERE X.pct_profit > 500;




