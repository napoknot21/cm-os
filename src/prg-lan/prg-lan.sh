#!/bin/sh

# Script for installing the following programming langages and some important libraries :
# java
# C/C++ (compiler)
# python
# haskell
# ocmal
# ruby, rust and others


## Java
sudo pacman -S java-runtime-common java-environment-common
sudo pacman -S jdk-openjdk openjdk-doc
sudo pacman -S jre-openjdk jre-openjdk-headless
sudo pacman -S java-openjfx java-openjfx-doc

## Python
sudo pacman -S tk python-pyqt5
sudo pacman -S pyhton-pandas python-networkx python-matplotlib python-numpy
sudo pacman -S python-tensorflow python-pytorch
# Addional pcks
sudo pacman -S ipython python-regex python-cv2 python-opencv
paru -S python-gym

# QT5
sudo pacman -S qt5-quickcontrols qt5-script qt5-sensors qt5-tools qt5-webchannel qt5-webengine qt5-webkit qt5-websockets

## C/C++
sudo pacman -S valgrind gdb cmake man-pages

## Ocaml
sudo pacman -S ocaml dune opam
sudo pacman -S ocaml-base

## haskell
sudo pacman -S cabal-install

## DB (sql and psql)
sudo pacman -S postgresql mysql

## ohters
sudo pacman -S rust go ruby nodejs npm

