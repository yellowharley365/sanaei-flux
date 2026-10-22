#!/usr/bin/env bash
set -Eeuo pipefail

cd source

if [ ! -x build/x-ui ]; then
  echo "ERROR: build/x-ui not found. Run build.sh first."
  exit 1
fi

exec ./build/x-ui
