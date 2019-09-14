#!/bin/bash -e

echo -n "Do you want to install Startup sound? [y/N] "
read REPLY
if [[ ! "$REPLY" =~ ^(yes|y|Y)$ ]]; then exit 0; fi

mkdir -p /usr/local/share/sounds/win95/sound
if [ ! -f /usr/local/share/sounds/win95/sound/startup.ogg ]; then
    curl -so /usr/local/share/sounds/win95/sound/startup.ogg https://raw.githubusercontent.com/NivxB/rpi-audio-receiver/master/sound/win95.ogg
fi
if [ ! -f /usr/local/share/sounds/WoodenBeaver/stereo/device-removed.ogg ]; then
    curl -so /usr/local/share/sounds/WoodenBeaver/stereo/device-removed.ogg https://raw.githubusercontent.com/madsrh/WoodenBeaver/master/WoodenBeaver/stereo/device-removed.ogg
fi

cat <<'EOF' > /etc/systemd/system/startup-sound.service
[Unit]
Description=Startup sound
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/ogg123 -q /usr/local/share/sounds/win95/sound/startup.ogg

[Install]
WantedBy=multi-user.target
EOF
systemctl enable startup-sound.service
