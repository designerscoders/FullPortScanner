figlet "FPS"
filename=$1
count=$(cat $filename | wc -l)
echo -e "\e[31m\e[1mDomains count $count \n"
echo -e "\e[32m\e[1mCollecting IPs \n"
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
echo -e "\e[31m\e[1mIPs Collected Successfully \n"
cat ip.txt
echo ""
echo -e "\e[33m\e[1mRunning PORT Scans on collected IPS \n"
while read line;do
        echo -e "\e[33m\e[1mCurrent IP Scanned $line \n"
        sudo /path/to/masscan/binary -p1-65535,U:1-65535 $line --rate 1800
done < ip.txt
