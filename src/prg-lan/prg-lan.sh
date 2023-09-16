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
sudo pacman -S python
sudo pacman -S tk python-pyqt5
sudo pacman -S pyhton-pandas python-networkx python-matplotlib python-numpy
sudo pacman -S python-tensorflow python-pytorch
# Addional pcks
sudo pacman -S ipython python-regex python-cv2 python-opencv
paru -S python-gym

## C/C++
sudo pacman -S gcc
sudo pacman -S valgrind gdb cmake man-db man-pages

## Ocaml
sudo pacman -S ocaml dune opam
sudo pacman -S ocaml-base

## haskell
sudo pacman -S ghc cabal-install

## DB (sql and psql)
sudo pacman -S postgresql mysql

## ohters
sudo pacman -S rust go ruby nodejs npm

