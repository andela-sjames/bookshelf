FROM python:3.6.2

# update package lists, fix broken system packages
RUN apt-get update && apt-get -f install 

# set working directory
WORKDIR /app

COPY . .

# install  dependencies in /tmp directory.
# doing it this way also installs any newly added dependencies.
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# connect work directory to host filesystem
VOLUME ["/app"]

# create user and add to docker group
RUN adduser --disabled-password --gecos '' bookshelfapp
RUN groupadd docker
RUN usermod -aG docker bookshelfapp

# grant newly created user permissions on essential files
RUN chown -R bookshelfapp:$(id -gn bookshelfapp) /app/
RUN chmod +x ./scripts/run_web.sh && chmod +x ./scripts/launch.sh
ENV PYTHONUNBUFFERED 1

# change user to newly created user
USER bookshelfapp

RUN /bin/bash -c "python manage.py makemigrations && python manage.py migrate \
    && python manage.py runserver"
