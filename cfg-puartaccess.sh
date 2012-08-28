#!/bin/sh

## Following packages must have been installed (named as aptitude pkg names):
## - mysql-server
## - libpam-mysql
## - libnss-mysql

echo "Creating database and mysql user account..."
echo "Please enter MySQL root password:"
mysql -u root -p < create_db.sql && echo "OK"

echo ""
echo "Copying configuration files... "
timestamp=`date +%y%m%d-%H%M%S_%N`
filestoreplace="/etc:pam-mysql.conf /etc/pam.d:sshd /etc:nss-mysql.conf /etc:nss-mysql-root.conf /etc:nsswitch.conf /home/notroot:proxyfw"
for item in $filestoreplace
do
    path=`echo $item | cut -d: -f1`
    file=`echo $item | cut -d: -f2`
    echo mv $path/$file $path/$file.$timestamp
    echo cp -p conf/$file $path/$file
done
echo "Configuration complete."
