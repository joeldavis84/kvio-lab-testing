#!/usr/bin/env bash

  ## Default to running lab1 tests
if [[ -z "$1" ]]; then

  labName="lab1"

else

  labName="$1"

fi

echo '-----------------------'
echo "Beginning Test for ${labName} on ${targetEnvironment}"
echo '-----------------------'

if [[ "x${targetEnvironment}" != "xaws" ]] && [[ "x${targetEnvironment}" != "xgcp" ]]; then

  echo "Unknown environment given: ${targetEnvironment}." >&2
  echo "Exiting with an error." >&2
  exit 1

fi

ansible-playbook ansible/${targetEnvironment}-provision.yml || exit 1
ansible-playbook --private-key ${SSH_KEY_LOCATION} -i /tmp/inventory ansible/${labName}.yml || exit 1
ansible-playbook ansible/${targetEnvironment}-cleanup.yml || exit 1
