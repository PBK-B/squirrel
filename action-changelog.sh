#!/usr/bin/env bash

set -euo pipefail

current=${1:-$(git describe --tags --abbrev=0)}
previous=$(git describe --tags --match '[0-9]*' --abbrev=0 "${current}^" 2>/dev/null || git rev-parse "${current}^")

echo "![GitHub Downloads](https://img.shields.io/github/downloads/PBK-B/squirrel/${current}/total)"
echo ""

echo "**Change log since ${previous}:**"

git log --no-merges "${previous}..${current}" --pretty="tformat:- %h %s"
