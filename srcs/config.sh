# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    config.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: asgaulti <asgaulti@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/25 17:05:27 by asgaulti@st       #+#    #+#              #
#    Updated: 2021/03/27 15:26:40 by asgaulti         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#sur Debian, un service (ou daemon / demon) est un script d'initialisation de type "system V" qui va permettre de gerer un service
# install ou upgrade php/ nginx/ mysql

service mysql start

#pour maintenir le container une fois lance

while true;
        do sleep 10000;
done

# ou
# tail -f fichier de logs nginx
# ou nginx -g 'daemon off'

# autorisation acces (user et droits)
chown -R www-data /var/www/
chmod -R 755 /var/www/

# creation du dossier site + fichier index
mkdir /var/www/localhost
touch /var/www/localhost/index.php

# config Nginx
# deplacer ma config nginx dans default + lien symbolique avec site enabled + rm le site enable
mv ./nginx-config /etc/nginx/site-available/localhost
ln -s /etc/nginx/site-available/localhost /etc/nginx/site-enabled/localhost
rm -rf /etc/nginx/site-enabled/localhost

# config mysql (creation database wp et donner privileges a l'user root)
echo "CREATE DATABASE wordpress;"
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysal_native_password' where user='root';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

# config / dl phpmyadmin
mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv ./config.phpmyadmin.php /var/www/localhost/phpmyadmin/config.inc.php
# > dans localhost/phpmyadmin > pour acceder a l'ecran de connexion PMA, se connecter avec l'user mysql wp : 'wordpress' 'password'
# permet de visualiser bdd et commentaires

#importer la bdd
mysql wordpress -u root < wordpress.sql

# dl wp (-c creation arch / -x extraction arch / -z compression zip / -v : mode verbose pour afficher ce qui se passe pendant l'operation)
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
# + wp-config copie dans localhost
mv wordpress /var/www/localhost
mv ./config-wp.php /var/www/localhost/wordpress
# creation bdd wp
echo "CREATE DATABASE wordpress;" | mysql -u root

# affichage logs du serveur en temps reel
tail -f /var/log/nginx/access.log /var/log/nginx/error.log

# creation et acces bdd depuis d'autres services / creation user et mdp pour acces bdd wp et phpmyadmin
echo "CREATE DATABASE testdb;" | mysql -u root
echo "CREATE USER 'test'@'localhost';" | mysql -u root
echo "SET password FOR 'test'@'localhost' = password('password');" | mysql -u root

service php7.3-fpm start
service nginx start
