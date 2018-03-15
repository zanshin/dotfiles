# Service Setup

Copy the `checkmail.service` and `checkmail.timer` files to `~/.config/systemd/user`.

# Enable, Start, Stop, Status, and List

    systemctl --user enable checkmail.service
    systemctl --user enable checkmail.timer
    systemctl --user start checkmail.timer
    systemctl --user status checkmail.timer
    systemctl --user list-timers
