#chown -R www-data /var/www/*
#chmod -R 755 /var/www/*

mkdir /var/www/localhost

# config SSL
#openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/localhost.pem -keyout /etc/nginx/ssl/localhost-key.pem -subj "/C=FR/ST=France/L=Paris/O=42 /CN=asgaulti"
# mkdir /mkcert
# wget https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-linux-amd64 && \
# mv mkcert-v1.1.2-linux-amd64 /mkcert
# chmod -R 755 /mkcert/mkcert-v1.1.2-linux-amd64
# /mkcert/mkcert-v1.1.2-linux-amd64 -install
# /mkcert/mkcert-v1.1.2-linux-amd64 localhost
# mv /localhost-key.pem /mkcert/localhost.key
# mv /localhost.pem /mkcert

# config Nginx
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
rm /var/www/html/index.nginx-debian.html
#rm /etc/nginx/nginx.conf
#cp /etc/nginx/sites-available/nginx.conf /etc/nginx/nginx.conf
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
service nginx restart
# > dans localhost/phpmyadmin > pour acceder a l'ecran de connexion PMA, se connecter avec l'user mysql wp : 'wordpress' 'password'
# permet de visualiser bdd et commentaires

#importer la bdd
#mysql wordpress -u root < wordpress.sql

# dl wp (-c creation arch / -x extraction arch / -z compression zip / -v : mode verbose pour afficher ce qui se passe pendant l'operation)
wget -c https://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz
# + wp-config copie dans localhost
mv wordpress /var/www/html
mv ./wp-config.php /var/www/html/wordpress/.
#supprimer fichier par defaut de config
rm /var/www/html/wordpress/wp-config-sample.php
#creation dossier photo + photo
#mkdir /var/www/html/wordpress/wp-config.php/photo
#mv /home/user42/Téléchargements/pingumappa.jpg /var/www/html/wordpress/wp-config.php/photo

service nginx start

service php7.3-fpm start

sh ./auto_index.sh

bash

#echo "finished"
#sleep infinity
