#!/bin/bash

echo "Searching for not used keys"

for K in `sed '/0x/!d;s/^.*0x/0x/;s/ *,.*$//;s/ *#.*$//' resources/pgp-keys-map.list | sort | uniq`; do
    if ! grep -q "$K" build.log; then
        echo "Key $K not used"
    fi
done

echo "."
