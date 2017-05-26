# Basemodule in which tests reside
TESTMODULE?={{ project_name }}.tests

# Content of the pre-commit hook
define PRECOMMIT
#!/usr/bin/env sh
make lint
endef
export PRECOMMIT


all: images up

images:
	docker-compose build

up:
	docker-compose up {{ project_name }} postgres

lint:
	docker-compose run --rm py find {{ project_name }}/ -name "*.py" ! -path "{{ project_name }}/settings/*" ! -path "{{ project_name }}/urls.py" ! -path "{{ project_name }}/wsgi.py" -exec pylint -ry {} +

test:
	docker-compose run --rm py ./manage.py test $(TESTMODULE)

# We do it in a single line so if one of the commands exits with > 0 the others get still executed
coverage:
	docker-compose run --rm py sh -c 'coverage run manage.py test $(TESTMODULE)&& coverage html && coverage report'

install_pre_commit:
	echo "$$PRECOMMIT" > .git/hooks/pre-commit
	chmod +x .git/hooks/pre-commit

psql:
	docker exec -ti --user postgres {{ project_name }}_postgres psql --dbname={{ project_name }}
