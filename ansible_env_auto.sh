#!/bin/bash
# Create Ansible Environment
# Version: 1.3.1
# Author : Bhushan Mahajan
# Date:- 09-JAN-2018
# Updated date: 05-May-2019


#Addin user
useradd ansible 
echo "ansible" | passwd --stdin ansible
 
##################################################################################

## Granting sudo access
## NOTE: Put double backslash before the variable and escapae the string in SED 
 sed -i "/^root/a \\ansible ALL=(ALL) NOPASSWD: ALL" /etc/sudoers > /dev/null


##################################################################################
#Create SSH key and auto on root
    echo -e "\n"|ssh-keygen -t rsa -N ""    
    cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys
    chmod 600 ~/.ssh/authorized_keys


#################################################################################
#Sync date & time 
ntpdate us.pool.ntp.org

yum -y install ntp*

###################################################################################
# SSH create_key
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



