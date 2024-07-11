import mysql.connector
from mysql.connector import Error


def create_server_connection(host_name, user_name, user_password):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection


# # Connect to the server to create a database first if none exists.

# host = "35.188.53.123" # Add here your host IP address from the GCP
# user = "root"
# password = "shareshare" # Add here your password

# connection = create_server_connection(host, user, password)


def create_db_connection(host_name, user_name, user_password, db_name):
    connection = None
    try:
        connection = mysql.connector.connect(
            host=host_name,
            user=user_name,
            passwd=user_password,
            database=db_name
        )
        print("MySQL Database connection successful")
    except Error as err:
        print(f"Error: '{err}'")

    return connection


# Connect to the database directly.

host = "35.188.53.123"
user = "root"
password = "shareshare"
database = "bda_proj_2"

connection = create_db_connection(host, user, password,database)

# Use the database.

cursor = connection.cursor()
cursor.execute(f"USE {database};")


def read_query(connection, query):
    cursor = connection.cursor()
    result = None
    try:
        cursor.execute(query)
        result = cursor.fetchall()
        return result
    except Error as err:
        print(f"Error: '{err}'")


# Procedure for SELECT statements without user input.

query1 = """
SELECT users.*, plan_name
FROM users
INNER JOIN subscription_plans USING (subscription_plan_id)
WHERE plan_name = 'HD';
"""
results = read_query(connection, query1)
for result in results:
    print(result)
