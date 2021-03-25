FROM debian:buster

# Astrid Gaultier <asgaulti@student.42.fr>

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


COPY ./srcs/init_docker.sh ./
COPY ./srcs/config.inc.php ./
COPY ./srcs/nginx-config ./
COPY ./srcs/config-wp.php ./
COPY ./srcs/start.sh ./

#installation wp tar xf : extraire une archive avec un fichier donne
#retirer le fichier .tar.gz apres install
# RUN tar xf ./wordpress.tar.gz && rm -rf wordpress.tar.gz
# RUN chmod 755 -R wordpress

EXPOSE 80 443

ENV autoindex on
CMD bash
# CMD bash init_docker.sh
