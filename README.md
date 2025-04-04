# Test OpenImageDebugger Note
This project is created to test OpenImageDebugger.</br>
The building procedure already become shell script. So just execute `./BuildOpenImageDebugger.sh`, all setting and dependency will be installed.</br>
But I only sure Mac OS can work. I am not test linux part.</br>
</br>
</br>
Very appreciate JiahangWu's suggestion in ["Does this project still work on Mac OS? #1"](https://github.com/hackereagle/TestOpenImageDebugger/issues/1) </br>
Here are my installation note:
</p>

## Preliminary Activity
In my Mac OS, python interpreter version of lldb is 3.9. It is less than OpenImageDebugger requirement. So we need to install lldb
```bash
brew install llvm
```
Then, get installed location:
```bash
brew --prefix llvm
```
Add path of lldb located to  `$PATH`.</br>
```bash
echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```
</br>
Chek python interpreter version of installed lldb:
First, execute installed lldb and use python to check:

```bash
/opt/homebrew/opt/llvm/bin/lldb
(lldb) script
Python Interactive Interpreter. To exit, type 'quit()', 'exit()' or Ctrl-D.
>>> import sys; print(sys.path)
```
In my case, output is
```bash
['/opt/homebrew/Cellar/llvm/19.1.7_1/lib', '/opt/homebrew/Cellar/llvm/19.1.7_1/libexec/python3.13/site-packages', '/opt/homebrew/Cellar/python@3.13/3.13.2/Frameworks/Python.framework/Versions/3.13/lib/python313.zip', '/opt/homebrew/Cellar/python@3.13/3.13.2/Frameworks/Python.framework/Versions/3.13/lib/python3.13', '/opt/homebrew/Cellar/python@3.13/3.13.2/Frameworks/Python.framework/Versions/3.13/lib/python3.13/lib-dynload', '/opt/homebrew/Cellar/python@3.13/3.13.2/Frameworks/Python.framework/Versions/3.13/lib/python3.13/site-packages', '/opt/homebrew/Cellar/openvino/2025.0.0/libexec/lib/python3.13/site-packages', '.']
```
Therefore, python interpreter version of installed lldb is `3.13.2`.

## Build
First, clone OpenImageDebugger source code
```bash
git clone https://github.com/OpenImageDebugger/OpenImageDebugger.git
cd OpenImageDebugger
git submodule init
git submodule update
```
Then modify `OpenImageDebugger/src/oidbridge/CMakeLists.txt` finding python package code. Specify the python version same with installed lldb:
```
# find_package(Python 3.10.12 REQUIRED COMPONENTS Development)
find_package(Python 3.13 REQUIRED COMPONENTS Interpreter Development)
```
After modified, execute `BuildOpenImageDebug.sh` script:
```bash
./BuildOpenImageDebugger
```