#!/bin/bash
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "{
\"branch\": \"$GIT_BRANCH\"
}"