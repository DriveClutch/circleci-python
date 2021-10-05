#!/usr/bin/env bash

#Create tar.gz archive with all .py, .html and .htm files within the repo and list all files for fun
if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

WORKINGDIR="${CIRCLE_WORKING_DIRECTORY}"
REPONAME="${CIRCLE_PROJECT_REPONAME}"

if [[ -z "$WORKINGDIR" ]]
then
      echo "no workdir for ya"
      exit 1
fi

if [[ -z "$REPONAME" ]]
then
      echo "no reponame for ya"
      exit 1
fi

mkdir -p /tmp/archives &&
cd "$WORKINGDIR" || echo "no circle_working_directory defined" &&
print "$(find . \( -name "*.py" -o -name "*.html" -o -name "*.htm" -o -name "Pipfile.lock" \))" > "$REPONAME.txt" &&
tar czf "$REPONAME.tar.gz" -T "$REPONAME.txt" &&
rm -f "$REPONAME.txt" &&
mv "$REPONAME.tar.gz" /tmp/archives/
exit 1

export ARTIFACT="$REPONAME.tar.gz"
export ARTIFACT_ZIP_PATH="/tmp/archives/$ARTIFACT"





