FROM alpine
MAINTAINER jasonfhill

RUN apk add --update --no-cache \
    unbound \
    curl \
    ca-certificates \
    s6 \
    && curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.cache

COPY files/root/ /

RUN chmod a+x /service/*/run

EXPOSE 53/udp 53/tcp

# Manage with s6
ENTRYPOINT ["/bin/s6-svscan","/service"]
