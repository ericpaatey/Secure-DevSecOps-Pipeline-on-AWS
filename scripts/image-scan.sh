#!/bin/bash

echo "Scanning Docker image for vulnerabilities..."

trivy image devsecops-app

if [ $? -ne 0 ]; then
  echo "Critical vulnerabilities found in image!"
  exit 1
fi

echo "Container image scan passed."