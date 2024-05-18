# Initia Node Setup Guide

Welcome to the Initia Node Setup Guide. This document will guide you through the process of setting up your Initia node, creating a wallet, managing your node, and submitting your node information.

# Help me, to stake on my validator
# [kinonomad](https://app.testnet.initia.xyz/stake?withValidator=initvaloper1yk2jssndh98n8rcz96xqyfk0qvs7km50np0u26)

## Minimum Requirements

- **CPU**: 4 cores
- **Memory**: 16GB RAM
- **Disk**: 1 TB SSD Storage

## Install Node

1. **Download and prepare the installation script:**
    ```bash
    wget -O initia.sh https://raw.githubusercontent.com/shidiqmuh0/initia-node/main/initia.sh
    chmod +x initia.sh
    ```

2. **Run the installation script and follow the prompts to input your name:**
    ```bash
    ./initia.sh
    ```

3. **Load the new profile settings:**
    ```bash
    source $HOME/.bash_profile
    ```
### Before your create wallet and validator, please sync your node first

## Create Wallet

1. **Create a new wallet:**
    ```bash
    initiad keys add wallet
    ```
    **Important**: Backup your mnemonic phrase and wallet information securely. Do not share this information with anyone.

## Get Testnet Tokens

Get testnet tokens from the faucet:
[Initia Faucet](https://faucet.testnet.initia.xyz/)

## Wallet Management

1. **View your wallet details:**
    ```bash
    initiad keys list
    ```

2. **Check your wallet balance:**
    ```bash
    initiad q bank balances $(initiad keys show wallet -a)
    ```

## Create Validator

1. **Submit a transaction to create a validator:**
    ```bash
    initiad tx mstaking create-validator \
    --amount 1000000uinit \
    --pubkey $(initiad tendermint show-validator) \
    --moniker "your_moniker" \
    --details "your_detail" \
    --website "your_web_or_twitter" \
    --chain-id initiation-1 \
    --commission-rate 0.05 \
    --commission-max-rate 0.20 \
    --commission-max-change-rate 0.05 \
    --from wallet \
    --gas-adjustment 1.4 \
    --gas 10000000 \
    --gas-prices 0.15uinit
    ```

## Monitor Node

1. **Check logs:**
    ```bash
    sudo journalctl -u initiad -f
    ```

2. **Check blocks left to sync:**
    ```bash
    local_height=$(initiad status | jq -r .sync_info.latest_block_height)
    network_height=$(curl -s https://rpc-initia-testnet.trusted-point.com/status | jq -r .result.sync_info.latest_block_height)
    blocks_left=$((network_height - local_height))
    echo "Your node height: $local_height"
    echo "Network height: $network_height"
    echo "Blocks left: $blocks_left"
    ```

3. **Check sync status:**
    ```bash
    initiad status 2>&1 | jq .sync_info
    ```

## Check Your Node Here
[Validator](https://scan.testnet.initia.xyz/initiation-1/validators)

in the inactive section

## Backup Validator Key

1. **Backup your `priv_validator_key.json` file:**
    ```bash
    cd $HOME/.initia/config
    cat priv_validator_key.json
    ```
    **Important**: Backup this file securely and do not share it with anyone.

## Submit Node Information

Complete the following form to submit your node information:
[Node Information Form](https://docs.google.com/forms/d/e/1FAIpQLSc09Kl6mXyZHOL12n_6IUA8MCcL6OqzTqsoZn9N8gpptoeU_Q/viewform)

## Stop Node
```bash
sudo systemctl stop initiad
```


## Start node
```bash
sudo systemctl start initiad
```

## Restart node
```bash
sudo systemctl restart initiad
```

## Update Peers
Before update your peers, please stop your node first

```bash
PEERS=$(curl -s --max-time 3 --retry 2 --retry-connrefused "https://raw.githubusercontent.com/shidiqmuh0/initia-node/main/peers.txt")
if [ -z "$PEERS" ]; then
    echo "No peers were retrieved from the URL."
else
    echo -e "
PEERS: "$PEERS""
    sed -i "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" "$HOME/.initia/config/config.toml"
    echo -e "
Configuration file updated successfully.
"
fi
```

## If your node can't catch up try to disable indexer in config.toml and restart

```bash
sed -i "s/^indexer *=.*/indexer = \"null\"/" $HOME/.initia/config/config.toml
```

```bash
sudo systemctl restart initiad && sudo journalctl -u initiad -f -o cat
```

and run the command to see how many blocks left.

```bash
local_height=$(initiad status | jq -r .sync_info.latest_block_height); network_height=$(curl -s https://rpc-initia-testnet.trusted-point.com/status | jq -r .result.sync_info.latest_block_height); blocks_left=$((network_height - local_height)); echo "Your node height: $local_height"; echo "Network height: $network_height"; echo "Blocks left: $blocks_left"
```

Sure, here's the updated README.md with improved formatting:


# State Sync

## Before proceeding, make sure to backup your priv_validator_key.json

### Step 1: Modify app.toml

Open the app.toml file using a text editor:

```bash
nano ~/.initia/config/app.toml
```

Add the following configurations at the bottom:

```toml
# Pruning Type
pruning = "custom"

# Pruning Strategy
pruning-keep-every = 0

# State-Sync Snapshot Strategy
snapshot-interval = 2000
snapshot-keep-recent = 5
```

### Step 2: Stop, Backup, and Reset Data

Stop the initiad service, backup the state validator, and reset the data:

```bash
sudo systemctl stop initiad.service
cp ~/.initia/data/priv_validator_state.json ~/.bcna/priv_validator_state.json.backup
initiad tendermint unsafe-reset-all --keep-addr-book --home ~/.initia
```

### Step 3: State Sync

Execute the following commands to initiate State Sync:

```bash
SNAP_RPC="https://initia-testnet-rpc.ibs.team:443"
STATESYNC_PEERS="8e7d1f41d223c12a9025cf34f49c50cb27a5cb18@65.109.82.111:46656"

LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height)
BLOCK_HEIGHT=$((LATEST_HEIGHT - 2000))
TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$SNAP_RPC,$SNAP_RPC\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"|" ~/.initia/config/config.toml
sed -i -e "s|^persistent_peers *=.*|persistent_peers = \"$STATESYNC_PEERS\"|" ~/.initia/config/config.toml

mv ~/.initia/priv_validator_state.json.backup ~/.initia/data/priv_validator_state.json
```

### Step 4: Restart and Check Logs

Start the initiad service again and check the logs:

```bash
sudo systemctl start initiad.service && sudo journalctl -fu initiad.service -o cat
```

Remember to replace any placeholders like file paths or URLs with the actual values relevant to your setup.

---

By following this guide, you will successfully set up and manage your Initia node. If you encounter any issues, refer to the official documentation or community forums for additional support.

# Thanks to for helping
Ikan Cupang, @sxlmnwb, @ashitherewego
