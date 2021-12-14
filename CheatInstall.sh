#!/bin/bash

display_help() {
	echo "Help for $0"
	echo "This script will install a cheat on your computer."
	echo "Any user in the group 'cheat' would be able to share this cheat."
	echo "$0 -i --> Installation"
	echo "$0 -u --> Uninstallation"
	echo "$0 -h --> Display this help"
	echo "Credits : PROUST Bastien"
}

###################################################################
#Install part
get_dependencies() {
	apt-get install -y unzip git vim
}

prepare_for_cheat() {
	export CHEAT_CONFIG_PATH="/usr/share/cheat/conf.yml"
	mkdir -p /usr/share/cheat/cheatsheets/{community,personal}
}

get_cheat_from_web() {
 	wget https://github.com/cheat/cheat/releases/download/4.2.3/cheat-linux-amd64.gz
 	gunzip cheat-linux-amd64.gz
 	chmod a+x cheat-linux-amd64
 	mv cheat-linux-amd64 /usr/bin/cheat
 	wget https://raw.githubusercontent.com/cheat/cheat/master/configs/conf.yml
 	mv conf.yml /usr/share/cheat/
 	sed -i -e 's/COMMUNITY_PATH/\/usr\/share\/cheat\/cheatsheets\/community/g' /usr/share/cheat/conf.yml
 	sed -i -e 's/PERSONAL_PATH/\/usr\/share\/cheat\/cheatsheets\/personal/g' /usr/share/cheat/conf.yml
	wget https://github.com/cheat/cheatsheets/archive/refs/heads/master.zip
	unzip master.zip
	mv cheatsheets-master/* /usr/share/cheat/cheatsheets/community/
	rm -f master.zip
	rm -rf cheatsheets-master
	chmod 770 /usr/share/cheat/cheatsheets/personal
}

create_and_set_group() {
	groupadd cheat
	usermod -a -G cheat bastien
	usermod -a -G cheat root
	echo "umask 007" >> /root/.bashrc
	echo "umask 007" >> /home/bastien/.bashrc
	chown -R root:cheat /usr/share/cheat/
	sudo chmod g+s /usr/share/cheat/cheatsheets/personal/
}



install() {
	echo "Cheat is gonna to be installed."
	get_dependencies
	prepare_for_cheat
	get_cheat_from_web
	create_and_set_group
}




####################################################################
#Uninstall part
remove_dependencies() {
	apt-get remove -y unzip git vim
}

remove_cheat() {
 	rm -rf /usr/bin/cheat
	rm -rf /usr/share/cheat
}

remove_group() {
	groupdel cheat
}

uninstall() {
	echo "Cheat is gonna to be uninstalled."
	remove_dependencies
	remove_cheat
	remove_group
}


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ $# -eq 0 ]
  then echo "No arguments supplied, please use -i, -u or -h for help"
  exit
fi

if [ $# -ge 2 ]
  then echo "Too many arguments supplied, please use -i, -u or -h for help"
  exit
fi

if [[ $1 != "-i" && $1 != "-u" && $1 != "-h" ]]
  then echo "Invalid argument, please use -i, -u or -h for help"
  exit
fi

if [ $1 == "-h" ]
  then display_help
  exit
fi

if [ $1 == "-i" ]
  then install
  exit
fi

if [ $1 == "-u" ]
  then uninstall
  exit
fi
