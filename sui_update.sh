#!/bin/bash

sleep 1 && curl -s https://raw.githubusercontent.com/cryptology-nodes/main/main/logo.sh |  bash && sleep 3

systemctl stop suid
rm -rf /var/sui/db/* /var/sui/genesis.blob $HOME/sui
source $HOME/.cargo/env
git clone https://github.com/MystenLabs/sui.git
cd $HOME/sui
git remote add upstream https://github.com/MystenLabs/sui
git fetch upstream
git checkout -B devnet --track upstream/devnet
cargo build --release -p sui-node
mv ~/sui/target/release/sui-node /usr/local/bin/
wget -O /var/sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob
systemctl restart suid
echo -e '\n\e[42m Молодец тигр у тебя все получилось :) \e[0m\n' && sleep 1
rm sui_update.sh
