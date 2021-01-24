FROM alpine:3.13

LABEL Maintainer="Bhaskar KC <xlinkerz@gmai.com>"
LABEL Description="Alipne linux based openconnect."

RUN apk --no-cache add bash openconnect openssl

COPY scripts/entrypoint.sh /tmp/

RUN chmod +x /tmp/entrypoint.sh

WORKDIR /tmp

CMD ["/bin/bash", "/tmp/entrypoint.sh"]
