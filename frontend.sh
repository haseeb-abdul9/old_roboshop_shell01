echo -e "\e[32m>>>>>>>>Install nginx<<<<<<<<\e[0m"
yum install nginx -y

echo -e "\e[32m>>>>>>>>Configure Reverse Proxy<<<<<<<<\e[0m"
cp roboshop.conf /etc/nginx/default.d/roboshop.conf

echo -e "\e[32m>>>>>>>>Remove nginx Content<<<<<<<<\e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32m>>>>>>>>Download frontend content<<<<<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip

echo -e "\e[32m>>>>>>>>Unzip frontend content<<<<<<<<\e[0m"
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[32m>>>>>>>>Start nginx<<<<<<<<\e[0m"
systemctl enable nginx
systemctl start nginx
