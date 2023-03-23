# sudo apt-get install python3 python3-dev python3-pip


# sudo pip3 install netaddr


sudo usermod -a -G docker root 
#if you don't want to log out and in to activate the change to group
newgrp docker
# set docker proxies by updating  `/etc/systemd/system/docker.service.d/http-proxy.conf`
sudo apt-get install rustc -y

pip3 install ansible 

cp .local/bin/ansible  /usr/local/bin


mv ansible.cfg.sample ansible.cfg

mv inventory.cfg.sample inventory.cfg


# ./local_inventory.sh

# ansible all -m setup


# make 