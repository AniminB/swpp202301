#!/bin/bash

# install re2c
if [ "$(uname)" == "Darwin" ]; then
    brew install re2c
else
    sudo apt install re2c
fi

# Specify LLVM installation directory
LLVM_DIR=~/llvm-swpp
# Specify Z3 installation directory (Z3 will be installed here!)
Z3_DIR=~/z3

# Install Z3
git clone -b z3-4.12.1 https://github.com/Z3Prover/z3.git --depth=1
cd z3
cmake -GNinja -Bbuild \
    -DCMAKE_INSTALL_PREFIX=$Z3_DIR
cmake --build build
cmake --install build

# Download Alive2 source
cd ../
git clone https://github.com/AliveToolkit/alive2.git
cd alive2

# Build Alive2
git checkout 9ca7092c21e69b4e71c91b9280cff920234410dc
cmake -GNinja -Bbuild \
    -DBUILD_TV=ON \
    -DCMAKE_PREFIX_PATH="$LLVM_DIR;$Z3_DIR" \
    -DCMAKE_BUILD_TYPE=Release
cmake --build build
