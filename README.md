{% if not project_name %}

# Project template

You can create a new project out of this template by using a gist.

**Requirements:**
* python3
* bash
* wget
* docker and docker-compose in version 1.10.0+

Do the following, replace <project_name> with your desired project name:
```shell
wget -O - https://gist.githubusercontent.com/mjainta/2e57c4b04d1bb9c526dc0843b4353aa5/raw/fbf135ae7b0935581c101136f2fd802747b21cf8/start-django-project.sh | bash -s <project_name>
```

This will create a folder called *project_name* in the current directory.

{% endif %}# {{ project_name|title }}

## Setup working environment

```shell
$ make
```

This will build all necessary docker images and start them up.

## Executing tests

```shell
(myenv) $ make coverage
```

This will execute all unittests it finds in the {{ project_name }}.tests module.
Also coverage is enabled which ends up in a file called [.coverage](.coverage) in the root directory.
Coverage also generates a html report in *coverage_html_report* and after prints a summary to stdout.

> By configuration, we aim to get a minimum code coverage of 95%
> Remember to use coverage before committing so the build will not fail after pushing!

If you do not want coverage to be executed, use tests_no_coverage instead
```shell
(myenv) $ make test
```

Both commands also work with a subset of the tests:
```Shell
(myenv) $ make coverage TESTMODULE={{ project_name }}.tests.models
```

Settings for the coverage tool can be found in the [.coveragerc](.coveragerc) file.

## Use the Linter

We gonna use pylint for linting functionality.

First, install the pre-commit hook which will check your files with the linter before you commit.

> Remember, since it creates a pre-commit hook you need to init the git repository first.

```shell
(myenv) $ make install_pre_commit
```

This will create the file *.git/hooks/pre-commit* with the desired hook for the linter.

You can also use pylint directly if you want to check every file (except a few which get ignored).
```shell
(myenv) $ make lint
```

Settings for the linter can be found in the [.pylintrc](.pylintrc) file.

The pylint manual can be found [here](https://pylint.readthedocs.io/en/latest/).

## Using postgresql

Built-in the template will use a postgresql database, instead of the sqlite default.

If you want to use sqlite instead, delete the according lines from the files:
* [base.py]({{ project_name }}/settings/base.py)
* [base.py]({{ project_name }}/settings/test.py)
* In [base.txt](requirements/base.py) remove the **psycopg2** library.
* In [docker-compose.yml](docker-compose.yml) remove the postgres container and the link for it.

Connect to it via `make psql`.

> Data is not preserved by default! Modify [docker-compose.yml](docker-compose.yml) to use volumes if you need to.

Documentation on the postgresql image is found on [hub.docker.com](https://hub.docker.com/_/postgres/).

# Running custom commands in the python container

```shell
$ docker-compose run --rm py <your command>
(myenv) $
```

# Deployment

The requirements the loaded in the docker build process during `make images`.
Requirements are held in their files, respectively: [test](requirements/test.txt) / [development](requirements/development.txt) / [staging](requirements/staging.txt) / [production](requirements/production.txt)

[base](requirements/base.txt) should be included for every stage.

## GitLab

You can use GitLab-CI for deployment, the [.gitlab-ci.yml](.gitlab-ci.yml) may help in setting up the build and deployment system.

Out of the box it has to stages:
* **build**: Creates a new docker container and saves it into the gitlab Registry
* **test**: Uses the created container for executing tests and linting
