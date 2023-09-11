script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=nginx
component2=frontend

print_head "Install ${component}"
yum install ${component} -y

print_head "Configure Reverse Proxy"
cp roboshop.conf /etc/${component}/default.d/roboshop.conf

print_head "Remove ${component} Content"
rm -rf /usr/share/${component}/html/*

print_head "Download ${component2} content"
curl -o /tmp/${component2}.zip https://roboshop-artifacts.s3.amazonaws.com/${component2}.zip

print_head "Unzip ${component2} content"
cd /usr/share/${component}/html
unzip /tmp/${component2}.zip

print_head "Start ${component}"
systemctl enable ${component}
systemctl start ${component}
systemctl restart ${component}