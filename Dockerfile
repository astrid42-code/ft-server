FROM debian:buster

MAINTAINER Astrid Gaultier <asgaulti@student.42.fr>

//(pour install / dl nginx et autres options ; apt-get est un outil pour installer /desinstaller des paquets provenant d'un dépot apt
RUN apt-get update // met le cache à jour (update auto des paquets)
RUN apt-get upgrade -y
RUN apt-get install -y wget //dl et installe le paquet (wget pour dl les fichiers) // pk -y?
RUN apt-get -y install nginx
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline
ou
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install mariadb-server // (syst de gestion de base de données / opensource relational database)
RUN apt-get -y install php-mysql


COPY ./srcs/init_docker.sh ./ (pour initier le lancement de docker et donc du site)
COPY ./srcs/config.inc.php ./ ou ./tmp/config.inc.php (2eme pour faire des fichiers temporaires qui partent quand on a fini?)
COPY ./srcs/nginx_config ./ ou ./tmp/nginx_config
COPY ./srcs/config-wp.php

CMD bash init_docker.sh 
