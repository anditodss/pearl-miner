#!/bin/sh
# Entrypoint: reads env vars and starts the miner

set -e

# Defaults (overridden by .env or docker-compose environment)
PROXY="${PROXY:-global.pearlfortune.org:443}"
ADDRESS="${ADDRESS:-your_prl_address_here}"
WORKER="${WORKER:-$(hostname)}"

echo "=============================="
echo "  Pearl Fortune Miner"
echo "=============================="
echo "  Proxy  : $PROXY"
echo "  Address: $ADDRESS"
echo "  Worker : $WORKER"
echo "=============================="

exec /pearlfortune/miner \
    --proxy "$PROXY" \
    --address "$ADDRESS" \
    --worker "$WORKER" \
    -gpu
