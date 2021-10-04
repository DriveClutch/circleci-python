#!/usr/bin/env bash

#Create tar.gz archive with all .py, .html and .htm files within the repo and list all files for fun
#if [[ -f ".circleci/debuglog" ]]; then
#	set -x
#fi

WORKINGDIR="${CIRCLE_WORKING_DIRECTORY}"
REPONAME="${CIRCLE_PROJECT_REPONAME}"

if [[ -z "$WORKINGDIR" ]]
then
      echo "\$CIRCLE_CIRCLE_WORKING_DIRECTORY is empty"
      exit 1
fi

if [[ -z "$REPONAME" ]]
then
      echo "\$CIRCLE_PROJECT_REPONAME is empty"
      exit 1
fi

mkdir -p /tmp/archives
export TEMP_DIR="/tmp/archives"

cd "$WORKINGDIR" || echo "no circle_working_directory defined"
#shopt -s nullglob
FILES=$(find . \( -name "*.py" -o -name "*.html" -o -name "*.htm" -o -name "Pipfile.lock" \))
print "$FILES" > "$REPONAME.txt"

tar czf "$REPONAME.tar.gz" -T "$REPONAME.txt"
rm -f "$REPONAME.txt"
mv "$REPONAME.tar.gz" "$TEMP_DIR"
export ARTIFACT_ZIP_PATH="$TEMP_DIR/$REPONAME.tar.gz"
tar -tf "$ARTIFACT_ZIP_PATH"

echo "TEMP_DIR: $TEMP_DIR"
echo "ARTIFACT_ZIP_PATH: $ARTIFACT_ZIP_PATH"
echo "WORKINGDIR: $WORKINGDIR"




