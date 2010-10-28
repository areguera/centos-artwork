#!/bin/bash
#
# render_loadConfig.sh -- This function defines CentOS brands
# pre-rendering configuration script. This function is used to produce
# CentOS brands translation files.
#
# The rendering process used to produce CentOS Brands translation
# files is a bit different to that commonly found in other artwork
# components inside CentOS Artwork Repository. Relevant differences
# are described below:
#
#  1) Translation files are not regular files, but symbolic links
#  pointing to the common template translation structure, inside the
#  translation template (`Tpl') directory.
#
#  2) Translation files are created using design templates as
#  reference. This script creates a translation structure where the
#  translation template (`Tpl') directory structure applies to each
#  single design template available.
#
#  For instance, if the translation template (`Tpl') directory
#  structure has 30 translation files and there are 20 design
#  templates, this script creates a translation structure of symbolic
#  links where the 30 translation files apply the 20 design templates
#  one by one, producing 600 images as result ---without counting
#  possible formats convenction that may happen during the
#  post-rendering actions---.
#
# Translation file names inside translation template (`Tpl') directory
# have special meaning:
#
#  1) Conventional file name (i.e. `blue.sed', `2c-a.sed', etc.): In
#  this case, replacements inside translation file are applied to
#  design template and the translation file name is used as final
#  image name. The final image is saved with same dimensions that its
#  design template has.
#
#  2) Numeric file name only (i.e. `300.sed', `200.sed', etc.): In
#  this case, replacements inside translation files are applied to the
#  design template, and the translation file name is used as final
#  image name. The final image is saved using an specific `width'
#  defined by the number part of the translation file name. The image
#  `height' is automatically scaled based on the previous `width'
#  definition to maintain the design template proportions. 
#
#  For instance, if your design template has 400x200 pixels of
#  dimension, and you apply a translation file named `300.sed' to it,
#  the final image you get as result will have 300x100 pixels of
#  dimension. 
#
#  The same is true if you use higher numbers like `1024.sed',
#  `2048.sed', etc. In these cases you have bigger images
#  proportionally.
#
#  As we are using scalable vectorial graphics as source, image size
#  definition starts to be a problem on very small generated images.
#  Bigger images have better definition. As it is bigger, more is the
#  image definition you have. But take care, too much definition for
#  an image that was not designed for such a big dimension can result
#  in something that looks different from what you expect. Just try,
#  look, and decide by yourself.
#
# Generally, translation files inside translation template (`Tpl')
# directory structure contain color replacements only. The color used
# as replacement pattern is black (#000000).
#
# Using CentOS Brand translation files rendering script, CentOS Brand
# designers can work freely and use this script to generate the
# translation files that renderImage needs, in order to produce CentOS
# Brand images in different dimensions and colors.
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

function render_loadConfig {

    # Define variables as local to avoid conflits in the function
    # outside.
    local FILE=''
    local TRANSLATION=''
    local BOND=''
    local DIRNAME=''

    # Define absolute path holding CentOS Brand design templates.
    local SVG=/home/centos/artwork/trunk/Identity/Brands/Tpl

    # Define absolute path holding CentOS Brand translations files.
    local TXT=/home/centos/artwork/trunk/Translations/Identity/Brands

    # Define bond path. Remove template (`./Tpl/') directory and
    # `.svg' extension from design template (`Tpl') structure.
    local BONDS=$(find $SVG -name '*.svg' \
       | sed -e "s!$SVG/!!" -e 's!\.svg$!!' | sort )

    for BOND in $BONDS;do

        # Look inside CentOS Brand translation template (`Tpl') directory
        # and remove the `Tpl/' string from path to produce the final
        # translation structure, relatively to the current location.
        # If the third argument has the form --filter=regex then you
        # can reduce the amount of translation templates to process
        # using the string regex as pattern. 
        for FILE in $(find $TXT/Tpl -regextype posix-egrep \
            -regex "^.+/$REGEX\.sed$" | sort );do

            # Define translation path.
            TRANSLATION=$FILE

            # Re-define file path.
            FILE=$(echo $FILE | sed -r 's!^.+/Tpl/!!')

            # Check output directory existence.
            DIRNAME=$(dirname $OPTIONVAL/$BOND/$FILE)
            if [ ! -d $DIRNAME ]; then
               mkdir -p $DIRNAME
            fi

            # Create final translation structure.  Brands' translation
            # files are always the same, in contrats with commonly
            # used translation files, there is no releases involved.
            # This let us reuse translation files using symbolic links
            # and pointing them to translation template (`Tpl') files.
            cli_printMessage $TRANSLATION "AsTranslationLine"
            cli_printMessage $OPTIONVAL/$BOND/$FILE "AsLinkToLine"
            ln -sf $TRANSLATION $OPTIONVAL/$BOND/$FILE

            echo '----------------------------------------------------------------------'

        done

    done \
        | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
}
