#!/bin/bash
# Create Ansible Environment
# Version: 1.3.1
# Author : Bhushan Mahajan
# Date:- 09-JAN-2018
# Updated date: 05-May-2019
############################################

#Addin user
cat /etc/passwd | grep ansible
  if [ $? -ne 0 ]; then
    useradd ansible && echo "ansible" | passwd --stdin ansible
  fi
 
##################################################################################

## Granting sudo access
## NOTE: Put double backslash before the variable and escapae the string in SED 
sed -i "/^root/a \\ansible ALL=(ALL) NOPASSWD: ALL" /etc/sudoers > /dev/null


##################################################################################
#Create SSH key for root 
    echo -e "\n"|ssh-keygen -t rsa -N ""    
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys


#################################################################################
#Sync date & time 

rpm -qa | grep ntp* > /dev/null
  if [ $? -ne 0 ]; then

     echo -e "\n\t\033[33;5mNTP is installing..\033[0m\n"
     yum -y install ntp*
     ntpdate us.pool.ntp.org

  else

     ntpdate us.pool.ntp.org
  
  fi

###################################################################################
# Creating SSH KEY for Ansible user 
    su - ansible  << EOF
    echo -e "\n"|ssh-keygen -t rsa -N ""    
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys
    #sudo ssh-keyscan localhost >> /home/ansible/.ssh/known_hosts
        
EOF



#################################### Create dir, file & give perm ##################
# Ansible_install()

     yum install epel-release -y > /dev/null
     yum install ansible -y  /dev/null
     yum install -y vim wget 

         
# Python-Boto
yum install -y python-pip* 
pip install --upgrade pip
pip install boto
pip install boto3
pip install awscli==1.15.83      
         
# git_install()

## Git clone
  yum -y install git
  su - ansible << EOF
  git config --global user.name "Bhushan Mahajan"
  git config --global user.email "bmahajan0@gmail.com"
  echo "cd /home/ansible/ansible/playbooks" >> ~/.bashrc
  cd /home/ansible/ansible
EOF



# Ansible configuration
sed -i "/^#host_key_checking = False/a host_key_checking = False" /etc/ansible/ansible.cfg

# INVENTORY
echo -e "[local]" >> /etc/ansible/hosts
echo -e "localhost\n" >> /etc/ansible/hosts



