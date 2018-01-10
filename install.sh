#!/bin/bash
TARGET=/chroot/letsencrypt;

sudo apt-get install debootstrap schroot -y;
sudo debootstrap xenial $TARGET http://de.archive.ubuntu.com/ubuntu/;

echo '[*] Adding user certbot-maint with ssh/sudo privileges';
useradd -r certbot-maint -d /etc/letsencrypt -s /bin/bash;
cat $TARGET/root/.ssh/id_rsa.pub >> /etc/letsencrypt/.ssh/authorized_keys;
echo 'certbot-maint   ALL=NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo;
