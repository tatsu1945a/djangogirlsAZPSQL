#!/bin/bash
#python manage.py runserver 0.0.0.0:8000
set -e 

echo "Starting SSH ..."
service ssh start

date > env-now.txt
env >> env-now.txt
env  > /usr/local/app/.env
python manage.py collectstatic
python manage.py migrate
gunicorn config.asgi:application -w 2 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
