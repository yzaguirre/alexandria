#!/bin/bash
netname=dvdnet
nodeserver=ec2dvd
serverssh=ec2dvd
thisnode=cb64
scp /etc/tinc/$netname/hosts/$thisnode $serverssh:.
scp $serverssh:/etc/tinc/$netname/hosts/$nodeserver .
sudo mv $nodeserver /etc/tinc/$netname/hosts/
ssh $serverssh "sudo mv $thisnode /etc/tinc/$netname/hosts/"
