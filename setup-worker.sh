#!/bin/bash
#
# FYI
#  - https://forums.raspberrypi.com/viewtopic.php?t=237195
#  - https://forums.raspberrypi.com/viewtopic.php?t=210310
#  - /etc/dhcp/dhcpd.conf -> configure subnets and stuff
#  - /etc/network/interfaces.d/dns-eth1 -> configure network interfaces
#  - /etc/default/isc-dhcp-server -> dhcp server config

sudo echo "auto eth1
iface eth1 inet static
    address 10.10.1.1
    netmask 255.255.255.0" > /etc/network/interfaces.d/dns-eth1

sudo systemctl restart networking
sudo systemctl restart systemd-networkd


sudo apt update
sudo apt install isc-dhcp-server
sudo echo "INTERFACESv4=\"eth1\"" > /etc/default/isc-dhcp-server
sudo echo "subnet 10.10.1.0 netmask 255.255.255.0 {
        range 10.10.1.100 10.10.1.200;
        option routers 10.10.1.1;
        option domain-name-servers 8.8.8.8, 8.8.4.4;
        interface eth1;
}" > /etc/dhcp/dhcpd.conf

sudo systemctl start isc-dhcp-server.service 