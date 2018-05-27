#!/bin/bash
# Bash Menu Script

if [ ! -f ./fly ]; then
wget -O fly "http://concourse.$SYSTEM_DOMAIN/api/v1/cli?arch=amd64&platform=linux"
chmod 700 fly
fi

./fly -t $TARGET login --concourse-url http://concourse.$SYSTEM_DOMAIN

PS3='Please enter your choice: '
options=("Option 1: bastion" "Option 2: workspace" "Option 3: terraform" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1: bastion")
            ./fly -t $TARGET intercept -j $TARGET-jumpbox/deploy-bastion
            echo ${options[@]}
            ;;
        "Option 2: workspace")
            ./fly -t $TARGET intercept -j $TARGET-jumpbox/deploy-bosh-workspace
            echo ${options[@]}
            ;;
        "Option 3: terraform")
            ./fly -t $TARGET intercept -j $TARGET-terraform/deploy-terraform
            echo ${options[@]}
            ;;
        "Quit")
            ./fly -t $TARGET logout
            break
            ;;
        *) echo invalid option;;
    esac
done
