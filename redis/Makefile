#   Copyright 2020 The KNIX Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

# Makefile
SHELL := /bin/bash
-include ../proxy.mk

default: redis-server

include ../docker.mk

redis-server: Dockerfile_redis_build
	echo "Building redis server"
	mkdir -p redis-server
	$(call build_image,Dockerfile_redis_build,redis_local_queue)
	docker run -i --rm -u $$(id -u):$$(id -g) -v $(CURDIR):/temp -w /temp --ulimit nofile=262144:262144 redis_local_queue:$(VERSION) cp /build/redis-6.2.1/src/redis-server redis-server/.
	touch redis-server/redis_4999.conf
	echo "port 4999" >> redis-server/redis_4999.conf
	echo "appendonly no" >> redis-server/redis_4999.conf
	echo "save \"\"" >> redis-server/redis_4999.conf

clean:
	rm -rf redis-server