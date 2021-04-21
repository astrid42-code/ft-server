if ((ps -ef | grep -v grep | grep nginx | wc -l) > 0)
    then if [ "$AUTOINDEX" = "off" ]
        then cp ./auto_index_off.conf etc/nginx/sites-available/localhost;
    fi
    service nginx reload
fi
