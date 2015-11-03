# vagrant-lxc-hadoop-hive
Scripts to create Vagrant LXC container with hadoop &amp; hive (single node)

Hadoop version: 2.6.0
Hive version: 1.2.1

Base box: olegd/centos-6-64-lxc (Vagrant LXC box, Centos 6.x)

## How to create box

Install vagrant & vagrant-lxc (https://github.com/fgrehm/vagrant-lxc)

Run ./build.sh to perform the following steps:

1. Create temporary box with centos 6.x
2. Install hadoop & hive
3. Configure hadoop to store data in the ~/vagrant directory instead of default /tmp
4. Configure password-less ssh access

Resulting box will be generated in the target subdirectory

## Atlas

This box is available on atlas.hashicorp.com as "olegd/lxc-centos6-hadoop260-hive121"
