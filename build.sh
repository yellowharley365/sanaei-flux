#!/usr/bin/env bash
set -Eeuo pipefail

echo "Preparing official 3x-ui source..."

if [ ! -d source/.git ]; then
  git clone --depth 1 https://github.com/MHSanaei/3x-ui.git source
fi

cd source

echo "Checking build tools..."
command -v go
command -v node
command -v npm

echo "Building frontend..."
cd frontend
npm ci
npm run build
cd ..

echo "Checking embedded frontend..."
test -f internal/web/dist/index.html

echo "Building Go application..."
mkdir -p build
CGO_ENABLED=1 go build -ldflags="-w -s" -o build/x-ui main.go

echo "Build completed."
