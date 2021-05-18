#/bin/bash

apt-get update #&& apt-get upgrade -y
apt install -y pwgen wget
wget -4qO- -o- raw.githubusercontent.com/energicryptocurrency/energi3-provisioning/master/scripts/linux/energi3-linux-installer.sh > /tmp/energi3-installer.sh 

sed -i 's/^\s*read.*Wait 10 sec or Press \[ENTER\] key to continue.*$/REPLY="n"/' /tmp/energi3-installer.sh
sed -i 's/^\s*read.*Did you write down the username and password.*$/REPLY="y"/' /tmp/energi3-installer.sh 
sed -i -r 's/^\s*(USRPASSWD=.*)$/\1\n echo \$USRPASSWD > \/tmp\/nrg_pass/' /tmp/energi3-installer.sh
sed -i 's/^\s*read.*Please select an option to get started.*$/REPLY="a"/' /tmp/energi3-installer.sh 
sed -i 's/^\s*read.*Do you want to install 2-Factor Authentication.*$/REPLY="n"/' /tmp/energi3-installer.sh
sed -i 's/^\s*read.*Do you want to copy the keystore file to the VPS.*$/REPLY="n"/' /tmp/energi3-installer.sh  
sed -i '/^.*present enode information.*$/,$d' /tmp/energi3-installer.sh  

chmod +x /tmp/energi3-installer.sh
/tmp/energi3-installer.sh          

echo "export PATH=/home/nrgstaker/energi3/bin:$PATH" >> /home/nrgstaker/.profile

chown nrgstaker /tmp/bootstrap_chain.sh

echo "nrgstaker's password: $(cat /tmp/nrg_pass)"
rm /tmp/nrg_pass
