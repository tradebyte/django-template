#!/usr/bin/env sh

main() {
    python3 waitforpostgres.py
    python3 manage.py migrate
    python3 manage.py runserver 0.0.0.0:8000
}

main
