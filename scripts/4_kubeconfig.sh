#!/bin/bash

TYPE=$1

function clusterEdge {
    eksctl utils write-kubeconfig --cluster basic-cluster-A --region us-east-1 --auto-kubeconfig
}

function clusterApp {
    eksctl utils write-kubeconfig --cluster basic-cluster-B --region us-east-1 --auto-kubeconfig
}

if [[ "$TYPE" = "edge" ]]; then
    echo "Updating edge cluster"
    clusterEdge
elif [[ "$TYPE" = "app" ]]; then 
    echo "Updating app cluster"
    clusterApp
else 
    echo "Updating ALL clusters"
    clusterEdge && clusterApp
fi

export KUBECONFIG=$HOME/.kube/eksctl/clusters/basic-cluster-A:$HOME/.kube/eksctl/clusters/basic-cluster-B

kubectx edge=$AWS_USER@basic-cluster-A.us-east-1.eksctl.io
kubectx app=$AWS_USER@basic-cluster-B.us-east-1.eksctl.io
kubectx

