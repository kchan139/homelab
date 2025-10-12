#!/bin/bash

set -e

PROJECT_ROOT="$(dirname "$0")/../.."
TOFU_DIR="$PROJECT_ROOT/terraform"
SCRIPT_DIR="$TOFU_DIR/scripts"

source "$SCRIPT_DIR/.env"

curl -s -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DIGITALOCEAN_TOKEN" \
  "https://api.digitalocean.com/v2/images?page=1&per_page=1000&type=distribution" \
| jq '.images[] | select(.distribution == "Fedora") | {name, distribution, regions, slug}'
