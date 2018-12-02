#!/bin/sh Requires MEGAcmd, git, mv, cd, mkidr, echo
COUNTER=0 LocalDir=~/fc-pregmod/ RemoteDir=FC-GIT U=anon@anon.anon P=13245 && mega-login $U $P
while [ $COUNTER -ge 0 ]; do
	if [ $COUNTER -eq 0 ]; then mega-login $U $P && mega-mkdir $RemoteDir ; mega-export -a $RemoteDir ; mkdir $LocalDir ; git clone -q https://gitgud.io/pregmodfan/fc-pregmod.git $LocalDir
	fi	
	cd $LocalDir/ && AbrevHash=`git log -n1 --reverse --abbrev-commit |grep -m1 commit | sed 's/commit //'`
	if [ $COUNTER -eq 0 ]; then echo "First run. Compliling, formatting and placing .html." && ./compile > /dev/null && mv bin/FC_pregmod.html "bin/FC-pregmod-$(git log -1 --format='%cd' --date='format:%F-%H-%M')-$AbrevHash.html" && mega-put bin/*.html $RemoteDir && echo "Inital compiled .html placed."
	else if [ "$(git pull)" == "Already up to date." ]; then echo "No updated files."
		else echo "Compliling, formatting and placing updated .html." ; rm bin/*.html ; ./compile > /dev/null && mv bin/FC_pregmod.html "bin/FC-pregmod-$(git log -1 --format='%cd' --date='format:%F-%H-%M')-$AbrevHash.html" && mega-login $U $P && mega-put bin/*.html $RemoteDir ; echo "Updated .html placed."
		fi
	fi	
	let COUNTER=COUNTER+1 && mega-logout > /dev/null && sleep 300s
done	