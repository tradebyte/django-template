PYTHON=./myenv/bin/python
PIP=./myenv/bin/pip
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
	$(PIP) install -r requirements.txt --upgrade

tests:
	coverage run manage.py test $(TESTMODULE)
	coverage html
	coverage report

tests_no_coverage:
	./manage.py test $(TESTMODULE)

install_pre_commit:
	mv .git/hooks/pre-commit.sample .git/hooks/pre-commit
	echo "$$PRECOMMIT" > .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit
