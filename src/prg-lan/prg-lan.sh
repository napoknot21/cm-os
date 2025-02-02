#!/bin/sh

# Script for installing (and config) the following programming langages and some important libraries :
# java
# C/C++ (compiler)
# python
# haskell
# ocmal
# ruby, rust and others


## Java
sudo pacman -S java-runtime-common java-environment-common
sudo pacman -S jdk-openjdk openjdk-doc
sudo pacman -S java-openjfx

## Python
sudo pacman -S tk python-pyqt5
sudo pacman -S pyhton-pandas python-networkx python-matplotlib python-numpy python-seaborn
sudo pacman -S python-tensorflow python-pytorch python-scikit-learn

# Addional pcks
sudo pacman -S ipython python-regex python-cv2 python-opencv
paru -S python-gym

# QT5
sudo pacman -S qt5-quickcontrols qt5-script qt5-sensors qt5-tools qt5-webchannel qt5-webengine qt5-webkit qt5-websockets

## C/C++
sudo pacman -S valgrind gdb cmake man-pages strace ltrace

## Ocaml
sudo pacman -S ocaml dune opam
opam init
sudo pacman -S ocaml-base ocaml-compiler-libs ocaml-sexplib0

## haskell
sudo pacman -S cabal-install

## DB (sql and psql)
sudo pacman -S postgresql mysql
sudo -u postgres initdb -D /var/lib/postgres/data
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
sudo systemctl enable mariadb.service postgresql.service

## Android
sudo pacman -S android-file-transfer android-sdk android-sdk-platform-tools android-tools android-udev
paru -S android-emulator

## Virtualbox
sudo pacman -S virtualbox-host-modules-arch virtualbox-guest-iso
sudo usermod -aG vboxusers $USER
paru -S virtualbox-ext-oracle

## ohters
sudo pacman -S rust go ruby nodejs npm docker elixir julia
sudo usermod -aG docker $USER
