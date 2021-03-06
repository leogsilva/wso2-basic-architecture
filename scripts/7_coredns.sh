#!/bin/bash
#https://istio.io/latest/docs/setup/install/multicluster/gateways/

TYPE=$1

function updateCM() {
  kubectl apply -f - <<EOF
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    .:53 {
        errors
        health
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           upstream
           fallthrough in-addr.arpa ip6.arpa
        }
        prometheus :9153
        forward . /etc/resolv.conf
        cache 30
        loop
        reload
        loadbalance
    }
    global:53 {
        errors
        cache 30
        forward . $(kubectl get svc -n istio-system istiocoredns -o jsonpath={.spec.clusterIP}):53
    }
EOF
kubectl rollout restart deploy coredns -n kube-system
}

function clusterEdge() {
  kubectx edge
  updateCM
}

function clusterApp() {
  kubectx app
  updateCM
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
