#!/bin/bash
#
# cli_getCopyrightInfo.sh -- This function outputs copyright
# information based on action value (ACTIONVAL) variable.
#
# The copyright information is printed to show the fact that one
# person how creates something has the creation rights over that
# something he/she created. An so, the legal power to release his/her
# creation under the ethical terms of whatever license he/she
# considers more appropriate, in order to distribute his/her creation.
#
# Inside CentOS Artwork Repository, we print copyright information in
# the following image-related components:
#
#   1. The artistic motifs, to define the visual style of themes.
#
#      The copyright information of artistic motifs is owned by the
#      person who creates the artistic motif (i.e., the artistic motif
#      author). The copyright information of artistic motifs is
#      specified in the `authors.txt' file placed inside the artistic
#      motif directory structure. The copyright information of
#      artistic motifs is printed in imagesunder
#      trunk/Identity/Themes/Motifs/$THEME/Concept directory structure
#      only.
# 
#   2. The design models, to define the characteristics of themes.
# 
#      The copyright information of design models is owned by the
#      person who creates the design model (i.e., the design model
#      author). The copyright information of design models is
#      specified in the metadata of each scalable vector graphic that
#      make a design model on its own. The copyright information of
#      design models is not printed in images.
#
#   3. The CentOS themes, to cover each visual manifestation of The
#      CentOS Project corporate visual identity.  A CentOS theme is
#      made of many different images connected among themselves by
#      mean of a uniform visual pattern (artistic motif + design
#      model).
#
#      The copyright information of CentOS themes is owned by The
#      CentOS Project. Instead of printing the copyright information
#      over all images inside one CentOS theme, the copyright
#      information of CentOS themes is printed only on images related
#      to Anaconda progress first slides.
#
#      The copyright information printed on Anaconda progress first
#      slides is used to print the creation rights of The CentOS
#      Project over its creation (i.e., The CentOS Distribution) not
#      The CentOS Theme itself.
# 
# At this point, we've defined who own the creation rights of image
# components. Now, it is important to remark that if we need to show
# one creation copyright, in different places, all references to the
# same cration copyright information should be the same. Cannot be any
# ambiguity among them. The best way to reach this is having just one
# unique definition, and build images using that unique copyright
# definition as reference.
#     
# Another relevant point, we need to be aware of, is that related to
# the licenses. As creators has the creation rights, they have the
# right to distribute their work as their consideration.  If creators
# release their creations under the terms of a privatizing license,
# that creation will be almost useless for The CentOS Community. So,
# in order for creations to be useful in The CentOS Community,
# creators should distribution their creations under the terms of a
# license that grants the freedom of using, studying, changing and
# releasing improved versions of them. Likewise, the license should
# prevent any privatizing practice or any kind of darkness that put in
# risk the freedom of The CentOS Community.
# 
# What license should be used to distribute images (and the components
# used to build them) is a decision for The CentOS Community to take.
# The license adopted, by The CentOS Community, specifies the ethical
# terms The CentOS Community is agree to work with. It is a reference
# we all have to agree with and follow in the sake of our community
# and ourselves freedom.  That's why license selection has to be a
# collective decision, and also be constantly in question.
#
# I'm not a lawyer. So, I can't give details of something I don't know
# certainly.  All I've done so far is using my intuition and basic
# understanding of what copyright and license is. So, if you have a
# deeper understanding and experience in such legal topics, please
# feel free to make your own revisions to ideas described here.
#         
# In the sake of covering copyright information and license needs
# inside centos-art.sh script, all images produced by `centos-art.sh'
# script will be released using the copyright information of his/her
# creator (see above) and the license Creative Common
# Attribution-ShareAlike 3.0 License
# (http://creativecommons.org/licenses/by-sa/3.0/).  
#
# The Creative Common Attribution-ShareAlike 3.0 License has been
# adopted in The CentOS Wiki (http://wiki.centos.org/) and seems to be
# good as well to distribute image-specific creations under CentOS
# Artwork Repository. Of course, as licenses are always questionable,
# the one we've choosed could be changed in the future after a
# collective discussion in the CentOS mailing list, in order to better
# reflect the ethical feelings of our community.
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
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

function cli_getCopyrightInfo {

    local -a DIRS
    local -a FILES
    local -a NOTES
    local NOTE=''
    local COUNT=0

    # Define directory structures that don't use default information.
    DIRS[0]="$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getPathComponent '--theme')/Concept"
    DIRS[1]="$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getPathComponent '--theme')/Promo"

    # Define absolute path to file from which we retrive copyright
    # information for directory structures that don't use default
    # information. 
    FILES[0]="$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getPathComponent '--theme-name')/copyright.txt"

    case "$1" in

        '--description' )

            # Define default description information.
            NOTE="The CentOS Project corporate visual identity."

            # Define description information for directory structures
            # that don't use default description information.
            NOTES[0]="=THEMENAME= is an artistic motif and theme for ${NOTE}"
            ;;

        '--license' )

            # Define default license information used by all
            # image-based creations inside CentOS Artwork Repository.
            NOTE="Creative Common Attribution-ShareAlike 3.0 License."

            # Define license information for directory structures that
            # don't match default license information.
            NOTES[0]="=THEMENAME= artistic motif and theme are released under ${NOTE}"
            NOTES[1]="`gettext "The CentOS distribution is released as GPL."`"
            ;;
        
        '--license-url' )

            # Define default license url used by all image-based
            # creations inside CentOS Artwork Repository.
            NOTE="http://creativecommons.org/licenses/by-sa/3.0/"

            # Define license  url for directory structures that don't
            # match default license information.
            NOTES[0]="${NOTE}"
            NOTES[1]="http://opensource.org/licenses/gpl-license.php"
            ;;

        '--copyright' | * )
    
            # Define default copyright information.
            NOTE="Copyright © 2003-$(date +%Y) The CentOS Project. `gettext "All rights reserved."`"

            # Define copyright information for directory structures
            # that don't match default copyright information.
            if [[ -f ${FILES[0]} ]];then
                NOTES[0]=$(cli_readFileContent "${FILES[0]}" '--copyright')
            fi
            ;;
    esac

    # Redefine information of directory structures that don't use
    # default copyright information.
    while [[ ${COUNT} -lt ${#DIRS[*]} ]];do
        if [[ $ACTIONVAL =~ "${DIRS[$COUNT]}" ]];then
            if [[ "${NOTES[$COUNT]}" != '' ]];then
                NOTE="${NOTES[$COUNT]}"
            fi
        fi
        COUNT=$(($COUNT + 1))
    done

    # Print information.
    echo "$NOTE"

}
