#!/bin/bash -e

if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

# Check if there is a build.sh in the repo and exec
if [[ -x "tools/build.sh" ]]; then
	tools/build.sh
	exit $?
fi

/tools/install_clutch_libs.sh
/tools/install_deps.sh
