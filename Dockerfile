FROM python:3.6.2

# update package lists, fix broken system packages
RUN apt-get update && apt-get -f install 
