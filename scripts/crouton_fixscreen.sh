cat <<EOT >> /etc/rc.local

SCREENDIR=/var/run/screen
if [ -L $SCREENDIR ] || [ ! -d $SCREENDIR ]; then
    rm -f $SCREENDIR
    mkdir $SCREENDIR
    chown root:utmp $SCREENDIR
fi
find $SCREENDIR -type p -delete
# If the local admin has used dpkg-statoverride to install the screen
# binary with different set[ug]id bits, change the permissions of
# $SCREENDIR accordingly
BINARYPERM=`stat -c%a /usr/bin/screen`
if [ "$BINARYPERM" -ge 4000 ]; then
    chmod 0755 $SCREENDIR
elif [ "$BINARYPERM" -ge 2000 ]; then
    chmod 0775 $SCREENDIR
else
    chmod 0777 $SCREENDIR
fi

EOT
