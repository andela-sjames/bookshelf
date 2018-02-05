# bookshelf
A mini book application to manage books

## Getting Started

First create a python 3 virtual environment inside the repo: virtualenv -p python3 <env_name>.

Then, as usual, activate the environment with source bin/activate.

Install dependencies with pip install -r requirements.txt.

Run the command `python bookshelf/manage.py runserver` and navigate to `http://127.0.0.1:8000/` to view application.


## Using Vagrant
To start the process run `vagrant up && vagrant ssh`, this will start the application and take you via ssh into the VM, inside the VM navigate to the `/vagrant/` folder to start the app via the command `./start_app.sh`

go to `192.168.50.4` to view the application.

Preferably edit your `/etc/hosts` file and map that IP address to the fully qualified domain name (FQDN) of the application called `bookshelf.example`

That done you should be able to view the application via: `http://bookshelf.example`
