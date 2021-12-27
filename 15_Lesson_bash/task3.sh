	while ((1==1))
	do
		curl http://192.168.0.1
		curl http://173.194.222.113
		curl http://87.250.250.242
		if (($? != 0))
		then
			date >> curl.log
		else
		  	break
		fi
		sleep 10
	done