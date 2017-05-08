"""
Utils for common operations regarding the project.

Do not put business logic in here!
"""
import os
import sys


def select_target():
    """Selects a target depending on existance of a .target file and its content."""
    target = 'development'

    if os.path.isfile('.target'):
        target = open('.target', 'r').readline().strip()

        if not target or not os.path.isfile('{{ project_name }}/settings/%s.py' % target):
            sys.exit("Missing settings file for target '%s'." % target)
