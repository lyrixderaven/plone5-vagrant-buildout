#!/bin/sh

# generate proper utf-8 locales
sudo locale-gen UTF-8

sudo pip install virtualenv

# virtualenv
cd plone5
virtualenv zinstance
cp manifests/buildout.cfg zinstance/
cd zinstance
bin/pip install zc.buildout
bin/buildout -N
