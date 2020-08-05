#!/bin/bash
export ISTIO_DIR=istio-1.5.7

for i in $(kubectx); do
    kubectx $i
    $ISTIO_DIR/bin/istioctl manifest apply \
    --set values.kiali.enabled=true \
    --set values.global.mtls.auto=true \
    --set values.global.mtls.enabled=false \
    --set values.gateways.istio-ingressgateway.sds.enabled=true \
    -f ${PROJECT_HOME}/istio-config/values-istio-multicluster-gateways.yaml

done
