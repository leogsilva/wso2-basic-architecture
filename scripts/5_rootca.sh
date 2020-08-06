#!/bin/bash 

echo "Download makefile from istio source..."
curl https://raw.githubusercontent.com/istio/istio/1.6.7/tools/certs/Makefile > $PROJECT_HOME/scripts/Makefile.rootca
rm -fr cluster1
make -f $PROJECT_HOME/scripts/Makefile.rootca cluster1-certs 

rm -fr $PROJECT_HOME/root*
rm -fr $PROJECT_HOME/scripts/Makefile.rootca
