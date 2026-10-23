
#!/usr/bin/env bash
set -Eeuo pipefail

echo "Cloning official 3x-ui source..."
git clone --depth 1 https://github.com/MHSanaei/3x-ui.git source

cd source

echo "Installing frontend dependencies..."
cd frontend
npm ci
npm run build
cd ..

echo "Checking frontend output..."
test -f internal/web/dist/index.html

echo "Building Go application..."
mkdir -p build
CGO_ENABLED=1 go build -ldflags="-w -s" -o build/x-ui main.go

echo "Build completed."
