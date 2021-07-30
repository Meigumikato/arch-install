#! /usr/bin/env bash

sudo pacman -S xorg-server xorg-xinit xorg-xbacklight xorg-xrandr xdotool \
               google-chrome \
               netease-cloud-music \
               i3lock \
               python-pywal \
               networkmanager-dmenu networkmanager \
               calc \
               mpd \
               libinput xf86-input-libinput \
               libinput-gestures \
               wmctl xdotool \
               scrot \
               xorg-xbacklight light \
               exo pulseaudio 

# shell 

sudo pacman -S oh-my-zsh-git 

# create pulseaudio systemd conf to start as daemon
sudo cat > /etc/systemd/system/pulseaudio.service << EOF 
[Unit]
Description=Sound Service

[Service]
# Note that notify will only work if --daemonize=no
Type=notify
ExecStart=/usr/bin/pulseaudio --daemonize=no --exit-idle-time=-1 --disallow-exit=true
Restart=always

[Install]
WantedBy=default.target
EOF
# systemd pulseaudio
systemctl enable --now pulseaudio
systemctl --global mask pulseaudio.socket

# mpd 


