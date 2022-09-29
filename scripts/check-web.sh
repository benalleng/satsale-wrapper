#!/bin/bash

DURATION=$(</dev/stdin)
if (($DURATION <= 7000)); then
    exit 60
else
    if ! curl --silent --fail lnbits.embassy:5000 &>/dev/null; then
        echo "LNBits Web UI is unreachable" >&2
        exit 1
    fi
fi
