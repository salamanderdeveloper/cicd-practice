#!/usr/bin/env bash
set -e

# A simple application function: adds two numbers (FIXED!)
add() {
  echo $(( $1 + $2 ))
}

# Run if called directly
add "$@"
# small comment
