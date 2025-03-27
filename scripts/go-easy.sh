#!/bin/sh

SHELF=$(dirname $(dirname $0))
mkdir -p "$SHELF/.go-stuff"

export GOBIN="$SHELF/bin"
export GOPATH="$SHELF/.go-stuff"
export GOWORK="$SHELF/go.work"
export CGO_ENABLED=0

set -ex
exec /usr/bin/go "$@"
