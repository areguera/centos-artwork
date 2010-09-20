#
# Render script.
#

LANGUAGE=$1
FILENAME=$2

ID='TREEFLOWER'
SVG=svg
TXT=../../../../../../trunk/Translations/Promo/Tshirt
IMG=img

if [ $LANGUAGE ];then
    TXTDIR=`ls $TXT/ | egrep $LANGUAGE`
else
    TXTDIR=`ls $TXT/`
fi

# Look for translations

for i in $TXTDIR; do

    # Define translation file names

    if [ $FILENAME ];then
        TXTFILES=`ls $TXT/$i | egrep $FILENAME`
    else
        TXTFILES=`ls $TXT/$i`
    fi

    # Look for files

    for j in $TXTFILES; do

        # Define translation file name

        TXTFILE=$TXT/$i/$j

        # Define svg template file name

        SVGFILE=$SVG/`echo $j | sed -r 's!\.sed$!.svg!'`

        # Create image directory

        IMGDIR=$IMG/$i

        if [ ! -d $IMGDIR ] ; then

            mkdir -p $IMGDIR;

        fi

        # Define image file name

        IMGFILE=$IMGDIR/`echo $j | sed -r 's!\.sed$!.png!'`

        # Define temporal file with the translation.
        # This file is used to render the translated 
        # png file. 

        TMP=tmp_$(basename $SVGFILE)

        # Do translation

        sed -f $TXTFILE $SVGFILE > $TMP

        # Render image.

        inkscape $TMP --export-id=$ID --export-png=$IMGFILE; 

        # Remove temporal file

        rm *.svg

    done
done
