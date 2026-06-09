# Identical base to v1.0.7 (which worked perfectly)
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download v1.1.1 (extracts to pearlfortune/ subfolder)
RUN wget -c https://github.com/pearlfortune/pearl-miner/releases/download/v1.1.1/pearlfortune-v1.1.1.tar.gz \
    && tar vxzf pearlfortune-v1.1.1.tar.gz \
    && chmod +x pearlfortune/miner \
    && rm pearlfortune-v1.1.1.tar.gz

# Env vars with defaults — users override via -e or .env
ENV PROXY=global.pearlfortune.org:443
ENV ADDRESS=your_prl_address_here
ENV WORKER=default

# No shell script needed — inline entrypoint eliminates CRLF issues entirely
ENTRYPOINT ["sh", "-c", "echo '=== Pearl Miner v1.1.1 ===' && echo \"Proxy: $PROXY\" && echo \"Address: $ADDRESS\" && echo \"Worker: $WORKER\" && exec /app/pearlfortune/miner --proxy \"$PROXY\" --address \"$ADDRESS\" --worker \"$WORKER\" -gpu"]
