#!/bin/bash

for file in "."/*.sql; do
    psql -f "${file}" > ${file%.sql}.txt
  
done
