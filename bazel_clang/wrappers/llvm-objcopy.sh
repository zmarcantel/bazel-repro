#!/usr/bin/env bash

set -e

TOOLCHAIN_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OBJCPYTOOL=$(WILDCARD=1 $TOOLCHAIN_DIR/find_tool.sh "llvm-objcopy")
if [ $? -ne 0 ]; then
    >&2 echo "could not find internal toolchain tools"
    exit 255
fi

$OBJCPYTOOL $@
