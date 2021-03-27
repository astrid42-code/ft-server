# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    config.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: asgaulti@student.42.fr <asgaulti>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/25 17:05:27 by asgaulti@st       #+#    #+#              #
#    Updated: 2021/03/27 17:32:14 by asgaulti@st      ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#sur Debian, un service (ou daemon / demon) est un script d'initialisation de type "system V" qui va permettre de gerer un service
# install ou upgrade php/ nginx/ mysql

service mysql start

#pour maintenir le container une fois lance

# while true;
#        do sleep 10000;
# done

# ou
# tail -f fichier de logs nginx
# ou nginx -g 'daemon off'

# creation du dossier site + fichier index
touch /var/www/html/index.php

# config Nginx
# deplacer ma config nginx dans default + lien symbolique avec site enabled + rm le site enable
mv ./config-nginx /etc/nginx/sites-available/localhost
#ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
#rm /etc/nginx/sites-enabled/default

# config mysql (creation database wp et donner privileges a l'user root)
echo "CREATE DATABASE wordpress;"
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# config / dl phpmyadmin
mkdir /var/www/html/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv ./phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpmyadmin
mv ./config.phpmyadmin.php /var/www/html/phpmyadmin/config.inc.php
# > dans localhost/phpmyadmin > pour acceder a l'ecran de connexion PMA, se connecter avec l'user mysql wp : 'wordpress' 'password'
# permet de visualiser bdd et commentaires

#importer la bdd
mysql wordpress -u root < wordpress.sql

# dl wp (-c creation arch / -x extraction arch / -z compression zip / -v : mode verbose pour afficher ce qui se passe pendant l'operation)
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
# + wp-config copie dans localhost
mv wordpress /var/www/html
mv ./config-wp.php /var/www/html/wordpress/.
# creation bdd wp
echo "CREATE DATABASE wordpress;" | mysql -u root

# creation et acces bdd depuis d'autres services / creation user et mdp pour acces bdd wp et phpmyadmin
echo "CREATE DATABASE testdb;" | mysql -u root
echo "CREATE USER 'test'@'localhost';" | mysql -u root
echo "SET password FOR 'test'@'localhost' = password('password');" | mysql -u root

# autorisation acces (user et droits)
chown -R www-data /var/www/
chmod -R 755 /var/www/

service php7.3-fpm start
service nginx start

# affichage logs du serveur en temps reel
#tail -f /var/log/nginx/access.log /var/log/nginx/error.log