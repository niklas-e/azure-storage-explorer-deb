#!/bin/bash

while getopts ":v:" opt; do
  case $opt in
    v) buildVersion="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ -z "$buildVersion" ]; then
    echo "Missing version argument (-v)"
    exit 1
fi

# Extract from archive
mkdir azure-storage-explorer
tar -xzf $(find ./*.tar.gz) -C azure-storage-explorer

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
dpkg -b $buildDir/ azure-storage-explorer_${buildVersion}_x64.deb

# Remove build dir
rm -r $buildDir
