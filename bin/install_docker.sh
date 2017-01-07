#!/bin/bash
#纠正iptables的默认配置,默认不修改iptables中的IPTABLES_SYSCTL_LOAD_LIST
cp /etc/sysconfig/iptables-config /etc/sysconfig/iptables-config.`date +%s`
sed -i 's/#IPTABLES_SYSCTL_LOAD_LIST/IPTABLES_SYSCTL_LOAD_LIST/g' /etc/sysconfig/iptables-config 
##整合worker与services账户
if ( id services )
then
        echo "worker" | passwd services --stdin
        chmod 755 /home/services
        ssh_dir="/home/services/.ssh"
        uname="services"
        ugroup="services"
else
        sed  -i 's/^worker\(.*\)/&\nservices\1/g' /etc/shadow
        sed  -i 's/^worker\(.*\)/&\nservices\1/g' /etc/passwd
        ssh_dir="/home/worker/.ssh"
        uname="worker"
        ugroup="worker"
fi
##建立信任关系
mkdir -p ${ssh_dir}  && chmod 700 ${ssh_dir}  && mv  authorized_keys ${ssh_dir}/authorized_keys.tmp && cat ${ssh_dir}/authorized_keys.tmp >> ${ssh_dir}/authorized_keys
chown -R ${uname}.${ugroup} ${ssh_dir}
curl_ip=`ping -c 1 ${HOSTNAME} | head -1| awk '{print $3}' | sed 's/(\|)//g'`
curl -X POST http://10.101.1.140:8080/api/add -d "mach_list=${curl_ip}"

#安装docker服务
yum -y install docker-1.8.2-7.el7.centos docker-devel docker-selinux-1.8.2-7.el7.centos
service docker start
#下载docker使用的证书
mkdir /etc/docker/certs.d/docker2.xxxxxx.com:5000
wget http://mirrors.xxxxxx.com/docker/ca.crt -O  /etc/docker/certs.d/docker2.xxxxxx.com:5000/ca.crt
##增加services
usermod -G dockerroot services
usermod -G dockerroot worker
#修改权限sock权限
chown root.dockerroot /var/run/docker.sock
#增加g2d的命令
wget http://mirrors.xxxxxx.com/docker/g2d.sh -O /etc/profile.d/g2d.sh
