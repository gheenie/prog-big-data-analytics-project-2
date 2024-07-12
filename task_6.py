# Import the driver
from cassandra.cluster import Cluster 

# Create a new cluster
cluster = Cluster() 

# Connect to the cluster's default port
cluster = Cluster(['172.17.0.2','172.17.0.3','172.17.0.4'], port=9042)

# Create the database using CQL first

# Connect to bda_proj_2
session = cluster.connect('bda_proj_2') 
session.set_keyspace('bda_proj_2')

# Use the preffered keyspace
session.execute('USE bda_proj_2') 


def run_query_without_inputs(query):
    # Run a query
    rows = session.execute(query)

    # Iterate and show the query response
    for i in rows: 
        print(i)


print('task 6.2:\n')
query_6_2 = '''
    SELECT *
    FROM bda_proj_2.users;
'''
run_query_without_inputs(query_6_2)
print('\ntask 6.3:\n')
query_6_3 = '''
    SELECT *
    FROM bda_proj_2.users
    WHERE country = 'USA';
'''
run_query_without_inputs(query_6_3)
print('\ntask 6.4:\n')
query_6_4 = '''
    SELECT *
    FROM bda_proj_2.users
    WHERE age >= 22
    AND age <= 30
    ALLOW FILTERING;
'''
run_query_without_inputs(query_6_4)
print('\ntask 6.5:\n')
query_6_5 = '''
    SELECT city, COUNT(username) as "number_of_users"
    FROM bda_proj_2.users
    WHERE city = 'Boston';
'''
run_query_without_inputs(query_6_5)
query_6_5 = '''
    SELECT city, COUNT(username) as "number_of_users"
    FROM bda_proj_2.users
    WHERE city = 'Los Angeles';
'''
run_query_without_inputs(query_6_5)
query_6_5 = '''
    SELECT city, COUNT(username) as "number_of_users"
    FROM bda_proj_2.users
    WHERE city = 'New York';
'''
run_query_without_inputs(query_6_5)
query_6_5 = '''
    SELECT city, COUNT(username) as "number_of_users"
    FROM bda_proj_2.users
    WHERE city = 'San Francisco';
'''
run_query_without_inputs(query_6_5)
# An example with user inputs
query_6_5 = '''
    SELECT city, COUNT(username) as "number_of_users"
    FROM bda_proj_2.users
    WHERE city = %s;
'''
city = input('Enter a city to count the number of users (e.g. Chicago): ')
rows = session.execute(query_6_5, [city])
for i in rows: 
    print(i)
