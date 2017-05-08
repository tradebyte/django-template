PYTHON=./env/bin/python
PIP=./env/bin/pip
TESTMODULE?={{ project_name }}.tests

define PRECOMMIT
#!/bin/sh
git-pylint-commit-hook --ignore urls.py --ignore wsgi.py
endef

export PRECOMMIT

setup: virtualenv requirements

virtualenv:
	test -x $(PYTHON) | python3 -m venv myenv

requirements:
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
