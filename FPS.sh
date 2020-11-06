figlet "FPS"
filename=$1
count=$(cat $filename | wc -l)
echo "\e[31m\e[1mDomains count $count \n"
echo "\e[32m\e[1mCollecting IPs \n"
while read line;do
	info=$(host $line)
	code=$(echo $?)
	if [ $code -eq 0 ]; then
                ip=$(echo "$info" | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
		echo "$ip" >> temp.txt
        fi
done < $filename
sort temp.txt | uniq > ip.txt
rm temp.txt
echo "\e[31m\e[1mIPs Collected Successfully \n"
cat ip.txt
echo ""
echo "\e[33m\e[1mRunning PORT Scans on collected IPS \n"
while read line;do
	echo ""
	echo "\e[33m\e[1mCurrent IP Scanned $line \n"
	sudo /home/k4k4r07/BugBounty/Tools/masscan/bin/masscan -p1-65535,U:1-65535 $line --rate 1800 -oG result.txt
	cat result.txt >> output.txt
done < ip.txt
rm result.txt
rm ip.txt

echo "\e[32m\e[1mOutput Saved in output.txt \n"
