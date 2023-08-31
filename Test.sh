echo -e "\e[32m>>>>>>>>Install nodejs<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y

echo -e "\e[32m>>>>>>>>Add application user & App directory<<<<<<<<\e[0m"
useradd roboshop
rm -rf /app
mkdir /app

echo -e "\e[32m>>>>>>>>Download & Unzip app content<<<<<<<<\e[0m"
curl -o /tmp/User.zip https://roboshop-artifacts.s3.amazonaws.com/User.zip
cd /app
unzip /tmp/user.zip

echo -e "\e[32m>>>>>>>>Install app dependencies<<<<<<<<\e[0m"
npm install

echo -e "\e[32m>>>>>>>>Create User service file<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/User.service /etc/systemd/system/User.service

echo -e "\e[32m>>>>>>>>Load service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[32m>>>>>>>>Start User<<<<<<<<\e[0m"
systemctl enable User
systemctl start User

echo -e "\e[32m>>>>>>>>Setup Mongo repo<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org-shell -y

echo -e "\e[32m>>>>>>>>Load Schema<<<<<<<<\e[0m"
mongo --host mongodb-dev.haseebdevops.online </app/schema/user.js