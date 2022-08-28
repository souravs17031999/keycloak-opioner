# syntax=docker/dockerfile:1

FROM alpine:3.16.2

ARG KEYCLOAK_VERSION=19.0.1
ENV KEYCLOAK_VERSION=${KEYCLOAK_VERSION}

RUN apk --no-cache add curl \
    && curl -k -LO --output-dir /tmp/ "https://github.com/keycloak/keycloak/releases/download/${KEYCLOAK_VERSION}/keycloak-${KEYCLOAK_VERSION}.tar.gz" \
    && tar -xzvf /tmp/keycloak-${KEYCLOAK_VERSION}.tar.gz --strip-components=1 -C /opt/

RUN apk add --no-cache --upgrade bash \ 
    && apk add --no-cache postgresql-client \
    && apk --no-cache add openjdk11 --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

COPY env.sh wait-for-db-server.sh build-keycloak.sh docker-entrypoint.sh /

COPY server.keystore keycloak.conf /opt/

RUN bash /build-keycloak.sh

ENTRYPOINT ["sh", "/docker-entrypoint.sh"]