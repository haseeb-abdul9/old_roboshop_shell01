echo -e "\e[32m>>>>>>>>Install nodejs<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y

echo -e "\e[32m>>>>>>>>Add application user & App directory<<<<<<<<\e[0m"
useradd roboshop
rm -rf /app
mkdir app

echo -e "\e[32m>>>>>>>>Download & Unzip app content<<<<<<<<\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/cart.zip

echo -e "\e[32m>>>>>>>>Install app dependencies<<<<<<<<\e[0m"
npm install

echo -e "\e[32m>>>>>>>>Create cart service file<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/cart.service /etc/systemd/system/cart.service

echo -e "\e[32m>>>>>>>>Load service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[32m>>>>>>>>Start cart<<<<<<<<\e[0m"
systemctl enable cart
systemctl start cart

