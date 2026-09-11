#!/bin/sh

set -e

apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    clang-20 \
    libclang-rt-20-dev \
    git \
    make \
    build-essential \
    cmake \
    libffi-dev \
    libgit2-dev \
    cargo \
    gh \
    libcriterion-dev

update-ca-certificates

mkdir -p /app
cd /app
git clone https://github.com/EpiSDK/EpiFaster.git

cd /app/EpiFaster
ln -sf /usr/bin/clang-20 /usr/bin/clang
./setup.sh

cd /app
mkdir -p /github/home/.local/bin
cp banana-check-repo.sh /github/home/.local/bin/banana-check-repo
ln -sf /app/EpiFaster/target/release/epiclang /usr/bin/epiclang

apt-get purge -y build-essential cargo
apt-get autoremove -y
apt-get clean
rm -rf /app/EpiFaster/.git /var/lib/apt/lists/* "$HOME/.cargo" "$HOME/.rustup" /root/.cargo /root/.rustup