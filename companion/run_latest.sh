#!/usr/bin/env sh
DL_ENDPOINT="https://dnlo0r667tlsj.cloudfront.net/LosslessAdapterManager2_Linux.gz"

BASE_DIR="$HOME/.local/share/lossless-companion"
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

mkdir -p {dl,bin}

# Be a nice user, don't spam the endpoint, just once every hour
currentTime=$(date +%s)
lastModified=$(date -r ./bin/LosslessAdapterManager2_Linux +%s)
((elapsed = currentTime - lastModified))
if [[ $elapsed -gt 3600 ]]; then
    cd dl

    curl --location --remote-name "$DL_ENDPOINT"
    gunzip LosslessAdapterManager2_Linux.gz
    chmod +x ./LosslessAdapterManager2_Linux
    mv LosslessAdapterManager2_Linux ../bin/LosslessAdapterManager2_Linux
    cd ..
fi
    cd bin
    exec env DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 ./LosslessAdapterManager2_Linux
