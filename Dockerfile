# Same base as v1.0.7 — NVIDIA CUDA libs required for GPU mining
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# Install wget to download the miner binary
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download v1.1.1 — note: different tar structure than v1.0.7
# v1.0.7: extracts directly as "miner"
# v1.1.1: extracts into "pearlfortune/miner" subfolder
RUN wget -c https://github.com/pearlfortune/pearl-miner/releases/download/v1.1.1/pearlfortune-v1.1.1.tar.gz \
    && tar vxzf pearlfortune-v1.1.1.tar.gz \
    && chmod +x pearlfortune/miner \
    && rm pearlfortune-v1.1.1.tar.gz

# Copy entrypoint (LF line endings enforced via .gitattributes)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
