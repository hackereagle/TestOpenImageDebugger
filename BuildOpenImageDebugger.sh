#!/bin/bash

git clone https://github.com/OpenImageDebugger/OpenImageDebugger.git
cd OpenImageDebugger
git submodule init
git submodule update

OpenImageDebuggerDir=""
installedSuccess=0
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	echo "Linux"

	isQtInstalled=$(which qmake)
	if [[ "$isQtInstalled" == "" ]]; then
		echo "qmake not found. So install qt5"
		apt-get install qt5-default
	else
		echo "qmake found:"
		echo $isQtInstalled
	fi

	installedDir=~/Documents/programs
	if [[ ! -d $installedDir ]]; then
		echo "Create target directory: $installedDir"
		mkdir $installedDir
	else
		echo "Target directory already exists: $installedDir"
	fi
	OpenImageDebuggerDir=$installedDir/OpenImageDebugger

	cmake -S . -B build -DCMAKE_INSTALL_PREFIX=$installedDir
	cmake --build build --config Release --target install -j 4

	installedSuccess=1
elif [[ "$OSTYPE" == "darwin"* ]]; then
	echo "Mac OS with lldb"

	isQtInstalled=$(which qmake)
	if [[ "$isQtInstalled" == "" ]]; then
		echo "qmake not found. So install qt5"
		brew install qt5
	else
		echo "qmake found:"
		echo $isQtInstalled
	fi

	installedDir=~/Documents/programs
	if [[ ! -d $installedDir ]]; then
		echo "Create target directory: $installedDir"
		mkdir $installedDir
	else
		echo "Target directory already exists: $installedDir"
	fi
	OpenImageDebuggerDir=$installedDir/OpenImageDebugger

	# TODO: PKG_CONFIG_PATH need to be set and its value must be from lldb script
	export PKG_CONFIG_PATH=/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/Current/lib/pkgconfig
	echo $PKG_CONFIG_PATH
	mkdir build
	cmake -S . -B build -DCMAKE_INSTALL_PREFIX=$installedDir -DQt5_DIR=$(brew --prefix qt5)/lib/cmake/Qt5
	cmake --build build --config Release --target install -j 4

	installedSuccess=1
else
	echo "Unknown OS"
fi

if [[ $installedSuccess -eq 0 ]]; then
	echo "OpenImageDebugger installation failed"
	exit 1
fi

echo "OpenImageDebuggerDir: $OpenImageDebuggerDir"

if [[ -f ~/.gdbini ]]; then
	echo "source $OpenImageDebuggerDir/oid.py" >> ~/.gdbinit
else
	echo "source $OpenImageDebuggerDir/oid.py" > ~/.gdbinit
fi

if [[ -f ~/.lldbini ]]; then
	echo "command $OpenImageDebuggerDir/oid.py" >> ~/.lldbinit
else
	echo "command $OpenImageDebuggerDir/oid.py" > ~/.lldbinit
fi

echo "OpenImageDebugger installation success"