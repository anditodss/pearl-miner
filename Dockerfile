# Same base as v1.0.7 — NVIDIA CUDA libs required for GPU mining
FROM nvidia/cuda:12.2.0-base-ubuntu22.04

# Install wget to download the miner binary
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download v1.1.1 and extract
RUN wget -c https://github.com/pearlfortune/pearl-miner/releases/download/v1.1.1/pearlfortune-v1.1.1.tar.gz \
    && tar vxzf pearlfortune-v1.1.1.tar.gz \
    && rm pearlfortune-v1.1.1.tar.gz \
    && echo "=== Listing all extracted files ===" \
    && find /app -type f \
    && echo "=== Done ==="

# Make all extracted binaries executable
RUN find /app -type f -exec chmod +x {} \;

# Copy entrypoint and FIX CRLF line endings inside the Dockerfile itself
COPY entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r$//' /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
