# azure-storage-explorer-deb

A .deb packaging template for Azure Storage Explorer

## Motivation

It's annoying to get a tarball to install a program. You won't get menu items, properly registered app or anything on OS level with a simple tarball containing all the binaries. Microsoft hasn't been providing anything else than that, so I decided to create a .deb packaging script at least for my own use.

## Contributors

- [@niklas-e](https://github.com/niklas-e)
- [@kitingChris](https://github.com/kitingChris)

## How to use

### Option 1: download .deb of latest version

1. Download the latest version ([checked/updated weekly](./.github/workflows/ci.yaml)) from [Releases page](https://github.com/niklas-e/azure-storage-explorer-deb/releases)
2. Double click the .deb you downloaded to install the Azure Storage Explorer :)

### Option 2: fetch the latest version manually and build deb package

1. `git clone https://github.com/niklas-e/azure-storage-explorer-deb.git`
2. `cd azure-storage-explorer-deb`
3. Download the latest Storage Explorer tarball from [https://azure.microsoft.com/en-us/features/storage-explorer/](https://azure.microsoft.com/en-us/features/storage-explorer/)
4. Copy the tarball to the root of this folder
5. Execute the create-deb script (and optionally pass the downloaded filename) `./create-deb.sh -f azure-storage-explorer.tar.gz`
6. Double click your newly created .deb package to install the Azure Storage Explorer :)

## Github Workflow

This repo contains a github workflow that automatically searches for new versions daily and builds them.
