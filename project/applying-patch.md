## How to apply Alive2 SWPP patch

Note: the Alive2 version must precisely be the commit specified in
`practice/install-alive2.sh`!  
Otherwise applying the patch will break the code and won't compile.

```bash
cd practice/alive2 # or Alive2 repository
git apply ../../project/alive2-swpp-intrinsics.patch # or path to patch
```

The patch adds a script `build.sh` into the repo directory.
Modify the `LLVM_DIR` and `Z3_DIR` in the script, and run the script.
```bash
./build.sh
```
