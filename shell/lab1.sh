#!/usr/bin/env bash

echo '-----------------------'
echo "Beginning Test for lab1 on ${targetEnvironment}"
echo '-----------------------'

if [[ "x${targetEnvironment}" == "xaws" ]]; then

  ansible-playbook ansible/aws-provision.yml || exit 1

elif [[ "x${targetEnvironment}" == "xgcp" ]]; then

  ansible-playbook ansible/gcp-provision.yml || exit 1

else

  echo "Unknown environment given: ${targetEnvironment}." >&2
  echo "Exiting with an error." >&2
  exit 1

fi

ansible-playbook --private-key ${SSH_KEY_LOCATION} -i /tmp/inventory ansible/lab1.yml || exit 1
ansible-playbook ansible/${targetEnvironment}-cleanup.yml || exit 1
