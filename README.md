{% if not project_name %}

# Project template

You can create a new project out of this template by using a gist.

**Requirements:**
* python3
* bash
* wget

Do the following, replace <project_name> with your desired project name:
```shell
wget -O - https://gist.githubusercontent.com/mjainta/2e57c4b04d1bb9c526dc0843b4353aa5/raw/50ebca17747b2f1875034a8e076ef002e4c11fbf/start-django-project.sh | bash -s <project_name>
```

This will create a folder called *project_name* in the current directory.

{% endif %}# {{ project_name|title }}

## Setup working environment

```shell
$ make
```

This will install a virtualenv in the folder *myenv* and install requirements via pip.

### Using the virtual env

```shell
$ source myenv/bin/activate
(myenv) $
```

You can exclude the myenv directory from version control in *.git/info/exclude*

## Executing tests

```shell
(myenv) $ make tests
```

This will execute all unittests it finds in the {{ project_name }}.tests module.
Also coverage is enabled which ends up in a file called [.coverage](.coverage) in the root directory.
Coverage also generates a html report in *coverage_html_report* and after prints a summary to stdout.

> We aim to get a minimum code coverage of 95%
> Remember to use coverage before committing so the build will not fail after pushing!

If you do not want coverage to be executed, use tests_no_coverage instead
```shell
(myenv) $ make tests_no_coverage
```

Both commands also work with a subset of the tests:
```Shell
(myenv) $ make tests TESTMODULE={{ project_name }}.tests.models
```

Settings for the coverage tool can be found in the [.coveragerc](.coveragerc) file.

## Use the Linter

We gonna use pylint for linting functionality.

> Every file with a rating below 8.0 will be rejected after pushing a commit!

First, install the pre-commit hook which will check your files with the linter before you commit.

> Remember, since it creates a pre-commit hook you need to init the git repository first.

```shell
(myenv) $ make install_pre_commit
```

This will move the *.git/hooks/pre-commit.sample* file to *.git/hooks/pre-commit*, puts content in it and makes it executable.

To use the linter for your added files simply use git-pylint-commit-hook.
```shell
(myenv) $ git-pylint-commit-hook --ignore urls.py --ignore wsgi.py
```

Settings for the linter can be found in the [.pylintrc](.pylintrc) file.

The pylint manual can be found [here](https://pylint.readthedocs.io/en/latest/).
The git-pylint-commit-hook tool can be found on [GitHub](https://github.com/sebdah/git-pylint-commit-hook).

## Using postgresql

Built-in you can use a postgresql database, instead of the sqlite default.

Requirements:
* Edit the [base.py]({{ project_name }}/settings/base.py) and set the **DATABASES** setting as desired.
* Edit the [base.txt](requirements/base.py) and uncomment the line for the **psycopg2** library.
    * After uncommenting, run ```make requirements``` to install **psycopg2**
* Installed docker and docker-compose in version 1.10.0+

The postgresql database is realized using docker. Use ```docker-compose up -d``` to boot the database server.
Use ```docker-compose down``` to bring it back down.

Connect to it via ```make psql```.

> Data is not preserved by default! Modify [docker-compose.yml](docker-compose.yml) to use volumes if you need to.

Documentation on the postgresql image is found on [hub.docker.com](https://hub.docker.com/_/postgres/).

## Deployment

Current stage is set by a file called *.target* in the root directory of the project.
Valid values lead to their requirements, respectively: [development](requirements/development.txt) / [staging](requirements/staging.txt) / [production](requirements/production.txt)

[base](requirements/base.txt) should be included for every stage.
