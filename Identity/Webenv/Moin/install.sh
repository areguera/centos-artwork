#!/bin/bash
#
#


# Export directory name.
EXPORTDIR=tmp
WIKILOCATION=/var/www

# Instance Name which you want apply this theme to.
printf 'Site instance: '
read WIKIINSTANCE
if [ ! -d "${WIKILOCATION}/${WIKIINSTANCE}" ];then
	echo "The instance '${WIKIINSTANCE}' does not exist."
	exit;
fi

# Customized version selector
echo 'Site customization:'
select VERSION in `find . -maxdepth 1 -type d \
	| egrep -v '^.$' | egrep -v 'svn' \
	| sed 's/\.\///'`;do
	# SVN Repository directory
	SVN=http://centos.org/svn/artwork/trunk/Extras/Moin/$VERSION
	break
done


# Location where your wiki instance is stored.
WIKILOCATION=/var/www/

# Define Theme Name.
THEMENAME="Modern"

# Create instance
echo 'Downloading customization ...'
mkdir $EXPORTDIR
svn export $SVN/ $EXPORTDIR/ --force --quiet

echo 'Applying customization ...'
cp -r $EXPORTDIR/$THEMENAME ${WIKILOCATION}${WIKIINSTANCE}/htdocs/
cp $EXPORTDIR/${THEMENAME}.py ${WIKILOCATION}${WIKIINSTANCE}/data/plugin/theme/${THEMENAME}.py
cp logo.png ${WIKILOCATION}${WIKIINSTANCE}/htdocs/common/logo.png
rm -r $EXPORTDIR

# Modify wikiconfig.py to set theme personalized names.
sed -i -e "
	/logo_string =/{
	c\\
    logo_string = u'<img src=\"/${WIKIINSTANCE}_staticfiles/common/logo.png\" alt=\"CentOS\">'
	}
	/theme_default =/{
	c\\
    theme_default = '${THEMENAME}'
	}
	" ${WIKILOCATION}${WIKIINSTANCE}/cgi-bin/*.py

# Set Permissions
echo 'Updating permissions ... '
chown -R apache.apache ${WIKILOCATION}${WIKIINSTANCE}/htdocs/${THEMENAME}/
chown -R apache.apache ${WIKILOCATION}${WIKIINSTANCE}/data/plugin/theme/${THEMENAME}.py
chown -R apache.apache ${WIKILOCATION}${WIKIINSTANCE}/htdocs/common/logo.png
chmod -R 750 ${WIKILOCATION}${WIKIINSTANCE}/htdocs/${THEMENAME}/
chmod -R 750 ${WIKILOCATION}${WIKIINSTANCE}/data/plugin/theme/${THEMENAME}.py
chmod -R 750 ${WIKILOCATION}${WIKIINSTANCE}/htdocs/common/logo.png
