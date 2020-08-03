# wso2-basic-architecture
Simple wso2 and istio architecture on AWS Cloud

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
./scripts/4_kubeconifg.sh
```
