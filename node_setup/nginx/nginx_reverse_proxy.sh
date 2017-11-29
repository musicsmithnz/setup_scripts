#!/bin/bash

app_name=lucentmonkey.com
web_dir='/var/www'
web_dir_escaped='\/var\/www'
script_dir=$(pwd)
script_sub_dir='node_setup/nginx'

domain_1="${app_name}"
domain_2="www.${app_name}"

yum -y update
yum -y install epel-release
yum -y install nginx

mkdir /etc/nginx/sites-available /etc/nginx/sites-enabled
cat ${script_dir}/${script_sub_dir}/nginx.conf > /etc/nginx/nginx.conf
cat ${script_dir}/${script_sub_dir}/app_name_http_standalone.conf > /etc/nginx/sites-available/${app_name}.conf
ln -s /etc/nginx/sites-available/${app_name}.conf /etc/nginx/sites-enabled/${app_name}.conf
sed -i "s/DOMAIN_1/${domain_1}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/DOMAIN_2/${domain_2}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/APP_NAME/${app_name}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/WEB_DIR/${web_dir_escaped}/g" /etc/nginx/sites-available/${app_name}.conf

#CERTBOT AUTOMATIC SSL CERTIFICATE GENERATION
yum -y update
yum -y install epel-release
yum -y install yum-utils
yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
yum -y install certbot-nginx
systemctl stop nginx
certbot certonly --standalone --preferred-challenges http -w $web_dir -d $domain_1 -d $domain_2

#ADD SSH CONFIG
setenforce 0
cat ${script_dir}/${script_sub_dir}/app_name_http.conf > /etc/nginx/sites-available/${app_name}.conf
cat ${script_dir}/${script_sub_dir}/app_name_https.conf >> /etc/nginx/sites-available/${app_name}.conf
sed -i "s/DOMAIN_1/${domain_1}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/DOMAIN_2/${domain_2}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/APP_NAME/${app_name}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/WEB_DIR/${web_dir_escaped}/g" /etc/nginx/sites-available/${app_name}.conf



systemctl start nginx
systemctl enable nginx
