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
    && rm pearlfortune-v1.1.1.tar.gz

# Show what was extracted (helps debug path issues)
RUN echo "=== Extracted files ===" && find / -name "miner" -type f 2>/dev/null && echo "======================="

# Make miner executable wherever it is
RUN find / -name "miner" -type f -exec chmod +x {} \; 2>/dev/null || true

# Copy our custom entrypoint (LF line endings enforced via .gitattributes)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
