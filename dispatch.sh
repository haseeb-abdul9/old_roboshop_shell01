echo -e "\e[32m>>>>>>>>Install Golang<<<<<<<<\e[0m"
yum install golang -y

echo -e "\e[32m>>>>>>>>Add application user & App directory<<<<<<<<\e[0m"
useradd roboshop
rm -rf app
mkdir app

echo -e "\e[32m>>>>>>>>Download & Unzip app content<<<<<<<<\e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip
cd /app
unzip /tmp/dispatch.zip

echo -e "\e[32m>>>>>>>>Install app dependencies<<<<<<<<\e[0m"e
go mod init dispatch
go get
go build

echo -e "\e[32m>>>>>>>>Create dispatch service file<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/etc/systemd/system/dispatch.service

echo -e "\e[32m>>>>>>>>Load service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[32m>>>>>>>>Start dispatch<<<<<<<<\e[0m"
systemctl enable dispatch
systemctl start dispatch