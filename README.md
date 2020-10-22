# FullPortScanner

A port scanner bash script which converts list of domains to IP addresses and then scan those IPs for open ports using masscan. The script scans all the ports (TCP/UDP) but can be changed accordingly by edited the masscan command on line 22.

# Prerequisite

```
1) Installed masscan (https://github.com/robertdavidgraham/masscan)
2) Installed filget  ( sudo apt install figlet )
3) Change the line 22 to your masscan binary path
4) Run script as root
```
# Usage
```
sudo su
./FPS.sh /path/to/list/of/domains.txt
```

