FROM alpine:3.8
MAINTAINER www.linuxea.com mark
ENV VPN_VSON="4.27-9668-beta"
ENV VPN_VSON_URL="https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/archive/v${VPN_VSON}.tar.gz" \
	BATADIR=/usr/local/SoftEtherVPN
RUN set -x \
	&& mkdir -p ${BATADIR} \
	&& apk --update add --virtual .BUILD_PASS -U build-base ncurses-dev openssl-dev readline-dev \
	&& apk add curl \
	&& echo -e "\033[32mstart install SoftEtherVPN_Stable\033[0m" \
	&& curl -Lks4  ${VPN_VSON_URL}|tar xz -C ${BATADIR} --strip-components=1 \
	&& cd ${BATADIR} && ./configure && make && make install \
	&& apk add supervisor gettext \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/supervisord.conf -o /etc/supervisord.conf \
	&& apk del .BUILD_PASS curl \
	&& runDev="$( \
		scanelf --needed --nobanner /usr/bin/vpnserver \
			| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
			|sort -u \
			| xargs -r  apk info --installed \
			|sort -u \
			)" \
        && apk add ${runDev} \
	&& apk add readline openssl \
	&& rm -rf /var/cache/apk/* ${BATADIR} \
	&& echo -e '#!/bin/sh\nsupervisord  -n -c /etc/supervisord.conf' >> /start.sh \
	&& chmod +x /start.sh
EXPOSE 1194/tcp 443/tcp
ENTRYPOINT ["/start.sh"]
