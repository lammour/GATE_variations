#!/bin/bashs

# Author: Luis Ammour
# email: luis@ammour.net
# https://github.com/lammour
# https://mamot.fr/@la

sudo apt-get install cmake cmake-curses-gui build-essential libqt4-opengl \
libqt4-opengl-dev qt4-qmake libqt4-dev libx11-dev libxmu-dev libxpm-dev \
libxft-dev wget git dpkg-dev g++ gcc binutils libxext-dev gfortran libssl-dev \
libpcre3-dev xlibmesa-glu-dev libglew1.5-dev libftgl-dev libmysqlclient-dev \
libfftw3-dev libcfitsio-dev graphviz-dev libavahi-compat-libdnssd-dev \
libldap2-dev python-dev libxml2-dev libkrb5-dev libgsl0-dev libqt4-dev -y

mkdir ~/Geant4
mkdir ~/ROOT
mkdir ~/GATE

# Geant4
cd ~/Geant4
wget http://geant4.web.cern.ch/geant4/support/source/geant4.10.03.p01.tar.gz
tar zxvf geant4.10.03.p01.tar.gz
mkdir geant4.10.03.p01-build
mkdir geant4.10.03.p01-install
cd geant4.10.03.p01-build
cmake -DCMAKE_INSTALL_PREFIX=~/Geant4/geant4.10.03.p01-install \
~/Geant4/geant4.10.03.p01 -DGEANT4_INSTALL_DATA=ON
make
#make -j7
make install
source ~/Geant4/geant4.10.03.p01-install/bin/geant4.sh
echo 'source ~/Geant4/geant4.10.03.p01-install/bin/geant4.sh' >> ~/.bashrc

# ROOT
cd ~/ROOT
wget https://root.cern.ch/download/root_v6.08.06.source.tar.gz
tar zxvf root_v6.08.06.source.tar.gz
mkdir root-6.08.06-build
cd root-6.08.06-build
cmake ../root-6.08.06/
cmake --build .
#cmake --build . -- -j7
source ~/ROOT/root-6.08.06-build/bin/thisroot.sh
echo 'source ~/ROOT/root-6.08.06-build/bin/thisroot.sh' >> ~/.bashrc

# GATE
cd ~/GATE
wget http://www.opengatecollaboration.org/sites/default/files/gate_v8.0.tar.gz
tar zxvf gate_v8.0.tar.gz
mkdir gate_v8.0-build
mkdir gate_v8.0-install
cd gate_v8.0-build
cmake -DCMAKE_INSTALL_PREFIX=~/GATE/gate_v8.0-install ~/GATE/gate_v8.0
make
#make -j7
make install
echo "export PATH=$PATH:~/GATE/gate_v8.0-install/bin" >> ~/.bashrc
source ~/.bashrc
