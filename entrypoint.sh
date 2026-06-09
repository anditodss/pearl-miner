#!/bin/sh
# Entrypoint: reads env vars and starts the miner

set -e

# Defaults (overridden by .env or docker-compose environment)
PROXY="${PROXY:-global.pearlfortune.org:443}"
ADDRESS="${ADDRESS:-your_prl_address_here}"
WORKER="${WORKER:-$(hostname)}"

echo "=============================="
echo "  Pearl Fortune Miner v1.1.1"
echo "=============================="
echo "  Proxy  : $PROXY"
echo "  Address: $ADDRESS"
echo "  Worker : $WORKER"
echo "  Binary : /app/pearlfortune/miner"
echo "=============================="

exec /app/pearlfortune/miner \
    --proxy "$PROXY" \
    --address "$ADDRESS" \
    --worker "$WORKER" \
    -gpu
