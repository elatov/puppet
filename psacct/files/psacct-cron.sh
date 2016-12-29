#!/bin/sh
echo -e "User stats\n"
/bin/ac -p
echo -e "elatov commands\n"
/bin/lastcomm elatov | /bin/awk '{print $1}' | /bin/sort | /bin/uniq -c  | /bin/sort -nr | /bin/head
echo -e "User Logins\n"
/bin/last | /bin/awk '{print $1}' | /bin/sort | /bin/uniq -c  | /bin/sort -nr | /bin/head
echo -e "Host Logins\n"
/bin/last | /bin/awk '{print $3}' | /bin/sort | /bin/uniq -c  | /bin/sort -nr | /bin/head
