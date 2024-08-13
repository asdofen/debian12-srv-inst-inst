#!/bin/bash

echo "::: Changing sources :::"

mv /etc/apt/sources.list /etc/apt/sources.list.bak
touch /etc/apt/sources.list

cat << EOF > /etc/apt/sources.list
deb http://deb.debian.org/debian bookworm main non-free-firmware
deb-src http://deb.debian.org/debian bookworm main non-free-firmware

deb http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware
deb-src http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware

deb http://deb.debian.org/debian bookworm-updates main non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware
EOF

echo "::: Sources changed :::"


echo ::: Turning off Sleep, Hibernate, and Suspend :::

systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target


echo ::: Installing some necessary apps :::

apt update && apt -y upgrade
apt install -y samba tightvncserver dbus-x11 lxqt pivpn cockpit-client nginx speedtest-cli cbm firefox


echo "::: Script done! :::"
