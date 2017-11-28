#!/bin/bash



scripts=("web2py_setup" "download_themes" "install_theme")
uris=("https://raw.githubusercontent.com/musicsmithnz/setup_scripts/master/servers/web2py_setup" "https://raw.githubusercontent.com/musicsmithnz/setup_scripts/master/theme_management/download_themes" "https://raw.githubusercontent.com/musicsmithnz/setup_scripts/master/theme_management/install_theme")


for i in ${!scripts[@]}; do
	echo "$i) ${scripts[$i]}"
done

for i in ${uris[@]}; do
	name=$(echo $i | sed 's|.*\/||g')
	wget --output-document=$name $i
	chmod +x $name
done

for i in ${scripts[@]}; do
	./$i
done
