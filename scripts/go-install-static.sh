#!/bin/sh
set -eu

SHELF="$( cd $(dirname $(dirname $0)) && pwd )"

set -eux
GOBIN="$SHELF/bin" CGO_ENABLED=0 go install -x -ldflags '-extldflags "-static"' "$@"
