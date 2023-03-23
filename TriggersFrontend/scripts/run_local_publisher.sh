#!/bin/sh
docker run -it --rm --network host --name rabbitpublisher -v $(pwd):/code -w /code python:3.8 bash -c './publisher.sh'
