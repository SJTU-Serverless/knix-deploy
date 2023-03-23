#!/bin/sh
./scripts/wait-for-it.sh $(hostname):5672 -t 30
docker run -it --rm --network host --name rabbitsubscriber -v $(pwd):/code -w /code python:3.8 bash -c './scripts/subscriber.sh'
