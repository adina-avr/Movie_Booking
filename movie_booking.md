Proiect MySQL: Baza de Date pentru Rezervare Filme

Descrierea Proiectului
Această bază de date gestionează sistemul de rezervare a biletelor pentru filme. Aplicația permite:

Stocarea informațiilor despre filme, clienți și cinematografe.
Gestionarea programărilor filmelor.
Administrarea rezervărilor clienților pentru diferite programări.
Baza de date conține următoarele tabele:

movies: stochează informații despre filme.
customers: conține detalii despre clienți.
cinemas: stochează informații despre cinematografe.
showtimes: conține programările filmelor în cinematografe.
bookings: înregistrează rezervările făcute de clienți.

Structura Tabelelor și Relațiile

Relațiile dintre Tabele
movies ↔ showtimes: Relație de tip one-to-many. Fiecare film poate avea mai multe programări.
cinemas ↔ showtimes: Relație de tip one-to-many. Un cinematograf poate găzdui mai multe programări.
showtimes ↔ bookings: Relație de tip one-to-many. O programare poate avea mai multe rezervări.
customers ↔ bookings: Relație de tip one-to-many. Un client poate face mai multe rezervări.

Crearea Tabelelor (DDL)

-- Tabelul `movies`
CREATE TABLE movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    duration INT
);

-- Tabelul `customers`
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Tabelul `cinemas`
CREATE TABLE cinemas (
    cinema_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- Tabelul `showtimes`
CREATE TABLE showtimes (
    showtime_id INT PRIMARY KEY AUTO_INCREMENT,
    movie_id INT,
    cinema_id INT,
    show_date DATE,
    show_time TIME,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
    FOREIGN KEY (cinema_id) REFERENCES cinemas(cinema_id)
);

-- Tabelul `bookings`
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    showtime_id INT,
    seats_reserved INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (showtime_id) REFERENCES showtimes(showtime_id)
);
Inserarea Datelor (DML)

-- Inserare filme
INSERT INTO movies (title, genre, duration) VALUES 
('Inception', 'Sci-Fi', 148),
('The Dark Knight', 'Action', 152),
('Interstellar', 'Sci-Fi', 169);

-- Inserare clienți
INSERT INTO customers (name, email) VALUES 
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

-- Inserare cinematografe
INSERT INTO cinemas (name, location) VALUES 
('Cinema City', 'Downtown'),
('IMAX', 'Mall Area');

-- Inserare programări filme
INSERT INTO showtimes (movie_id, cinema_id, show_date, show_time) VALUES 
(1, 1, '2024-11-12', '18:00'),
(2, 2, '2024-11-12', '20:30');

-- Inserare rezervări
INSERT INTO bookings (customer_id, showtime_id, seats_reserved) VALUES 
(1, 1, 2),
(2, 2, 3);
Extragerea Datelor (DQL)
Select simplu

-- Afișarea tuturor filmelor
SELECT * FROM movies;

Filtrare cu operatori

-- Afișarea rezervărilor cu mai mult de 2 locuri rezervate
SELECT * FROM bookings WHERE seats_reserved > 2;

-- Afișarea programărilor din "IMAX" pentru filme Sci-Fi
SELECT m.title, c.name, s.show_date, s.show_time
FROM showtimes s
JOIN movies m ON s.movie_id = m.movie_id
JOIN cinemas c ON s.cinema_id = c.cinema_id
WHERE c.name = 'IMAX' AND m.genre = 'Sci-Fi';

Funcții agregate și clauza GROUP BY

-- Total locuri rezervate pe programare
SELECT showtime_id, SUM(seats_reserved) AS total_seats
FROM bookings
GROUP BY showtime_id;

-- Cinematografe cu mai mult de 3 locuri rezervate pentru un film
SELECT c.name, SUM(b.seats_reserved) AS total_reserved
FROM bookings b
JOIN showtimes s ON b.showtime_id = s.showtime_id
JOIN cinemas c ON s.cinema_id = c.cinema_id
GROUP BY c.cinema_id
HAVING total_reserved > 3;
Join-uri și Subinterogări

Join-uri

-- INNER JOIN între `bookings` și `customers`
SELECT b.booking_id, c.name AS customer_name, b.seats_reserved
FROM bookings b
INNER JOIN customers c ON b.customer_id = c.customer_id;

-- LEFT JOIN pentru a arăta toate filmele și programările, inclusiv cele fără rezervări
SELECT m.title, s.show_date, s.show_time, b.booking_id
FROM movies m
LEFT JOIN showtimes s ON m.movie_id = s.movie_id
LEFT JOIN bookings b ON s.showtime_id = b.showtime_id;

Subqueries

-- Filmele cu rezervări peste 3 locuri
SELECT title
FROM movies
WHERE movie_id IN (
    SELECT s.movie_id
    FROM showtimes s
    JOIN bookings b ON s.showtime_id = b.showtime_id
    WHERE b.seats_reserved > 3
);
Relații între Tabele
movies ↔ showtimes: movies.movie_id este cheie primară, iar showtimes.movie_id este cheie secundara.
.
cinemas ↔ showtimes: cinemas.cinema_id este cheie primară, iar showtimes.cinema_id este cheie secundara.
.
showtimes ↔ bookings: showtimes.showtime_id este cheie primară, iar bookings.showtime_id este cheie secundara.
.
customers ↔ bookings: customers.customer_id este cheie primară, iar bookings.customer_id este cheie secundara.
.
Concluzii
Această bază de date permite gestionarea completă a unui sistem de rezervări pentru filme, cu relații bine definite între tabele și o structură care asigură integritatea datelor. Proiectul oferă suport pentru interogări complexe, filtrări și analize prin utilizarea funcțiilor SQL.-