# Initia Node

## Minimum Req
CPU: 4 cores
Memory: 16GB RAM
Disk: 1 TB SSD Storage

## Install Node
```bash
wget -O initia.sh https://raw.githubusercontent.com/shidiqmuh0/initia-node/main/initia.sh; chmod +x initia.sh
```

```bash
./initia.sh
```
Input your name, after run initia.sh

```bash
source $HOME/.bash_profile
```

## Create Wallet
```bash
initiad keys add wallet
```

Please Backup Your Phrase and Wallet, and don't tell to anybody

##  See your wallet after create
```bash
initiad keys list
```

## Check Balance
```bash
initiad q bank balances $(initiad keys show wallet -a)
```

## Create Validator
```bash
initiad tx mstaking create-validator \
--amount 1000000uinit \
--pubkey $(initiad tendermint show-validator) \
--moniker "Your_Name" \
--identity "keybase" \
--details "Your_Details" \
--website "Your_Web_Or_Twitter" \
--chain-id initiation-1 \
--commission-rate 0.05 \
--commission-max-rate 0.2 \
--commission-max-change-rate 0.05 \
--from wallet \
--fees 300000uinit \
-y
```

## Check Logs
```bash
sudo journalctl -u initiad -f
```


## Check Block left
```bash
local_height=$(initiad status | jq -r .sync_info.latest_block_height); network_height=$(curl -s https://rpc-initia-testnet.trusted-point.com/status | jq -r .result.sync_info.latest_block_height); blocks_left=$((network_height - local_height)); echo "Your node height: $local_height"; echo "Network height: $network_height"; echo "Blocks left: $blocks_left"
```

## Check Sync
```bash
initiad status 2>&1 | jq .sync_info
```

## Backup priv_validator_key.json
```bash
cd .initia; cd config; cat priv_validator_key.json
```

Please Backup Your priv_validator_key.json, and don't tell to anybody

## Sumbit your node information
This the from:
[Node Initia]([https://docs.google.com/forms/d/e/1FAIpQLSc09Kl6mXyZHOL12n_6IUA8MCcL6OqzTqsoZn9N8gpptoeU_Q/viewform])
