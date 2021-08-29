#!/bin/bash

basedir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo BaseDir is $basedir

docker run -v "$basedir/src":/src -it terrafromansible /src/Destroy.sh