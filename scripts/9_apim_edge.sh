#!/bin/bash
# Documentation:https://github.com/wso2/kubernetes-apim
# https://github.com/wso2/kubernetes-apim/tree/master/advanced/am-pattern-1

export APIM_NS="wso2-apim"
kubectx edge
helm repo add wso2 https://helm.wso2.com 
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install nginx ingress-nginx/ingress-nginx
kubectl create ns ${APIM_NS}
helm install apim wso2/am-pattern-1 --version 3.1.0-3 -f ${PROJECT_HOME}/apim-config/values.yaml --namespace ${APIM_NS}






