#!/bin/bash
#
# render_getActionsTranslations.sh -- This function takes translation
# templates and produces the release-specific translation structures
# needed by renderImage function.
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

function render_getActionsTranslations {

    # Check parent directory. Translation rendition takes place under
    # trunk/Translations directory structure only. Be sure action
    # value referes a translation directory structure before perform
    # translation rendition.
    if [[ ! $ACTIONVAL =~ "^$(cli_getRepoTLDir $ACTIONVAL)/Translations/.+$" ]];then
        cli_printMessage "`eval_gettext "Can't do translation rendition at \\\`\\\$ACTIONVAL'."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Check directory content. Translation rendition can be realized
    # only if inside the action value directory there is a 'Tpl/'
    # directory. Translation rendition is based on translation
    # templates inside 'Tpl/' directory. If that directory doesn't
    # exist leave a message and quit execution. 
    if [[ ! -d $ACTIONVAL/Tpl ]];then
        cli_printMessage "`gettext "Can't find translation templates in the directory provided."`" 'AsErrorLine'
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # Check if there are pre-defined configuration scripts for the
    # current translation directory being processed. If you passed the
    # previous checks, it is time to check if the directory you are
    # processing already has render.conf.sh configuration scripts,
    # inside its trunk/Scripts/Bash/Config/... asociated strucutre. If
    # such directory entry exists, the translation rendition should
    # end immediatly at this point because it is surely not a
    # release-specific translation rendition.
    if [[ -d $ARTCONF ]];then
        for FILE in $(find $ARTCONF -name 'render.conf.sh');do
            # Initialize configuration function.
            . $FILE
            # Execute configuration function
            render_loadConfig
        done
        # At this point, an entry inside trunk/Scripts/Bash/Config/...
        # was found for the directory being processed. If the
        # render.conf.sh files were there, they were executed. Because
        # render.conf.sh has to do with very specificy translation
        # rendition features (e.g., brands translation rendition),
        # that doesn't match release-specifc translation rendition
        # (the one done after this block). So, we need to end the
        # translation rendition right here.
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    # -------------------------------------------------------------
    # - release-specific translation rendition stuff from this point on.
    # -------------------------------------------------------------

    # Initialize variables as local to avoid conflicts in other places.
    local RELEASES=''
    local MAJOR_RELEASE=''
    local MINOR_RELEASE=''
    local RELEASE_INFO=''
    local LOCALES_INFO=''
    local LOCALE=''
    local TRANSLATION=''
    local FILE=''

    # Define warning message about the nature of release notes
    # translation files. This message is included in the very top of
    # every translation file.
    local MESSAGE="\
        # Warning: Do not modify this file directly. This file is created
        # automatically using 'centos-art' command line interface.  Any change
        # you do in this file will be lost the next time you update
        # translation files using 'centos-art' command line interface. If you
        # want to improve the content of this translation file, improve its
        # template file instead and run the 'centos-art' command line
        # interface later to propagate your changes."

    # Strip opening spaces from warning message output lines. 
    MESSAGE=$(echo "$MESSAGE" | sed 's!^[[:space:]]*!!')

    # Re-define releases using action value. If there is an
    # --option=value arguments then use the value to create/update
    # release-specific directories.  Otherwise, all release-specific
    # translations directories available in the current location will
    # be affected.
    if [[ $FLAG_FILTER =~ "^${RELEASE_FORMAT}$" ]];then
        RELEASES=$ACTIONVAL/$FLAG_FILTER

    # Re-define releases using regular expression value. If you need
    # to create/update two or more release-specific directories (e.g.,
    # 5, 5.1, 5.2, and 6.0), you can use a command similar to
    # 'centos-art render --translation=./ --filter=5,5.1,5.2,6.0' to
    # create them all using just one command.
    elif [[ $FLAG_FILTER =~ "^(${RELEASE_FORMAT},?)+" ]];then
        for RELEASE in $(echo $FLAG_FILTER | tr ',' ' ');do
            RELEASES="$RELEASES $RELEASE"
        done

    # By default look for available release-specific directories and
    # use them all.
    else
        RELEASES=$(find $ACTIONVAL -regextype posix-egrep \
            -regex "^${ACTIONVAL}/${RELEASE_FORMAT}$" | sort)
    fi

    # At this point, if there isn't release-specific directories
    # inside translation entry, output a message and quit script
    # execution.
    if [[ $RELEASES == "" ]];then
        cli_printMessage "`gettext "There is not release-specific directory in the translation entry."`"
        cli_printMessage "$(caller)" "AsToKnowMoreLine"
    fi

    for RELEASE in $RELEASES;do

        # Strip directory path from release number.
        RELEASE=$(basename $RELEASE)

        # Check release format.
        if [[ ! "$RELEASE" =~ "^${RELEASE_FORMAT}$" ]]; then
            cli_printMessage "`eval_gettext "The \\\"\\\$RELEASE\\\" release number isn't valid."`"
            cli_printMessage "$(caller)" "AsToKnowMoreLine"
        fi

        # Define major and minor release format.
        if [[ "$RELEASE" =~ '^[[:digit:]]+\.[[:digit:]]+$' ]]; then
            MAJOR_RELEASE="$(echo $RELEASE | cut -d. -f1)"
            MINOR_RELEASE="$(echo $RELEASE | cut -d. -f2)"
        elif [[ "$RELEASE" =~ '^[[:digit:]]+$' ]]; then
            MAJOR_RELEASE="$RELEASE"
            MINOR_RELEASE='0'
        fi

        # Define release translation markers.
        RELEASE_INFO="
            # Release number information.
            s!=RELEASE=!=MAJOR_RELEASE=.=MINOR_RELEASE=!g
            s!=MINOR_RELEASE=!$MINOR_RELEASE!g
            s!=MAJOR_RELEASE=!$MAJOR_RELEASE!g"
    
        # Strip opening spaces from release info output lines.
        RELEASE_INFO=$(echo "$RELEASE_INFO" | sed 's!^[[:space:]]*!!')
  
        # Get translation templates and process them using release
        # information previously defined.
        for FILE in $(find $ACTIONVAL/Tpl -name '*.sed');do

            # Define translation file locale.
            LOCALE=$(echo $FILE | sed -r 's!^/.+/Tpl/([a-z]{2}|[a-z]{2}_[A-Z]{2})/.+$!\1!' )
            if [[ $LOCALE =~ '^([a-z]{2}|[a-z]{2}_[A-Z]{2})$' ]];then

                # Define locales translation markers.
                LOCALES_INFO="
                    # Locale information.
                    s!=LOCALE=!${LOCALE}!g"

                # Strip opening spaces from locales translation markers
                # output lines.
                LOCALES_INFO=$(echo "$LOCALES_INFO" | sed 's!^[[:space:]]*!!')

            fi

            # Define absolute path to translation template file.
            TRANSLATION=$FILE

            # Define absolute path to translation final file.
            FILE=$(echo $FILE | sed "s!/Tpl!/$RELEASE!")

            # Create release-specific directory, if it doesn't exist.
            DIRNAME=$(dirname $FILE)
            if [[ ! -d $DIRNAME ]];then
                mkdir -p $DIRNAME
            fi

            # Output information about files being processed.
            cli_printMessage $TRANSLATION "AsTranslationLine"
            cli_printMessage $FILE "AsSavedAsLine"

            # Add warnning message to final translation file.
            echo "$MESSAGE" > $FILE

            # Add template content to final translation file.
            cat $TRANSLATION >> $FILE

            # Add release markers to final translation file.
            echo "$RELEASE_INFO" >> $FILE

            # Add locales markers to final translation file, if they
            # have locales information only.
            if [[ $LOCALES_INFO != '' ]];then
                echo "$LOCALES_INFO" >> $FILE
                # Clean up locales information variable to receive
                # next value. If we don't clean up the variable here,
                # translation files without locale information (e.g.,
                # progress-first.sed, firstboot-left.sed, etc.) will
                # use the locale information of the last translation
                # template which does have locale information and we
                # don't want that. We want to set locale information
                # for each translation template individually.
                LOCALES_INFO=''
            fi

            # Output separator line.
            cli_printMessage '-' "AsSeparatorLine"

        done

    done \
        | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
}
