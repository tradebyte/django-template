## Setting up the working environment

You can use python venv!

```bash
$ python3 -m venv myenv
```

### Activating to the virtual env

```bash
$ source myenv/bin/activate
(myenv) $
```

Now you can use pip to install requirements etc.

You can exclude the myenv directory from version control in _.git/info/exclude_

## Starting tests

Testing is started via _manage.py_

Starting tests for a whole app:
```bash
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
```bash
(myenv) $ ./manage.py test fe.tests.models
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK
Destroying test database for alias 'default'...
```
