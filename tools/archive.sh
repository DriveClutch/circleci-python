#!/bin/bash -e

if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

mkdir -p /tmp/archives

cd "${CIRCLE_WORKING_DIRECTORY}" || echo "no circle_working_directory defined"

for filename in $(find . \( -name "*.py" -o -name "*.html" -o -name "*.htm" -o -name "Pipfile.lock" )\); do
	print "${filename}" > "${CIRCLE_PROJECT_REPONAME}.txt"
done

tar czf "${CIRCLE_PROJECT_REPONAME}.tar.gz" -T "${CIRCLE_PROJECT_REPONAME}.txt"

rm -f "${CIRCLE_PROJECT_REPONAME}.txt"

mv "${CIRCLE_PROJECT_REPONAME}.tar.gz" /tmp/archives

export ARTIFACT="${CIRCLE_PROJECT_REPONAME}.tar.gz"
export ARTIFACT_ZIP_PATH="/tmp/archives/${CIRCLE_PROJECT_REPONAME}.tar.gz"





