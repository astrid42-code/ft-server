# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    config.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: asgaulti@student.42.fr <asgaulti>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/25 17:05:27 by asgaulti@st       #+#    #+#              #
#    Updated: 2021/03/25 17:39:19 by asgaulti@st      ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# autorisation acces

chown -R www-data /var/www/
chmod -R 755 /var/www/

# config Nginx
#deplacer ma config nginx dans default + lien symbolique avec site enabled + rm le site enable
mv ./nginx-config /etc/nginx/site-available/localhost
ln -s /etc/nginx/site-available/localhost /etc/nginx/site-enabled/localhost
rm -rf /etc/nginx/site-enabled/localhost

# config / dl phpmyadmin
mkdir /var/www/localhost/phpmyadmin
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
mv ./config.phpmyadmin.php /var/www/localhost/phpmyadmin/config.inc.php

# dl wp (-c creation arch / -x : extraire arch / -z compression zip / -v : mode verbose pour afficher ce qui se passe pendant l'operation)
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
mv wordpress /var/www/localhost
mv ./config-wp.php /var/www/localhost/wordpress

