script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=redis

print_head "Install ${component} repo"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

print_head "Install ${component}"
dnf module enable ${component}:remi-6.2 -y
yum install ${component} -y

print_head "Change port"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/${component}.conf /etc/${component}/${component}.conf

print_head "Start ${component}"
systemctl enable ${component}
systemctl start ${component}
systemctl restart ${component}