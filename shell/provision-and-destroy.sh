#!/usr/bin/env bash

#####
## Purpose: Testing basic ability to deploy _any_ sort of VM from the expected image.
#####

echo '-----------------------'
echo "Beginning Basic Provisioning Test on ${targetEnvironment}"
echo '-----------------------'

if [[ "x${targetEnvironment}" == "xaws" ]]; then

  ansible-playbook ansible/aws-provision.yml && ansible-playbook ansible/aws-cleanup.yml

elif [[ "x${targetEnvironment}" == "xgcp" ]]; then

  ansible-playbook ansible/gcp-provision.yml && ansible-playbook ansible/gcp-cleanup.yml

else

  echo "Unknown environment given: ${targetEnvironment}." >&2
  echo "Exiting with an error." >&2
  exit 1

fi
