CREATE KEYSPACE bda_proj_2
WITH REPLICATION = {
    'class': 'SimpleStrategy',
    'replication_factor': 3
};

USE bda_proj_2;

CREATE TABLE bda_proj_2.users (
    username TEXT,
    city TEXT,
    country TEXT,
    age INT,
    email TEXT,
    pass_word TEXT,
    subscription_plan_id INT,
    PRIMARY KEY (username)
);

INSERT INTO bda_proj_2.users
    (username, email, pass_word, subscription_plan_id, city, country, age)
VALUES
    ('john_doe', 'john@example.com', 'password1', 1, 'New York', 'USA', 28);
INSERT INTO bda_proj_2.users
    (username, email, pass_word, subscription_plan_id, city, country, age)
VALUES
    ('alice_smith', 'alice@example.com', 'password2', 1, 'Los Angeles', 'USA', 34);
INSERT INTO bda_proj_2.users
    (username, email, pass_word, subscription_plan_id, city, country, age)
VALUES
    ('jane_doe', 'jane@example.com', 'password3', 2, 'Chicago', 'USA', 21);
INSERT INTO bda_proj_2.users
    (username, email, pass_word, subscription_plan_id, city, country, age)
VALUES
    ('bob_jones', 'bob@example.com', 'password4', 2, 'Boston', 'USA', 30);
INSERT INTO bda_proj_2.users
    (username, email, pass_word, subscription_plan_id, city, country, age)
VALUES
    ('emma_johnson', 'emma@example.com', 'password5', 1, 'San Francisco', 'USA', 25);

CREATE INDEX ON bda_proj_2.users (country);
CREATE INDEX ON bda_proj_2.users (city);
