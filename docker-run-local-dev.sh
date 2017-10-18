#!/bin/bash

docker run \
	--rm \
	-it \
	-v ${PWD}/assets:/opt/resource \
	maliksalman/github-team-repos-resource:1.0 \
    /bin/bash