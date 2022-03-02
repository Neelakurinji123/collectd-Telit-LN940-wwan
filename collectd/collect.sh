#!/bin/sh

#HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
#INTERVAL=$(printf %.0f $COLLECTD_INTERVAL)

HOSTNAME="${COLLECTD_HOSTNAME:-localhost}"
INTERVAL="${COLLECTD_INTERVAL:-60}"
TTY='/dev/ttyUSB2'
TMP_FILE='/tmp/collectd-Telit-LN940-wwan'
SCRIPT_PATH='/usr/libexec/collectd/'
SCRIPT='collectd_lte_signal.sh'

#[ -z "$(ps | grep -v grep | grep $SCRIPT)" ] && sh -c "$SCRIPT_PATH$SCRIPT &"
flock -n /var/${SCRIPT%.sh}.lock -c "sh $SCRIPT_PATH$SCRIPT &"


while sleep "$INTERVAL"; do
#    v=$(echo 'AT^RFSTS?' | socat - /dev/ttyUSB2,crnl 2>/dev/null | \
#      awk -F, '/\^RFSTS\:/{getline ;print;}' | head -n 1 | sed 's/,/:/g')

    RSRP=$(cat $TMP_FILE | cut -d ':' -f 3)           # RSRP
    RSSI=$(cat $TMP_FILE | cut -d ':' -f 4)           # RSSI
    RSRQ=$(cat $TMP_FILE | cut -d ':' -f 5)           # RSRQ
    SINR=$(cat $TMP_FILE | cut -d ':' -f 16)          # SINR

    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_rsrp\" interval=${INTERVAL} N:${RSRP}"
    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_rssi\" interval=${INTERVAL} N:${RSSI}"
    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_rsrq\" interval=${INTERVAL} N:${RSRQ}"
    echo "PUTVAL \"${HOSTNAME}/exec-Telit-LN940-wwan/mobile_signal_sinr\" interval=${INTERVAL} N:${SINR}"
done

