#!/bin/bash
netname=tunnelsat
nodename=client1
ip='10.6.6.2'
subnet=${ip}'/32'
interface='tun0'
connectto=srv1
bits=2048

echo $netname >> /etc/tinc/nets.boot
mkdir -p /etc/tinc/$netname/hosts
cat <<EOF > /etc/tinc/$netname/tinc.conf
Name = $nodename
Interface = $interface
ConnectTo = $connectto
EOF
cat <<EOF > /etc/tinc/$netname/hosts/$nodename
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
cat <<EOF > /etc/tinc/$netname/hosts/$connectto
Address = 7.6.2.18
Subnet = 10.0.0.0/24

-----BEGIN RSA PUBLIC KEY-----
MIIBCgKCAQEA4LDCjV/2sQ12D4mVMKJS737zikb7Sb8GF4W+QDlYuxhJoHtfWVR8
TbmeqxOiBJaO+SZsZ2Iy9C63Ubt3wO5WfiVMQ896OwFVaDNA4GxNBRyyYJ0I5eNb
kVuSXN/av9uK0ytPYcVpG9XM8BHAjFQXrvi2Qnht+OBVrbo5Z2oJY1wZSjEkdcZv
5OLyO/r1r2BPrW2C9CvmgkfmpwCXZaFcXEkCfkaCR3pa2WqKEdKuO4oAp0yH7NkP
EhLG5FvqnGwyqW3E08ff0MO7YfyBkl95bsYgz3Xw+JRbnIFxMNWDxvVlBABd4sRD
4yac3dwbqMb06xN/VrmO6NzJe2cM46b7dQIDAQAB
-----END RSA PUBLIC KEY-----
EOF

echo "Pub key for '$nodename' is"
echo
cat /etc/tinc/$netname/hosts/$nodename
