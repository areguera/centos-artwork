#!/bin/bash
#
# svg_updateMetadata.sh -- This function replaces metadata section
# inside scalable vector graphic (SVG) files with one of pre-defined
# metadata templates available. Use this function to maintain metadata
# information inside repository.
#
#   Usage:
#   centos-art svg --update-metadata=path/to/dir --filter=filename
#
# In the above usage example `path/to/dir' represents the parent
# directory where scalable vector graphics you want to update metadata
# information are. The `--filter=filename' is optional and if provided
# just the file specificed is affected. Otherwise all files ending in
# `.svg' are massively modified.
#
# Copyright (C) 2009-2010 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
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

function svg_updateMetadata {

    local TITLE=''
    local DATE=''
    local CREATOR=''
    local RIGHTS=''
    local PUBLISHER=''
    local COVERAGE=''
    local TEMPLATES=''
    local KEYWORDS=''
    local INSTANCE=''

    # Define absolute path to metadata templates parent directory.
    # This is the place where we store metadata template files.
    TEMPLATES=~/artwork/trunk/Scripts/Bash/Functions/Svg/Tpl

    # Define metadata template file we want to apply. More than one
    # metadata template file may exist, so let choosing which one to
    # use.
    cli_printMessage "`gettext "Select the metadata template you want to apply:"`"
    select TEMPLATE in $(ls $TEMPLATES);do
       TEMPLATE=$TEMPLATES/$TEMPLATE
       break
    done

    # Check metadata template file existence.
    cli_checkFiles $TEMPLATE 'f' '' '--quiet'
    if [[ $? -ne 0 ]];then
       cli_printMessage "`gettext "The template file you provided doesn't exist."`"
       cli_printMessage "$(caller)" 'AsToKnowMoreLine'
    fi

    # Define metadata template instance.
    INSTANCE=${TMPFILE}-$(basename $TEMPLATE)

    # Define svg document date.
    DATE=$(date +%Y-%m-%d)

    # Define svg document creator.
    CREATOR='CentOS Artwork SIG'

    # Define svg document rights.
    RIGHTS=$CREATOR

    # Define svg document publisher.
    PUBLISHER='The CentOS Project'

    # Define svg document coverage.
    COVERAGE=$PUBLISHER

    for FILE in $FILES;do

        # Define svg document title.
        TITLE=$(basename $FILE)

        # Define svg document keywords.
        KEYWORDS=$(echo $FILE | cut -d/ -f6- | tr '/' '\n')

        # Redifine keywords using SVG standard format. Note that this
        # information is inserted inside metadata template file. The
        # metadata template file is a replacement set of sed commands
        # so we need to escape the new line of each line using one
        # backslash (\). As we are doing this inside bash, it is
        # required to escape the backslash with another backslash so
        # it passes literally.
        KEYWORDS=$(\
           for KEY in $KEYWORDS;do
              echo "            <rdf:li>$KEY</rdf:li>\\"
           done)

        # Create metadata template instance.
        sed -r \
            -e "s!=TITLE=!$TITLE!" \
            -e "s!=DATE=!$DATE!" \
            -e "s!=CREATOR=!$CREATOR!" \
            -e "s!=RIGHTS=!$RIGHTS!" \
            -e "s!=PUBLISHER=!$PUBLISHER!" \
            -e "s!=COVERAGE=!$COVERAGE!" \
            -e "/=KEYWORDS=/c\\${KEYWORDS}" \
            $TEMPLATE > $INSTANCE
        sed -i -r -e 's/>$/>\\/g' $INSTANCE

        # Apply metadata template instance to scalable vector graphic
        # file.
        sed -i -f $INSTANCE $FILE

        # Remove metadata template instance.
        cli_checkFiles $INSTANCE 'f' '' '--quiet'
        if [[ $? -eq 0 ]];then
            rm $INSTANCE
        fi

    done \
        | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk

    # Check repository changes and ask you to commit them up to
    # central repository.
    cli_commitRepoChanges

}
