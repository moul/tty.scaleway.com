#!/bin/sh

echo "Installing required packages..."
dpkg -l | grep mysql-server > /dev/null && echo "mysql-server already installed" || apt-get install mysql-server
dpkg -l | grep libpam-mysql > /dev/null && echo "libpam-mysql already installed" || apt-get install libpam-mysql
dpkg -l | grep libnss-mysql > /dev/null && echo "libnss-mysql already installed" || apt-get install libnss-mysql
echo "OK"

echo ""
echo "Creating database and mysql user account..."
echo "Please enter MySQL root password:"
mysql -u root -p < create_db.sql && echo "OK"

echo ""
echo "Copying configuration files..."
timestamp=`date +%y%m%d-%H%M%S_%N`
filestoreplace="/etc:pam-mysql.conf /etc/pam.d:sshd /etc:nss-mysql.conf /etc:nss-mysql-root.conf /etc:nsswitch.conf /home/notroot:proxyfw"
for item in $filestoreplace
do
    path=`echo $item | cut -d: -f1`
    file=`echo $item | cut -d: -f2`
    mv $path/$file $path/$file.$timestamp
    cp -p conf/$file $path/$file
done
echo "Configuration complete."
