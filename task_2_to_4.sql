DROP DATABASE IF EXISTS bda_proj_2;

CREATE DATABASE bda_proj_2;

\c bda_proj_2;

-- Task 2.

CREATE TABLE actors (
    actor_id SERIAL PRIMARY KEY,
    full_name VARCHAR,
    city VARCHAR,
    date_of_birth DATE,
    age INT
);

CREATE TABLE shows (
    show_id SERIAL PRIMARY KEY,
    title VARCHAR,
    genre VARCHAR,
    medium VARCHAR,
    release_date DATE
);

CREATE TABLE actors_shows (
    actor_id INT REFERENCES actors(actor_id) ON DELETE NO ACTION,
    show_id INT REFERENCES shows(show_id) ON DELETE NO ACTION,
    acting_role VARCHAR,
    PRIMARY KEY (actor_id, show_id)
);

CREATE TABLE subscription_plans (
    subscription_plan_id SERIAL PRIMARY KEY,
    plan_name VARCHAR,
    price INT,
    duration_in_months INT
);

CREATE TABLE users (
    username VARCHAR PRIMARY KEY,
    city VARCHAR,
    country VARCHAR,
    age INT,
    email VARCHAR,
    pass_word VARCHAR,
    subscription_plan_id INT REFERENCES subscription_plans(subscription_plan_id) ON DELETE NO ACTION
);

CREATE TABLE favourites (
    username VARCHAR REFERENCES users(username) ON DELETE CASCADE,
    show_id INT REFERENCES shows(show_id) ON DELETE NO ACTION,
    score INT,
    PRIMARY KEY (username, show_id)
);

CREATE TABLE reviews (
    username VARCHAR REFERENCES users(username) ON DELETE CASCADE,
    show_id INT REFERENCES shows(show_id) ON DELETE NO ACTION,
    score INT,
    comment TEXT,
    PRIMARY KEY (username, show_id)
);

CREATE TABLE active_subscriptions (
    show_id INT REFERENCES shows(show_id) ON DELETE NO ACTION,
    username VARCHAR REFERENCES users(username) ON DELETE NO ACTION,
    PRIMARY KEY (show_id, username)
);

-- Task 3.

INSERT INTO actors
    (full_name, city, date_of_birth, age)
VALUES
    ('Millie Bobby Brown', 'Los Angeles', '2004-02-19', 20),
    ('Bryan Cranston', 'Hollywood', '1956-03-07', 68),
    ('Winona Ryder', 'New York', '1971-10-29', 52),
    ('Aaron Paul', 'Boise', '1979-08-27', 44),
    ('David Harbour', 'White Plains', '1975-04-10', 49)
RETURNING *;

INSERT INTO shows
    (title, genre, medium, release_date)
VALUES
    ('Stranger Things', 'Sci-Fi', 'tv','2016-07-15'),
    ('Breaking Bad', 'Drama', 'tv','2008-01-20'),
    ('The Office', 'Comedy', 'tv','2005-03-24'),
    ('Parks and Recreation','Comedy', 'tv', '2009-04-09'),
    ('The Godfather', 'Crime', 'movie','1972-03-24')
RETURNING *;

INSERT INTO actors_shows
    (actor_id, show_id, acting_role)
VALUES
    (1, 1, 'Eleven'),
    (2, 2, 'Walter White'),
    (3, 1, 'Joyce Byers'),
    (4, 2, 'Jesse Pinkman'),
    (5, 1, 'Jim Hopper')
RETURNING *;

INSERT INTO subscription_plans
    (plan_name, price, duration_in_months)
VALUES
    ('HD', 9.99, 1),
    ('UHD', 14.99, 1)
RETURNING *;

INSERT INTO users
    (username, email, pass_word, subscription_plan_id, city, country, age)
VALUES
    ('john_doe', 'john@example.com', 'password1', 1, 'New York', 'USA', 28),
    ('alice_smith', 'alice@example.com', 'password2', 1, 'Los Angeles', 'USA', 34),
    ('jane_doe', 'jane@example.com', 'password3', 2, 'Chicago', 'USA', 21),
    ('bob_jones', 'bob@example.com', 'password4', 2, 'Boston', 'USA', 30),
    ('emma_johnson', 'emma@example.com', 'password5', 1, 'San Francisco', 'USA', 25)
