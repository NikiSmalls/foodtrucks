# start from base
FROM ubuntu:latest
MAINTAINER Nikita Louison <nikita@nikita.me>

# install system-wide deps for python and node
RUN apt-get -yqq update && apt-get -yqq install python-pip python-dev curl gnupg && curl -sL https://deb.nodesource.com/setup_10.x | bash && apt-get install -yq nodejs

# copy our application code
ADD flask-app /opt/flask-app
WORKDIR /opt/flask-app

# fetch app specific deps
RUN npm install && npm run build && pip install -r requirements.txt

# expose port
EXPOSE 5000

# start app
CMD [ "python", "./app.py" ]
