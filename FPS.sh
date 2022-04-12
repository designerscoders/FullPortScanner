green=`tput setaf 2`
yellow=`tput setaf 3`
red=`tput setaf 1`
blue=`tput setaf 4`
magenta=`tput setaf 5`
cyan=`tput setaf 6`
white=`tput setaf 7`
bold=`tput bold`
normal=`tput sgr0`
ORANGE='\033[0;33m'
filename=$1

echo ""

printf "${green}${bold}"
figlet -w 250 -f slant "FullPortScanner"
echo -e "${normal}${yellow}A Bash Script to scan list of hosts for open ports using masscan and runninng nmap on those ports to identify running services by @k4k4r07 (https://twitter.com/k4k4r07)"
echo ""
echo ""
rm temp.txt results.txt nmapResults.txt ipAddressList.txt openPorts.xml 2> /dev/null

function runNmap(){
	echo "" | tee -a results.txt
	printf "${ORANGE}${bold}"
	echo "Nmap Results for IP: $ip" | tee -a results.txt
	echo "" | tee -a results.txt
	ip=$1
	ports=$2
	sudo nmap -sS -sV $ip -p $ports -T5 > temp.txt
	cat temp.txt | grep -e PORT -e open -e filtered > nmapResults.txt
	cat nmapResults.txt | tee -a results.txt
	echo "" | tee -a results.txt
}

function runMasscan(){
	domain=$1
	while read line;do
		ip=$line
		printf "${cyan}${bold}"
		echo "Scanning Results for $ip" | tee -a results.txt
		sudo /home/k4k4r07/BugBounty/Tools/masscan/bin/masscan -p1-65535 $line --rate 1800 -oX openPorts.xml 2> /dev/null
		echo "" | tee -a results.txt
		ports=$(python3 parseMasscanResult.py)
		echo "Open ports for IP: $ip are $ports as per masscan" | tee -a results.txt

		runNmap $ip $ports
	done < ipAddressList.txt
}

function scanDomain(){
	domain=$1
	printf "${green}${bold}"
	echo "Domain Name: $domain" | tee -a results.txt
	echo "" | tee -a results.txt
	echo "IPv4 Addresses $domain resolves to are: " | tee -a results.txt
	printf "${red}${bold}"
	echo "" | tee -a results.txt
	hostInfo=$(host $line)
	successCode=$(echo $?)
	if [ $successCode -eq 0 ]; then
		ipAddresses=$(echo "$hostInfo" | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
    fi
	echo $ipAddresses | tr " " "\n" > ipAddressList.txt
	cat ipAddressList.txt | tee -a results.txt
	echo "" | tee -a results.txt
	runMasscan $domain
}


function main(){
	while read line;do
		domain=$line
		scanDomain "$domain"
	done < $filename
}

main
