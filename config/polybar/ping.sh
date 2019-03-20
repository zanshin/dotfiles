
#!/bin/sh

# HOST=5.1.92.157
HOST=8.8.8.8

if ! ping=$(ping -n -c 1 -W 1 $HOST); then
    echo "# ping failed"
else
    rtt=$(echo "$ping" | sed -rn 's/.*time=([0-9]{1,})\.?[0-9]{0,} ms.*/\1/p')

    if [ "$rtt" -lt 50 ]; then
        icon="%{F#3cb703}#%{F-}"
    elif [ "$rtt" -lt 150 ]; then
        icon="%{F#f9dd04}#%{F-}"
    else
        icon="%{F#d60606}#%{F-}"
    fi

    echo "$icon $rtt ms"
fi
<Paste>
