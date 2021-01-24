#!/usr/bin/env bash
#
# Author: Bhaskar K C

_sha256() {
    echo 'Q' \
        | openssl s_client \
        -connect globalprotect.domain.com.au:443 \
        2> /dev/null \
        | openssl x509 -pubkey -noout \
        | openssl pkey -pubin -outform der \
        | openssl dgst -sha256 -binary \
        | openssl enc -base64
}


gvpn() {
    echo -n "${PASSWORD}" \
    | openconnect --protocol=gp "${SERVER}" \
    --servercert pin-sha256:"$(_sha256)" \
    --user="${USER}" -b && echo "Connected!"\
    && sleep 5 &&
    iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE &&
    iptables -A FORWARD -i eth0 -j ACCEPT &&
    /bin/bash
}

gvpn
