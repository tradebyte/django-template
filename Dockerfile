FROM python:3.6-slim

ARG TARGET=development

ADD . /usr/src/app
WORKDIR /usr/src/app

RUN pip install --no-cache-dir --upgrade -r requirements/base.txt -r requirements/$TARGET.txt