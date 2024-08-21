#!/bin/bash

# $1 is a positional parameter that will be used to pass the namespace to the script when it is executed. 
# If the namespace is not provided as an argument, the script will prompt the user to enter it. 
# The script will then validate that the namespace is provided and exit if it is not.
# to use the script, run the following command:


# ./cleanup_empty_replicasets.sh <namespace>

# Prompt user for namespace if not provided as an argument
if [ -z "$1" ]; then
  read -p "Please enter the namespace: " NAMESPACE
else
  NAMESPACE=$1
fi

# Validate that namespace is provided
if [ -z "$NAMESPACE" ]; then
  echo "Usage: $0 <namespace>"
  exit 1
fi

# Get all ReplicaSets with zero replicas
REPLICASETS=$(kubectl get replicaset -n $NAMESPACE --no-headers | awk '$2 == 0 {print $1}')

if [ -z "$REPLICASETS" ]; then
  echo "No unused ReplicaSets found in namespace $NAMESPACE."
  exit 0
fi

# Delete each unused ReplicaSet
for rs in $REPLICASETS; do
  echo "Deleting ReplicaSet $rs in namespace $NAMESPACE..."
  kubectl delete replicaset $rs -n $NAMESPACE
done

echo "Cleanup complete."
