#rsync -urltv --delete -e ssh intertino sabeiro@intertino:/var/www/html/
#https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html
REM_HOST="192.168.0.1"
case $1 in  
    git)
	cd src
	git add .
	git commit -m "commit $(date) "
	git push origin master
	cd ..
	;;
    svn)
	svn ci script/* -m "automatic update"
	rsync -av -e ssh --delete node intertino:$LAV_DIR
	;;
    push)
	rsync -avz -e ssh --delete src $REM_HOST:$LAV_DIR
        rsync -avz -e ssh --delete raw $REM_HOST:$LAV_DIR
        rsync -avz -e ssh --delete credenza $REM_HOST:$LAV_DIR
        rsync -avz -e ssh --delete conf $REM_HOST:$LAV_DIR
        rsync -avz -e ssh --delete bin $REM_HOST:$LAV_DIR
        rsync -avz -e ssh --delete gis $REM_HOST:$LAV_DIR
        rsync -avz -e ssh --delete train $REM_HOST:$LAV_DIR
        rsync -avz -e ssh --delete www $REM_HOST:$LAV_DIR
	rsync -rvz --no-g -e ssh webapp $REM_HOST:"~/lav/dauvi/"
	;;
    samba)
	rsync -avz  --delete src $SMB_HOST
        rsync -avz  --delete raw $SMB_HOST
        rsync -avz  --delete credenza $SMB_HOST
        rsync -avz  --delete conf $SMB_HOST
        rsync -avz  --delete bin $SMB_HOST
        rsync -avz  --delete gis $SMB_HOST
        rsync -avz  --delete train $SMB_HOST
        rsync -avz  --delete www $SMB_HOST
	#rsync -rvz --no-g -e ssh webapp $SMB_HOST:"~/lav/dauvi/"
	;;
    pull)
#	rsync -rvz --no-g -e ssh $REM_HOST:"/var/www/webapp" .
	rsync -avz -e ssh  $REM_HOST:"~/lav/" .
	;;
    *)
	echo "cmd push | pull | git | svn | samba"
	;;
esac
