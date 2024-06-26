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
PEERS="12f4ac936dea1856fb9010bfca3f64abc492bb68@43.157.56.203:26656,eb0a05641caa0e9693487afd0e74303b7505f530@149.102.141.50:26656,610fa5564b1413eeb8c2aec79beda50266128bb8@43.157.20.93:26656,da346ff4d35f326abb6c331e9240e626401de469@164.90.154.129:51656,62775997caa3d814c5ad91492cb9d411aea91c58@51.38.53.103:26856,a7c9a128ab748322d8f8374a76b15223fdcdd7ff@213.199.62.51:26656,2c8c752df6f0e6f6e9b70d432338e0dafec480b1@43.157.28.168:26656,d7b99582e0b224c700bcc6223ce5f6b87f933738@198.244.176.117:51656,5ef80d3a3f069b9be83cfcb49ec4eca19b23bf9c@43.155.173.197:26656,57edaba810694a1c4fbc90d17c0a5041ae9a743d@43.128.156.169:26656,79d78fdbd7bc49e9648b24b40bfa97eea89357d9@38.242.217.43:26656,c75b17673371d206345a090e15229de032872c64@129.226.147.60:26656,526d8c79450eb441668205f230aa17f43d496ba5@5.9.105.248:50756,ccd091237613721bf020010d30400b8fd4f3dc3d@84.46.240.145:26656,1677252f64d728aa9598cb7365f74af7c862d9df@65.109.57.221:25756,7c7e292e0c8fbb9e62839689f6a47e69de6570ae@62.171.168.50:26656,5da0b9878ba1603f02a74c4cf59910db00f04af9@43.134.77.19:26656,7329063c910b9fe5b10695486c6c20869777befb@161.97.164.178:26656,e329399bef19a937666e0c4637e6caf23de274e5@43.155.131.57:26656,d36faf8c2ad75a630c1963dcdc7c4a86dd00abf9@101.33.78.42:26656,fd1ca2ea4914f820e3442a53626646e56611704f@43.155.142.67:26656,4de71d3e17c550c79913ebdb69f4a543b89e82ab@138.201.142.39:26656,3ffc950d7cb2004c39ea5723dd90ed005bc300c1@43.131.45.201:26656,df3c89aa5bb7b7a29ec72243873cf1d2d8d3cb60@37.27.43.255:17956,73c2832ede1227cf0b4da4b127073deb77a7b8ad@65.108.129.239:26656,4a061c760a3126a0785e0091cb73f9f0377fe7d7@49.51.143.57:26656,8a8754635009cc25aade2138cc3dbcbce88f9052@84.46.240.209:26656,ae980af6aaf78e13ff52985247d8282befadb0de@124.156.203.83:26656,f3e8eb0d3e12eb527ac4ce18ab9c570900595eae@185.215.165.42:26656,cbc631992c6e42f454b9f0bb70c130e053c4c544@43.134.0.15:26656,12e54b686bc35d1884d05571b1e43427c2ecf944@15.164.118.189:26656,3b944bcae9db0b88d8419adde8e26188a6a5ef5d@65.109.59.22:25756,3194727c8195c5819093b677a982be0d512fa033@13.209.148.118:26656,86d077660e85dff44171a9bd0a4ae20b060a1cad@43.133.161.34:26656,ab65fe0c814fa4a837bbcf9bf944a2e8d9eacfb4@195.3.221.44:33756,d1aeb143f1e4b8b2390a37fe87864d396b61c342@109.123.253.29:26656,9a7e5ef2efc610ceee64f65371d85c9f77447049@173.212.222.195:26656,3a70f22bc2cfbc39c746686eda509c76d5560e9c@43.155.138.227:26656,915e9775c93112ab3362d2b7c91c493f56645741@65.109.106.113:26656,748dd3ebec5e3ab134587e9f190c368b268fb0e8@119.28.102.164:26656,ebc0557a3c84c14e2d2f4ef4d752ed6e8d86b587@150.109.239.227:26656,093eed8d8828961654c23233a7e0dff5f6d19569@43.133.175.211:26656,50b773b5866911826e5a4b72cb702b6fe1b4b5bc@162.62.52.150:26656,2da714585d9207ace5897d7a8506b78074cc5af5@65.108.70.106:26606,75588c9d6ece63d0e2631244368c5c1a218f7a17@167.235.115.119:26656,f1c162afb153ed64ebe03e4ec36847c1587c5a24@89.163.255.195:33756,51a299cd591431af87c9392bb7d58a28442b3265@194.34.232.204:26656,40e9df55cea3412c5c9026256566df8949415e02@101.32.115.123:26656,cb0ed745d33704659852ea89f66f3225e787539e@84.46.242.61:26656,4b6cfaea90934868a00be5d0834f0fd253d808b9@43.130.247.207:26656,79c937ad01771731b2e24dca78419474332ce207@148.113.16.164:27656,9b5a9b93c6f8d91f46e46d1faf2fbfc739e1b393@109.123.253.199:26656,1b51748fe5ca9494261a9bf7831396b609c4b7da@43.157.38.156:26656,cfa9f86aea8b6332b7bff1fb45e71c3b560c87cc@43.130.230.180:26656,ae0aff058a44136d54bbd7a6a70ac140b72bd23d@157.230.36.36:26656,ec90788adebfae73ab7f790426df9ab7db2ecb1f@37.60.251.209:33756,807eaf0e07231766b7df788f4aa3422fa813dad8@43.131.26.90:26656,794810f38de161bb0a23ba05a24776f5dc984569@43.134.11.178:26656,0498d50ba667cf27e228df58101ae1fb601ea778@43.163.202.179:26656,c2185644822333128b8fe19f80f34c2a3646853a@150.109.253.86:26656,634b4dd8ad6946e6d1ef4f7f6927c90eba3c42b8@85.10.201.125:17956,05e6ad583fc495f2064cd1a75c4ff6110d15f39b@43.131.0.118:26656,c08e6b6e514869113d121859c1eecdd68fa4f5dd@109.123.247.164:26656,6d221eee71bed1db7c3f339b0ab18668ccaa1c6f@124.156.213.8:26656,6fdb3bb6b7979fcba6fa1d56d7248ef86e490ba0@150.109.236.39:26656,e1ce9d9d82d9783cec5d9421b1dcca42ce4ae852@43.153.167.47:26656,769ec3e4cc3948923856aa78fe9210000b5669d5@65.109.112.148:21016,0f564af6282b9d482afef942dab3e05682006b35@37.60.251.7:26656,233dc308e77d27408c8ebcfa1e335260ecaed07c@43.128.147.198:26656,8f15e54aaeede8683d61563f95a17026a1a3fa84@43.155.167.13:26656,fba93c5340823e74bc43f9135cc51d02aca9a4ec@43.134.32.129:26656,1db61033a646718ff0656b3fa337398b2b45d216@173.231.40.186:25756,51777c33bee9ff1761bcbccea62b600ae2e6f40c@193.193.226.66:26656,10597f9f4b1dc6a06c4757ca01e5ca92a4c9fcf7@84.46.245.251:26656,612fc5a144cc26f89bbb57e1092bf3a7d84b542e@43.133.212.245:26656,de3f8976450c8da6c603540e3b12adc24da54b6d@89.117.63.143:26656,d25d54a07f013eda1a57f4271b49f4b4652b7cac@43.156.159.57:26656,074d4abf6df72e862ff10b55fc1e3173b3bc3d27@43.155.174.234:26656,3638e8a7b41b72f883ba0fa75c527388d415df1b@43.156.121.36:26656,0ba5b6c36027d621508f1cb584d21e7425949595@162.62.119.224:26656,f0ae0b0dabac59825883201ec58f944402015021@156.67.28.117:13656,c5bfe36e8100f8e1d64bba1455063aaaf6491fb7@45.151.122.92:26656,ead724282b82d3c9ebab34cce1e5cecd53d236b9@154.38.164.207:26656,147da30fea230fac5b8940930890317db372e80e@209.250.236.158:26656,e96d699f5fd90e71cfabd75d8eed2e5bf8c03962@43.155.161.189:26656,07372f92b37dd83700e6811370f0a53a09e4f024@43.157.91.31:26656,b00f4bc958f0984accf9169096ceaf93c2d45dd2@92.43.189.78:26656,2386ce79b98515184d1477ff67e50b41cd6df9f0@65.108.234.158:26606,8648960443317d76234dbf786737c44b747040c9@129.226.156.214:26656,8fc7323acaf7cf92c9550a49ff91586a7e4e81e1@101.32.167.183:26656,16c283b5a5d2edfec8370300c48b87fc0a5d6e86@161.97.175.6:26656,454be72f212062922913df7d406531794abc6828@43.157.28.44:26656,b358b8f14b53413989d15fcb6729e518ca4d3bd5@213.199.62.52:26656,462f8e8865ab55950f26e90366f822327807bdcc@43.128.148.164:26656,3c307e1c888516b15c6a9577e418ec0d602d43a9@43.130.238.85:26656,62ad22242484862d578af84651cadd0b1d85a46f@49.13.161.193:51656,9e6fbf0cf138f09443304b8b4d79d4265131933c@43.155.170.117:26656,d76820c0890379eb75e3c27ea881167f97f3ca70@95.216.43.37:26656,e7bee5a476dcca27e1829fac9bcffd94fe0b8970@158.220.97.81:26656,c6edf09a70cb97593a2780d319878fae942a7817@43.131.57.124:26656,c8a06a8e4f42464f9243fd1490967407a2ff3a81@152.42.194.121:26656,185dc7a46304684780dad381792d5c9f204127f7@150.109.15.230:26656,2284949b8fd2fdeffcc76d5ce94a3812a6e2a6b1@37.60.246.110:53456,4dc5563ad010c9aee883779e4480de93d1be242a@43.157.3.35:26656,fe14e2f245a487c161d9707bf2c6d86c956583c7@43.157.124.111:26656,940688290d3d9e9e0a6e224176afb9283ec1f607@43.157.106.111:26656,d357782600edb545b9bb7b8f8b61d48dc84b3747@124.156.198.130:26656,cb8b6a11bbe48056fd5106fa822228b9c215a2a0@43.128.145.24:26656,73a5a9092285bf283fc429ec302b8b793be431d7@157.245.159.138:26656,ea645b6632728eb8fbac0d5a89c80d9e388c068d@43.157.93.228:26656,f2a7c7b7ef7dc1b1f4d7b8aa034900800e4c16d6@43.128.110.211:26656,cb42be49b6d210546352f24a64e2be8ff69d9ca3@43.134.23.238:26656,12ac33d2fd11ba8479f3db61e685eb615ce548fa@43.153.199.30:26656,34cdf8d200552509b80448df76ddca75993abfb0@43.133.70.91:26656,f10e2366bb85224da1566767cd4e6adbc48e39bc@43.133.190.128:26656,6410404f235bd8f75854368ea522b05b0669f1ec@43.128.145.28:26656,f5b0a8b68ee4c30c0f7d0cea4b18f6c65175174c@43.157.111.153:26656,9d894b00b6f28f79be9829043a5c56fc460832c5@46.166.143.69:26656,6024362f196b0f5df5f0abaf0552712d5b0333e7@37.27.43.80:26656,13ad318af0e47a890b5f5d8fe6c22e32580eac98@193.203.15.92:26656,7ca410f6f871620f853ff7d7ccc1cc74255aa349@65.109.137.38:26656,e567b0f7f59287b6ac3c2a39ae3d5318a50ef17f@43.153.211.14:26656,02dd64b0a1dc5b1681b796a121ab71870330ca80@43.128.136.171:26656,2a0fe1372474ab57e8970a6512d4dd21c42f477f@43.156.187.159:26656,42dbf2319b49f029274c4535daa54c0eb86708fa@43.157.58.236:26656,848a1b5f78e40f1eb50d61f927019b10b311b8a1@84.46.241.217:26656,e41afe06e0e16fc1de80bb6176eba7ada667eece@62.169.31.66:26656,d3bd4f74431e6adb91f8a14e892a6ba48a831e12@84.46.242.165:26656,ddf2c81b38b117d8fac06d5f86790cdca142ce31@162.62.117.29:26656,0bd2b07707cae5933e243ecca090ffa89a525b4d@43.163.5.248:26656,a1b18a12778ba67fa85127662127909fea40bd10@174.138.89.62:26656,a39905dab66d3bec1158b0cc502609ed4e4a4238@43.153.226.146:26656,9466874524152b0454da76463f30dc544faaae80@158.220.112.196:26656,7a1fe5bdd871e4bd648be9393ce3bb00be30336e@43.128.87.126:26656,e302c6a7037740fed6b80fbb983e3c9a5d44f43e@165.227.146.117:21356,f6b2f6025baba5c44ef4089da5480d34ec5a4005@162.62.209.144:26656,806444bc8feeced2deb6849c2b3ee0ce2012a536@154.26.135.57:26656,43956f5d7fa82bf7f1d93f98f41120c955136f07@167.99.114.210:15656,25749ab8e12c6fec5cfaad0011f9537a9e809606@31.220.79.248:26656,6720c1c497c111bca97d2aaf169e79b731c70626@176.57.189.33:26656"
SEEDS="2eaa272622d1ba6796100ab39f58c75d458b9dbc@34.142.181.82:26656,c28827cb96c14c905b127b92065a3fb4cd77d7f6@testnet-seeds.whispernode.com:25756,ade4d8bc8cbe014af6ebdf3cb7b1e9ad36f412c0@testnet-seeds.polkachu.com:25756"
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
curl -o - -L https://snapshots.polkachu.com/testnet-snapshots/initia/initia_187918.tar.lz4 | lz4 -c -d - | tar -x -C $HOME/.initia
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

