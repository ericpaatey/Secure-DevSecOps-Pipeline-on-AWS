#!/bin/bash

echo "Running dependency vulnerability scan..."

trivy fs .

if [ $? -ne 0 ]; then
  echo "Dependency vulnerabilities detected!"
  exit 1
fi

echo "Dependency scan completed successfully."