#!/bin/bash

set -e
set -u

cd python
python setup.py install --single-version-externally-managed --record=/tmp/record.txt
cd ..

cd topi/python
python setup.py install --single-version-externally-managed --record=/tmp/record.txt
cd ../..

cd nnvm/python
python setup.py install --single-version-externally-managed --record=/tmp/record.txt
cd ../..
