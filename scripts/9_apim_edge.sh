#!/bin/bash
# Documentation available at https://github.com/wso2/kubernetes-apim/tree/master/advanced/am-pattern-1

set -x

export APIM_NS="wso2-apim"
kubectx edge
helm repo add wso2 https://helm.wso2.com && helm repo update
kubectl create ns ${APIM_NS} || true
helm install apim wso2/am-pattern-1 --version 3.1.0-3 -f ${PROJECT_HOME}/apim-config/values.yaml --namespace ${APIM_NS}