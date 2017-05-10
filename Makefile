# Setting the target, defaults to "development"
TARGET_FILE=.target

ifeq ($(wildcard $(TARGET_FILE) ),$(TARGET_FILE))
	TARGET?=$(shell cat $(TARGET_FILE))
else
	TARGET?=development
endif

# Python executables
PYTHON=./myenv/bin/python
PIP=./myenv/bin/pip

# Basemodule in which tests reside
TESTMODULE?={{ project_name }}.tests

# Content of the pre-commit hook
define PRECOMMIT
#!/bin/sh
git-pylint-commit-hook --ignore urls.py --ignore wsgi.py
endef

export PRECOMMIT


all: requirements

virtualenv:
	test -x $(PYTHON) | python3 -m venv myenv

requirements: virtualenv
	$(PIP) install -r requirements/base.txt --upgrade
	$(PIP) install -r requirements/$(TARGET).txt --upgrade

# We do it in a single line so if one of the commands exits with > 0 the others get still executed
tests:
	coverage run manage.py test $(TESTMODULE);coverage html;coverage report

tests_no_coverage:
	./manage.py test $(TESTMODULE)

install_pre_commit:
	mv .git/hooks/pre-commit.sample .git/hooks/pre-commit
	echo "$$PRECOMMIT" > .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

psql:
	docker exec -ti --user postgres {{ project_name }} psql --dbname={{ project_name }}

pylint:
	find {{ project_name }}/ -name "*.py" ! -path "{{ project_name }}/settings/*" ! -path "{{ project_name }}/urls.py" ! -path "{{ project_name }}/wsgi.py" -exec pylint --reports=yes "{}" +
