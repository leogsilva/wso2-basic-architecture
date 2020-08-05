#!/usr/bin/env bash
# Importante fix
# https://gitmemory.com/issue/jetstack/cert-manager/2147/540542406


NS="cert-manager"

kubectl apply --validate=false -f cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo update
# We should use the istio-ingressgateway as ingress controller
# helm install nginx-ingress stable/nginx-ingress --set rbac.create=true --set controller.publishService.enabled=true
# kubectl create ns ${NS}
# helm template \
#   cert-manager jetstack/cert-manager \
#   --namespace ${NS} \
#   --version v0.16.0 \
#   -f values.yaml > certmanager.yaml

kubectl apply -f certmanager.yaml 
kubectl apply -f issuer-letsencrypt-production.yaml 
