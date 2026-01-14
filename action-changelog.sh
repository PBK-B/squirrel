#!/usr/bin/env bash

set -euo pipefail

current=${1:-$(git describe --tags --abbrev=0)}
previous=$(git log -1 --format=%H --grep='^chore(release): ' "${current}^")
if [[ -z ${previous} ]]; then
  echo "No previous release commit found" >&2
  exit 1
fi
release_subject=$(git show -s --format=%s "${previous}")
if [[ ${release_subject} =~ ^chore\(release\):\ (squirrel\ )?([^[:space:]]+) ]]; then
  previous_version=${BASH_REMATCH[2]}
else
  echo "Unable to parse previous version from: ${release_subject}" >&2
  exit 1
fi

echo "![GitHub Downloads](https://img.shields.io/github/downloads/PBK-B/squirrel/${current}/total) [![Homebrew: zmide/tap/squirrel (cask)](https://img.shields.io/endpoint?url=https%3A%2F%2Fbrew.zmorg.cn%2Fbadges%2Fcask%2Fsquirrel.json&label=Homebrew&style=flat&logo=homebrew)](https://brew.zmorg.cn/cask/squirrel/)"
echo ""

echo "**Change log since ${previous_version}:**"

git log --no-merges "${previous}..${current}" --pretty="tformat:- %h %s"
