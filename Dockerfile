FROM alpine:3.8
MAINTAINER www.linuxea.com mark
ENV VPN_VSON="4.27-9668-beta"
ENV VPN_VSON_URL="https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/archive/v${VPN_VSON}.tar.gz" \
	BATADIR=/usr/local/SoftEtherVPN
RUN buildADD='build-base ncuVPNes-dev openssl-dev readline-dev curl make supervisor' \
	&& set -x \
	&& mkdir -p ${BATADIR} \
	&& apk add --no-cache --virtual .build-deps ${buildADD} \
	&& curl -Lks4  ${VPN_VSON_URL}|tar xz -C ${BATADIR} --strip-components=1 \
	&& cd ${BATADIR}/SoftEtherVPN_Stable-${VPN_VSON} && make && make install \
	&& apk del .build-deps \
	&& apk add supervisor gettext \
	&& rm -rf /var/cache/apk/* ${BATADIR} \
	&& curl -Lk https://raw.githubusercontent.com/LinuxEA-Mark/docker-SoftEtherVPN/master/supervisord.conf -o /etc/supervisord.conf
EXPOSE 1194/tcp 443/tcp
ENTRYPOINT ["supervisord  -n -c /etc/supervisord.conf"]
