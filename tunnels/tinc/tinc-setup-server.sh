#!/bin/bash
netname=tunnelsat
nodename=srv1
ip='10.6.6.1'
subnet=${ip}'/32'
interface='tun0'
nodename_public_IP='124.25.5.7'
bits=2048

mkdir -p /etc/tinc/$netname/hosts
cat <<EOF > /etc/tinc/$netname/tinc.conf
Name = $nodename
Interface = $interface
EOF

cat <<EOF > /etc/tinc/$netname/hosts/$nodename
Address = $nodename_public_IP
Subnet = $subnet
EOF
# generate the public/private keypair for this host:
tincd -n $netname -K${bits}
cat <<EOF > /etc/tinc/$netname/tinc-up
#!/bin/sh
ifconfig \$INTERFACE $ip netmask 255.255.255.0

EOF
cat <<EOF > /etc/tinc/$netname/tinc-down
#!/bin/sh
ifconfig \$INTERFACE down

EOF
chmod 755 /etc/tinc/$netname/tinc-*
