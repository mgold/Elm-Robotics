#!/bin/bash

elm --make --only-js "$1" && \
cat `elm --get-runtime` `echo "build/$1" | sed "s/elm$/js/"` portHandlers.js \
> `echo "$1" | sed "s/.elm$/_pi.js/"`

