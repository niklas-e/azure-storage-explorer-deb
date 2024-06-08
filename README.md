# azure-storage-explorer-deb

A .deb packaging template for Azure Storage Explorer

## Motivation

It's annoying to get a tarball to install a program. You won't get menu items, properly registered app or anything on OS level with a simple tarball containing all the binaries. Microsoft hasn't been providing anything else than that, so I decided to create a .deb packaging script at least for my own use.

## Contributors

- [@niklas-e](https://github.com/niklas-e)
- [@kitingChris](https://github.com/kitingChris)

## How to use

1. `git clone https://github.com/niklas-e/azure-storage-explorer-deb.git`
2. `cd azure-storage-explorer-deb`
3. `chmod +x create-deb.sh`
4. Download the latest Storage Explorer tarball from [https://azure.microsoft.com/en-us/features/storage-explorer/](https://azure.microsoft.com/en-us/features/storage-explorer/)
5. Copy the tarball to the root of this folder
6. Execute the create-deb script (and optionally pass the downloaded filename) `./create-deb.sh -f azure-storage-explorer.tar.gz`
7. Double click your newly created .deb package to install the Azure Storage Explorer :)

## Github Workflow

This repo contains a github workflow that automatically searches for new versions daily and builds them.
