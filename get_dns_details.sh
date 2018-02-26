#!/bin/sh

ServersList=serverlist.txt
ResultFile=dns_report.csv

if [ -f $ServerList ]
then
	if [ -f $ResultFile ]
	then
		if [ `cat $ResultFile | wc -l ` -ge 1 ]
		then
			echo "$ResultFile contain data please clear it before run the script"
			echo "exiting...!"
			exit
		fi
	fi

	#Making the csv file heading

	echo "Server Name, A Record, Name Server " > $ResultFile

	for server in `cat serverlist.txt`
	do
		echo "Fetching $server details..."
		echo "$server , `dig +short $server | tr '\n' ' : '`, `dig $server | grep SERVER | awk -F '(' '{print $2}' | sed s/\)//g`" >> $ResultFile
	done
else
	echo "serverlist.txt not found exiting..!"
	exit
fi
if [ -f $ResultFile ]
then
	echo "Script completed successfully..!"
	echo "Check the file $ResultFile"
	echo "exiting...!"
	exit
else
	echo "Script completed with error...!"
	echo "exiting..!"
	exit
fi
