#!/bin/bash
# PAT Firewall startup script
# Configures iptables NAT rules for port address translation

set -e

# Enable IP forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf

# Wait for network interfaces to be ready
sleep 10

# DNAT rules - translate external ports to internal web servers
# Port 8081 -> Blue server (10.1.1.3:80)
iptables -t nat -A PREROUTING -p tcp --dport 8081 -j DNAT --to-destination 10.1.1.3:80

# Port 8082 -> Red server (10.1.2.3:80)
iptables -t nat -A PREROUTING -p tcp --dport 8082 -j DNAT --to-destination 10.1.2.3:80

# Masquerade outgoing traffic (SNAT)
iptables -t nat -A POSTROUTING -o ens4 -j MASQUERADE
iptables -t nat -A POSTROUTING -o ens5 -j MASQUERADE

# Allow forwarding
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -p tcp --dport 80 -j ACCEPT

# Install iptables-persistent to survive reboots
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
netfilter-persistent save

echo "PAT Firewall configuration complete"
