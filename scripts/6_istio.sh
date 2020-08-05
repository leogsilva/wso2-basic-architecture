#!/bin/bash
export ISTIO_DIR=istio-1.5.7

TYPE=$1

function clusterEdge {
    kubectx edge
    pushd $PROJECT_HOME/cluster1
    kubectl create ns istio-system; 
    kubectl create secret generic cacerts -n istio-system --from-file=ca-cert.pem --from-file=ca-key.pem --from-file=root-cert.pem --from-file=cert-chain.pem
    popd
    $ISTIO_DIR/bin/istioctl manifest apply \
    --set values.kiali.enabled=true \
    --set values.tracing.enabled=true \
    --set values.global.mtls.auto=true \
    --set values.global.mtls.enabled=false \
    --set values.gateways.istio-ingressgateway.sds.enabled=true \
    -f ${PROJECT_HOME}/istio-config/values-istio-multicluster-gateways-edge.yaml
}

function clusterApp {
    kubectx app
    pushd $PROJECT_HOME/cluster1
    kubectl create ns istio-system; 
    kubectl create secret generic cacerts -n istio-system --from-file=ca-cert.pem --from-file=ca-key.pem --from-file=root-cert.pem --from-file=cert-chain.pem
    popd
    $ISTIO_DIR/bin/istioctl manifest apply \
    --set values.kiali.enabled=true \
    --set values.tracing.enabled=true \
    --set values.global.mtls.auto=true \
    --set values.global.mtls.enabled=false \
    --set values.gateways.istio-ingressgateway.sds.enabled=true \
    -f ${PROJECT_HOME}/istio-config/values-istio-multicluster-gateways-app.yaml
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
