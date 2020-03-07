FROM debian:stable-slim

ARG USER_ID
ARG GROUP_ID

ENV HOME /home/runebase

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

RUN groupadd -g ${GROUP_ID} runebase \
	&& useradd -u ${USER_ID} -g runebase -s /bin/bash -m -d ${HOME} runebase

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates gosu \
	&& rm -rf /var/lib/apt/lists/*

# install runebase binaries
COPY /bin/runebased /usr/local/bin/
COPY /bin/runebase-cli /usr/local/bin/
COPY /bin/runebase-tx /usr/local/bin/

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["runebased"]