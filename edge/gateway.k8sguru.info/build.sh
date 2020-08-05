#!/bin/bash
# reference documentation for deployment.toml 
# https://docs.wso2.com/display/MG301/deployment.toml+for+Kubernetes
export GATEWAY_NAME="gateway_k8sguru_info"
export GATEWAY_NS="gateway"

micro-gw init ${GATEWAY_NAME}
cp apis/* ${GATEWAY_NAME}/api_definitions

cat > deployment.toml <<EOF
[kubernetes]
  [kubernetes.kubernetesDeployment]
    enable = true
    name = 'gateway'
    namespace = '${GATEWAY_NS}'
    tag = 'v1'
    #labels = ''
    replicas = '1'
    #enableLiveness = ''
    #initialDelaySeconds = ''
    #periodSeconds = ''
    #livenessPort = ''
    imagePullPolicy = 'Always'
    #imagePullSecrets = ['secret1']
    image = 'docker.io/leogsilva/gateway'
    #env = ''
    buildImage = true
    #cmd = 'CMD gateway ${APP} --b7a.config.file=conf/micro-gw.conf --b7a.log.level=DEBUG'
    #copyFiles = ''
    #dockerHost = ''
    #dockerCertPath = ''
    #push = 'false'
    registry = 'docker.io/leogsilva'
    #username = ''
    #password = ''
    baseImage = 'wso2/wso2micro-gw:3.1.0'
    [kubernetes.kubernetesDeployment.livenessProbe]
        enable = true
        initialDelaySeconds = '20'
        periodSeconds = '20'
    [kubernetes.kubernetesDeployment.readinessProbe]
        enable = true
        initialDelaySeconds = '30'
        periodSeconds = '30'
  [kubernetes.kubernetesServiceHttps]
      enable = false
      name = 'httpsService'
      #labels = '{"": ""}'
      serviceType = 'NodePort'
      #port = ''
  [kubernetes.kubernetesServiceHttp]
      enable = true
      name = 'httpService'
      #labels = '{"": ""}'
      serviceType = 'ClusterIP'
      #port = ''
  [kubernetes.kubernetesConfigMap]
    enable = true
    ballerinaConf = '${WSO2_GW_ROOT}/resources/conf/micro-gw.conf'
EOF

micro-gw build ${GATEWAY_NAME} --deployment-config deployment.toml

docker push docker.io/leogsilva/gateway:latest
kubectl create ns ${GATEWAY_NS} || true 
kubectl label namespace ${GATEWAY_NS} istio-injection=enabled 
kubectl apply -n ${GATEWAY_NS} -f "${GATEWAY_NAME}/target/gen/target/kubernetes/${GATEWAY_NAME}/${GATEWAY_NAME}.yaml"
kubectl apply -f kubernetes/gateway-certificate-production.yaml
kubectl apply -n ${GATEWAY_NS} -f kubernetes/service.yaml
kubectl apply -n ${GATEWAY_NS} -f kubernetes/ingress.yaml
kubectl rollout restart deploy gateway -n ${GATEWAY_NS}