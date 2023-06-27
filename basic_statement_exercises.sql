SHOW databases;
USE albums_db;
SELECT *
FROM albums
WHERE artist = 'Pink Floyd';
SELECT *
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
SELECT *
FROM albums
WHERE name = "Nevermind";
SELECT *
FROM albums
WHERE release_date >= 1990 AND release_date <= 1999;
SELECT name AS low_selling_albums
FROM albums
WHERE sales < 20;

/* 
What is the primary key for the albums table?
id
What does the column named 'name' represent?
Name of the album
What do you think the sales column represents?
number of record sold
Find the name of all albums by Pink Floyd.
The Wall, The Dark Side of the Moon
What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
1967 The Beatles
What is the genre for the album Nevermind?
Grunge, Alternative rock
Which albums were released in the 1990s?
Which albums had less than 20 million certified sales? Rename this column as low_selling_albums.

*/