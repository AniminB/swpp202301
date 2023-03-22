#!/bin/bash

# Install necessary dependencies
brew update
brew install git cmake ninja zlib ncurses

# Download LLVM source
git clone -b llvmorg-16.0.0 https://github.com/llvm/llvm-project.git --depth 1
cd llvm-project

# Create LLVM installation directory
LLVM_DIR=~/llvm-swpp # Edit this directory
mkdir $LLVM_DIR

# Build LLVM
# Intel Mac users should use X86 instead of AArch64
cmake -G Ninja -S llvm -B build \
    -DLLVM_ENABLE_PROJECTS="clang;lldb;compiler-rt" \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_TARGETS_TO_BUILD="AArch64" \
    -DLLVM_ENABLE_RTTI=ON \
    -DLLVM_ENABLE_EH=ON \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DCOMPILER_RT_ENABLE_IOS=OFF \
    -DLLDB_INCLUDE_TESTS=OFF \
    -DLLDB_USE_SYSTEM_DEBUGSERVER=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$LLVM_DIR
cmake --build build
cmake --install build
