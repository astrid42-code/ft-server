FROM debian:buster

# Astrid Gaultier <asgaulti@student.42.fr>

# met le cache à jour (update auto des paquets)
RUN apt-get update
RUN apt-get upgrade -y
#dl et installe le paquet (wget pour dl les fichiers)
RUN apt-get install -y wget
RUN apt-get -y install nginx
#RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline
#ou
RUN apt-get -y install php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-mysql


COPY ./srcs/init_docker.sh ./
COPY ./srcs/config.inc.php ./
COPY ./srcs/nginx-config ./
COPY ./srcs/config-wp.php ./

ENV autoindex on
CMD bash init_docker.sh
