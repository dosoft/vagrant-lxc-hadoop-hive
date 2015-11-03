# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

$install = <<SCRIPT
yum install tar java-1.7.0-openjdk.x86_64 -y
cd /tmp

# HADOOP
wget --progress=bar:force http://www.eu.apache.org/dist/hadoop/common/hadoop-2.6.0/hadoop-2.6.0.tar.gz
tar xfz hadoop-2.6.0.tar.gz
chown -R vagrant:vagrant hadoop-2.6.0
mv hadoop-2.6.0 /usr/local/
rm hadoop-2.6.0.tar.gz

# HIVE
wget --progress=bar:force http://www.eu.apache.org/dist/hive/hive-1.2.1/apache-hive-1.2.1-bin.tar.gz
tar xfz apache-hive-1.2.1-bin.tar.gz
chown -R vagrant:vagrant apache-hive-1.2.1-bin
mv apache-hive-1.2.1-bin /usr/local/
rm apache-hive-1.2.1-bin.tar.gz
SCRIPT

$setup = <<SCRIPT
echo "export JAVA_HOME=/usr/lib/jvm/jre-openjdk" >> ~/.bashrc
. ~/.bashrc
ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
cat ~/.ssh/id_dsa.pub > ~/.ssh/authorized_keys
cat ~/.ssh/authorized_keys
ssh-keyscan -t rsa,dsa localhost >> ~/.ssh/known_hosts

# HADOOP
cat <<CORESITE > /usr/local/hadoop-2.6.0/etc/hadoop/core-site.xml
<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
  <property>
    <name>hadoop.tmp.dir</name>
    <value>/home/vagrant/hadoop</value>
  </property>
</configuration>
CORESITE

/usr/local/hadoop-2.6.0/bin/hadoop namenode -format

# HIVE
echo "export HADOOP_USER_CLASSPATH_FIRST=true" > /usr/local/apache-hive-1.2.1-bin/conf/hive-env.sh
echo "export HADOOP_HOME=/usr/local/hadoop-2.6.0" >> /usr/local/apache-hive-1.2.1-bin/conf/hive-env.sh

cat /dev/null > ~/.bash_history && history -c

SCRIPT

Vagrant.configure(2) do |config|

  config.vm.box = "olegd/centos-6-64-lxc"

  config.vm.hostname = "base-box"
  config.vm.provision :shell, inline: $install
  config.vm.provision :shell, inline: $setup, privileged: false
  config.vm.provider :lxc do |lxc|
    lxc.container_name = "base-box"
  end

end

