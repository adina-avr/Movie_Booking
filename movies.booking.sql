-- Crearea bazei de date
CREATE DATABASE MovieBooking;
USE MovieBooking;

-- Crearea tabelei Movies
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,  -- Cheia primară
    title VARCHAR(100) NOT NULL,
    director VARCHAR(100),
    genre VARCHAR(50),
    release_year INT
);

-- Crearea tabelei Customers
CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY, -- Cheia primară
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15)
);

-- Crearea tabelei Cinemas
CREATE TABLE Cinemas (
    cinema_id INT AUTO_INCREMENT PRIMARY KEY,  -- Cheia primară
    cinema_name VARCHAR(100),
    location VARCHAR(100)
);

-- Crearea tabelei Showtimes
CREATE TABLE Showtimes (
    showtime_id INT AUTO_INCREMENT PRIMARY KEY,  -- Cheia primară
    movie_id INT, 
    cinema_id INT, 
    showtime DATETIME,  -- Ora și data proiecției
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (cinema_id) REFERENCES Cinemas(cinema_id)
);

-- Crearea tabelei Bookings
CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,  -- Cheia primară
    customer_id INT, 
    showtime_id INT, 
    seats INT,  -- Numărul de locuri rezervate
    total_price DECIMAL(10, 2),  -- Prețul total al rezervării
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (showtime_id) REFERENCES Showtimes(showtime_id)
);
-- Inserarea de filme
INSERT INTO Movies (title, director, genre, release_year) VALUES
('Inception', 'Christopher Nolan', 'Sci-Fi', 2010),
('The Dark Knight', 'Christopher Nolan', 'Action', 2008),
('Avatar', 'James Cameron', 'Sci-Fi', 2009),
('The Matrix', 'The Wachowskis', 'Action', 1999);

-- Inserarea de clienți
INSERT INTO Customers (name, email, phone_number) VALUES
('Alexandru','alexandru@yahoo.com', '0758943211'),
('Maria','maria_93@gmail.com', '0744943266'),
('Mihai','mihai_m@yahoo.com', '0767943200'),
('Ana','ana_maria@yahoo.com', '0735563201');

-- Inserarea de cinematografe
INSERT INTO Cinemas (cinema_name, location) VALUES
('Cinema City', 'Bucharest'),
('Movieplex''Bucharest'),
('Cinema Palace', 'Oradea'),
('Cine Gold', 'Sibiu');

-- Inserarea de proiecții
INSERT INTO Showtimes (movie_id, cinema_id, showtime) VALUES
(1, 1, '2024-12-01 18:30:00'),
(1, 2, '2024-12-01 20:30:00'),
(2, 1, '2024-12-02 19:00:00'),
(3, 2, '2024-12-03 17:00:00');

-- Inserarea de rezervări
INSERT INTO Bookings (customer_id, showtime_id, seats, total_price) VALUES
(1, 1, 2, 30.00),
(2, 2, 3, 45.00);

-- Instructiuni DML (Delete, Update)
-- Șterge o rezervare
DELETE FROM Bookings WHERE booking_id = 1;

-- Actualizează numărul de locuri rezervate
UPDATE Bookings SET seats = 5, total_price = 75.00 WHERE booking_id = 2;

-- Instrucțiuni DQL (Select, Filtrare)
-- Selectează toate filmele
SELECT * FROM Movies;

-- Selectează toate filmele dintr-un anumit gen
SELECT title, director, release_year FROM Movies WHERE genre = 'Sci-Fi';

-- Selectează detaliile unei rezervări, incluzând datele clienților și filmele rezervate
SELECT b.booking_id, c.name AS customer_name, m.title AS movie_title, b.seats, b.total_price
FROM Bookings b
INNER JOIN Customers c ON b.customer_id = c.customer_id
INNER JOIN Showtimes s ON b.showtime_id = s.showtime_id
INNER JOIN Movies m ON s.movie_id = m.movie_id;

-- Functii agregate
-- Numără câte bilete sunt rezervate per film
SELECT m.title, COUNT(b.booking_id) AS total_bookings
FROM Movies m
INNER JOIN Showtimes s ON m.movie_id = s.movie_id
INNER JOIN Bookings b ON s.showtime_id = b.showtime_id
GROUP BY m.title;

-- Filme cu mai mult de 2 rezervări
SELECT m.title, COUNT(b.booking_id) AS total_bookings
FROM Movies m
INNER JOIN Showtimes s ON m.movie_id = s.movie_id
INNER JOIN Bookings b ON s.showtime_id = b.showtime_id
GROUP BY m.title
HAVING COUNT(b.booking_id) > 1;

-- Join-uri
-- INNER JOIN: Rezervări pentru filmele disponibile într-un cinematograf
SELECT c.name, m.title, b.seats, b.total_price
FROM Bookings b
INNER JOIN Customers c ON b.customer_id = c.customer_id
INNER JOIN Showtimes s ON b.showtime_id = s.showtime_id
INNER JOIN Movies m ON s.movie_id = m.movie_id
INNER JOIN Cinemas c1 ON s.cinema_id = c1.cinema_id
WHERE c1.cinema_name = 'Cinema City';

-- LEFT JOIN: Toate filmele și câte rezervări au avut, inclusiv filmele fără rezervări
SELECT m.title, COUNT(b.booking_id) AS total_bookings
FROM Movies m
LEFT JOIN Showtimes s ON m.movie_id = s.movie_id
LEFT JOIN Bookings b ON s.showtime_id = b.showtime_id
GROUP BY m.title;

-- RIGHT JOIN: Toate rezervările și filmele corespunzătoare
SELECT b.booking_id, m.title
FROM Bookings b
RIGHT JOIN Showtimes s ON b.showtime_id = s.showtime_id
RIGHT JOIN Movies m ON s.movie_id = m.movie_id;

-- Subqueries
-- Găsește filmele care au avut mai mult de 1 rezervare
SELECT title FROM Movies
WHERE movie_id IN (
    SELECT m.movie_id
    FROM Movies m
    INNER JOIN Showtimes s ON m.movie_id = s.movie_id
    INNER JOIN Bookings b ON s.showtime_id = b.showtime_id
    GROUP BY m.movie_id
    HAVING COUNT(b.booking_id) > 1
);

-- Găsește rezervările făcute pentru filmele care rulează într-un anumit cinematograf
SELECT b.booking_id, b.total_price
FROM Bookings b
WHERE b.showtime_id IN (
    SELECT showtime_id
    FROM Showtimes
    WHERE cinema_id = 1
);
