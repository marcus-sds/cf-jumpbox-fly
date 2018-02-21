#!/bin/bash

./fly -t $TARGET  login --concourse-url http://concourse.$SYSTEM_DOMAIN
./fly -t $TARGET intercept -j $TARGET-jumpbox/deploy-bastion
