#!/usr/bin/env bash

echo '-----------------------'
echo "Beginning Test for lab2 on ${targetEnvironment}"
echo '-----------------------'

if [[ "x${targetEnvironment}" == "xaws" ]]; then

  echo "AWS specific steps here"

elif [[ "x${targetEnvironment}" == "xgcp" ]]; then

  echo "GCP specific steps here"

else

  echo "Unknown environment given: ${targetEnvironment}." >&2
  echo "Exiting with an error." >&2
  exit 1

fi
