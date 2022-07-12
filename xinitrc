# wallpaper
bash $HOME/.fehbg

# monitors
sh ~/.screenlayout/monitor.sh &

# notifications
/usr/bin/dunst &

# polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# picom
picom -I 1 -O 1 -e 1 &

# i3
exec dbus-launch i3
