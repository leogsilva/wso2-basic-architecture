# wso2-basic-architecture
Simple wso2 and istio architecture on AWS Cloud

## To install kubectx

```
git clone https://github.com/ahmetb/kubectx $WORKDIR/kubectx
export PATH=$PATH:$WORKDIR/kubectx
```

## To create both clusters
```
./scripts/1_create.sh
```

## To enable [IAM Roles for service account on EKS](https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html) integration for EKS
```
./scripts/2_oidc.sh
```

## To download the 1.5.x version of Istio Service Mesh
```
./scripts/3_downloadIstio.sh
```

## Setup Kubeconfig and Kubectx configuration
```
./scripts/4_kubeconfig.sh
```

## Setup the rootca for both clusters
```
./scripts/5_rootca.sh
```

## Istio 1.5.7 installation
```
./scripts/6_istio.sh
```

## Updates coredns configuration to enable multicluster architecture
```
./scripts/7_coredns.sh
```

## Installs certmanager on edge cluster
```
./scripts/8_certmanager_edge.sh
```

## Installs the WSO2 api manager on edge cluster
```
./scripts/9_apim_edge.sh
``` 

## Downloads the api micro gateway toolkit
```
./scripts/10_downloadmg.sh
```

## Build and install micro gateway on edge cluster
```
./scripts/11_buildgateway_edge.sh
```
