#!/bin/bash
TARGET=/chroot/letsencrypt;

sudo apt-get install debootstrap schroot -y;
sudo debootstrap xenial $TARGET http://de.archive.ubuntu.com/ubuntu/;

echo '[*] Adding user certbot-maint with ssh/sudo privileges';
useradd -r certbot-maint -d /etc/letsencrypt -s /bin/bash;

cp -R ./etc/* /etc/;
cp -R ./usr/ /usr/;

schroot -c chroot-letsencrypt -- sh -c 'apt-get install ssh -y ; ssh-keygen -t rsa -C "" -P "" -f "/root/.ssh/id_rsa.pub" -q';

mkdir -p /etc/letsencrypt/.ssh/;
cat $TARGET/root/.ssh/id_rsa.pub >> /etc/letsencrypt/.ssh/authorized_keys;

# ToDo use /etc/suders.d/
echo 'certbot-maint   ALL=NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo;
