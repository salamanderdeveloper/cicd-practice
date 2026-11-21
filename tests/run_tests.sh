#!/usr/bin/env bash
set -e

echo "=== Running Test Suite ==="

# Test 1: 2 + 3 must equal 5
result=$(bash scripts/app.sh 2 3)
echo "Testing: 2 + 3 = $result"

if [ "$result" -eq 5 ]; then
  echo "✅ TEST PASSED: 2 + 3 is 5"
else
  echo "❌ TEST FAILED: expected 5, got $result"
  exit 1
fi

echo "=== All tests passed! ==="
exit 0
