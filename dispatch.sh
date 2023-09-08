script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh

component=dispatch

print_head "Install Golang" 
yum install golang -y

print_head "Add application user & App directory"
useradd $app_user
rm -rf /app
mkdir /app

print_head "Download & Unzip app content" 
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
cd /app
unzip /tmp/${component}.zip

print_head "Install app dependencies"
go mod init ${component}
go get
go build

print_head "Create ${component} service file" 
cp ${scriot_path}/${component}.service etc/systemd/system/${component}.service

print_head "Load service" 
systemctl daemon-reload

print_head "Start ${component}"
systemctl enable ${component}
systemctl start ${component}