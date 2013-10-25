#!/bin/bash -x
if [ $# -ne 2 ]; then
  echo "Please specify width and height."
  exit 1
fi

openscad -o joints/$1x$2.stl -D W=$1 -D H=$2 joint.scad

exit 0
