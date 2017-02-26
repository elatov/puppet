#!/bin/sh
OS=$(uname -s)

/sbin/aureport -au

if [ ${OS} = "Linux" ]; then
     if [ -f /etc/redhat-release ]; then
        /sbin/aureport -l
        /sbin/aureport -f --summary | /usr/bin/head -20
        /sbin/aureport -x --summary | /usr/bin/head -20 
     elif [ -f /etc/debian_version ]; then
     	W="nothing"
        # do nothing
        # due to this bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=841272
    fi
elif [ ${OS} = 'FreeBSD' ]; then
	W="nothing"
    # do nothing
fi

/sbin/aureport -u -i --summary
/sbin/aureport --failed
