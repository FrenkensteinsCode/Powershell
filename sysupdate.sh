GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
NC=$(tput sgr0)

WARNING="${RED}Must be root to continue...${NC}"
INFO="${YELLOW}Updating system, please be patient...${NC}"
SUCCESS="${GREEN}Updates finished. Go ahead!${NC}"

if [[ $USER != "root" ]]; then echo $WARNING && exit 1
else
	echo "Do you want to see updating output?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes )
			echo $INFO
			sleep 2
			apt-get update >> ./tmp.log && apt-get upgrade >> ./tmp.log -y &&
			echo $SUCCESS
			break;;

			No )
			echo $INFO
			sleep 2
			apt-get update | pv -p --timer --rate --bytes >> ./tmp.log &&
			apt-get upgrade -y | pv -p --timer --rate --bytes >> ./tmp.log &&
			echo $SUCCESS
			break;;
		esac
	done
	echo "Generate log-file?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes )
			$(cp ./tmp.log ./update.log) && $(rm -f ./tmp.log)
			break;;

			No )
			$(rm -f ./tmp.log)
			break;;
		esac
	done
fi
