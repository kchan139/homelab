#!/bin/bash

set -e

PROJECT_ROOT="$(dirname "$0")/../.."
TOFU_DIR="$PROJECT_ROOT/terraform"
SCRIPT_DIR="$TOFU_DIR/scripts"

source "$SCRIPT_DIR/.env"

curl -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  "https://api.digitalocean.com/v2/sizes" \
| jq '.sizes[] | {slug, price_monthly, vcpus, memory, disk}' 
