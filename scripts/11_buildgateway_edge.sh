#!/bin/bash

kubectx edge
pushd ${PROJECT_HOME}/edge/gateway.k8sguru.info
./build.sh
popd