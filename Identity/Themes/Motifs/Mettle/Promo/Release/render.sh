#!/bin/bash
#
# Render script.
#

# Define export id
ID='CENTOSARTWORK'

# Make first argument required
if [ ! "$1" ]; then
    echo ' You need to specifiy the version you want to render as first argument.'
    echo ' Syntax: ./render.sh version language filename';
    exit;
fi

# Define SVG template directory
SVG=svg

# Define translation's base directory
TXT=../../../../../../trunk/Translations/Promo/Release

# Define absolute path for the background file. Relative path is not
# allowed. Inkscape needs an absolute path as reference to the
# background image. That is the absolute path we build here.
MYPATH=`pwd`
BGFILE=../../../../../../trunk/Themes/Mettle/Wallpapers/img
cd $BGFILE
BGFILE=`pwd`/wallpaper-fog.png
cd $MYPATH

# Apply Language Filter
if [ $2 ];then
    TXTDIRS=`ls $TXT/ | egrep $2`
else
    TXTDIRS=`ls $TXT/`
fi

# Look for translations
for VERSION in `echo "$1"`; do

    # Define major version value
    MAJORV=`echo $VERSION | sed -e 's/\.[0-9]//'`

    # Look for languages
    for LANGUAGE in $TXTDIRS; do

        # Apply file name filter
        if [ $3 ];then
            TXTFILES=`ls $TXT/$LANGUAGE | egrep $3`
        else
            TXTFILES=`ls $TXT/$LANGUAGE`
        fi

        # Define image directory  
        IMG=img/$LANGUAGE
        if [ ! -d $IMG ];then
            mkdir $IMG;
        fi

        # Look for filenames 
        for FILE in $TXTFILES; do

            # Define translation file name
            TRANSLATION=$TXT/$LANGUAGE/$FILE

            # Define svg template file name
            TEMPLATE=release.svg

            # Define image file name
            IMGFILE=$IMG/release-$VERSION.png

            # Do translation and lefticon insertion
            sed -e "s!=BGFILE=!$BGFILE!" \
    	        -f $TRANSLATION \
    	        -e "s!=MAJORV=!$MAJORV!" \
    	        -e "s!=VERSION=!$VERSION!" \
                $SVG/$TEMPLATE > $TEMPLATE

            # Render image.
            inkscape $TEMPLATE --export-id=$ID --export-png=$IMGFILE; 

            # Remove temporal file
            rm $TEMPLATE

        done
    done
done
