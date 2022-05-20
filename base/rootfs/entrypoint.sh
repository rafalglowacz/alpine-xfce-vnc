#!/bin/ash

USER=${USER:-root}

if [ "$USER" != "root" ]; then
    echo "* enable custom user: $USER"
    adduser "$USER"
    if [ -z "$PASSWORD" ]; then
        echo "  set default password to \"secret\""
        PASSWORD=secret
    fi
    HOME=/home/$USER
    echo "$USER:$PASSWORD" | chpasswd
    chown -R $USER:$USER ${HOME}
fi

supervisord -c /etc/supervisord.conf -n