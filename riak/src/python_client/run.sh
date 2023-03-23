#!/bin/sh
docker run -it --rm --network host --ulimit nofile=262144:262144 -v $(pwd):/code -w /code python:3.8 bash -c './dockerrun.sh'
