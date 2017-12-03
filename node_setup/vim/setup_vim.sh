#AS NEW USER - SETUP VIM WITH PLUGINS

yum -y update
yum -y install vim

mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo '
execute pathogen#infect()
syntax on
filetype plugin indent on
set number
' >> ~/.vimrc

git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
git clone https://github.com/wavded/vim-stylus.git ~/.vim/bundle/vim-stylus
git clone git://github.com/digitaltoad/vim-pug.git ~/.vim/bundle/vim-pug
git clone https://github.com/sheerun/vim-polyglot ~/.vim/pack/default/start/vim-polyglot
git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript
