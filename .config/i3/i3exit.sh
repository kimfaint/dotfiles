#!/bin/sh

lock() {
    #i3lock -c 222222
    #i3lock -i ~/.config/i3/lockscreen.png -t
    dm-tool switch-to-greeter
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && systemctl supend -i
        #systemctl suspend -i
        ;;
    hibernate)
        lock && systemctl hibernate -i
        #systemctl hibernate -i
        ;;
    reboot)
        systemctl reboot
        ;;
    shutdown)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
        exit 2
esac

exit 0