RETURNING *;

INSERT INTO favourites
    (username, show_id, score)
VALUES
    ('john_doe', 3, 5),
    ('john_doe', 4, 4),
    ('alice_smith', 5, 3),
    ('jane_doe', 1, 5),
    ('bob_jones', 2, 4)
RETURNING *;

INSERT INTO reviews
    (username, show_id, score, comment)
VALUES
    ('john_doe', 1, 5, 'Amazing show!'),
    ('alice_smith', 2, 3, 'Good show'),
    ('jane_doe', 3, 4, 'Funny and smart'),
    ('bob_jones', 4, 2, 'Not my taste'),
    ('emma_johnson', 5, 5, 'A classic!')
RETURNING *;

INSERT INTO active_subscriptions
    (show_id, username)
VALUES
    (1, 'john_doe'),
    (2, 'alice_smith'),
    (3, 'jane_doe'),
    (4, 'bob_jones'),
    (5, 'emma_johnson')
RETURNING *;

-- Task 4.

\echo '\n 4.1 Export all data about users in the HD subscriptions.'
SELECT users.*, plan_name
FROM users
INNER JOIN subscription_plans USING (subscription_plan_id)
WHERE plan_name = 'HD';

\echo '\n 4.2 Export all data about actors and their associated movies.'
SELECT *
FROM actors
LEFT JOIN actors_shows USING (actor_id)
LEFT JOIN shows USING (show_id);

\echo '\n 4.3 Export all data to group actors from a specific city, showing also the average age (per city).'
SELECT city, COUNT(actor_id) AS "number_of_actors", AVG(age) AS "average_age"
FROM actors
GROUP BY city;

\echo '\n 4.4 Export all data to show the favourite comedy movies for a specific user.'
SELECT *
FROM favourites
INNER JOIN shows USING (show_id)
WHERE genre = 'Comedy'
    AND username = 'john_doe';

\echo '\n 4.5 Export all data to count how many subscriptions are in the database per country.'
SELECT country, COUNT(show_id) AS "subscription_count"
FROM users
LEFT JOIN active_subscriptions USING (username)
GROUP BY country;

\echo '\n 4.6 Export all data to find the movies that start with the keyword The .'
SELECT *
FROM shows
WHERE title LIKE 'The%';

\echo '\n 4.7 Export data to find the number of subscriptions per movie category.'
SELECT genre, COUNT(username) as "subscription_count"
FROM shows
LEFT JOIN active_subscriptions USING (show_id)
GROUP BY genre;

\echo '\n 4.8 Export data to find the username and the city of the youngest customer in the UHD subscription category.'
WITH uhd_plan_id AS (
    SELECT subscription_plan_id
    FROM subscription_plans
    WHERE plan_name = 'UHD'
),
min_age_of_uhd AS (
    SELECT MIN(age) as age
    FROM users
    WHERE subscription_plan_id = (SELECT subscription_plan_id FROM uhd_plan_id)
)
SELECT username, city, age, plan_name
FROM users
INNER JOIN subscription_plans USING (subscription_plan_id)
WHERE plan_name = 'UHD'
    AND age = (SELECT age FROM min_age_of_uhd);

\echo '\n 4.9 Export data to find users between 22 - 30 years old (including 22 and 30 ).'
SELECT *
FROM users
WHERE age BETWEEN 22 AND 30;

\echo '\n 4.10 Export data to find the average age of users with low score reviews (less than 3). Group your data for users under 20, 21-40, and 41 and over.'
WITH low_score_users AS (
    SELECT username
    FROM reviews
    WHERE score < 3
)
SELECT AVG(age) AS "average_age",
CASE
    WHEN age <= 20 THEN 'under 20'
    WHEN age BETWEEN 21 AND 40 THEN '21 - 40'
    WHEN age >= 41 THEN '41 and over'
END AS "age_group"
FROM users
WHERE username IN (SELECT username FROM low_score_users)
GROUP BY age;
