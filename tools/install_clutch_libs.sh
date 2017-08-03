#!/bin/bash -e

if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

LIBDIR="clutch_python_libs"

clutch_libs_needed=$(find . -name "*requirements.txt" -print0 | xargs -0 grep -h clutch)

rm -rf ${LIBDIR}
mkdir ${LIBDIR}

for lib in $clutch_libs_needed; do
	pip download --index-url=https://${BINTRAY_USER}:${BINTRAY_PASSWORD}@driveclutch.bintray.com/clutch-python --no-deps -d $LIBDIR $lib
done
