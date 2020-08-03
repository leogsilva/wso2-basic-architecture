#!/bin/bash

function clusterEdge {
    eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=basic-cluster-A --approve
}

function clusterApp {
    eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=basic-cluster-B --approve
}

TYPE=$1

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


