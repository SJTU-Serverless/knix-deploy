#!/bin/sh
docker run -it --rm --network host --name rabbitsubscriber -v $(pwd):/code -w /code python:3.8 bash -c './subscriber.sh'
