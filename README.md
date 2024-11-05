# Movie_Booking
Database Project for "MovieBooking"
The scope of this project is to use all the SQL knowledge gained throught the Software Testing course and apply them in practice.

Application under test: Rezervare filme

Tools used: MySQL Workbench

Database description: Proiectul propus se referă la o aplicație de rezervare de filme, având ca scop gestionarea utilizatorilor, filmelor, sălilor de cinema, rezervărilor și programărilor. Baza de date va conține următoarele tabele:
1.	Users - Informații despre utilizatori
2.	Movies - Detalii despre filme
3.	Cinemas - Informații despre cinematografe
4.	Showtimes - Programările filmelor în diferite cinematografe
5.	Bookings - Rezervările efectuate de utilizatori pentru filme


Database Schema
You can find below the database schema that was generated through Reverse Engineer and which contains all the tables and the relationships between them.

The tables are connected in the following way:

1. Movies
•	movie_id (Primary Key)
•	title
•	director
•	genre
•	release_year

2. Customers
•	customer_id (Primary Key)
•	email
•	phone_number

3. Cinemas
•	cinema_id (Primary Key)
•	cinema_name
•	location

4.  Showtimes
•	showtime_id (Primary Key)
•	movie_id (Foreign Key - legat de Movies.movie_id)
•	cinema_id (Foreign Key - legat de Cinemas.cinema_id)
•	showtime

5.  Bookings
•	booking_id (Primary Key)
•	customer_id (Foreign Key - legat de Customer.customer_id)
•	showtime_id (Foreign Key - legat de Showtimes.showtime_id)
•	seats
•	total_price

Database Queries
DDL (Data Definition Language)
The following instructions were written in the scope of CREATING the structure of the database (CREATE INSTRUCTIONS)

create database MovieBooking
create table Movies
create table Customers 
create table Cinemas
create table Showtimes
create table Bookings

DML (Data Manipulation Language)
In order to be able to use the database I populated the tables with various data necessary in order to perform queries and manipulate the data. In the testing process, this necessary data is identified in the Test Design phase and created in the Test Implementation phase.

Below you can find all the insert instructions that were created in the scope of this project:
insert into Movies 
insert into Customer 
insert into Cinemas
insert into Showtimes
insert into Bookings

After the testing process, I deleted the data that was no longer relevant in order to preserve the database clean:
DELETE FROM Bookings WHERE booking_id = 1; ( Șterge o rezervare)

DQL (Data Query Language)
In order to simulate various scenarios that might happen in real life I created the following queries that would cover multiple potential real-life situations:

Inserati aici toate instructiunile de SELECT pe care le-ati scris folosind filtrarile necesare astfel incat sa extrageti doar datele de care aveti nevoie Incercati sa acoperiti urmatoarele:
Selectează toate filmele - SELECT * FROM Movies;

Selectează toate filmele dintr-un anumit gen - SELECT title, director, release_year FROM Movies WHERE genre = 'Sci-Fi';

 Selectează detaliile unei rezervări, incluzând datele clienților și filmele rezervate - SELECT b.booking_id, c.name AS customer_name, m.title AS movie_title, b.seats, b.total_price
FROM Bookings b
INNER JOIN Customers c ON b.customer_id = c.customer_id
INNER JOIN Showtimes s ON b.showtime_id = s.showtime_id
INNER JOIN Movies m ON s.movie_id = m.movie_id;

 Functii agregate
Numără câte bilete sunt rezervate per film - SELECT m.title, COUNT(b.booking_id) AS total_bookings
FROM Movies m
INNER JOIN Showtimes s ON m.movie_id = s.movie_id
INNER JOIN Bookings b ON s.showtime_id = b.showtime_id
GROUP BY m.title;

Filme cu mai mult de 2 rezervări - SELECT m.title, COUNT(b.booking_id) AS total_bookings
FROM Movies m
INNER JOIN Showtimes s ON m.movie_id = s.movie_id
INNER JOIN Bookings b ON s.showtime_id = b.showtime_id
GROUP BY m.title
HAVING COUNT(b.booking_id) > 1;

Rezervări pentru filmele disponibile într-un cinematograf
SELECT c.name, m.title, b.seats, b.total_price
FROM Bookings b
INNER JOIN Customers c ON b.customer_id = c.customer_id
INNER JOIN Showtimes s ON b.showtime_id = s.showtime_id
INNER JOIN Movies m ON s.movie_id = m.movie_id
INNER JOIN Cinemas c1 ON s.cinema_id = c1.cinema_id
WHERE c1.cinema_name = 'Cinema City';

Toate filmele și câte rezervări au avut, inclusiv filmele fără rezervări
SELECT m.title, COUNT(b.booking_id) AS total_bookings
FROM Movies m
LEFT JOIN Showtimes s ON m.movie_id = s.movie_id
LEFT JOIN Bookings b ON s.showtime_id = b.showtime_id
GROUP BY m.title;

Toate rezervările și filmele corespunzătoare
SELECT b.booking_id, m.title
FROM Bookings b
RIGHT JOIN Showtimes s ON b.showtime_id = s.showtime_id
RIGHT JOIN Movies m ON s.movie_id = m.movie_id;

Subqueries
Găsește filmele care au avut mai mult de 1 rezervare
SELECT title FROM Movies
WHERE movie_id IN (
    SELECT m.movie_id
    FROM Movies m
    INNER JOIN Showtimes s ON m.movie_id = s.movie_id
    INNER JOIN Bookings b ON s.showtime_id = b.showtime_id
    GROUP BY m.movie_id
    HAVING COUNT(b.booking_id) > 1

Găsește rezervările făcute pentru filmele care rulează într-un anumit cinematograf
SELECT b.booking_id, b.total_price
FROM Bookings b
WHERE b.showtime_id IN (
    SELECT showtime_id
    FROM Showtimes
    WHERE cinema_id = 1

Conclusions
Această bază de date permite gestionarea eficientă a utilizatorilor, filmelor, sălilor de cinema și rezervărilor, utilizând relații între tabele pentru a asigura integritatea datelor. Instrucțiunile SQL oferă un set complet de operații pentru a interacționa cu baza de date, acoperind cerințele de business pentru o aplicație de rezervare de filme.
