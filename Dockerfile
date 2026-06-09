# Build from a clean Ubuntu base — no dependency on the official image internals
FROM ubuntu:22.04

# Install wget and ca-certificates for HTTPS downloads
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and extract the official pearl-miner binary from GitHub Releases
RUN wget -c https://github.com/pearlfortune/pearl-miner/releases/download/v1.1.1/pearlfortune-v1.1.1.tar.gz \
    && tar vxzf pearlfortune-v1.1.1.tar.gz \
    && chmod +x /pearlfortune/miner \
    && rm pearlfortune-v1.1.1.tar.gz

# Copy our custom entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
