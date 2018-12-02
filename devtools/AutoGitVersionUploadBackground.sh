#!/bin/sh Requires MEGAcmd, git, mv, cd, mkidr, echo
COUNTER=0 LocalDir=~/fc-pregmod/ RemoteDir=FC-GIT U=anon@anon.anon P=13245 && mega-login $U $P
while [ $COUNTER -ge 0 ]; do
	if [ $COUNTER -eq 0 ]; then mega-login $U $P && mega-mkdir $RemoteDir && mega-export -a $RemoteDir && mkdir $LocalDir ; git clone -q https://gitgud.io/pregmodfan/fc-pregmod.git $LocalDir
	fi	
	cd $LocalDir/ && AbrevHash=`git log --reverse -n1 --abbrev-commit |grep -m1 commit | sed 's/commit //'`
	if [ $COUNTER -eq 0 ]; then ./compile > /dev/null && mv bin/FC_pregmod.html "bin/FC-pregmod-$(git log -1 --format='%cd' --date='format:%F-%H-%M')-$AbrevHash.html" && mega-put bin/*.html $RemoteDir
	else if [ "$(git pull)" == "Already up to date." ]; then ehco -n ""
		else clear && rm bin/*.html ; ./compile > /dev/null && mv bin/FC_pregmod.html "bin/FC-pregmod-$(git log -1 --format='%cd' --date='format:%F-%H-%M')-$AbrevHash.html" && mega-login $U $P && mega-put bin/*.html $RemoteDir
		fi
	fi	
	let COUNTER=COUNTER+1 && mega-logout > /dev/null && sleep 300s
done	