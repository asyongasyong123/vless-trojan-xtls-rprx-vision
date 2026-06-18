#!/bin/bash
set -e

# Sugdi ang Xray
echo "Starting Xray..."
xray run -c /etc/xray/config.json &

# Maghulat 5 segundos aron andam na ang Xray
sleep 5

# Sugdi ang OpenResty
echo "Starting OpenResty..."
openresty -g "daemon off;"
