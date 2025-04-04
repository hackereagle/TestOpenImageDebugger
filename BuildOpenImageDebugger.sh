#!/bin/bash

cd OpenImageDebugger

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

	export PKG_CONFIG_PATH=/opt/homebrew/Cellar/python@3.13/3.13.2/Frameworks/Python.framework/Versions/3.13/lib/pkgconfig
	echo $PKG_CONFIG_PATH
	mkdir build
	cmake -S . -B build -DCMAKE_INSTALL_PREFIX=$installedDir -DQt5_DIR=$(brew --prefix qt5)/lib/cmake/Qt5 -DCMAKE_BUILD_TYPE=Release
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


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	if [[ -f ~/.gdbini ]]; then
		echo "source $OpenImageDebuggerDir/oid.py" >> ~/.gdbinit
	else
		echo "source $OpenImageDebuggerDir/oid.py" > ~/.gdbinit
	fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
	if [[ -f ~/.lldbinit ]]; then
		echo "command script import $OpenImageDebuggerDir/oid.py" >> ~/.lldbinit
	else
		echo "command script import $OpenImageDebuggerDir/oid.py" > ~/.lldbinit
	fi
fi

echo "OpenImageDebugger installation success"


