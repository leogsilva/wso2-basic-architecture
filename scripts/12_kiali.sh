#!/bin/bash

for i in $(kubectx); do
kubectx $i
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kiali
  namespace: istio-system
  labels:
    app: kiali
type: Opaque
data:
  username: $(echo -n 'admin' | base64)
  passphrase: $(echo -n 'admin' | base64)
EOF
done