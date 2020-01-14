#!/bin/bash
#Author: Bhushan Mahajan
#Date: 14-JAN-2020

#DIR="$(cd "$(dirname "$0")" && pwd)"
#$DIR/script.sh

 rpm -qa | grep ansible > /dev/null
  if [ $? -eq 0 ]; then

   echo -e "\n\t\033[33;5mAnsible is installed with version `ansible --version | head -1 | awk -F " " '{print $2}'`\033[0m\n"

 
  else

    echo -e "`tput setaf 1`Ansible does not present. Do you want to install Ansible[y/n]`tput sgr0`"
    read -p "Enter val" val
       
     if [i $val -eq "y" ];then

 echo -e -n "`tput setaf 2``tput bold`\n Ansible is intalling & Fasten your seatbelt please! `tput sgr0`";sleep 2;echo -n ..;sleep 1;echo -n ...;echo " ";echo " "
         ./ansible_env_auto.sh

     else
         exit;
     fi
     
  fi

sleep 1
echo -e "\n"
echo -e "`tput setaf 5`Do you want to launch ec2 instance? press y or e exit`tput sgr0`\t" 
read -p "Enter Input: " vale


case $vale in 

y) echo -e -n "`tput setaf 2``tput bold`\nLaunching ec2 instance Fasten your seatbelt please `tput sgr0`";sleep 2;echo -n ..;sleep 1;echo -n ...;echo " ";echo " "
   ansible-playbook ec2-launch.yml --vault-password-file .pass 
   ansible-playbook create_user_ssh_key.yml --vault-password-file .pass 
   ;;

e) exit
   ;;

*) echo -e "`tput setaf 1`You have entered wrong value.!!`tput sgr0`"

   ;;
esac
