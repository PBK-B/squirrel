#!/usr/bin/env bash

beta=$(git describe --tags --abbrev=0)
current=$(git describe --tags --abbrev=0 --tags ${beta}^)
previous=$(git describe --always --abbrev=0 --tags ${current}^)

echo "![GitHub Downloads](https://img.shields.io/github/downloads/PBK-B/squirrel/${beta}/total)"
echo ""

echo "**Change log since ${beta}:**"

git log --oneline --decorate ${previous}...${beta} --pretty="format:- %h %s" | grep -v Merge
