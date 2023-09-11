script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
mysql_root_password=$1

if [ -z "$mysql_root_password" ]; then
  echo Input rabbitmq_password missing
  exit
fi

print_head "Disable Default MySQL"
yum module disable mysql -y

print_head "Install MySQL 5.7"
cp ${script_path}/mysql.repo /etc/yum.repos.d/mysql.repo
yum install mysql-community-server -y

print_head "Start MySQL"
systemctl enable mysqld
systemctl start mysqld

print_head "Change Default password"
mysql_secure_installation --set-root-pass ${mysql_root_password}