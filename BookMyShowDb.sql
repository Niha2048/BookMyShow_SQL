-- Step 1: Create a new database
CREATE DATABASE bookmyshow_clean;

-- Step 2: Switch to the new database
USE bookmyshow_clean;

-- Step 3: Create tables

-- Theatre table
CREATE TABLE Theatres (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- Movie table
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    language VARCHAR(50),
    genre VARCHAR(50),
    duration INT
);

-- Shows table
CREATE TABLE Shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT,
    movie_id INT,
    show_date DATE,
    show_time TIME,
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Bookings table
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT,
    user_id INT,
    seat_number VARCHAR(10),
    booking_date DATE,
    FOREIGN KEY (show_id) REFERENCES Shows(show_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Switch to the new schema
USE bookmyshow_clean;

-- Insert into Theatres
INSERT INTO Theatres (name, location) 
VALUES 
('PVR Koramangala', 'Bangalore'),
('INOX Forum Mall', 'Bangalore');

-- Insert into Movies
INSERT INTO Movies (title, language, genre, duration) 
VALUES 
('Inception', 'English', 'Sci-Fi', 148),
('RRR', 'Telugu', 'Action', 180),
('3 Idiots', 'Hindi', 'Comedy', 170);

-- Insert into Shows
INSERT INTO Shows (theatre_id, movie_id, show_date, show_time) 
VALUES 
(1, 1, '2026-09-12', '18:30:00'),
(1, 2, '2026-09-12', '21:30:00'),
(2, 3, '2026-09-12', '17:00:00');

-- Insert into Users
INSERT INTO Users (name, email, phone) 
VALUES 
('Nithya', 'nithya@example.com', '9876543210'),
('Rahul', 'rahul@example.com', '9123456789');

-- Insert into Bookings
INSERT INTO Bookings (show_id, user_id, seat_number, booking_date) 
VALUES 
(1, 1, 'A10', '2026-09-10'),
(2, 2, 'B15', '2026-09-11');


SHOW TABLES;


SELECT * FROM Theatres;
SELECT * FROM Movies;
SELECT * FROM Shows;
SELECT * FROM Users;
SELECT * FROM Bookings;

-- P2
SELECT m.title, s.show_time
FROM Shows s
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Theatres t ON s.theatre_id = t.theatre_id
WHERE s.show_date = '2026-09-12'
  AND t.name = 'PVR Koramangala';

