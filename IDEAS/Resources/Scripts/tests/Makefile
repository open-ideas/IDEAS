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
	docker stop ${IMG_NAME} > /dev/null 2>&1 || true

# Command to remove potentially missing files in funnel_comp from the default working directory (_work)
cleanup:
	make stop
	rm -rf /home/actions-runner/_work/IDEAS/IDEAS/IDEAS/funnel_comp > /dev/null 2>&1 || true

exec-interactive:
	docker exec \
		-it \
		${IMG_NAME} \
		/bin/bash -c "${ARGS} && exit"

exec-batch:
	docker exec \
		-t \
		${IMG_NAME} \
		/bin/bash -c "${ARGS} && exit"

# Set interactive as the default case to activate the testing container
# INTERACTIVE=true (default) should be used to run tests locally
# INTERACTIVE=false should be used to run tests in the server
INTERACTIVE=true

test-dymola:
	echo "Activating container for testing."
	make run-detached
	if [ "${INTERACTIVE}" = "true" ]; then \
	  	make exec-interactive ARGS="make test-dymola-interactive PACKAGE=${PACKAGE}"; \
	else \
	  	make exec-batch ARGS="make test-dymola-batch PACKAGE=${PACKAGE} && rm -rf ~/IDEAS/IDEAS/funnel_comp"; \
	fi;
	cd ../../../ && cat failed-simulator-dymola.log
	make stop

test-dymola-interactive:
	cd ${ROOT}/IDEAS && \
	  	python3 ../bin/runUnitTests.py \
	  		--tool dymola \
	  		--single-package ${PACKAGE}

test-dymola-batch:
	make cleanup
	cd ${ROOT}/IDEAS && \
	  	python3 ../bin/runUnitTests.py \
	  		--tool dymola \
	  		--single-package ${PACKAGE} \
	  		--batch