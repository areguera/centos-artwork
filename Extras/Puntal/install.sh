#!/bin/bash
# Puntal Theme installation script.

PUNTAL_PATH=/var/www/html/puntal

EXPORTDIR=tmp_puntal

SVNREPODIR=https://projects.centos.org/svn/artwork/trunk/Extras/Puntal

if [ "$@" ]; then

        for i in "$@";do
        case $i in
           --subversion | -s    )
                svn export $SVNREPODIR $EXPORTDIR --force --quiet
                /bin/cp -r $EXPORTDIR/themes/punbb/* $PUNTAL_PATH/themes/punbb/;
                /bin/rm -r $EXPORTDIR;;
        esac
        done
else

	/bin/cp -r themes/punbb/* $PUNTAL_PATH/themes/punbb/;

fi 

