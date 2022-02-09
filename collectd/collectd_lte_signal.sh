#!/bin/sh

INTERVAL=15
TTY='/dev/ttyUSB2'
TMP_FILE='/tmp/collectd-Telit-LN940-wwan'

get_info() {
    v=$(echo 'AT^RFSTS?' | socat - ${TTY},crnl 2>/dev/null | \
      awk -F, '/\^RFSTS\:/{getline ;print;}' | head -n 1 | sed 's/,/:/g')
}

while sleep "$INTERVAL"; do
    get_info
    echo $v
    n=0
    if ! $(echo $v | grep -q '.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*'); then
        until [ "$n" -ge 4 ] || $(echo $v | grep -q '.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*:.*'); do
            let n++
            get_info
            sleep 2
        done
        echo $v > $TMP_FILE
    else
        echo $v > $TMP_FILE
	logger -p local0.err -t collectd.exec -s "No response from modem"
    fi
done

