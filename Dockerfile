FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get install -y apache2 && apt-get clean

RUN a2enmod userdir
RUN useradd raman

COPY public_html/ /home/raman
COPY .htpasswd /etc/apache2
COPY 000-default.conf /etc/apache2/sites-available
COPY hosts /etc
COPY site1.conf /etc/apache2/sites-available
COPY 