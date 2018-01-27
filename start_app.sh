### Define start up script variables
### ====================================================================================$

NAME="bookshelf application"                                   # Name of the application
DJANGODIR=/vagrant/bookshelf                                   # django project directo$
NUM_WORKERS=3                                                  # No. of worker processe$
DJANGO_SETTINGS_MODULE=bookshelf.settings                      # Settings file that Gun$
DJANGO_WSGI_MODULE=bookshelf.wsgi                              # WSGI module name
DJANGO_PROD_DEBUG=False                                                 
DB_USER=vagrant
DB_PASSWORD=vagrant

### export variables (optional edit to activate virtualenv as well)
### ====================================================================================$

echo "Starting $NAME as `whoami`"
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export DEBUG=$DJANGO_PROD_DEBUG
export DB_USER=$DB_USER
export DB_PASSWORD=$DB_PASSWORD

# virtualenv env ---> use only if needed otherwise best to keep it simple.
# source "/vagrant/env/bin/activate"


### Start Gunicorn
### ====================================================================================$

gunicorn bucketlistapp.wsgi --workers $NUM_WORKERS --bind 127.0.0.1:8000 --pythonpath=bookshelf --log-file -
