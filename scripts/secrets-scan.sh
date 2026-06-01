#!/bin/bash

echo "Scanning repository for secrets..."

trivy fs --scanners secret .

if [ $? -ne 0 ]; then
  echo "Secrets detected in repository!"
  exit 1
fi

echo "Secrets scan completed successfully."