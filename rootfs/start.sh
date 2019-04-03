#!/usr/bin/env bash

# Check mount
if ! [ "$(stat -f -c '%T' '/tmp')" == 'tmpfs' ]; then
    echo "Please mount /tmp as tmpfs" >&2
    exit 1
fi

# Setup stats auth
user=${STATS_USER:-admin}
pass=${STATS_PASSWORD}
key=${PUBLISH_KEY}

if [ -z "${STATS_PASSWORD}" ]; then
    echo "No stats password set, generating a random password..."
    pass=$(dd if=/dev/urandom bs=32 status=none count=1| md5sum | cut -d' ' -f1)
fi

if [ -z "${PUBLISH_KEY}" ]; then
    echo "No publish key set, generating a random key..."
    key=$(dd if=/dev/urandom bs=32 status=none count=1| md5sum | cut -d' ' -f1)
fi

htpasswd -bc /etc/nginx/htpasswd "$user" "$pass" 2>/dev/null
sed -i "s placeholder ${key} " /etc/nginx/nginx.conf

echo "You can login to /stats using $user $pass"
echo "Publish key is ${key}"

exec nginx -g 'daemon off;'