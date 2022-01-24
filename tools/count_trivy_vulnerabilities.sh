#!/bin/bash -e

if [[ -f ".circleci/debuglog" ]]; then
	set -x
fi

critical=0;
high=0;
medium=0;

sev=$(cat /tmp/archives/trivy_report.json | jq '.Results[]?.Vulnerabilities[]?.Severity?' | sed 's/"//g') 2> /dev/null

for a in $sev;
do
	 if [[ "$a" == *"CRITICAL"* ]]; then
		 critical=$((critical+1));
	 elif [[ "$a" == *"HIGH"* ]]; then
		 high=$((high+1));
	 else
		 medium=$((medium+1))
	 fi
done

echo -e "Trivy detected vulnerabilities in docker image.............!\n"
echo -e "CRITICAL = $critical\n"
echo -e "HIGH = $high\n"
echo -e "MEDIUM = $medium\n"