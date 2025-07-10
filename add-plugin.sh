#!/bin/sh
git submodule add --force --name $2 --depth 1 $1 pack/plugins/opt/$2
