#!/bin/bash
set -x

kubectx edge
pushd certmanager
./certmanager.sh

popd