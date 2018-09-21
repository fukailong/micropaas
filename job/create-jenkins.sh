yum install java-1.8.0-openjdk* -y

yum -y install wget

wget https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/3.5.4/apache-maven-3.5.4-bin.tar.gz
tar -xvf apache-maven-3.5.4-bin.tar.gz 

mv apache-maven-3.5.4 /usr/local/apache-maven

echo "
export MAVEN_HOME=/usr/local/apache-maven
export PATH=/usr/local/apache-maven/bin:$PATH
">> /etc/profile 

source /etc/profile

yum -y install git

wget http://pkg.jenkins.io/redhat/jenkins-2.10-1.1.noarch.rpm
rpm -ivh jenkins-2.10-1.1.noarch.rpm
#wget http://pkg.jenkins.io/redhat/jenkins-2.130-1.1.noarch.rpm
#rpm -ivh jenkins-2.130-1.1.noarch.rpm

service jenkins start


type docker >/dev/null 2>&1 || 
{
#yum install -y docker-1.12.6-71.git3e8e77d.el7.centos.x86_64 
#yum -y install docker
yum install -y yum-utils
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install -y --setopt=obsoletes=0 \
   docker-ce-17.03.2.ce-1.el7.centos.x86_64 \
   docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch

mkdir -p /etc/docker
echo '{
  "registry-mirrors": ["https://yf758kjo.mirror.aliyuncs.com"],
  "insecure-registries":["192.168.146.34:5000"]
}
' > /etc/docker/daemon.json


echo "
INSECURE_REGISTRY='--insecure-registry=192.168.146.34:5000'
" >> /etc/sysconfig/docker

service docker start

systemctl enable docker.service
}
