if [ $UID -gt 199 ] && [ "`id -gn`" = "`id -un`" ]; then
    umask 027
else
    umask 027
fi