	while ((1==1))
	do
		curl https://localhost:4757
		if (($? != 0))
		then
			date >> curl.log
		else
		  	break
		fi
		sleep 10
	done