#!/bin/sh
docker run -it --rm --network host --name mqttpublisher -v $(pwd):/code -w /code python:3.8 bash -c './mqttpublisher.sh'
