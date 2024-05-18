#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && sleep 1

NODE="initia"
export DAEMON_HOME=$HOME/.initia
export DAEMON_NAME=initiad
CHAIN_ID="initiation-1"
if [ -d "$DAEMON_HOME" ]; then
    new_folder_name="${DAEMON_HOME}_$(date +"%Y%m%d_%H%M%S")"
    mv "$DAEMON_HOME" "$new_folder_name"
fi
#echo 'export CHAIN_ID='\"${CHAIN_ID}\" >> $HOME/.bash_profile

if [ ! $VALIDATOR ]; then
    read -p "Enter validator name: " VALIDATOR
    echo 'export VALIDATOR='\"${VALIDATOR}\" >> $HOME/.bash_profile
fi
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 1
cd $HOME
sudo apt update
sudo apt install make unzip clang pkg-config lz4 libssl-dev build-essential git jq ncdu bsdmainutils htop -y < "/dev/null"

echo -e '\n\e[42mInstall Go\e[0m\n' && sleep 1
cd $HOME
VERSION=1.22.3
wget -O go.tar.gz https://go.dev/dl/go$VERSION.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go.tar.gz && rm go.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version

echo -e '\n\e[42mInstall software\e[0m\n' && sleep 1

sleep 1
cd $HOME
rm -rf initia
git clone https://github.com/initia-labs/initia.git
cd initia
git checkout v0.2.14
make build
sudo mv build/initiad /usr/local/bin/
source .profile
PEERS="9ea146b73504a8cb2d8269f50b736c1d3e4f54a4@154.12.229.0:53456,cb3fbecdb02d272dbe342d2e631570d2c11ee3f9@213.199.63.26:39656,421e7eda7975e66fffc0d65da0474dd80a883f6e@185.230.138.64:14656,12cd2a5f22782094cc90470def2fc665050a551d@62.169.20.176:53456,4c7d65bee0ff5fb9ebb3ec8aca477f77a6e30305@194.163.152.237:53456,a919fa81b40a7312eb96082acf1ece0358b164e6@62.171.139.83:14656,0864b4f2cafb87dd500feca0a689af2c6381deb3@109.123.251.247:26656,398fca7aab6856631becc4034284c2cdddeed7a6@127.0.0.1:26933,b9b043fb2f836c0dafe9faa287a5f49c4b05cd13@46.38.241.12:53456,df76857e532cb93aac68798d805d4460c7765cd1@37.27.108.81:26656,96e561c9d8bc3cf7d039a4f19debb620498736e3@62.169.20.172:53456,63ab5e25e8bcb6d06b6355c5074d28a8e59de106@173.249.23.220:14656,028c3db8c2658887f5714432c21cb53d8c8aa0be@155.133.27.151:14656,b24bf0d7a4bc0fd3a969500ce34dca4628b26b77@62.171.145.224:14656,f773345d464203b9c4928c8b145acbea4b6a8acf@5.189.174.117:14656,8e43839ca6041e14b013b84631a5a34f383cbd44@155.133.27.223:14656,22eab5cec333a7bf42c624a5f0a93236866c75f1@158.220.100.155:26656,69376ad6f9433cb4d32f1f6dd36a2eab3d8c1a39@135.181.134.118:53456,6ba0f79c18652cfb4c27531bd62eeb60fdc0f997@213.199.50.221:53456,8a059d3aa383ff746f5713e0a4b5a0fc8ddcd110@164.68.119.228:14656,9fc67f4588ae642413cafd1922fe96699aed5704@81.17.102.18:53456,8871661c5ce2f90be39a6bc5f65c4112327d4906@185.135.137.183:26656,ec009acf130d529ea6031117db47f5a8274f41e0@155.133.27.234:14656,bc5f3e27e89125431293aa1cf6d92cccb419cd4a@158.220.102.219:17956,56c86f460fd6b566e598be16328e23ac0c8e9b60@81.17.101.100:53456,17efe50d1511fedb07d566bb46c7d867c53be8e2@38.242.237.80:14656,d9d295e179cd2603f2ea03e7e00a38ef3c1b5795@183.80.124.21:10656,f396faca04598721481e714dcb0e3c8ed05a406c@49.12.209.114:15656,4befc5f9928c7b10d9bf86439d23ef5b08c564f7@5.189.187.42:14656,6d5436d16dc2cbd79b7c5cea9d294a6c4c919424@213.199.54.87:53456,cea76d6adcadd2ed767beaa1646698fae5b6b21d@213.199.50.157:53456,d01b0e7d01371388ca455c94a1298513eaf8d664@81.17.102.23:53456,0823bda8a95938b8530032467f514fd853d58932@194.34.232.169:14656,598157a19c31aabac15047c965e9fe4fb0e28ac6@144.91.109.167:26656,b0894b3fc0fef262b3de0d0433f3ec118e8f592d@89.58.58.180:53456,f194cb15d21e5f55a7528f6755b887cad0950997@149.50.107.249:14656,249646ca0f525656c7085b36f66b2fc1a90100e2@161.97.158.236:53456,4a6d51ee908eb624feddc1a2297d499b68017be0@173.212.243.179:14656,504940507764ca6d39d6facd249d01143d5241d3@95.217.95.10:14656,7827b14abdd185a544a371fdfa5645ef439258a9@185.245.182.186:14656,ca5d0237c47ac684cf1b985124bb74b60ecb32f8@144.91.72.215:39656,0146f6e189b4152cf27c110991b8d13c738807ac@5.161.233.155:15656,41121fc2b74bae55a76f1aa592efcc4c083945f9@62.169.20.209:53456,66abd758f6971eb8227fc54d11cb56ca1ca280e6@65.109.113.251:13656,27c9c8f9966b8fd34b13d4b738efd8dc7918f419@156.67.24.125:53456,57671760b7e2f7d14f23b43559542a4b18dabb4b@38.242.215.207:14656,7d0f01b958c52cdebe2f6704ca69b4dd100a931b@167.86.88.100:14656,1847ef0cb094bde6c305b242f5e9cb740ae7628b@185.252.232.26:14656"
SEEDS="2eaa272622d1ba6796100ab39f58c75d458b9dbc@34.142.181.82:26656,c28827cb96c14c905b127b92065a3fb4cd77d7f6@testnet-seeds.whispernode.com:25756"
$DAEMON_NAME init "${VALIDATOR}" --chain-id $CHAIN_ID
sleep 1
$DAEMON_NAME config set client chain-id $CHAIN_ID
$DAEMON_NAME config set client keyring-backend test

