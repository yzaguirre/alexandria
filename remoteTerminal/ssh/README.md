# SSH all you need to know
OpenSSH tools
OpenSSH available for Windows! Better late than never :P

## Create Keypair
```bash
ssh-keygen -t rsa -b 4096
```
You'll be asked to enter a passphrase. Enter a secure passphrase

Make sure the ssh-agent is running
```bash
eval "$(ssh-agent -s)"
```
Add ssh priv key to ssh-agent
```bash
ssh-add ~/.ssh/id_rsa
```

Add your public key to a server
```bash
ssh-copy-id -i ~/.ssh/id_rsa user@server
```
Or print, copy and past to a Git server
```
cat ~/.ssh/id_rsa 
```
