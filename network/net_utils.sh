#check port status
port=21
hostA=localhost
case $1 in
	map) #which ports are mapped
		nmap $hostA
		curl $hostA:$port
	;;
	port) #connect to port
		telnet $hostA $port
		curl -v telnet://$hostA:$port
		netcat -p $port -w 5 $hostA 42
		nc -zv $hostA $port
	;;
	proc) #process on port
		lsof -i :$port
		nstat -tln | grep $port
		netstat -ntpl | grep $port
		sudo lsof -i -n -P | grep TCP | more
		sudo ss -tulpn | grep $port
		sudo netstat -tulpen | grep LISTEN 
	;;
	ip) #network spec
		nslookup $hostA
	;;
	firewall) #firewall
		sudo ufw status 
		sudo iptables -L
		sudo ufw status numbered
		#sudo ufw enable
		#sudo ufw disable
		#sudo ufw allow ssh
	;;
	network) #hardware
		iconfig -a
	;;
	scan_net)
		nmap -sn 129.168.0.0/24
		sudo netdiscover -r 192.168.1.0/24 -i wlan0
		ss -ltnp
	*)
		echo "net utils"
	;;
#mysql 3306, postgresql 5432, cassandra 7199, mongodb 27017, neo4j 7474, elastic 9300, kibana 5601 
esac
