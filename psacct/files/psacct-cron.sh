#!/bin/sh
OS=$(uname -s)
if [ ${OS} = "Linux" ]; then
# setup variables

     if [ -f /etc/redhat-release ]; then
        AC=/bin/ac
        LAST=/bin/last
        LASTCOMM=/bin/lastcomm
        AWK=/bin/awk
        SORT=/bin/sort
        UNIQ=/bin/uniq
        HEAD=/bin/head
        ECHO=/bin/echo
     elif [ -f /etc/debian_version ]; then
        AC=/usr/bin/ac
        LAST=/usr/bin/last
        LASTCOMM=/usr/bin/lastcomm
        AWK=/usr/bin/awk
        SORT=/usr/bin/sort
        UNIQ=/usr/bin/uniq
        HEAD=/usr/bin/head
        ECHO=/bin/echo
    fi

# run the actual commands

    $ECHO -e "User stats\n"
	$AC -p
	$ECHO -e "\n"
	$ECHO -e "elatov commands\n"
	$LASTCOMM elatov | $AWK '{print $1}' | $SORT | $UNIQ -c  | $SORT -nr | $HEAD
	$ECHO -e "\n"
	$ECHO -e "User Logins\n"
	$LAST | $HEAD -n -2| $AWK '{print $1}' | $SORT | $UNIQ -c  | $SORT -nr | $HEAD
	$ECHO -e "\n"
	$ECHO -e "Host Logins\n"
	$LAST | $HEAD -n -2 | $AWK '{print $3}' | $SORT | $UNIQ -c  | $SORT -nr | $HEAD
	$ECHO -e "\n"
	
elif [ ${OS} = 'FreeBSD' ]; then
# setup variables

	AC=/usr/bin/ac
	LAST=/usr/bin/last
	LASTCOMM=/usr/bin/lastcomm
	AWK=/usr/bin/awk
	SORT=/usr/bin/sort
	UNIQ=/usr/bin/uniq
	HEAD=/usr/bin/head
	ECHO=/bin/echo
	TAIL=/usr/bin/tail
	SED=/usr/bin/sed

# run the actual commands
	
	$ECHO "User stats\n"
	$AC -p
	$ECHO "\n"
	$ECHO "elatov commands\n"
	$LASTCOMM elatov | $AWK '{print $1}' | $SORT | $UNIQ -c  | $SORT -nr | $HEAD
	$ECHO "\n"
	$ECHO "User Logins\n"
	$LAST | $TAIL -r | $sed '1,2d'|$TAIL -r | $AWK '{print $1}' | $SORT | $UNIQ -c  | $SORT -nr | $HEAD
	$ECHO "\n"
	$ECHO "Host Logins\n"
	$LAST | $TAIL -r | $sed '1,2d'|$TAIL -r | $AWK '{print $3}' | $SORT | $UNIQ -c  | $SORT -nr | $HEAD
fi
