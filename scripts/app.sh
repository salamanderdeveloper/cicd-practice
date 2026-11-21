#!/usr/bin/env bash
set -e

# A simple application function: adds two numbers
add() {
  echo $(( $1 + $2 ))
}

# Run if called directly
add "$@"
