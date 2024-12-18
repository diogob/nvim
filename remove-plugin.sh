#!/bin/sh

git submodule deinit $1
git rm -f $1
