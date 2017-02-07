#!/bin/sh
OS=$(uname -s)

/sbin/aureport -au
/sbin/aureport -l
if [ ${OS} = "Linux" ]; then
     if [ -f /etc/redhat-release ]; then
        /sbin/aureport -x --summary | /usr/bin/head -20 
     elif [ -f /etc/debian_version ]; then
        # do nothing
        # due to this bug https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=841272
    fi
elif [ ${OS} = 'FreeBSD' ]; then
    # do nothing
fi

/sbin/aureport -f --summary | /usr/bin/head -20
/sbin/aureport -u -i --summary
/sbin/aureport --failed
