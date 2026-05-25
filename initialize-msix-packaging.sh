#!/bin/bash

git remote | grep msix-packaging; if [[ $? == 1 ]]; then
    git remote add msix-packaging https://github.com/microsoft/msix-packaging.git
fi

git subtree add --squash --prefix docker-msix/msix-packaging msix-packaging master
