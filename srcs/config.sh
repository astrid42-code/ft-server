# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    config.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: asgaulti@student.42.fr <asgaulti>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/25 17:05:27 by asgaulti@st       #+#    #+#              #
#    Updated: 2021/03/31 17:55:49 by asgaulti@st      ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


#pour maintenir le container une fois lance

# while true;
#        do sleep 10000;
# done

# ou
# tail -f fichier de logs nginx
# ou nginx -g 'daemon off'

service mysql start

# creation du dossier site + fichier index
touch /var/www/html/index.php
echo "<?php phpinfo(); ?>" >> /var/www/html/index.php

# config SSL
mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhostkey.key -subj "/C=FR/ST=France/L=Paris/O=Me/OU=42Paris/CN=asgaulti/emailAddress=asgaulti@student.42.fr"

# config Nginx
# deplacer ma config nginx dans default + lien symbolique avec site enabled + rm le site enable
mv ./config-nginx /etc/nginx/sites-available/localhost
rm /etc/nginx/sites-enabled/default
rm -f /var/www/html/index.nginx-debian.html
rm -f /var/www/html/index.php
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/default

# config mysql (creation database wp et donner privileges a l'user root)
echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# config / dl phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv ./phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpmyadmin
mv ./config.phpmyadmin.php /var/www/html/phpmyadmin/config.inc.php
rm /var/www/html/phpmyadmin/config.sample.inc.php
# > dans localhost/phpmyadmin > pour acceder a l'ecran de connexion PMA, se connecter avec l'user mysql wp : 'wordpress' 'password'
# permet de visualiser bdd et commentaires

#importer la bdd
#mysql wordpress -u root < wordpress.sql

# dl wp (-c creation arch / -x extraction arch / -z compression zip / -v : mode verbose pour afficher ce qui se passe pendant l'operation)
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
# + wp-config copie dans localhost
mv wordpress /var/www/html
mv ./config-wp.php /var/www/html/wordpress/.
#supprimer fichier par defaut de config
rm /var/www/html/wordpress/wp-config-sample.php

service php7.3-fpm start
service nginx start
# creation et acces bdd depuis d'autres services / creation user et mdp pour acces bdd wp et phpmyadmin
#echo "CREATE DATABASE testdb;" | mysql -u root
#echo "CREATE USER 'test'@'localhost';" | mysql -u root
#echo "SET password FOR 'test'@'localhost' = password('password');" | mysql -u root
#echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# autorisation acces (user et droits)
chown -R www-data /var/www/
chmod -R 755 /var/www/

#sur Debian, un service (ou daemon / demon) est un script d'initialisation de type "system V" qui va permettre de gerer un service
# install ou upgrade php/ nginx/ mysql

bash

# affichage logs du serveur en temps reel
#tail -f /var/log/nginx/access.log /var/log/nginx/error.log

