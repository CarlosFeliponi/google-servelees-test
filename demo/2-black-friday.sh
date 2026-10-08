#!/usr/bin/env bash
# Simula a Black Friday: 50 acessos simultâneos durante 2 minutos.
set -euo pipefail
URL=${1:-$(cat .url)}
DURACAO=${DURACAO:-2m}
SIMULTANEOS=${SIMULTANEOS:-50}

if ! command -v hey >/dev/null; then
  echo "Instalando o hey (gerador de carga)..."
  go install github.com/rakyll/hey@latest
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

echo "Disparando $SIMULTANEOS acessos simultâneos por $DURACAO em $URL"
hey -z "$DURACAO" -c "$SIMULTANEOS" "$URL?nome=BlackFriday"
