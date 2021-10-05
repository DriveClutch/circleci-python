#!/bin/bash -e

set -euo pipefail

mkdir -p /tmp/archives

cd "${CIRCLE_WORKING_DIRECTORY}" || echo "no circle_working_directory defined"

filename="$(find . \( -name "*.py" -o -name "*.html" -o -name "*.htm" -o -name "Pipfile.lock" \))"

print "${filename}" > "${CIRCLE_PROJECT_REPONAME}".txt

tar czf "${CIRCLE_PROJECT_REPONAME}".tar.gz -T "${CIRCLE_PROJECT_REPONAME}".txt

rm -f "${CIRCLE_PROJECT_REPONAME}".txt

mv "${CIRCLE_PROJECT_REPONAME}".tar.gz /tmp/archives
#
#export ARTIFACT="${CIRCLE_PROJECT_REPONAME}.tar.gz"
#export ARTIFACT_ZIP_PATH="/tmp/archives/${CIRCLE_PROJECT_REPONAME}.tar.gz"