wget -O $DAEMON_HOME/config/genesis.json https://raw.githubusercontent.com/initia-labs/networks/main/initiation-1/genesis.json
sed -i.bak -e "s/^seeds *=.*/seeds = \"${SEEDS}\"/" $DAEMON_HOME/config/config.toml
sed -i -e "s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $DAEMON_HOME/config/config.toml
sed -i -e "s|^minimum-gas-prices *=.*|minimum-gas-prices = \"0.15uinit,0.01uusdc\"|" $DAEMON_HOME/config/app.toml
sed -i -e 's/external_address = \"\"/external_address = \"'$(curl httpbin.org/ip | jq -r .origin)':26656\"/g' $DAEMON_HOME/config/config.toml
#PRUNING
sed -i "s/pruning *=.*/pruning = \"custom\"/g" $DAEMON_HOME/config/app.toml
sed -i "s/pruning-keep-recent *=.*/pruning-keep-recent = \"100\"/g" $DAEMON_HOME/config/app.toml
sed -i "s/pruning-interval *=.*/pruning-interval = \"19\"/g" $DAEMON_HOME/config/app.toml
sed -i -e "s/indexer *=.*/indexer = \"null\"/g" $DAEMON_HOME/config/config.toml

echo "[Unit]
Description=$NODE Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/$DAEMON_NAME start
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/$DAEMON_NAME.service
sudo mv $HOME/$DAEMON_NAME.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF

