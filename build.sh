#!/usr/bin/env bash

set -e

echo "Creating base container ..."
vagrant up
vagrant halt

echo "Creating box ..."

rm -rf target
mkdir target
cp configs/config target/lxc-config
cp configs/metadata.json target/

TODAY="$(date -u +"%Y-%m-%d")"
WD="$(pwd)"
VAGRANT_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"

sed -i "s/<TODAY>/${TODAY}/" target/metadata.json
echo $VAGRANT_KEY | sudo tee --append /var/lib/lxc/base-box/rootfs/home/vagrant/.ssh/authorized_keys
sudo bash -c "cd /var/lib/lxc/base-box && tar --numeric-owner --anchored --exclude=./rootfs/dev/log -czf ${WD}/target/rootfs.tar.gz ./rootfs/*"

echo "Packaging box ..."
(cd target && tar -czf vagrant-lxc-centos-6-amd64-hadoop-2.6.0-hive-1.2.1.box ./*)

echo "Removing base box ..."
vagrant destroy -f
