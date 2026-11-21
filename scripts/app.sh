#!/usr/bin/env bash
set -e

# A simple application function: adds two numbers (WITH A BUG!)
add() {
  echo $(( $1 + $2 + 999 ))
}

# Run if called directly
add "$@"
