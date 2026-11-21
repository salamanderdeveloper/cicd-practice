#!/usr/bin/env bash
set -euo pipefail

# A simple CLI math calculator: ./scripts/math.sh add 2 3
operation="${1:-}"
a="${2:-0}"
b="${3:-0}"

if [ -z "$operation" ]; then
  echo "Usage: $0 {add|multiply} num1 num2"
  exit 1
fi

case "$operation" in
  add)
    echo $(( a + b ))
    ;;
  multiply)
    echo $(( a * b ))
    ;;
  *)
    echo "Unknown operation: $operation"
    exit 1
    ;;
esac
