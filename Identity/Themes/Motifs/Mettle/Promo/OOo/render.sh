#!/bin/bash
#
# Render script

# Define export id
ID='CENTOSARTWORK'

# Make first argument required
if [ ! "$1" ]; then
    echo ' Syntax Error!. See the README file for more information.';
    exit;
fi

# Define SVG template directory
SVG=svg

# Define absolute path for the background file. Relative path is not
# allowed. Inkscape needs an absolute path as reference to the
# background image. That is the absolute path we build here.
MYPATH=`pwd`
BGFILE=../../../../../../trunk/Themes/Mettle/Wallpapers/img
cd $BGFILE
BGFILE=`pwd`/wallpaper-fog.png
cd $MYPATH

# Define Translation directory
TXT=../../../../../../trunk/Translations/Promo/OOo

# Look for versions
for VERSION in `echo $1`;do

    # Define translation's language 
    if [ $2 ];then
        TXTDIRS=`ls $TXT/ | egrep $2`
    else
        TXTDIRS=`ls $TXT/`
    fi

    # Look for translations
    for LANGUAGE in $TXTDIRS; do
    
        # Define Image directory
        IMG=img/$VERSION/$LANGUAGE
        if [ ! -d $IMG ];then
            mkdir -p $IMG
        fi

        # Define translation file names
        if [ $3 ];then
            TXTFILES=`ls $TXT/$LANGUAGE | egrep $3`
        else
            TXTFILES=`ls $TXT/$LANGUAGE`
        fi

        # Look for files
        for FILE in $TXTFILES; do

            # Define translation file name
            TRANSLATION=$TXT/$LANGUAGE/$FILE

            # Define svg template file name
            TEMPLATE=`echo $FILE | sed -r 's!\.sed$!.svg!'`

            # Define image file name
            IMAGE=$IMG/`echo $FILE | sed -r 's!\.sed$!.png!'`

            # Do translation and lefticon insertion
            sed -e "s!=BGFILE=!$BGFILE!" \
        	    -f $TRANSLATION \
        	    -e "s!=VERSION=!$VERSION!" \
                $SVG/$TEMPLATE > $TEMPLATE

            # Render image.
            inkscape $TEMPLATE --export-id=$ID --export-png=$IMAGE; 

            # Remove temporal file
            rm $TEMPLATE

        done
    done
done
