#!/bin/bash

basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo BaseDir is $basedir

docker build -t terrafromansible ./src
docker run -v "$basedir/src":/src -t terrafromansible /src/Deploy.sh