#!/bin/bash

set -e

# set the portable distribution version
poh_version="0.0.5"

# get the Open Hospital version
test -f ./gui/rsc/version.properties
version_file="./gui/rsc/version.properties"
major=$(grep VER_MAJOR $version_file | cut -d"=" -f2)
minor=$(grep VER_MINOR $version_file | cut -d"=" -f2)
release=$(grep VER_RELEASE $version_file | cut -d"=" -f2)
version="$major.$minor.$release"

mkdir -p ./poh-bundle-win/openhospital
mkdir -p ./poh-bundle-linux/oh-$version
cp -rf ./gui/target/OpenHospital20/* ./poh-bundle-win/oh
cp -rf ./gui/poh_files/win32/oh/* ./poh-bundle-win/oh

cp -rf ./gui/target/OpenHospital20/* ./poh-bundle-win/oh-$version
cp -f ./gui/poh_files/linux/oh/* ./poh-bundle-linux/oh-$version

cd ./poh-bundle-win
zip -r ../poh-win32-$poh_version-$version.zip *
cd ..

cd ./poh-bundle-linux
tar -cvzf ../poh-linux-$poh_version-$version.tar * | gzip
cd ..

echo "Portable distributions of Open Hospital created successfully."
