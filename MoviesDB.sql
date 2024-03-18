1. How many Bollywood and Hollywood  movies are present in the dataset ?

SELECT industry, COUNT(*) as Movies_Count
FROM movies
GROUP BY industry;

2. How many movies were released in each year respectively and  in which year maximum no of movies produced ?

SELECT Release_Year, COUNT(*) as Movies_Count 
FROM movies
GROUP BY Release_Year
ORDER BY Release_Year DESC;

