#!/bin/bash

TYPE=$1

function clusterEdge() {
  eksctl create cluster -f $PROJECT_HOME/eksconfig/cluster_edge.yaml
}

function clusterApp() {
  eksctl create cluster -f $PROJECT_HOME/eksconfig/cluster_app.yaml
}

if [[ "$TYPE" = "edge" ]]; then
    echo "Creating edge cluster"
    clusterEdge
elif [[ "$TYPE" = "app" ]]; then 
    echo "Creating app cluster"
    clusterApp
else 
    echo "Creating ALL clusters"
    clusterEdge && clusterApp
fi    
