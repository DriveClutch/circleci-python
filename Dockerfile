FROM python:3.10.5

RUN apt-get update \
    && apt-get install -y \
	     openssh-client \
		 ca-certificates \
		 tar \
		 gzip \
#		 python-pip \
         lsb-release \
    && export DOCKER_VERSION=$(curl --silent --fail --retry 3 https://download.docker.com/linux/static/stable/x86_64/ | grep -o -e 'docker-[.0-9]*-ce\.tgz' | sort -r | head -n 1) \
    && DOCKER_URL="https://download.docker.com/linux/static/stable/x86_64/${DOCKER_VERSION}" \
	&& echo Docker URL: $DOCKER_URL \
	&& curl --silent --show-error --location --fail --retry 3 --output /tmp/docker.tgz "${DOCKER_URL}" \
	&& ls -lha /tmp/docker.tgz \
	&& tar -xz -C /tmp -f /tmp/docker.tgz \
	&& mv /tmp/docker/* /usr/bin \
	&& rm -rf /tmp/docker /tmp/docker.tgz linux-amd64 \
	&& /usr/local/bin/python -m pip install --upgrade pip \
	&& pip install --upgrade awscli \
	&& pip install pipenv \
    && echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release -c -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
    && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && apt-get update \
    && apt-get install -y google-cloud-sdk kubectl \
	&& pip install nose \
    && apt-get install -y shellcheck bats

COPY tools/* /tools/
