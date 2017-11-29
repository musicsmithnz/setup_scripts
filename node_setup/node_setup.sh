user_name="raymond" #user_name_to_run_commands
app_name=lucentmonkey.com
web_dir=/var/www
script_dir=$(pwd)

#AS ROOT
yum -y update
yum -y install epel-release
yum -y install nodejs
yum -y install npm
npm install yarn 
npm install yarn -g
yum -y install git
mkdir -p ${web_dir}/${app_name}

#NGINX
chmod +x ${script_dir}/nginx/nginx_reverse_proxy
${script_dir}/nginx/nginx_reverse_proxy

#DEVELOPMENT PACKAGES
yum -y install wget
##VIM
chmod +x ${script_dir}/vim/setup_vim
${script_dir}/nginx/vim/setup_vim


adduser $user_name
su $user_name

#AS NEW USER - SETUP NPM FOR GLOBAL NON-ROOT ACCESS
mkdir "${HOME}/.npm-packages"
touch ~/.npmrc
chmod +x ~/.npmrc
echo "NPM_PACKAGES=${HOME}/.npm-packages" >> ~/.npmrc
echo "PATH=$NPM_PACKAGES/bin:$PATH">> ~/.npmrc
echo "prefix=$NPM_PACKAGES" >> ~/.npmrc
echo "source ~/.npmrc" >> ~/.bash_profile
#unset MANPATH 
#export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
source ~/.bash_profile

#FOR MAKING NPM INIT NON-INTERACTIVE
yum -y install pip
pip install --upgrade pip
pip install pexpect

cd ${web_dir}/${app_name}
#Interactive
#AS USER
yarn init
git init

#PRODUCTION APP RUNNER
yum -y install pm2
sudo pm2 startup systemd

#Needed Packages
yarn add gulp browser-sync --dep
yarn add gulp-stylus --dep
yarn add gulp-pug --dep 
yarn add gulp-inject --dep
yarn add wiredep --dep
yarn add morgan --dep 
yarn add body-parser 
yarn add express 
yarn add mongoose 
yarn add mongodb 

#For Authentication
yarn add passport passport-local 

#Not sure about
yarn add autoprefixer 

#Optional
yarn add jquery.easing 
yarn add three 

#Validation
#Code Quality - Linting
yarn add jshint 
yarn add jscs 
yarn add jshint-stylish 
yarn add gulp-jshint --dep
yarn add gulp-jscs --dep
yarn add jshint-stylish --dep
cp ${script_location} .jshintrc

#Functionality - Testing, Continuous Integration
yarn add karma -g
yarn add karma --dep
karma init
yarn add mocha --dep
yarn add sinon --dep
yarn add mocha --dep

#For Minification
yarn add gulp-sourcemaps 
yarn add gulp-ng-annotate 
yarn add gulp-concat 
yarn add gulp-uglify 
yarn add gulp-filter 

yarn add webpack 
yarn add style-loader 
yarn add url-loader  
yarn add css-loader 
yarn add webpack

yarn add path
yarn add glob
yarn add extract-text-webpack-plugin
yarn add purifycss-webpack
yarn install bootstrap loader
#Compiling/Transpiling
yarn add gulp-babel babel-preset-env babel-core@7 --dep

#YEOMAN NOT WORKING WELL !!
#yarn add yo -g 

#yarn add  express
#yarn add  generator-express-passport-auth
#yarn add  generator-karma
#yarn add  generator-angular
#
