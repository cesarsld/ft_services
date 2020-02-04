#!bin/sh

mkdir -p /usr/share/webapps/
cd /usr/share/webapps
wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-4.5.0.2-all-languages.tar.gz
tar zxvf phpMyAdmin-4.5.0.2-all-languages.tar.gz
rm phpMyAdmin-4.5.0.2-all-languages.tar.gz
mv phpMyAdmin-4.5.0.2-all-languages phpmyadmin
chmod -R 777 /usr/share/webapps/
ln -s /usr/share/webapps/phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin
bash