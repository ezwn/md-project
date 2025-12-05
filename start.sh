#!/bin/bash
# Load environment variables from .env file if it exists
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi
node-red -p 1882 -u flows