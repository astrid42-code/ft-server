mkdir /var/www/localhost

# config Nginx
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
rm /var/www/html/index.nginx-debian.html
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

service mysql start

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

# dl wp (-c creation arch / -x extraction arch / -z compression zip / -v : mode verbose pour afficher ce qui se passe pendant l'operation)
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz

mv wordpress /var/www/html
mv ./wp-config.php /var/www/html/wordpress/.

#supprimer fichier par defaut de config
rm /var/www/html/wordpress/wp-config-sample.php

service nginx start

service php7.3-fpm start

sh ./auto_index.sh

bash

tail -f /dev/null

