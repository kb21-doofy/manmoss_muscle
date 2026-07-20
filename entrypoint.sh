#!/bin/bash
set -e

# Rails のサーバが前回のコンテナ由来の server.pid を残していると再起動できないため削除する
if [ -f tmp/pids/server.pid ]; then
  rm -f tmp/pids/server.pid
fi

# Dockerfile の CMD（コンテナのメインプロセス）を実行する
exec "$@"
