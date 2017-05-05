## Setting up the working environment

You can use python venv!
Installing requirements is done via *pip*.

```shell
$ python3 -m venv myenv
(myenv) $ pip install -r ../requirements.txt
```

New requirements for the whole repository should be added to [requirements.txt](requirements.txt) in the git root directory.

### Activating to the virtual env

```shell
$ source myenv/bin/activate
(myenv) $
```

Now you can use pip to install requirements etc.

You can exclude the myenv directory from version control in *.git/info/exclude*

## Starting tests

Testing is started via *manage.py*

Starting tests for a whole app:

```shell
(myenv) $ ./manage.py test fe.tests
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 2 tests in 0.001s

OK
Destroying test database for alias 'default'...
```

Its also possible to start a subset of the tests:
```Shell
(myenv) $ ./manage.py test fe.tests.models
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK
Destroying test database for alias 'default'...
```

### Using code coverage

> We aim to get a minimum code coverage of 95%

Getting the code coverage is also possible:
```Shell
(myenv) $ coverage run manage.py test fe.tests # Generates the coverage report in the file .coverage
...
(myenv) $ coverage html # Generates a HTML coverage report located in the dir coverage_html_report
(myenv) $ coverage report # Displays the report in the console
Name                                    Stmts   Miss  Cover   Missing
---------------------------------------------------------------------
fe/__init__.py                              0      0   100%
fe/tests/models/test_models_simple.py       4      0   100%
fe/tests/views/sample_class.py              5      1    80%   7
fe/tests/views/test_views_simple.py         8      0   100%
fe/urls.py                                  3      0   100%
---------------------------------------------------------------------
TOTAL                                      20      1    95%
```
This:
* ```coverage run manage.py test fe.tests```: Generates the coverage report in the file .coverage
* ```coverage html```:Generates a HTML coverage report located in the dir coverage_html_report
* ```coverage report```:Displays the report in the console

## Install Linter

The *pylint* linter can be used as a pre-commit hook using *git-pylint-commit-hook*

Configuring the linter as a pre-commit hook
```shell
(myenv) $ cd $git_root
(myenv) $ mv .git/hooks/pre-commit.sample .git/hooks/pre-commit
(myenv) $ cat > .git/hooks/pre-commit << EOL
#!/bin/sh
git-pylint-commit-hook
EOL
```

The limit which the commit-hook is using for linting is *8.0* hence every try to commit something below will be rejected.
Settings for the linter can be found in the [.pylintrc](.pylintrc) file

The pylint manual can be found [here](https://pylint.readthedocs.io/en/latest/).
The git-pylint-commit-hook tool can be found on [GitHub](https://github.com/sebdah/git-pylint-commit-hook).
