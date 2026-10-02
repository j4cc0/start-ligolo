#!/bin/bash

DEV="ligolo"
MYLIGOLO="/root/bin/ligolo"

[ "x$(id -u)x" = "x0x" ] || \
        { echo "Rootly powers required to run this baby! Byebye" >&2; exit 1; }


ip link delete "$DEV" &>/dev/null
ip tuntap add user $(id -un) mode tun "$DEV"
ip link set "$DEV" up
ip route add 240.0.0.1/32 dev "$DEV"

cat <<-___EOF___
        [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+]
        [+]                                                                                     [+]
        [+] 1. Start the agent like this: './agent.exe -ignore-cert -connect <IPADDR>:11601'    [+]
        [+] 2. As soon as the agents connects, run 'session', followed by 'start'               [+]
        [+] 3. If that succeeds, you can reach the remote host: 'nmap -sV 240.0.0.1'            [+]
        [+]                                                                                     [+]
        [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+] [+]

___EOF___

${MYLIGOLO:-ligolo-proxy} -selfcert
