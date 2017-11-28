#AS NEW USER - SETUP VIM WITH PLUGINS

yum -y update
yum -y install vim

#git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#echo 'set nocompatible
#filetype off                  
#set rtp+=~/.vim/bundle/Vundle.vim
#call vundle#begin()
#Plugin "VundleVim/Vundle.vim"
#call vundle#end()            
#filetype plugin indent on'
#vim +PluginInstall +qall
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo '
execute pathogen#infect()
syntax on
filetype plugin indent on
' >> ~/.vimrc

git clone https://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
git clone https://github.com/wavded/vim-stylus.git ~/.vim/bundle/vim-stylus
git clone git://github.com/digitaltoad/vim-pug.git ~/.vim/bundle/vim-pug
git clone https://github.com/sheerun/vim-polyglot ~/.vim/pack/default/start/vim-polyglot
git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-javascript
