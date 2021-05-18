#/bin/bash

cd /home/nrgstaker
sudo systemctl stop energi3
energi3 removedb
curl -s https://s3-us-west-2.amazonaws.com/download.energi.software/releases/chaindata/mainnet/gen3-chaindata.tar.gz | tar xvz
sudo systemctl start energi3
