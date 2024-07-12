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
5. Test the entire project by running index.py from the project root
```
python src/index.py
```
6. When finished, deactivate your virtual environment
```
deactivate
```

Whenever you want to revisit the project after the first time, skip steps 2 and 4.
