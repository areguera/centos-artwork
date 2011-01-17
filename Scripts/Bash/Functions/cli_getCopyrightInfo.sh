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
# At this point, we've defined who own the creation rights of artistic
# motifs, design models, and the CentOS themes.
#     
# Now, in order for the CentOS Community to use these components, it
# is required that each component author relases his/her creation
# under a license that grants the freedom of using, studying, changing
# and releasing improved versions of his/her creation. Also, the license
# should prevent any privatizing practice or any kind of darkness that
# put in risk the freedom of CentOS Community.
# 
# What license to use is a decision that CentOS Community has to take.
# The license adopted, by CentOS Community, specifies the ethical terms
# the CentOS Community agree to work with. It reflects the
# philosophical thinking of CentOS Community, so all creation inside
# CentOS Community should be released under such license terms, no
# matter who the person who creates something be. If some person want
# to create for CentOS, that person has to aggree with CentOS
# Community philosophical thinking (i.e. that reflected by license
# adopted to release creations). This way, that's because it is so
# important that the decision of what license to use be a collective
# decision, that everyone understand why we are using this license and
# not other.
#
# I'm not a lawyer. So, I can't give details of something I don't know
# certainly.  All I can do is using my intuition and it says to me
# that Creative Common Attribution-ShareAlike 3.0 License
# (http://creativecommons.org/licenses/by-sa/3.0/) seems to be a good
# candidate. It has been used in the wiki (http://wiki.centos.org/)
# for some time. Also, other relevant projects like The Tango Project
# are using it to release art works and similar creations.
#         
# So, in the sake of covering copyright information and license needs
# inside centos-art.sh script, all images produced by `centos-art.sh'
# script will be released using the copyright information his/her
# author (see above) and the license Creative Common
# Attribution-ShareAlike 3.0 License
# (http://creativecommons.org/licenses/by-sa/3.0/).  This could change
# in the future, after a collective discussion in the CentOS mailing
# list.
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

    local NOTE=''
    local DIR=''
    local -a DIRS
    local -a NOTES
    local COUNT=0

    # Define directory structures that don't use default information.
    DIRS[0]="$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getThemeName)/Concept"

    case "$1" in

        '--description' )

            # Define default description information.
            NOTE="The CentOS Project corporate visual identity"

            # Define description information for directory structures
            # that don't use default description information.
            NOTES[0]="=NAME= is an artistic motif and theme for ${NOTE}."
            ;;

        '--license' )

            # Define default license information used by all
            # image-based creations inside CentOS Artwork Repository.
            NOTE="Creative Common Attribution-ShareAlike 3.0 License"

            # Define license information for directory structures that
            # don't match default license information.
            NOTES[0]="=NAME= artistic motif and theme are released under ${NOTE}."
            ;;

        '--copyright' | * )
    
            # Define default copyright information.
            NOTE="Copyright © 2003-$(date +%Y) The CentOS Project. All rights reserved."

            # Define copyright information for directory structures
            # that don't use default copyright information.
            NOTES[0]=$(cli_readFileContent \
                "$(cli_getRepoTLDir)/Identity/Themes/Motifs/$(cli_getThemeName)/authors.txt" \
                '--copyright')
            ;;
    esac

    # Redefine information of directory structures that don't use
    # default copyright information.
    while [[ ${COUNT} -lt ${#DIRS[*]} ]];do
        if [[ $ACTIONVAL =~ "${DIRS[$COUNT]}" ]];then
            if [[ "${NOTES[$COUNT]}" != '' ]];then
                NOTE=${NOTES[$COUNT]}
            fi
        fi
        COUNT=$(($COUNT + 1))
    done

    # Print information.
    echo $NOTE

}
