#!/bin/bash
#
# help_updateOutputFiles.sh -- This function updates manuals' related
# output files.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function help_updateOutputFiles {

    # Output action message.
    cli_printMessage "`gettext "Updating manual's output files"`"

    # -- .info ----------

    # Check .info output directory 
    [[ ! -d ${MANUALS_DIR[3]} ]] &&  mkdir -p ${MANUALS_DIR[3]}

    # Update .info file
    /usr/bin/makeinfo ${MANUALS_FILE[1]} --output=${MANUALS_FILE[4]} --no-ifhtml

    # Check .info file. If the info file was not created then there
    # are errors to fix.
    if [[ ! -f ${MANUALS_FILE[4]} ]];then
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Compress .info file.
    bzip2 -f ${MANUALS_FILE[4]}

    # -- .html ----------

    # Check html output directory
    [[ ! -d ${MANUALS_DIR[4]} ]] && mkdir -p ${MANUALS_DIR[4]}

    # Add html output directory into directory stack to make it the
    # working directory. If we don't do this, texi2html doesn't
    # produce paths correctly inside html output.
    pushd ${MANUALS_DIR[4]} > /dev/null

    # Update html files.  At this point, we use texi2html to export
    # texinfo files to html using Modern's CSS definitions. We also
    # append image directories to the @include search path, using
    # texi2html's '--I' option. Adding image directories to @include
    # search path is needed in order for texi2html to build html paths
    # correctly, once the html output is produced.  For exmample, if
    # you want to include the following image:
    #
    #   /home/centos/artwork/trunk/Identity/Models/Img/en/Scripts/renderImage.png
    #
    # you add its directory path to @include search path using the
    # following command: 
    #
    #   texi2html --I=/home/centos/artwork/trunk/Identity/Models/Img/en/Scripts
    #
    # Once the image directory path has been added to @include search
    # path, use the @image command inside texinfo files to include
    # images available.  In order to include images correctly, do not
    # include the image path in the first argument of @image command,
    # use just the image name (without extension) instead (e.g.,
    # @image{renderImage,,,,png}).
    texi2html ${MANUALS_FILE[1]} --output=${MANUALS_DIR[4]} --split section \
        --nosec-nav \
        --css-include=/home/centos/artwork/trunk/Identity/Models/Css/Texi2html/stylesheet.css \
        --I=/home/centos/artwork

    # Apply html transformations.
    sed -r -i \
        -f /home/centos/artwork/trunk/Identity/Models/Css/Texi2html/transformations.sed \
        ${MANUALS_DIR[4]}/*.html

    # Remove html output directory from directory stack.
    popd > /dev/null

    # -- .txt -----------

    # Check plaintext output directory.
    [[ ! -d ${MANUALS_DIR[5]} ]] &&  mkdir -p ${MANUALS_DIR[5]}

    # Update plaintext output directory.
    /usr/bin/makeinfo ${MANUALS_FILE[1]} --output=${MANUALS_FILE[5]} --plaintext --no-ifhtml

    # Re-define output variable in order for cli_commitRepoChanges
    # functionality to receive the correct location to apply
    # subversion commands. Inside `help' functionality, the correct
    # place to commit changes is not the initial value of OPTIONVAL
    # but the directory path where documentation changes take place
    # under.
    OPTIONVAL=${MANUALS_DIR[0]}

    # Update central repository. Be sure this is the last action
    # you perform inside centos-art.sh script flow.
    cli_commitRepoChanges

}
