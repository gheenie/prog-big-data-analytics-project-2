To run the scripts in a self-contained environment for the first time, follow the steps below.

1. Change your current working directory to the project root
2. Create a virtual environment
```
python -m venv venv
```
3. Activate your virtual environment and set PYTHONPATH
```
source venv/bin/activate
export PYTHONPATH=$(pwd)
```
4. Install required packages
```
pip install requirements.txt
```
5. Ensure you have PostgreSQL installed and started.
6. Test task 2 to 4 SQL scripts by running the block below. Text files with results will be generated.
```
./run_all.sh
```
7. Create a folder and file so you have the following
```
config/_env_development.py
```
8. This file should contain the following, with the user and password of your PostgreSQL user inserted. Modify the host if running the script in a cloud platform instead of locally
```
user=''
password=''
database='bda_proj_2'
host='localhost'
```
9. Run task 5 with the code below
```
python task_5.py
```
10. Run task_6.py in whichever environment you have Docker and Cassandra installed and set up.
11. When finished, deactivate your virtual environment
```
deactivate
```

Whenever you want to revisit the project after the first time, skip steps 2, 4, 7, and 8.
