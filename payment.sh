script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_password=$1
component=${component}

if [ -z "$rabbitmq_password"]; then
  echo Input rabbitmq_password missing
  exit
fi

print_head "Install Python"
yum install python36 gcc python3-devel -y

print_head "Add application user & App directory"
useradd ${app_user}
rm -rf /app
mkdir /app

print_head "Download & Unzip app content"
curl -L -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
cd /app
unzip /tmp/${component}.zip

print_head "Install app dependencies"
pip3.6 install -r requirements.txt

print_head "Create ${component} service file"
sed -i -e "s|rabbitmq_password|${rabbitmq_password}|" ${script_path}/${component}.service
cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

print_head "Load service"
systemctl daemon-reload

print_head "Start ${component}"
systemctl enable ${component}
systemctl restart ${component}