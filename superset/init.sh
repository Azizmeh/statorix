#!/bin/bash
set -e

superset db upgrade || true

superset fab create-admin \
  --username admin \
  --firstname Admin \
  --lastname User \
  --email admin@statorix.local \
  --password admin || true

superset init

exec superset run -h 0.0.0.0 -p 8088
