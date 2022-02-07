#!/bin/sh

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL=$(printf %.0f $COLLECTD_INTERVAL)
TTY='/dev/ttyUSB2'
TMP_FILE='/tmp/collectd-Telit-LN940-wwan'
GET_DATA='/usr/share/collectd/scripts/collectd_lte_signal.sh'

$(ps | grep -q collectd_lte_signal.sh) || sh -c "$GET_DATA &"

while sleep "$INTERVAL"; do
#    v=$(echo 'AT^RFSTS?' | socat - /dev/ttyUSB2,crnl 2>/dev/null | \
#      awk -F, '/\^RFSTS\:/{getline ;print;}' | head -n 1 | sed 's/,/:/g')

    v=$(cat $TMP_FILE)

    RSRP=$(echo $v | cut -d ':' -f 3)		# RSRP
    RSSI=$(echo $v | cut -d ':' -f 4)		# RSSI
    RSRQ=$(echo $v | cut -d ':' -f 5)		# RSRQ
    SINR=$(echo $v | cut -d ':' -f 16)		# SINR
    SUM=$(echo $v | cut -d ':' -f 3,4,5,16)
    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_rsrp\" interval=${INTERVAL} N:${RSRP}"
    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_rssi\" interval=${INTERVAL} N:${RSSI}"
    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_rsrq\" interval=${INTERVAL} N:${RSRQ}"
    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_sinr\" interval=${INTERVAL} N:${SINR}"
#    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_sum\" interval=${INTERVAL} N:${SUM}"
done

