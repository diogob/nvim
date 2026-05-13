#!/bin/sh

git submodule deinit -f $1
git rm -f $1
