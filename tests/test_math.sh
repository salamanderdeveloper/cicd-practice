#!/usr/bin/env bash
set -euo pipefail

echo "Running test suite..."

# Test 1: Addition
res_add=$(bash scripts/math.sh add 5 7)
if [ "$res_add" -eq 12 ]; then
  echo " PASS: 5 + 7 = 12"
else
  echo " FAIL: Expected 12, got $res_add"
  exit 1
fi

# Test 2: Multiplication
res_mul=$(bash scripts/math.sh multiply 3 4)
if [ "$res_mul" -eq 12 ]; then
  echo " PASS: 3 * 4 = 12"
else
  echo " FAIL: Expected 12, got $res_mul"
  exit 1
fi

echo "All tests passed successfully!"
exit 0
