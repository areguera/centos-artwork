#!/bin/bash
#
# Render script.
#

# Define export id
ID='CENTOSARTWORK'

# Make first argument required
if [ ! "$1" ]; then
    echo ' Syntax Error!. See the README file for more information.';
    exit;
fi
 
SVG=svg
TXT=../../../../../../trunk/Translations/Promo/Media

# Define absolute path for the background file. Relative path is not
# allowed. Inkscape needs an absolute path as reference to the
# background image. That is the absolute path we build here.
MYPATH=`pwd`
BGFILE=../../../../../../trunk/Themes/Mettle/Wallpapers/img
cd $BGFILE
BGFILE=`pwd`/wallpaper-fog.png
cd $MYPATH

# Define file name filter
if [ "$3" ];then
    TXTDIRS=`ls $TXT/$FILE | egrep "$3"`
else
    TXTDIRS=`ls $TXT/$FILE`
fi

# Look for versions 
for VERSION in `echo "$1"`; do

    # Define major version
    MAJORV=`echo $VERSION | sed -e 's/\.[0-9]//'`

    # Define Image directory
    IMG=img/$VERSION
    if [ ! -d $IMG ];then
        mkdir $IMG
    fi

    # Look for architectures
    for ARCH in `echo "$2"`;do

        # Look for translations
        for FILE in $TXTDIRS; do
    
            # Define translation file names
            TRANSLATION=$TXT/$FILE
    
            # Define svg template file name
            TEMPLATE=`echo $FILE | sed -r 's!\.sed$!.svg!'`
    
            # Define png image file name
            IMAGE=$IMG/`echo $FILE | sed -r "s/\.sed$/-$ARCH.png/"`
        
            # Define svg template instance. Specify which svg template
            # will be used for a specific translation file and creates
            # a copy of it in the current directory for further
            # translations.
            case $TEMPLATE in
        
        	    # CD Labels
                label.svg		)
                    cat $SVG/label.svg > $TEMPLATE
                ;;
        
        	    # CD Sleeves
    	        sleeve-cd.svg	)
                    cat $SVG/sleeve-cd.svg > $TEMPLATE
	            ;;

                # DVD Sleeves
	            sleeve-dvd.svg	)
    	            cat $SVG/sleeve-dvd.svg > $TEMPLATE
                ;;

            esac

            # Translation. Makes replacements over the recently
            # created template instance.
        	sed -i -e "s!=BGFILE=!$BGFILE!" \
                   -e "s!=ARCH=!$ARCH!" \
                   -f $TRANSLATION \
                   -e "s!=MAJORV=!$MAJORV!" \
                   -e "s!=VERSION=!$VERSION!" $TEMPLATE

            # Rendering.
            inkscape $TEMPLATE --export-id=$ID --export-png=$IMAGE; 

            # Remove temporal file
            rm $TEMPLATE

        done
    done
done
