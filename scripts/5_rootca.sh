#!/bin/bash 

echo "Download makefile from istio source..."
curl https://raw.githubusercontent.com/istio/istio/1.6.7/tools/certs/Makefile > $PROJECT_HOME/scripts/Makefile.rootca
make -f $PROJECT_HOME/scripts/Makefile.rootca cluster1-certs 
pushd $PROJECT_HOME/cluster1
for i in $(kubectx); do
    kubectx $i
    kubectl create ns istio-system; 
    kubectl create secret generic cacerts -n istio-system --from-file=ca-cert.pem --from-file=ca-key.pem --from-file=root-cert.pem --from-file=cert-chain.pem
done
rm -fr $PROJECT_HOME/scripts/Makefile.rootca
popd
