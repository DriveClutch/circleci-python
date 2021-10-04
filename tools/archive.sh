#!/usr/bin/env bash
#Create tar.gz archive with all .py, .html and .htm files within the repo and list all files for fun
if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

WORKINGDIR="${CIRCLE_WORKING_DIRECTORY}"
REPONAME="${CIRCLE_PROJECT_REPONAME}"
TEMP_DIR="/tmp/archives"
pyfiles=$(find . \( -name "*.py" -o -name "*.html" -o -name "*.htm" -o -name "Pipfile.lock" \))

cd "$WORKINGDIR" || echo "no circle_working_directory defined"
shopt -s nullglob

print "${pyfiles}" > "${REPONAME}.txt"

tar czf "${REPONAME}.tar.gz" -T "${REPONAME}.txt" && rm -f "${REPONAME}.txt"

mkdir -p "${TEMP_DIR}" && mv "${REPONAME}.tar.gz" "${TEMP_DIR}"

export ARTIFACT_ZIP_PATH="${TEMP_DIR}/${REPONAME}.tar.gz"

tar -tf "$ARTIFACT_ZIP_PATH"

echo "ARTIFACT_ZIP_PATH: $ARTIFACT_ZIP_PATH"



