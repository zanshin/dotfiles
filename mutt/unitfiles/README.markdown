# Service Setup

Copy the `checkmail.service` file to `~/.config/systemd/user`
Copy the `checkmail.timer` file to `~/.config/systemd/user`

# Starting, Stoping, Status

    systemctl --user enable checkmail.service
    systemctl --user enable checkmail.timer
    systemctl --user start checkmail.timer
    systemctl --user status checkmail.timer
    systemctl --user list-timers
