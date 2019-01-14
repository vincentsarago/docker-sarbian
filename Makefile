
SHELL = /bin/bash
TAG = latest
ACCOUNT = remotepixel

build:
	docker build  --tag sarbian:${TAG} .


shell: build
	docker run --name sarbian  \
		--rm -it sarbian:${TAG} /bin/bash


push:
	docker build -f Dockerfile --tag sarbian:${TAG} .
	docker tag sarbian:${TAG} ${ACCOUNT}/sarbian:${TAG}
	docker push ${ACCOUNT}/sarbian:${TAG}


clean:
	docker stop sarbian
	docker rm sarbian
