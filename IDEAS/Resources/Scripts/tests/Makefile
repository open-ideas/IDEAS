# Set $ROOT to top-level directory of the library
ROOT ?= $(shell dirname \
  $(shell dirname \
  $(shell dirname \
  $(shell dirname \
  $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))))))

# Local image name and home
IMG_NAME=dymimg
IMG_HOME=/home/developer/IDEAS

build:
	docker build -f ${ROOT}/IDEAS/Resources/Scripts/tests/Dockerfile \
		--build-arg DYMOLAVERSION=${DYMOLAVERSION} \
		--build-arg DYMOLAFILE=${DYMOLAFILE} \
		--platform=linux/amd64 --progress=plain --rm -t ${IMG_NAME} ${DYMOLAPATH}

build-no-cache:
	docker build -f ${ROOT}/IDEAS/Resources/Scripts/tests/Dockerfile \
		--build-arg DYMOLAVERSION=${DYMOLAVERSION} \
		--build-arg DYMOLAFILE=${DYMOLAFILE} \
		--platform=linux/amd64 --progress=plain --no-cache --rm -t ${IMG_NAME} ${DYMOLAPATH}

run:
	docker run \
		--platform=linux/amd64 \
		--name ${IMG_NAME} \
		--detach=false \
		--network=host \
		--rm \
		-v ${ROOT}:${IMG_HOME} \
		-w ${IMG_HOME} \
		-it \
		${IMG_NAME}

run-detached:
	docker run \
		--platform=linux/amd64 \
		--name ${IMG_NAME} \
		--detach=true \
		--network=host \
		--rm \
		-v ${ROOT}:${IMG_HOME} \
		-w ${IMG_HOME} \
		-it \
		${IMG_NAME}

stop:
	docker stop ${IMG_NAME}

exec-interactive:
	make run-detached
	docker exec \
		-it \
		${IMG_NAME} \
		/bin/bash -c "cd ${IMG_HOME} && ${ARGS} && exit"
	make stop

exec-batch:
	make run-detached
	docker exec \
		-t \
		${IMG_NAME} \
		/bin/bash -c "cd ${IMG_HOME} && ${ARGS} && exit"
	make stop

# Set interactive as the default case to activate the testing container
# INTERACTIVE=true should be used to run tests locally whereas the server will be using INTERACTIVE=false
INTERACTIVE=true

test-all:
	make test-dymola PACKAGE=None INTERACTIVE=${INTERACTIVE} --quiet

test-dymola:
	if [ "${INTERACTIVE}" = "true" ]; then \
  		echo "Activating container for testing." && \
	  	make exec-interactive ARGS="cd IDEAS/Resources/Scripts/tests && make test-dymola-interactive PACKAGE=${PACKAGE}"; \
	else \
	  	echo "Activating container for testing." && \
	  	make exec-batch ARGS="cd IDEAS/Resources/Scripts/tests && make test-dymola-batch PACKAGE=${PACKAGE}"; \
	fi;

test-dymola-interactive:
	cd ${ROOT}/IDEAS --quiet && \
	  	python3 ../bin/runUnitTests.py \
	  		--tool dymola \
	  		--single-package ${PACKAGE}

test-dymola-batch:
	cd ${ROOT}/IDEAS --quiet && \
	  	python3 ../bin/runUnitTests.py \
	  		--tool dymola \
	  		--single-package ${PACKAGE} \
	  		--batch
