#!/bin/bash
if [ $# -ne 1 ]; then
  echo "ERROR"
  exit 1
fi

pstoedit -dt -f dxf:-polyaslines $1/floor.eps $1/floor.dxf
# pstoedit -dt -f dxf:-polyaslines $1/pillar.eps $1/pillar.dxf
pstoedit -dt -f dxf:-polyaslines $1/rail.eps $1/rail.dxf

exit 0
