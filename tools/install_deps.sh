#!/bin/bash -e

if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

for reqfile in $(find . -name "*requirements.txt"); do
	pip install -r ${reqfile}
done
