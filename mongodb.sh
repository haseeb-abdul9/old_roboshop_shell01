echo -e "\e[32m>>>>>>>>Install Mongo Repo<<<<<<<<\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y

echo -e "\e[32m>>>>>>>>Change port<<<<<<<<\e[0m"
sed -i -e 's|127.0.0.1|0.0.0.0' /etc/mongod.conf

echo -e "\e[32m>>>>>>>>Start mongodb<<<<<<<<\e[0m"
systemctl enable mongod
systemctl start mongod

