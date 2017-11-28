#!/bin/bash

app_name=lucentmonkey.com
web_dir=/var/www
script_dir=$(pwd)

yum -y update
yum -y install epel-release
yum -y install nginx

mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled
cp ${script_dir}/nginx.conf /etc/nginx/nginx.conf
cp ${script_dir}/app_name.conf /etc/nginx/sites-available/${app_name}.conf
ln -s /etc/nginx/sites-available/${app_name}/etc/nginx/sites-enabled/${app_name}
sed -i "s/APP_NAME/${app_name}/" /etc/nginx/sites-available/${app_name}
sed -i "s/WEB_DIR/${web_dir}/" /etc/nginx/sites-available/${app_name}

systemctl start nginx
systemctl enable nginx
