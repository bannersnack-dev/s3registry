#!/usr/bin/env bash

echo 'LOGIN:'
docker login -u bannersnack

echo 'BUILDING THE DOCKER IMAGE:'
docker build -f Dockerfile -t bannersnack/s3registry:latest .

echo 'PUSHING TO THE REGISTRY:'
docker push bannersnack/s3registry:latest

echo 'all done. '
