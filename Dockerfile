FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get install -y apache2 && apt-get clean
RUN apt-get install curl

RUN a2enmod userdir
RUN useradd raman

COPY public_html/Dev /home/raman/public_html/Dev
COPY .htpasswd /home/raman/public_html/Dev
COPY site1.conf /etc/apache2/sites-available
COPY site2.conf /etc/apache2/sites-available
COPY site3.conf /etc/apache2/sites-available
COPY site1/ /var/www/html/site1
COPY site2/ /var/www/html/site2
COPY site3/ /var/www/html/site3

RUN a2ensite site1.conf
RUN a2ensite site2.conf
RUN a2ensite site3.conf

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]