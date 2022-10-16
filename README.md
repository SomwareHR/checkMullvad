# checkMullvad

Bash script for checking if Mullvad connection is active; if not - downs and ups WireGuard NIC. If connection is down, a log is written in `~/z-checkMullvad.log`

Script is short and self-explanatory. It uses [Mullvad's API](https://mullvad.net/en/check/) (see API) requests, "Connected" or "JSON". Currently, "Connected" method is used. Method "JSON" is in the script, just change order to make it active instead. Or do whatever you want with script, I'm not the boss of you ;)



# Prerequisites

+ Linux
+ Wireguard
+ Mullvad account



# CRONTAB

You can set Crontab to check every 5 minutes

```bash
*/5 * * * * sudo /root/checkMullvad.sh
```




# Wireguard killswitch

Edit `/etc/wireguard/wg0.conf` and add PostUp and PreDown lines:

```ini
[Interface]
 <...somethingsomething...>
PostUp  = iptables -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -I OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
PreDown = iptables -D OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT && ip6tables -D OUTPUT ! -o %i -m mark ! --mark $(wg show %i fwmark) -m addrtype ! --dst-type LOCAL -j REJECT
[Peer]
 <...somethingsomething...>
```



###### checkMullvad.sh ... (C)2022 SomwareHR ... License: MIT ... SWID#2022101610210901
