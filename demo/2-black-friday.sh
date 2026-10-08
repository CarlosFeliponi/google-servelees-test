#!/usr/bin/env bash
# Simula a Black Friday: 50 acessos simultâneos durante 2 minutos.
set -euo pipefail
URL=${1:-$(cat .url)}
DURACAO=${DURACAO:-2m}
SIMULTANEOS=${SIMULTANEOS:-50}
REQUISICOES=${REQUISICOES:-3000}

if ! command -v hey >/dev/null && command -v go >/dev/null; then
  echo "Instalando o hey (gerador de carga)..."
  go install github.com/rakyll/hey@latest
  export PATH="$PATH:$(go env GOPATH)/bin"
fi

if command -v hey >/dev/null; then
  echo "Disparando $SIMULTANEOS acessos simultâneos por $DURACAO em $URL"
  hey -z "$DURACAO" -c "$SIMULTANEOS" "$URL?nome=BlackFriday"
else
  echo "hey/go indisponíveis; usando curl em paralelo: $REQUISICOES requisições, $SIMULTANEOS simultâneas, em $URL"
  seq "$REQUISICOES" | xargs -P "$SIMULTANEOS" -I{} curl -s -o /dev/null -w "%{http_code}\n" "${URL}?nome=BlackFriday" | sort | uniq -c
fi
