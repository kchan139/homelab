#!/bin/bash

set -e

source "$(dirname "$0")"/../.env

curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  "https://api.digitalocean.com/v2/sizes?page=1&per_page=999" | jq 
