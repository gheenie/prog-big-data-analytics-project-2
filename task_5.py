import pg8000.native

from config._env_development import (user, password)

connection = pg8000.native.Connection(user=user, password=password, database='bda_proj_2')


def query_1(plan_name):
    query = f'''
        SELECT users.*, plan_name
        FROM users
        INNER JOIN subscription_plans USING (subscription_plan_id)
        WHERE plan_name = '{plan_name}';
    '''
    rows = connection.run(query)
    columns = [metadata['name'] for metadata in connection.columns]
    print('Column names in order: ', columns)
    for row in rows:
        print(row)


def query_2(full_name):
    query = f'''
        SELECT *
        FROM actors
        LEFT JOIN actors_shows USING (actor_id)
        LEFT JOIN shows USING (show_id)
        WHERE full_name = '{full_name}';
    '''
    rows = connection.run(query)
    columns = [metadata['name'] for metadata in connection.columns]
    print('Column names in order: ', columns)
    for row in rows:
        print(row)


def query_3(city):
    query = f'''
        SELECT city, COUNT(actor_id) AS "number_of_actors", AVG(age) AS "average_age"
        FROM actors
        WHERE city = '{city}'
        GROUP BY city;
    '''
    rows = connection.run(query)
    columns = [metadata['name'] for metadata in connection.columns]
    print('Column names in order: ', columns)
    for row in rows:
        print(row)


def query_4(genre, username):
    query = f'''
        SELECT *
        FROM favourites
        INNER JOIN shows USING (show_id)
        WHERE genre = '{genre}'
            AND username = '{username}';
    '''
    rows = connection.run(query)
    columns = [metadata['name'] for metadata in connection.columns]
    print('Column names in order: ', columns)
    for row in rows:
        print(row)


def query_5(country):
    query = f'''
        SELECT country, COUNT(show_id) AS "subscription_count"
        FROM users
        LEFT JOIN active_subscriptions USING (username)
        WHERE country = '{country}'
        GROUP BY country;
    '''
    rows = connection.run(query)
    columns = [metadata['name'] for metadata in connection.columns]
    formatted_results = [
        {column: row[i] for (i, column) in enumerate(columns)}
        for row in rows
    ]
    for row in formatted_results:
        print(row)


def run_queries_with_fixed_inputs():
    query_1('HD')
    query_1('UHD')
    query_2('Millie Bobby Brown')
    query_2('Bryan Cranston')
    query_3('Los Angeles')
    query_3('Hollywood')
    query_4('Comedy', 'john_doe')
    query_5('USA')


run_queries_with_fixed_inputs()


def run_queries_with_user_inputs():
    plan_name = input('Enter a plan name to view users under that plan: ')
    query_1(plan_name)
    full_name = input("Enter an actor's full name to view all data of her and her associated shows: ")
    query_2(full_name)
    city = input('Enter a city to find the number of actors in that city and their average age: ')
    query_3(city)
    genre = input('Enter a genre first: ')
    username = input("Then enter a username to view that user's favourite shows in that genre: ")
    query_4(genre, username)
    country = input('Enter a country to find the total number of subscriptions in that country: ')
    query_5(country)


# run_queries_with_user_inputs()
