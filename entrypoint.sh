#!/bin/sh
set -e

PROXY="${PROXY:-global.pearlfortune.org:443}"
ADDRESS="${ADDRESS:-your_prl_address_here}"
WORKER="${WORKER:-$(hostname)}"

echo "=============================="
echo "  Pearl Fortune Miner v1.1.1"
echo "=============================="
echo "  Proxy  : $PROXY"
echo "  Address: $ADDRESS"
echo "  Worker : $WORKER"

# Auto-find the miner binary
MINER=$(find /app -name "miner" -type f 2>/dev/null | head -1)

if [ -z "$MINER" ]; then
    echo "ERROR: miner binary not found in /app!"
    echo "Contents of /app:"
    find /app -type f 2>/dev/null
    exit 1
fi

echo "  Binary : $MINER"
echo "=============================="

exec "$MINER" \
    --proxy "$PROXY" \
    --address "$ADDRESS" \
    --worker "$WORKER" \
    -gpu
