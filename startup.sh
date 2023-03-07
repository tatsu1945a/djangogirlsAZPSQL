#!/bin/bash
#python manage.py runserver 0.0.0.0:8000
set -e 

echo "Starting SSH ..."
service ssh start

date > /home/env-now.txt
env >> /home/env-now.txt

python manage.py collectstatic
python manage.py migrate
gunicorn config.asgi:application -w 2 -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
