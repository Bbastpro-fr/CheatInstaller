#!/bin/bash


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ $# -eq 0 ]
  then echo "No arguments supplied, please enter an username"
  exit
fi

if [ $# -ge 2 ]
  then echo "Too many arguments supplied, please enter an username"
  exit
fi

echo "umask 007" >> /home/$1/.bashrc
usermod -a -G cheat $1
