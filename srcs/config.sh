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
#rm /etc/nginx/nginx.conf
#cp /etc/nginx/sites-available/nginx.conf /etc/nginx/nginx.conf

ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/

service nginx start
bash

#echo "finished"


#sleep infinity
