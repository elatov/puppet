#!/bin/sh
/sbin/aureport -au
/sbin/aureport -l
/sbin/aureport -x --summary | /bin/head -20 
/sbin/aureport -f --summary | /bin/head -20
/sbin/aureport -u -i --summary
/sbin/aureport --failed
