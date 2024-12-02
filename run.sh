#!/usr/bin/env bash

CWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
cd "$CWD"

set +x

parallel=${2:-10000}

status () {
  local opts
  if [ $(uname) = "Darwin" ]; then 
    opts="-l 15"
  else 
    opts="-b -n15"
  fi
  top $opts -pid $1 -stats pid,cpu,mem | egrep "$1"
}

_dotnet () {
  cd dotnet
  dotnet publish -c Release --self-contained true
  exec ./bin/Release/net9.0/osx-arm64/publish/dotnet $parallel &
  status $!
}

_elixir () {
  cd elixir
  exec elixir tasks.ex $parallel &
  status $!
}

_go () {
  cd go
  go build
  exec ./coroutines $parallel &
  status $!
}

_java () {
  cd java
  exec java VirtualThreads.java $parallel &
  status $! 
}

_nodejs () {
  cd nodejs
  exec node main.js $parallel &
  status $!
}

_python () {
  cd python
  exec python3 main.py $parallel &
  status $!
}

_rust_async_std () {
  cd rust_async_std
  cargo build -r 
  exec ./target/release/rust_async_std $parallel &
  local pid=$!
  status $pid 
}

_rust_futures () {
  cd rust_futures
  cargo build -r 
  exec ./target/release/rust_futures $parallel &
  local pid=$!
  status $pid 
}

_rust_tokio () {
  cd rust_tokio
  cargo build -r 
  exec ./target/release/rust_tokio $parallel &
  local pid=$!
  status $pid 
}

_all () {
  for cmd in dotnet elixir go java nodejs python rust_async_std rust_futures rust_tokio; do
    echo === $cmd ===
    ./run.sh $cmd $parallel
  done
}

_versions () {
  cat << EOS
- dotnet: $(dotnet --version)
- elixir: $(elixir --version | tail -1)
- go: $(go version)
- java: $(java --version | head -1)
- nodejs: $(node --version)
- python: $(python3 --version)
- rust: $(cargo --version)
EOS
}

# ... ignition ...

function help {
	# declare -F does not works in zsh!
	declare -F | sed -e 's/declare -f /    /; s/    _/    /;'
}

if test -z "$1"; then
	help
else
	_$1 ${*:2}
fi