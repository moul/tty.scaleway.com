#!/bin/sh

echo "Copying configuration files... "
filestoreplace="/etc:pam-mysql.conf /etc/pam.d:sshd /etc:nss-mysql.conf /etc:nss-mysql-root.conf /etc:nsswitch.conf /home/notroot:proxyfw"
for item in $filestoreplace
do
    path=`echo $item | cut -d: -f1`
    file=`echo $item | cut -d: -f2`
    cp -p $path/$file conf/$file
done
echo "Done."
