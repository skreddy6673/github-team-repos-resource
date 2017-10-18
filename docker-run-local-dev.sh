#!/bin/bash

docker run \
	--rm \
	-it \
	-v ${PWD}/assets:/opt/resource \
	pivotalservices/github-team-repos-resource:1.0 \
	/bin/bash
