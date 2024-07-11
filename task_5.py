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
    for row in rows:
        print(row)


def query_2():
    query = '''
        SELECT *
        FROM actors
        LEFT JOIN actors_shows USING (actor_id)
        LEFT JOIN shows USING (show_id);
    '''
    rows = connection.run(query)
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
    for row in rows:
        print(row)


query_1('HD')
query_1('UHD')
query_2()
query_3('Hollywood')
query_4('Comedy', 'john_doe')
