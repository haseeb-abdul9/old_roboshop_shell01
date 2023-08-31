echo -e "\e[32m>>>>>>>>Install nodejs<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y

echo -e "\e[32m>>>>>>>>Add application user & App directory<<<<<<<<\e[0m"
useradd roboshop
rm -rf /app
mkdir app

echo -e "\e[32m>>>>>>>>Download & Unzip app content<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[32m>>>>>>>>Install app dependencies<<<<<<<<\e[0m"e
npm install

echo -e "\e[32m>>>>>>>>Create catalogue service file<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[32m>>>>>>>>Load service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[32m>>>>>>>>Start catalogue<<<<<<<<\e[0m"
systemctl enable catalogue
systemctl start catalogue

echo -e "\e[32m>>>>>>>>Setup Mongo repo<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

echo -e "\e[32m>>>>>>>>Load Schema<<<<<<<<\e[0m"
mongo --host mongodb-dev.haseebdevops.online </app/schema/catalogue.js