import pg8000.native

from config._env_development import (user, password)

connection = pg8000.native.Connection(user=user, password=password, database='bda_proj_2')


def task_4_1(plan_name):
    query = f'''
        SELECT users.*, plan_name
        FROM users
        INNER JOIN subscription_plans USING (subscription_plan_id)
        WHERE plan_name = '{plan_name}';
    '''
    rows = connection.run(query)
    for row in rows:
        print(row)


task_4_1('HD')
task_4_1('UHD')
