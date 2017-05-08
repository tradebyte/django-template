PYTHON=./env/bin/python
PIP=./env/bin/pip

setup: virtualenv requirements

virtualenv:
	test -x $(PYTHON) | python3 -m venv myenv

requirements:
	$(PIP) install -r requirements.txt --upgrade
