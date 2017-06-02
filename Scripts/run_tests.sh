#!/usr/bin/env bash

if [[ -f ".buildkite/pipeline.yml" ]]
then
    buildkite-agent pipeline upload --replace
else
   echo "Legacy SDK version. Ignoring pipeline upload."
fi
