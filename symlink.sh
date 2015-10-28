#!/bin/bash
set -e

IGNORE=(symlink.sh)

array_contains () { 
  local array="$1[@]"
  local seeking=$2
  local in=1
  for element in "${!array}"; do
    if [[ $element == $seeking ]]; then
      in=0
      break
    fi
  done
  return $in
}

link() {
  TARGET=../.$1
  if [ -d "$TARGET" ]; then
    rm -rf $TARGET
  fi
  if [ -f "$TARGET" ] || [ -h "$TARGET" ]; then
    rm $TARGET
  fi
  ln -s $(pwd)/$1 $TARGET
}

for var in *; do
  array_contains IGNORE $var || link $var
done
