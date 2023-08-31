echo -e "\e[32m>>>>>>>>Install Maven<<<<<<<<\e[0m"
yum install maven -y

echo -e "\e[32m>>>>>>>>Add application user & Directory<<<<<<<<\e[0m"
useradd roboshop
rm -rf app
mkdir app

echo -e "\e[32m>>>>>>>>Download & unzip app content<<<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip
cd /app
unzip /tmp/shipping.zip

echo -e "\e[32m>>>>>>>>Download Dependencies<<<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[32m>>>>>>>>create service file<<<<<<<<\e[0m"
cp /etc/systemd/system/shipping.service

echo -e "\e[32m>>>>>>>>Load service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[32m>>>>>>>>Install MySQL<<<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[32m>>>>>>>>Change MySQl default password<<<<<<<<\e[0m"
mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[32m>>>>>>>>start shipping<<<<<<<<\e[0m"
systemctl enable shipping
systemctl start shipping
