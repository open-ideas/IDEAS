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
		-w ${IMG_HOME}/IDEAS/Resources/Scripts/tests \
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
		-w ${IMG_HOME}/IDEAS/Resources/Scripts/tests \
		-it \
		${IMG_NAME}

stop:
	docker stop ${IMG_NAME}

exec:
	echo "Activating container for testing."
	make run-detached
	docker exec \
		-t \
		${IMG_NAME} \
		/bin/bash -c "${ARGS} && exit"
	make stop

# Set interactive as the default case to activate the testing container
# INTERACTIVE=true (default) should be used to run tests locally
# INTERACTIVE=false should be used to run tests in the server
INTERACTIVE=true

test-all:
	make test-dymola PACKAGE=None INTERACTIVE=${INTERACTIVE} --quiet

test-dymola:
	if [ "${INTERACTIVE}" = "true" ]; then \
	  	make exec ARGS="make test-dymola-interactive PACKAGE=${PACKAGE}"; \
	else \
	  	make exec ARGS="make test-dymola-batch PACKAGE=${PACKAGE} && rm -rf ~/IDEAS/IDEAS/funnel_comp"; \
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