echo -e '\n\e[42mDownloading a snapshot\e[0m\n' && sleep 1
#curl https://snapshots.kjnodes.com/initia-testnet/snapshot_latest.tar.lz4 | lz4 -dc - | tar -xf - -C $DAEMON_HOME
#curl -o - -L https://snapshots.kjnodes.com/initia-testnet/snapshot_latest.tar.lz4 | lz4 -c -d - | tar -x -C $DAEMON_HOME
#curl -o - -L https://snapshots.polkachu.com/testnet-snapshots/initia/initia_150902.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.initia
curl -o - -L https://snapshots.polkachu.com/testnet-snapshots/initia/initia_170136.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.initia

wget -O $DAEMON_HOME/config/addrbook.json https://snapshots.nodes.guru/initia/addrbook.json

echo -e '\n\e[42mChecking a ports\e[0m\n' && sleep 1
#CHECK PORTS
PORT=337
if ss -tulpen | awk '{print $5}' | grep -q ":26656$" ; then
    echo -e "\e[31mPort 26656 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:26656\"|:${PORT}56\"|g" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26656 changed to ${PORT}56.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":26657$" ; then
    echo -e "\e[31mPort 26657 already in use\e[39m"
    sleep 2
    sed -i -e "s|:26657\"|:${PORT}57\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26657 changed to ${PORT}57.\e[0m\n"
    sleep 2
    $DAEMON_NAME config set client node tcp://localhost:${PORT}57
fi
if ss -tulpen | awk '{print $5}' | grep -q ":26658$" ; then
    echo -e "\e[31mPort 26658 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:26658\"|:${PORT}58\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 26658 changed to ${PORT}58.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":6060$" ; then
    echo -e "\e[31mPort 6060 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:6060\"|:${PORT}60\"|" $DAEMON_HOME/config/config.toml
    echo -e "\n\e[42mPort 6060 changed to ${PORT}60.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":1317$" ; then
    echo -e "\e[31mPort 1317 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:1317\"|:${PORT}17\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 1317 changed to ${PORT}17.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":9090$" ; then
    echo -e "\e[31mPort 9090 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:9090\"|:${PORT}90\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 9090 changed to ${PORT}90.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":9091$" ; then
    echo -e "\e[31mPort 9091 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:9091\"|:${PORT}91\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 9091 changed to ${PORT}91.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":8545$" ; then
    echo -e "\e[31mPort 8545 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:8545\"|:${PORT}45\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 8545 changed to ${PORT}45.\e[0m\n"
    sleep 2
fi
if ss -tulpen | awk '{print $5}' | grep -q ":8546$" ; then
    echo -e "\e[31mPort 8546 already in use.\e[39m"
    sleep 2
    sed -i -e "s|:8546\"|:${PORT}46\"|" $DAEMON_HOME/config/app.toml
    echo -e "\n\e[42mPort 8546 changed to ${PORT}46.\e[0m\n"
    sleep 2
fi

#echo -e '\n\e[42mRunning a service\e[0m\n' && sleep 1
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable $DAEMON_NAME
sudo systemctl restart $DAEMON_NAME


echo -e '\n\e[42mCheck node status\e[0m\n' && sleep 1
if [[ `service $DAEMON_NAME status | grep active` =~ "running" ]]; then
  echo -e "Your $DAEMON_NAME node \e[32minstalled and works\e[39m!"
  echo -e "You can check node status by the command \e[7mservice $DAEMON_NAME status\e[0m"
  echo -e "Press \e[7mQ\e[0m for exit from status menu"
else
  echo -e "Your $NODE node \e[31mwas not installed correctly\e[39m, please reinstall."
fi

