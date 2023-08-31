echo -e "\e[32m>>>>>>>>Install Python<<<<<<<<\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[32m>>>>>>>>Add application user & App directory<<<<<<<<\e[0m"
useradd roboshop
rm -rf app
mkdir app

echo -e "\e[32m>>>>>>>>Download & Unzip app content<<<<<<<<\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip

echo -e "\e[32m>>>>>>>>Install app dependencies<<<<<<<<\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[32m>>>>>>>>Create payment service file<<<<<<<<\e[0m"
cp /home/centos/Roboshop-shell/payment.sh /etc/systemd/system/payment.service

echo -e "\e[32m>>>>>>>>Load service<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[32m>>>>>>>>Start Payment<<<<<<<<\e[0m"
systemctl enable payment
systemctl start payment