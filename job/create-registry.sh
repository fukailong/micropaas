yum -y update

type docker >/dev/null 2>&1 || 
{
sudo yum remove docker \
                   docker-client \
                   docker-client-latest \
                   docker-common \
                   docker-latest \
                   docker-latest-logrotate \
                   docker-logrotate \
                   docker-selinux \
                   docker-engine-selinux \
                   docker-engine

sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install -y --setopt=obsoletes=0 \
   docker-ce-17.03.2.ce-1.el7.centos.x86_64 \
   docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch


#echo "
#INSECURE_REGISTRY='--insecure-registry=${registry_ip_port}'
#" >> /etc/sysconfig/docker
mkdir -p /etc/docker

tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://43wxvjkp.mirror.aliyuncs.com"],
  "insecure-registries":["192.168.194.16:5000"]
}
EOF


sudo systemctl daemon-reload
sudo systemctl restart docker
}
docker pull registry

if [ "$(docker ps| grep "registry")" == "" ]
        then

                docker run -d --restart=always -p 5000:5000 registry
fi

#docker pull java:8

#curl http://192.168.56.34:5000/v2/_catalog
#docker tag java:8  192.168.194.16:5000/microservice/java:8

#curl http://192.168.56.34:5000/v2/_catalog
#docker push  192.168.194.16:5000/microservice/java:8
