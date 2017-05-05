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
