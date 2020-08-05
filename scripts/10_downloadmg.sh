#!/bin/bash
# Download page https://github.com/wso2/product-microgateway/releases

curl -LO https://github.com/wso2/product-microgateway/releases/download/v3.1.0/${WSO2_MICROGW_PKG}.zip
unzip "${WSO2_MICROGW_PKG}.zip"
rm -fr "${WSO2_MICROGW_PKG}.zip"

