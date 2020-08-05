#!/bin/bash
set -x 

kubectx app
export CLUSTER2_GW_ADDR=$(kubectl get svc --selector=app=istio-ingressgateway \
    -n istio-system -o jsonpath='{.items[0].status.loadBalancer.ingress[0].hostname}')

kubectx edge
kubectl apply -n gateway -f - <<EOF
apiVersion: networking.istio.io/v1alpha3
kind: ServiceEntry
metadata:
  name: products-micro
spec:
  hosts:
  # must be of form name.namespace.global
  - products.micro.global
  location: MESH_INTERNAL
  ports:
  - name: http1
    number: 8000
    protocol: http
  resolution: DNS
  addresses:
  - 240.0.0.2
  endpoints:
  - address: ${CLUSTER2_GW_ADDR}
    network: external
    ports:
      http1: 15443 # Do not change this port value
  - address: istio-egressgateway.istio-system.svc.cluster.local
    ports:
      http1: 15443
EOF

kubectx app
pushd ${PROJECT_HOME}/edge/gateway.k8sguru.info
./install_sample_backend.sh
popd