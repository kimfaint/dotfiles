#!/bin/sh

lock() {
    #i3lock -c 222222
    #i3lock -i ~/.config/i3/lockscreen.png -t
    #dm-tool switch-to-greeter
    import -silent -window root /tmp/i3lock.png
    convert /tmp/i3lock.png -interpolate nearest -virtual-pixel mirror -spread 5 /tmp/i3lock.png
    convert /tmp/i3lock.png ~/.config/i3/i3lock-icon.png -gravity center -composite /tmp/i3lock.png
    i3lock -i /tmp/i3lock.png
    rm -f /tmp/i3lock.png
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
