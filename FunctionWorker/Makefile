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

SHELL := /bin/bash
-include ../proxy.mk
include ../docker.mk
include ../build_env.mk
UID:=`id -u`
GID:=`id -g`

default: doc/MicroFunctionsAPI.html

PYTHON_DATALAYER=$(shell find python/data_layer -type f -size +1c) python/data_layer
$(PYTHON_DATALAYER): ../build_env.mk \
		../DataLayerService/thrift/DataLayerMessage.thrift \
		../DataLayerService/thrift/DataLayerService.thrift \
		../build_tools/thrift/$(THRIFT_VERSION)/build_thrift.sh
	cd ../build_tools/thrift/$(THRIFT_VERSION)/; ./build_thrift.sh; cd -
	docker run --user $(UID):$(GID) --rm -v $(CURDIR)/..:/root -w /root $(THRIFT_IMAGE_NAME):$(THRIFT_VERSION) bash -c '\
		thrift --gen py -out FunctionWorker/python/ DataLayerService/thrift/DataLayerMessage.thrift; \
		thrift --gen py -out FunctionWorker/python/ DataLayerService/thrift/DataLayerService.thrift'

doc/MicroFunctionsAPI.html: $(PYTHON_DATALAYER)
	docker run --user $(UID):$(GID) --rm -i \
		--name mfnapi_doc_gen \
		-v $(CURDIR):/opt/mfnapi \
		-w /opt/mfnapi \
		-e http_proxy \
		-e https_proxy \
		python:3.8 \
		/bin/bash -c '\
		pip3 install pdoc3 --target /opt/mfnapi/tmppip/pdoc3; \
		pip3 install requests --target /opt/mfnapi/tmppip/requests; \
		pip3 install thrift --target /opt/mfnapi/tmppip/thrift; \
		PYTHONPATH=/opt/mfnapi/tmppip/pdoc3:/opt/mfnapi/tmppip/requests:/opt/mfnapi/tmppip/thrift tmppip/pdoc3/bin/pdoc3 --html --output-dir doc --force /opt/mfnapi/python/MicroFunctionsAPI.py'; \
		rm -rf tmppip
clean:
	rm -rf doc

