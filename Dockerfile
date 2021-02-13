###########################################################
# Dockerfile that builds a Valheim Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

# Valheim dedicated server app id
ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"

COPY entry.sh .

# Install Mordhau server dependencies and clean up
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		libfontconfig1=2.13.1-2 \
		libpangocairo-1.0-0=1.42.4-8~deb10u1 \
		libnss3=2:3.42.1-1+deb10u3 \
		gconf-gsettings-backend=3.2.6-5 \
		libxi6=2:1.7.9-1 \
		libxcursor1=1:1.1.15-2 \
		libxss1=1:1.2.3-1 \
		libxcomposite1=1:0.4.4-2 \
		libasound2=1.1.8-1 \
		libxdamage1=1:1.1.4-3+b3 \
		libxtst6=2:1.2.3-1 \
		libatk1.0-0=2.30.0-2 \
		libxrandr2=2:1.5.1-1 \
		libcurl3-gnutls=7.64.0-4+deb10u1 \
		libcurl4=7.64.0-4+deb10u1 \
		wget=1.20.1-1.1 \
		libsdl2-2.0 \
		libsdl2-2.0:i386 \
		ca-certificates \
		iputils-ping=3:20180629-2+deb10u1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& cp entry.sh "${HOMEDIR}/entry.sh" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" \
	&& rm -rf /var/lib/apt/lists/*



RUN	chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}"

ENV SERVER_NAME="NobodysReal" \
	SERVER_PORT="2456" \
	SERVER_WORLD="Deadworld" \
	SERVER_PASSWORD="Password1" \
	SERVER_SAVE_DIR="/data" \
	STEAMCMD_UPDATE_ARGS="" \
	ADDITIONAL_ARGS=""

# Switch to user
USER ${USER}

# Switch to workdir
WORKDIR ${HOMEDIR}

VOLUME ${STEAMAPPDIR}

CMD ["bash", "entry.sh"] 

# Expose ports
EXPOSE $SERVER_PORT/udp \
		2457/udp \
		2458/udp

