#!/bin/bash

set -e

docs_path=$(dirname "$(dirname "$(realpath $0)")")

cd $docs_path

# Building image

if [ ! "$(docker images --filter=reference="poc/docs" -q)" ]; then
    echo "Building PoC docs"
    docker build --force-rm -q -t poc/docs .
fi

# Starting docs container

if [ ! "$(docker ps -q -f name=mkdocs)" ]; then
    echo "Starting PoC docs"
    if [ "$(docker ps -aq -f status=exited -f name=mkdocs)" ]; then
        docker start mkdocs
    else
        docker run -d --name mkdocs -p 8000:8000 -v $docs_path:/docs poc/docs
    fi

    echo "PoC docs ready! Access: http://localhost:8000"
else
    echo "Stopping PoC docs"
    docker stop mkdocs
    docker rm mkdocs
fi