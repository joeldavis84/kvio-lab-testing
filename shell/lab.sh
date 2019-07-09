#!/usr/bin/env bash

#########################################
### Global Vars and Utility Functions
#########################################

  ## This disables a warning about something that's intended behavior (not having inventory for provisioning and cleanup
export ANSIBLE_LOCALHOST_WARNING="False"

  ## Default to running lab1 tests
if [[ -z "$1" ]]; then

  labName="lab1"

else

  labName="$1"

fi

failImmediately(){
  if [[ $1 -ne 0 ]]; then
    echo "Ansible Playbook Failed with: $1" >&1
    exit $1
  fi
}


#########################################
### Main Logic
#########################################

echo '-----------------------'
echo "Beginning Test for ${labName} on ${targetEnvironment}"
echo '-----------------------'

if [[ "x${targetEnvironment}" != "xaws" ]] && [[ "x${targetEnvironment}" != "xgcp" ]]; then

  echo "Unknown environment given: ${targetEnvironment}." >&2
  echo "Exiting with an error." >&2
  exit 1

fi

set -o pipefail
ansible-playbook ansible/${targetEnvironment}-provision.yml | tee ansible-${targetEnvironment}-${labName}-provision.log
failImmediately $?

ansible-playbook --private-key ${SSH_KEY_LOCATION} -i /tmp/inventory ansible/${labName}.yml | tee ansible-${targetEnvironment}-${labName}.log
failImmediately $?

ansible-playbook ansible/${targetEnvironment}-cleanup.yml | tee ansible-${targetEnvironment}-${labName}-cleanup.log
failImmediately $?

if [[ "$targetEnvironment" == "gcp" ]]; then

cat $GOOGLE_APPLICATION_CREDENTIALS > ansible-fakelog-gcp.log

fi
