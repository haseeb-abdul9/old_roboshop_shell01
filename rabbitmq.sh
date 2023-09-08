script=$(realpath "$0")
script_path=$(dirname "$script")
source ${script_path}/common.sh
rabbitmq_password=$1

if [ -z "$rabbitmq_password"]; then
  echo Input rabbitmq_password missing
  exit
fi

print_head "Download & Install Erlang"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash


print_head "Download & Install RabbitMQ server"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
yum install rabbitmq-server -y

print_head "Start RabbitMQ"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server

print_head "Change default Username & password"
rabbitmqctl add_user roboshop ${rabbitmq_password}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"



