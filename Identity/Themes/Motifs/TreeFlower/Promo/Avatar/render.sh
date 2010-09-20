#
# Render script.
#

ID='TREEFLOWER'
SVG=svg
TXT=../../../../../../trunk/Translations/Promo/Avatar
IMG=img

# Define absolute path for background file
MYPATH=`pwd`
BGFILE=../../../../../../trunk/Themes/TreeFlower/Wallpapers/img
cd $BGFILE
BGFILE=`pwd`/wallpaper-fog.png
cd $MYPATH

# Look for translations
for j in `ls $TXT`; do

        # Define translation file name

        TXTFILE=$TXT/$j

        # Define svg template file name

        SVGFILE=$SVG/`echo $j | sed -r 's!\.sed$!.svg!'`

        # Define image file name

        IMGFILE=$IMG/`echo $j | sed -r 's!\.sed$!.png!'`

        # Define temporal file with the translation.
        # This file is used to render the translated 
        # png file. 

        TMP=tmp_$(basename $SVGFILE)

        # Do translation

        sed -e "s!=BGFILE=!$BGFILE!" -f $TXTFILE $SVGFILE > $TMP

        # Render image.

        inkscape $TMP --export-id=$ID --export-png=$IMGFILE; 

        # Remove temporal file

        rm *.svg

    done
