# collectd-Telit-LN940-wwan

This package collects mobile signal statistics with collectd on OpenWrt v21.02. 

## Hardware and Firmware
### Hardware
- Sony NCP-HG100/Cellular
### Firmware
OpenWrt 21.0.1
- nginx
- nginx-mod-luci
- nginx-ssl
- collectd
- collectd-mod-lua
- collectd-mod-nginx
- collectd-mod-rrdtool
- nginx-ssl-util
- nginx-util
- luci-nginx
- luci-app-statistics
- nginx-mod-luci
- uwsgi-luci-support

## Usage
1. Install OpenWrt packages: `collectd-mod-exec`, `collectd-mod-rrdtool` and `socat`
2. Create a directory: `/usr/share/collectd/scripts`
3. Copy `collect.sh` and `collectd_lte_signal.sh` to `/usr/share/collectd/scripts` and run `chmod +x /usr/share/collectd/scripts/*`
4. Edit `/usr/share/collectd/types.db` and add:
```
mobile_signal_rsrp	value:GAUGE:U:U
mobile_signal_rssi	value:GAUGE:U:U
mobile_signal_rsrq	value:GAUGE:U:U
mobile_signal_sinr	value:GAUGE:U:U
```
2. In the web interface, go to Statistics -> Setup -> General plugins -> Exec
   and add a command. Script is `/usr/share/collectd/scripts/collect.sh`, user
   is `network`, and group is `dialout`
3. Visualise the data. This can be done by installing the `exec.js` script in
    `/www/luci-static/resources/statistics/rrdtool/definitions/exec.js`
