# azure-storage-explorer-deb

A .deb packaging template for Azure Storage Explorer

## Motivation

It's annoying to get a tarball to install a program. You won't get menu items, properly registered app or anything on OS level with a simple tarball containing all the binaries. Microsoft hasn't been providing anything else than that, so I decided to create a .deb packaging script at least for my own use.

## How to use

1. `git clone https://github.com/niklas-e/azure-storage-explorer-deb.git`
2. `cd azure-storage-explorer-deb`
3. `chmod +x create-deb.sh`
4. Download the latest Storage Explorer tarball from [https://azure.microsoft.com/en-us/features/storage-explorer/](https://azure.microsoft.com/en-us/features/storage-explorer/)
5. Copy the tarball to the root of this folder
6. Execute the create-deb script (and pass the version number) `./create-deb.sh -v 1.4.2`