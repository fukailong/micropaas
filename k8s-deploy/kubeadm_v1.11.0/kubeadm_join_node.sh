#!/bin/bash

set -e

## Pre-configure
./01_pre_check_and_configure.sh

# Install Docker
./02_install_docker.sh

# Install kubelet kubeadm kubectl
./03_install_kubernetes.sh

# Pull kubernetes node images
./04_pull_kubernetes_node_images_from_aliyun.sh


# Join kubernetes node

# Put "kubeadm join" here from "kubeadm init" output
# Example: kubeadm join 192.168.37.101:6443 --token mmxy0q.sjqca7zrzzj7czft --discovery-token-ca-cert-hash sha256:099421bf9b3c58e4e041e816ba6477477474614a17eca7f5d240eb733e7476bb	
kubeadm join 192.168.194.11:6443 --token p5n7sy.imkpt14l829mfsuj --discovery-token-ca-cert-hash sha256:60d50c5b6923940550733dec5ec48e0dcf3c32355f590c70aad846c6ceb72935


