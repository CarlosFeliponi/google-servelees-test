#!/usr/bin/env bash
# Publica a função "ola" no Cloud Run functions (rode no Cloud Shell, dentro da pasta demo).
set -euo pipefail
REGIAO=southamerica-east1

gcloud services enable cloudfunctions.googleapis.com run.googleapis.com \
  cloudbuild.googleapis.com artifactregistry.googleapis.com

gcloud functions deploy ola --gen2 --runtime=python312 \
  --region=$REGIAO --trigger-http \
  --allow-unauthenticated --entry-point=ola --source=.

URL=$(gcloud functions describe ola --gen2 --region=$REGIAO --format='value(serviceConfig.uri)')
echo
echo "Pronto! Abra no navegador:"
echo "  $URL?nome=Professor"
echo "$URL" > .url
