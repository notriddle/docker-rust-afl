#!/bin/sh
# This script is released under the same terms as Rust itself.
set -e
apt-get update
apt-get install -y git clang cmake libssl-dev valgrind
rm -rf /var/lib/apt/lists/*
cd /opt
# Build rust
git clone https://github.com/rust-lang/rust.git
cd rust
./configure --enable-clang --disable-libcpp --enable-optimize --disable-docs
make -j 8
cd ..
export PATH=$PATH:/opt/rust/x86_64-unknown-linux-gnu/stage2/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/rust/x86_64-unknown-linux-gnu/stage2/lib/
# Build cargo
git clone https://github.com/rust-lang/cargo
cd cargo
apt-get install -y pkg-config  # https://github.com/frewsxcv/afl.rs/issues/11
./configure --local-rust-root=../rust/x86_64-unknown-linux-gnu/stage2/ --enable-optimize
make
export PATH=$PATH:/opt/cargo/target/x86_64-unknown-linux-gnu/release
cd ..
# Build afl
VERSION=1.96b
wget http://lcamtuf.coredump.cx/afl/releases/afl-$VERSION.tgz
tar xf afl-$VERSION.tgz
cd afl-$VERSION
make
make install
# To avoid having crashes misinterpreted as hangs (recommended by afl-fuzz when first run)
# echo core > /proc/sys/kernel/core_pattern

