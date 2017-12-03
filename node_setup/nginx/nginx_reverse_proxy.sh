#!/bin/bash

#read -p "app name:\t\t" app_name
#read -p "email address:\t" email_address

app_name=lucentmonkey
email_address=musicsmithnz@gmail.com

script_dir=$(pwd)
script_sub_dir='node_setup/nginx'

web_dir='/var/www'
web_dir_escaped=$(sed 's#/#\\/#g')

nginx_skeleton_conf='https://raw.githubusercontent.com/musicsmithnz/setup_scripts/master/node_setup/nginx/nginx.conf'
nginx_http_conf='https://raw.githubusercontent.com/musicsmithnz/setup_scripts/master/node_setup/nginx/app_name_http_standalone.conf'
nginx_https_conf='https://raw.githubusercontent.com/musicsmithnz/setup_scripts/master/node_setup/nginx/app_name_https.conf'
online=true

domain_1="${app_name}"
domain_2="www.${app_name}"

yum -y update
yum -y install epel-release
yum -y install nginx

mkdir /etc/nginx/sites-available /etc/nginx/sites-available
if [ $online ==  'true' ]; then
  wget -O /etc/nginx/nginx.conf ${nginx_skeleton_conf}
  wget -O /etc/nginx/sites-available/${app_name}.conf ${nginx_http_conf}
else 
  cat ${script_dir}/${script_sub_dir}/nginx.conf > /etc/nginx/nginx.conf
  cat ${script_dir}/${script_sub_dir}/app_name_http_standalone.conf > /etc/nginx/sites-available/${app_name}.conf
fi
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
#certbot certonly --standalone --preferred-challenges http -w $web_dir -d $domain_1 -d $domain_2
sudo certbot --nginx certonly -w $web_dir -d $domain_1 -d $domain_2 --non-interactive --email $email_address --agree-tos
#ADD NGINX SSH CONFIG
setenforce 0
if [ $online == 'true' ]; then
  wget -O /etc/nginx/sites-available/${app_name}.conf ${nginx_https_conf}
else
  cat ${script_dir}/${script_sub_dir}/app_name_https.conf > /etc/nginx/sites-available/${app_name}.conf
fi
sed -i "s/DOMAIN_1/${domain_1}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/DOMAIN_2/${domain_2}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/APP_NAME/${app_name}/g" /etc/nginx/sites-available/${app_name}.conf
sed -i "s/WEB_DIR/${web_dir_escaped}/g" /etc/nginx/sites-available/${app_name}.conf



systemctl start nginx
systemctl enable nginx
