# BookMyShow DB Assignment – Entities, SQL, Queries

##  Overview
This project models a simplified **BookMyShow database** with tables for theatres, movies, shows, users, and bookings.  
It includes:
- Normalized schema design
- SQL scripts for table creation and sample inserts
- Queries to retrieve show details by date and theatre

---

##  Database Schema

### Theatres
| Attribute   | Data Type        | Key | Description              |
|-------------|------------------|-----|--------------------------|
| theatre_id  | INT AUTO_INCREMENT | PK  | Unique theatre identifier |
| name        | VARCHAR(100)     |     | Theatre name             |
| location    | VARCHAR(100)     |     | Theatre location         |

### Movies
| Attribute   | Data Type        | Key | Description              |
|-------------|------------------|-----|--------------------------|
| movie_id    | INT AUTO_INCREMENT | PK  | Unique movie identifier   |
| title       | VARCHAR(100)     |     | Movie title              |
| language    | VARCHAR(50)      |     | Language of the movie    |
| genre       | VARCHAR(50)      |     | Genre category           |
| duration    | INT              |     | Duration in minutes      |

### Shows
| Attribute   | Data Type        | Key | Description              |
|-------------|------------------|-----|--------------------------|
| show_id     | INT AUTO_INCREMENT | PK  | Unique show identifier    |
| theatre_id  | INT              | FK  | Linked to Theatres       |
| movie_id    | INT              | FK  | Linked to Movies         |
| show_date   | DATE             |     | Date of the show         |
| show_time   | TIME             |     | Time of the show         |

### Users
| Attribute   | Data Type        | Key | Description              |
|-------------|------------------|-----|--------------------------|
| user_id     | INT AUTO_INCREMENT | PK  | Unique user identifier    |
| name        | VARCHAR(100)     |     | User name                |
| email       | VARCHAR(100) UNIQUE |   | User email               |
| phone       | VARCHAR(15)      |     | User phone number        |

### Bookings
| Attribute   | Data Type        | Key | Description              |
|-------------|------------------|-----|--------------------------|
| booking_id  | INT AUTO_INCREMENT | PK  | Unique booking identifier |
| show_id     | INT              | FK  | Linked to Shows          |
| user_id     | INT              | FK  | Linked to Users          |
| seat_number | VARCHAR(10)      |     | Seat number booked       |
| booking_date| DATE             |     | Date of booking          |

---

##  Sample Data

### Theatres
| theatre_id | name             | location   |
|------------|------------------|------------|
| 1          | PVR Koramangala  | Bangalore  |
| 2          | INOX Forum Mall  | Bangalore  |

### Movies
| movie_id | title     | language | genre   | duration |
|----------|-----------|----------|---------|----------|
| 1        | Inception | English  | Sci-Fi  | 148      |
| 2        | RRR       | Telugu   | Action  | 180      |
| 3        | 3 Idiots  | Hindi    | Comedy  | 170      |

### Shows
| show_id | theatre_id | movie_id | show_date   | show_time |
|---------|------------|----------|-------------|-----------|
| 1       | 1          | 1        | 2026-09-12  | 18:30:00  |
| 2       | 1          | 2        | 2026-09-12  | 21:30:00  |
| 3       | 2          | 3        | 2026-09-12  | 17:00:00  |

### Users
| user_id | name   | email              | phone       |
|---------|--------|--------------------|-------------|
| 1       | Nithya | nithya@example.com | 9876543210  |
| 2       | Rahul  | rahul@example.com  | 9123456789  |

### Bookings
| booking_id | show_id | user_id | seat_number | booking_date |
|------------|---------|---------|-------------|--------------|
| 1          | 1       | 1       | A10         | 2026-09-10   |
| 2          | 2       | 2       | B15         | 2026-09-11   |

---

##  SQL Scripts

### P1 – Table Creation
```sql
CREATE DATABASE bookmyshow_clean;
USE bookmyshow_clean;

-- Theatres
CREATE TABLE Theatres (
    theatre_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL
);

-- Movies
CREATE TABLE Movies (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    language VARCHAR(50),
    genre VARCHAR(50),
    duration INT
);

-- Shows
CREATE TABLE Shows (
    show_id INT PRIMARY KEY AUTO_INCREMENT,
    theatre_id INT,
    movie_id INT,
    show_date DATE,
    show_time TIME,
    FOREIGN KEY (theatre_id) REFERENCES Theatres(theatre_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Users
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15)
);

-- Bookings
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    show_id INT,
    user_id INT,
    seat_number VARCHAR(10),
    booking_date DATE,
    FOREIGN KEY (show_id) REFERENCES Shows(show_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
```

## P2 Query
```sql
SELECT m.title, s.show_time
FROM Shows s
JOIN Movies m ON s.movie_id = m.movie_id
JOIN Theatres t ON s.theatre_id = t.theatre_id
WHERE s.show_date = '2026-09-12'
  AND t.name = 'PVR Koramangala';
```
##  How to Run

1. Open MySQL Workbench.  
2. Run the `BookMyShow_DB.sql` script to create schema and tables.  
3. Insert sample data.  
4. Run the P2 query to verify results.


# Normalization Justification

### 1NF (First Normal Form)
All attributes hold atomic values (no repeating groups or multi‑valued fields).

Example: Movies.title stores a single movie name, not multiple titles.

Bookings.seat_number stores one seat per row, not a list of seats.

### 2NF (Second Normal Form)
Every non‑key attribute depends on the whole primary key, not part of it.

Example: In Shows, show_date and show_time depend on the full show_id, not just theatre_id or movie_id.

No partial dependency exists because composite keys are avoided - each table has a surrogate key (*_id).

### 3NF (Third Normal Form)
No transitive dependencies (non‑key attributes depending on other non‑key attributes).

Example: In Users, email does not determine phone; both depend only on user_id.

In Movies, genre does not determine duration; both depend only on movie_id.

### BCNF (Boyce‑Codd Normal Form)
Every determinant is a candidate key.

Example: In Bookings, the determinant booking_id uniquely determines show_id, user_id, seat_number, and booking_date.

No non‑trivial functional dependency exists where a non‑candidate key determines another attribute.