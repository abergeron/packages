#!/bin/bash

set -e
set -u

cd python
python setup.py install --single-version-externally-managed --record=/tmp/record.txt
cd ..
