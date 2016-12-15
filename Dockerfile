FROM centos

MAINTAINER zhangxiaozheng <zhangxiaozheng85@126.com>
LABEL Description="This image is build for MAC to use nexus" 

RUN yum install -y wget iproute crontabs.noarch logrotate.x86_64 && yum clean all

RUN mkdir -p /home/worker && wget http://mirrors.cnnic.cn/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz  && tar zxvf apache-maven-3.3.9-bin.tar.gz && rm -rf apache-maven-3.3.9-bin.tar.gz
ENV PATH /home/worker/apache-maven-3.3.9/bin:$PATH

RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install -y jenkins
RUN yum install -y java-1.8.0-openjdk
