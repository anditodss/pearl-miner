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

# Find the miner binary dynamically
MINER_BIN=$(find / -name "miner" -type f 2>/dev/null | head -1)

if [ -z "$MINER_BIN" ]; then
  echo "ERROR: miner binary not found!"
  exit 1
fi

echo "  Binary : $MINER_BIN"
echo "=============================="

exec "$MINER_BIN" \
    --proxy "$PROXY" \
    --address "$ADDRESS" \
    --worker "$WORKER" \
    -gpu
