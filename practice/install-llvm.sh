#!/bin/bash

# Install necessary dependencies
# Package names may slightly differ in macOS (brew)
sudo apt update
sudo apt -y install git g++ cmake ninja-build python3-distutils zlib1g-dev \
libncurses-dev

# Download LLVM source
git clone -b llvmorg-15.0.7 https://github.com/llvm/llvm-project.git --depth 1
cd llvm-project

# Create LLVM installation directory
LLVM_DIR=~/llvm-swpp # Edit this directory
mkdir $LLVM_DIR

# Build LLVM
# ARM Mac users should use AArch64 instead of X86
# You may erase line 27-28 if your computer is powerful enough
cmake -G Ninja -S llvm -B build \
    -DLLVM_ENABLE_PROJECTS="clang;lldb;compiler-rt" \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_TARGETS_TO_BUILD="X86" \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_PARALLEL_COMPILE_JOBS=4 \
    -DLLVM_PARALLEL_LINK_JOBS=1 \
    -DLLVM_USE_LINKER=gold \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$LLVM_DIR
cmake --build build
cmake --install build
