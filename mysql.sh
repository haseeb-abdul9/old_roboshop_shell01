echo -e "\e[32m>>>>>>>>Disable Default MySQL<<<<<<<<\e[0m"
yum module disable mysql -y

echo -e "\e[32m>>>>>>>>Install MySQL 5.7<<<<<<<<\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo
yum install mysql-community-server -y

echo -e "\e[32m>>>>>>>>Start MySQL<<<<<<<<\e[0m"
systemctl enable mysqld
systemctl start mysqld

echo -e "\e[32m>>>>>>>>Change Default password<<<<<<<<\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1