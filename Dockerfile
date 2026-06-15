FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl ca-certificates libgomp1 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download PearlHash miner v8 (confirmed working version)
RUN curl https://pearlhash.xyz/downloads/pearl-miner-v8 -o /app/pearl-miner && \
    chmod +x /app/pearl-miner

# Default env vars — override on Salad dashboard
ENV HOST=pool.pearlhash.xyz:9000
ENV USER=your_prl_address_here
ENV WORKER=worker1

ENTRYPOINT ["sh", "-c", "\
    echo '=============================' && \
    echo '  PearlHash Pool Miner v8   ' && \
    echo '=============================' && \
    echo \"  Host   : $HOST\"            && \
    echo \"  User   : $USER\"            && \
    echo \"  Worker : $WORKER\"          && \
    echo '=============================' && \
    exec /app/pearl-miner --host \"$HOST\" --user \"$USER\" --worker \"$WORKER\" \
"]
