#!/bin/bash

usage() { echo "Usage: $0 [-f <tarFile>]" 1>&2; exit 1; }
while getopts ":f:" opt; do
  case $opt in
    f) tarFile="$OPTARG"
    ;;
    *) usage
    ;;
  esac
done

if ! command -v jq >/dev/null 2>&1 ; then
    echo "jq not found."
fi
if ! command -v dpkg-deb >/dev/null 2>&1 ; then
    echo "dpkg-deb not found."
fi
if ! command -v tar >/dev/null 2>&1 ; then
    echo "tar not found."
fi

outputFile="azure-storage-explorer_{{buildVersion}}_x64.deb"

tarFile="${tarFile:-"azure-storage-explorer.tar.gz"}" 

if [ ! -f "$tarFile" ]; then
    echo "tar file \"$tarFile\" not found"
    exit 1
fi

# Extract from archive
mkdir azure-storage-explorer
tar -xzf "$tarFile" -C azure-storage-explorer

buildVersion=$(cat azure-storage-explorer/resources/app/package.json | jq '.version' | tr -d '"')
outputFile=${outputFile/\{\{buildVersion\}\}/$buildVersion}

# Get package size
packageSize=$(du -sk azure-storage-explorer | cut -f1)

# Create folder structure
buildDir=build

mkdir $buildDir
mkdir $buildDir/opt
mkdir $buildDir/usr
mkdir $buildDir/usr/share
mkdir $buildDir/usr/share/applications
mkdir $buildDir/usr/share/pixmaps

# Set up files
mv azure-storage-explorer $buildDir/opt/
cp -r files/DEBIAN/ $buildDir/
cp files/azure-storage-explorer.desktop $buildDir/usr/share/applications/
cp $buildDir/opt/azure-storage-explorer/resources/app/out/app/icon.png $buildDir/usr/share/pixmaps/azure-storage-explorer.png

# Set permissions to installation scripts
chmod 755 $buildDir/DEBIAN/postinst
chmod 755 $buildDir/DEBIAN/prerm

# Set package size
sed -i "s/{{packageSize}}/$packageSize/g" $buildDir/DEBIAN/control

# Set version number to the package
sed -i "s/{{versionNumber}}/$buildVersion/g" $buildDir/DEBIAN/control
sed -i "s/{{versionNumber}}/$buildVersion/g" $buildDir/usr/share/applications/azure-storage-explorer.desktop

# Generate md5sums
cd $buildDir
find . -type f -printf '"%P" ' | xargs md5sum > DEBIAN/md5sums
cd ..

# Build
dpkg-deb --build --root-owner-group $buildDir $outputFile

# Remove build dir
rm -r $buildDir
