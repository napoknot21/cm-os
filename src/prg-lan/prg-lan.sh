#!/bin/sh

# Script for installing the following programming langages and some important libraries :
# java
# C/C++ (compiler)
# python
# haskell
# ocmal
# ruby, rust and others


## Java
pacman -S java-runtime-common java-environment-common
pacman -S jdk-openjdk openjdk-doc
pacman -S jre-openjdk jre-openjdk-headless
pacman -S java-openjfx java-openjfx-doc

## Python
pacman -S python
pacman -S tk python-pyqt5
pacman -S pyhton-pandas python-networkx python-matplotlib python-numpy
pacman -S python-tensorflow python-pytorch

## C/C++
pacman -S gcc
pacman -S valgrind gdb cmake man-db man-pages

## Ocaml
pacman -S ocaml dune opam
pacman -S ocaml-base

## haskell
sudo pacman -S ghc cabal-install

## ohters
pacman -S rust go ruby nodejs npm

