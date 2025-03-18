#!/bin/sh
set -ex
rm -rf build  # NOTE Lack of trust in mkdocs change detection.
uv run mkdocs build --strict
tar -czf build/guide.tgz -C build/guide .
du -h build/guide.tgz
