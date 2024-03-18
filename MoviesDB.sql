How many Bollywood and Hollywood  movies are present in the dataset ?
  SELECT industry, COUNT(*) as Movies_Count
  FROM movies
  GROUP BY industry;

How many movies were released in each year respectively and  in which year maximum no of movies produced ?
  SELECT Release_Year, COUNT(*) as Movies_Count 
  FROM movies
  GROUP BY Release_Year
  ORDER BY Release_Year DESC;

Give all the details of the movies having movie ids  105, 117 & 128  ?
  SELECT  * 
  FROM movies 
  WHERE movie_id IN (105, 117, 128);

What is the average rating of all the movies  ?
  SELECT  
  ROUND (AVG(IMDB_Rating),2)
  FROM movies;


