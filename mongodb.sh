script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
component=mongod

print_head "Install ${component} Repo"
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install ${component}b-org -y

print_head "Change port"
sed -i -e 's|127.0.0.1|0.0.0.0|' /etc/${component}.conf

print_head "Start ${component}"
systemctl enable ${component}
systemctl start ${component}

