#!/bin/bash
#
# Update Background Images.
#
# This script is used to copy background images from a Theme into the
# different extra works here in trunk/Extras directory.
#
# --
# CentOS Artowk SIG | https://projects.centos.org/trac/artwork

#
# Initializations
#
THEMEDIR=../Themes

function updateBG {

    if [ "$TARGET_BG_HTML" != "NONE" ];then
        printf "   HTML : "
        cp $SOURCE_BG_HTML $TARGET_BG_HTML
        printf " Updated.\n"
    fi

    if [ "$TARGET_BG_HEAD" != "NONE" ];then
        printf " HEADER : "
        cp $SOURCE_BG_HEAD $TARGET_BG_HEAD
        printf " Updated.\n"
    fi

    if [ "$TARGET_BG_TOC" != "NONE" ];then
        printf "    TOC : "
        cp $SOURCE_BG_TOC $TARGET_BG_TOC
        printf " Updated.\n"
    fi
}

#
# Add some presentation.
#
clear;
echo '---------------------------------------------------'
echo ' CentOS Artwort SIG -> Update Backgrounds'
echo '---------------------------------------------------'
#
# Define Theme to use.
#
THEMES=`ls $THEMEDIR | sed 's!/$!!g'`
echo 'Select the theme you want to apply:'
select i in $THEMES;do
    THEME=$i;
    SOURCE_BG_HTML=$THEMEDIR/$THEME/Backgrounds/img/html-bg.png
    SOURCE_BG_HEAD=$THEMEDIR/$THEME/Backgrounds/img/header-bg.png
    SOURCE_BG_TOC=$THEMEDIR/$THEME/Backgrounds/img/toc-bg.png
    break;
done

#
# Verify Theme Background Images
#
for i in `echo $SOURCE_BG_HTML $SOURCE_BG_HEAD $SOURCE_BG_TOC`;do
    ls $i > /dev/null 2>&1; 
    if [ "$?" != "0" ];then
        echo "Background image can't be found in $THEME theme."
        echo '---------------------------------------------------'
        exit 1;
    fi
done
#
# Define Background Image Paths
#
for i in `ls`;do
    if [ -d $i ];then
        case $i in
            Apache                      )
            echo '---------------------------------------------------'
            echo " Updating $i backgrounds"
            echo '---------------------------------------------------'
            TARGET_BG_HTML=$i/error/include/img/html-background.png
            TARGET_BG_HEAD=$i/error/include/img/header-background.png
            TARGET_BG_TOC=NONE # No Toc image here
            updateBG;
            ;;
            BrowserDefaultPage          )
            echo '---------------------------------------------------'
            echo " Updating $i backgrounds"
            echo '---------------------------------------------------'
            TARGET_BG_HTML=$i/img/html-background.png
            TARGET_BG_HEAD=$i/img/header-background.png
            TARGET_BG_TOC=NONE # No Toc image here
            updateBG;
            ;;
            Mantis                      )
            echo '---------------------------------------------------'
            echo " Updating $i backgrounds"
            echo '---------------------------------------------------'
            TARGET_BG_HTML=$i/images/html-background.png
            TARGET_BG_HEAD=$i/images/header-background.png
            TARGET_BG_TOC=NONE # No Toc image here
            updateBG;
            ;;
            Moin                        )
            echo '---------------------------------------------------'
            echo " Updating $i backgrounds"
            echo '---------------------------------------------------'
            TARGET_BG_HTML=$i/Mettle/img/moin-html-background.png
            TARGET_BG_HEAD=$i/Mettle/img/moin-header-background.png
            TARGET_BG_TOC=$i/Mettle/img/moin-toc-background.png
            updateBG;
            ;; 
            Trac                        )
            echo '---------------------------------------------------'
            echo " Updating $i backgrounds"
            echo '---------------------------------------------------'
            TARGET_BG_HTML=$i/htdocs/background.png
            TARGET_BG_HEAD=$i/htdocs/header-background.png
            TARGET_BG_TOC=$i/htdocs/toc.png
            updateBG;
            ;; 
            Punbb                       )
            echo '---------------------------------------------------'
            echo " Updating $i backgrounds"
            echo '---------------------------------------------------'
            TARGET_BG_HTML=$i/img/html-background.png
            TARGET_BG_HEAD=$i/img/header-background.png
            TARGET_BG_TOC=NONE # No Toc image here
            updateBG;
            ;; 

            # NOTE: If you add other works that use backgrounds,
            # header, or table of content (toc) images add it here.
            #

        esac
    fi

done
echo '---------------------------------------------------'
exit 0;
