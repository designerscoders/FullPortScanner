# FullPortScanner

A Bash Script to scan list of hosts for open ports using masscan and runninng nmap on those ports to identify running services by @k4k4r07 (https://twitter.com/k4k4r07). The script scans all the TCP ports but can be changed accordingly by editing the masscan command on line 41.

# Prerequisite

```
1) Installed masscan (https://github.com/robertdavidgraham/masscan)
2) Installed filget  ( sudo apt install figlet )
3) Installed nmap (sudo apt install nmap)
3) Change the line 41 to your masscan binary path
```
# Usage
```
sudo bash FPS.sh /path/to/list/of/domains.txt
```
After completion check results.txt for complete scan results
