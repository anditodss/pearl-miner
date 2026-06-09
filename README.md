# Pearl Miner Custom Docker Setup (with `.env` support)

This repository provides a custom Docker wrapper for the official **[pearl-miner](https://hub.docker.com/r/pearlfortune/pearl-miner)** image. It allows you to configure your miner using a `.env` file instead of passing long, hardcoded CLI arguments when starting the container.

---

## 📂 Project Structure

Ensure your directory contains the following files:

```text
pearl-miner/
├── Dockerfile          # Wraps the official image and adds the entrypoint
├── entrypoint.sh       # Reads environment variables and runs the miner
├── docker-compose.yml  # Defines the service, mounts GPUs, and loads .env
├── .env                # Your configuration (wallet, worker name, proxy)
└── .gitignore          # Prevents pushing your wallet address to git
```

---

## 🛠️ Prerequisites

1. **Docker & Docker Compose** installed.
2. **NVIDIA Container Toolkit** installed (for GPU mining support).
   - [NVIDIA Container Toolkit Install Guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

---

## 🚀 Get Started

### Step 1: Configure your Wallet and Worker

Open the [.env](file:///.env) file (or copy the template if you don't have one) and fill in your details:

```ini
# Pool proxy endpoint
# Global Accelerated (Recommended):
PROXY=global.pearlfortune.org:443
# Japan / East Asia:
# PROXY=jp.pearlfortune.org:443

# Your Pearl Fortune (PRL) wallet address
ADDRESS=your_prl_wallet_address_here

# Worker name shown on the pool dashboard
WORKER=my-custom-miner
```

### Step 2: Build the Container

Build your custom docker image using Docker Compose:

```bash
docker compose build
```

### Step 3: Run the Miner

Start the miner in the background:

```bash
docker compose up -d
```

### Step 4: Monitor the Miner Logs

To view your miner's logs and confirm it is successfully running and mining on your GPU:

```bash
docker compose logs -f
```

To stop the miner, run:

```bash
docker compose down
```

---

## ⚙️ How it Works Under the Hood

1. **`docker-compose.yml`** reads the variables defined in `.env` and passes them to the container environment. It also requests access to all NVIDIA GPUs on the host.
2. **`Dockerfile`** installs a custom `entrypoint.sh` script on top of the official `pearlfortune/pearl-miner:v1.1.1` base image.
3. **`entrypoint.sh`** acts as a wrapper that starts `/miner` with the corresponding CLI flags dynamically set from your environment variables:
   ```bash
   /miner --proxy "$PROXY" --address "$ADDRESS" --worker "$WORKER" -gpu
   ```
