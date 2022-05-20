#!/bin/ash

USER=${USER:-root}
HOME=/root

if [ "$USER" != "root" ]; then
    echo "* enable custom user: $USER"
    adduser -g "$USER" "$USER"
    if [ -z "$PASSWORD" ]; then
        echo "  set default password to \"secret\""
        PASSWORD=secret
    fi
    HOME=/home/$USER
    echo "$USER:$PASSWORD" | chpasswd
    chown -R $USER:$USER ${HOME}
fi

sed -i -e "s|%USER%|$USER|" -e "s|%HOME%|$HOME|" /etc/supervisor/conf.d/*

supervisord -c /etc/supervisord.conf -n