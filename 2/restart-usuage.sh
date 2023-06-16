if [ `ps aux | grep nginx | sort -r -k4 | head -1 | awk '{print $4}'` > 80 ];
then
systemctl restart nginx
fi