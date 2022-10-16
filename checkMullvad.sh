#!/bin/bash
PATH="${PATH}:/usr/bin"



# METHOD 1 - "Connected" ------------------------------------------------------------------------------------------------------------------------------------------------------
checkMullvad=`curl --silent https://am.i.mullvad.net/connected`
# "You are connected to Mullvad (server <%MullvadServer%>). Your IP address is <%IPaddress%>"
# "You are not connected to Mullvad. Your IP address is <%IPaddress%>"
if [[ "$checkMullvad" =~ "not connected" ]]; then
  echo `date` "Not connected - method 1" | tee --append ~/z-checkMullvad.log
  wg-quick down wg0
  sleep 1
  wq-quick up wg0	# /etc/wireguard/wg0.conf
fi
exit $?



# METHOD 2 - "JSON" ------------------------------------------------------------------------------------------------------------------------------------------------------
checkMullvad=`curl --silent https://am.i.mullvad.net/json`
# "mullvad_exit_ip":true
# "mullvad_exit_ip":false
if [[ "$checkMullvad" =~ "\"mullvad_exit_ip\":false" ]]; then
  echo `date` "Not connected - method 2" | tee --append ~/z-checkMullvad.log
  wg-quick down wg0
  sleep 1
  wq-quick up wg0	# /etc/wireguard/wg0.conf
fi
exit $?
