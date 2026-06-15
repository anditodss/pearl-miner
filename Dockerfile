FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download PearlHash miner v12 at build time
# Use a browser User-Agent to bypass Cloudflare protection
RUN curl -fsSL \
    -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
    https://pearlhash.xyz/downloads/pearl-miner-v12 \
    -o pearl-miner && \
    chmod +x pearl-miner

# Default env vars — override on Salad dashboard
ENV HOST=pool.pearlhash.xyz:9000
ENV USER=your_prl_address_here
ENV WORKER=worker1

ENTRYPOINT ["sh", "-c", "\
    echo '=============================' && \
    echo '  PearlHash Pool Miner v12  ' && \
    echo '=============================' && \
    echo \"  Host   : $HOST\"            && \
    echo \"  User   : $USER\"            && \
    echo \"  Worker : $WORKER\"          && \
    echo '=============================' && \
    exec /app/pearl-miner --host \"$HOST\" --user \"$USER\" --worker \"$WORKER\" \
"]
