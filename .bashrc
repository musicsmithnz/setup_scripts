cc() {
#	https://www.linux.org/threads/ansi-codes-and-colorized-terminals.11706/
	BLACK='\033[0;30m'
	DARK_GREY='\033[1;30m'
	RED='\033[0;31m'
	LIGHT_RED='\033[1;31m'
	GREEN='\033[0;32m'
	LIGHT_GREEN='\033[1;32m'
	BROWN_ORANGE='\033[0;33m'
	YELLOW='\033[1;33m'
	BLUE='\033[0;34m'
	LIGHT_BLUE='\033[1;34m'
	PURULE='\033[0;35m'
	LIGHT_PURPLE='\033[1;35m'
	CYAN='\033[0;36m'
	LIGHT_CYAN='\033[1;36m'
	LIGHT_GRAY='\033[0;37m'
	WHITE='\033[1;37m'

	black='\e[40m'
	blue='\e[44m'
	cyan='\e[46m'
	grey='\e[40;1m'
	green='\e[42m'
	magenta='\e[45m'
	red='\e[41m'
	white='\e[47m'
	yellow='\e[43m'
	RGB='\e[48;2;0;0;0m' #0;0;0=R;G;B
	Index='\e[48;5;0m'
	NC='\033[0m'

	for var in "$@"
	do
		echo -e "${LIGHT_GREEN}_______________________________________________${NC}"
		echo -e "${GREEN}$var${NC}"
		echo -e "${LIGHT_GREEN}_______________________________________________${NC}"
	        pygmentize $var | cat -n | sed "s/^[ \t]*//"
 	done
}

alias p="cc"
