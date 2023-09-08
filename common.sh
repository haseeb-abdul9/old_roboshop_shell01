app_user=roboshop

print_head() {
  echo -e "\e[32m>>>>>>>> $1 <<<<<<<<\e[0m"
}

schema_setup() {
  if [ "$schema_setup" == mongo]; then
    print_head "Setup Mongo repo"
    cp /home/centos/Roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo
    yum install mongodb-org-shell -y

    print_head "Load Schema"
    mongo --host mongodb-dev.haseebdevops.online </app/schema/catalogue.js
  fi
}

function_nodejs() {
    print_head "Install nodejs" 
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash
    yum install nodejs -y

    print_head "Add application user & App directory" 
    useradd ${app_user}
    rm -rf /app
    mkdir /app

    print_head "Download & Unzip app content" 
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip
    cd /app
    unzip /tmp/${component}.zip

    print_head "Install app dependencies" 
    npm install

    print_head "Create cart service file" 
    cp ${script_path}/${component}.service /etc/systemd/system/${component}.service

    print_head "Load service" 
    systemctl daemon-reload

    print_head "Start ${component}" 
    systemctl enable ${component}
    systemctl restart ${component}

    schema_setup
}