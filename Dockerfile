FROM debian:buster

# met le cache à jour (update auto des paquets)
RUN apt-get update
RUN apt-get upgrade -y

#dl et installe le paquet (wget pour dl les fichiers)
RUN apt-get install -y wget

#installation nginx
RUN apt-get -y install nginx

# installation php
RUN apt-get -y install php7.3 php7.3-fpm php7.3-common php7.3-mysql php7.3-curl php7.3-intl php7.3-mbstring php7.3-cli php7.3-soap php7.3-imap

#installation mariadb-server (syst de gestion de base de donnees)
RUN apt-get -y install mariadb-server

#installation php-mysql (realiser des applis php avec une base de donnees mysql)
RUN apt-get -y install php-mysql

#RUN apt-get install vim -y

RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O mkcert 
RUN chmod 755 mkcert && ./mkcert -install && ./mkcert -cert-file /etc/ssl/certs/localhost.pem -key-file /etc/ssl/certs/localhost-key.pem localhost sendmail
#RUN install mkcert /etc/nginx/ssl
#RUN mkdir /var/www/localhost

# donner acces aux users
RUN chown -R www-data:www-data /var/www/

COPY ./srcs/config.phpmyadmin.php ./
COPY ./srcs/nginx.conf ./etc/nginx/sites-available/localhost
COPY ./srcs/wp-config.php ./
COPY ./srcs/config.sh ./
COPY ./srcs/auto_index.sh ./
COPY ./srcs/auto_index_off.conf ./
COPY ./srcs/pingumappa.jpg ./

#installation wp tar xf : extraire une archive avec un fichier donne
#retirer le fichier .tar.gz apres install
# RUN tar xf ./wordpress.tar.gz && rm -rf wordpress.tar.gz
# RUN chmod 755 -R wordpress

EXPOSE 80 443

ENV AUTOINDEX on

#cmd qui sexecute au run
CMD sh config.sh
#ENTRYPOINT bash config.sh \

#&& tail -f /dev/null

#CMD bash

#RUN sh ./config.sh
#CMD bash config.sh

# RTFM

# CMD sudo docker build -t (nom image) .
# CMD sudo docker run -it --rm -p 80:80 -p 443:443 + nom de l'image
# CMD service nginx stop si deja en train de tourner
# CMD sudo docker exec -it (nom image) bash > pour entrer dans l'image quand sleep infinity
# CMD docker system prune pour supprimer ressources en suspens de docker
# -a pour containers arretes et images non utilisees
