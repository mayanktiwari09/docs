#!/usr/bin/env bash

# Variables
GOPATH=/home/vagrant/go
GOROOT_BOOTSTRAP=/usr/local/go
export PATH=$GOPATH/bin:$GOROOT_BOOTSTRAP/bin:$PATH

LOG=/vagrant/vm_build.log

# Clear old log contents
> $LOG

# Installing Go-Lang packages
echo -e "\n--- Installing Go ---\n"
sudo apt-get update >> $LOG 2>&1
sudo apt-get -y upgrade >> $LOG 2>&1
wget https://dl.google.com/go/go1.10.linux-amd64.tar.gz >> $LOG 2>&1
sudo tar -xvf go1.10.linux-amd64.tar.gz >> $LOG 2>&1
sudo mv go /usr/local
mkdir $GOPATH

#Setting up vagrant .bashrc
echo 'export GOPATH=/home/vagrant/go' >> /home/vagrant/.bashrc
echo 'export GOROOT_BOOTSTRAP=/usr/local/go' >> /home/vagrant/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT_BOOTSTRAP/bin:$PATH' >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

# Installing dara packages
echo -e "\n--- Installing dara packages ---\n"
mkdir $GOPATH/src
mkdir $GOPATH/src/github.com
cd $GOPATH/src/github.com
mkdir DARA-Project
mkdir novalagung
cd novalagung
git clone https://github.com/novalagung/go-eek.git >> $LOG 2>&1
cd ../DARA-Project
git clone https://github.com/DARA-Project/GoDist.git >> $LOG 2>&1
git clone https://github.com/DARA-Project/GoDist-Scheduler.git >> $LOG 2>&1
cd $GOPATH/src/github.com/DARA-Project/GoDist/src
sudo apt-get -y install gcc >> $LOG 2>&1
./make.bash >> $LOG 2>&1
sudo ln -s $GOPATH/src/github.com/DARA-Project/GoDist/bin/go /usr/bin/dgo
cd $GOPATH/src/github.com/DARA-Project/GoDist-Scheduler
sudo chown -R vagrant:vagrant $GOPATH
chmod +x dependencies.sh
./dependencies.sh >> $LOG 2>&1
