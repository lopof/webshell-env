#!/bin/bash

SA='/home/thomas'
#SA="/run/secrets/kubernetes.io/serviceaccount"
USER='thomas'
SERVER='https://192.168.64.5:8443'


# create user
#if [ ! -d "/home/$USER" ]; then
useradd -s /bin/bash -m -p '$1$n7mG/uK.$ZRDo2zwadvSnkC8Glga2t1' $USER 
mkdir /home/$USER/.ssh && echo "StrictHostKeyChecking=no" > /home/$USER/.ssh/config
#fi

# create kubernetes config
kubectl config set-cluster minikube --server=$SERVER  --certificate-authority=$SA/ca.crt
kubectl config set-credentials minikube --client-key /home/thomas/client.key --client-certificate /home/thomas/client.crt
kubectl config set-context minikube --cluster=minikube  --user=minikube --namespace=train
kubectl config use minikube
mkdir /home/$USER/.kube && cp /root/.kube/config /home/$USER/.kube/config
chown -R $USER:$USER /home/$USER

exit 0
