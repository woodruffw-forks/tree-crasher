#!/usr/bin/env bash

set -e

repos=(
  "pydantic/pydantic"
  "celery/celery"
  "django/django"
)
mkdir -p python
for repo in "${repos[@]}"; do
  base=$(basename "${repo}")
  if ! [[ -d "${base}" ]]; then
    git clone --jobs 4 --depth 1 "https://github.com/${repo}"
  fi
  for f in $(find "${base}" -type f -name "*.py"); do
    echo "${f}"
    cp "${f}" python/"${base}-$(sha256sum "${f}" | head -c 5)-$(basename "${f}")"
  done
done
