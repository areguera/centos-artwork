#!/bin/bash
#
# cli_printMessage.sh -- This function outputs information in
# predifined formats. This function (cli_printMessage) is the standard
# way to output information inside centos-art.sh script.
#
#   cli_printMessage $1 $2
#   $1 --> The message you want to output.
#   $2 --> The message format.
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
# $Id: cli_printMessage.sh 98 2010-09-19 16:01:53Z al $
# ----------------------------------------------------------------------

function cli_printMessage {

    # Define variables as local to avoid conflicts outside.
    local MESSAGE="$1"
    local FORMAT="$2"

    # Reduce paths inside output messages. The main purpose for this
    # is to free horizontal space in output messages.
    MESSAGE=$(echo "$MESSAGE" \
        | sed -r 's!/home/centos/artwork/(trunk|branches|tags)/!\1/!')

    # Remove blank spaces from lines' begining.
    MESSAGE=$(echo "$MESSAGE" | sed -r 's!^[[:space:]]+!!')

    # Define message formats.
    case $FORMAT in

        'AsHeadingLine' )
            echo '----------------------------------------------------------------------'
            echo "$MESSAGE" | fmt --width=70
            echo '----------------------------------------------------------------------'
            ;;

        'AsWarningLine' )
            echo '----------------------------------------------------------------------'
            echo "`gettext "WARNING"`: $MESSAGE" | fmt --width=70
            echo '----------------------------------------------------------------------'
            ;;

        'AsNoteLine' )
            echo '----------------------------------------------------------------------'
            echo "`gettext "NOTE"`: $MESSAGE" | fmt --width=70
            echo '----------------------------------------------------------------------'
            ;;

        'AsHelpLine' )
            echo '----------------------------------------------------------------------'
            echo "$MESSAGE" | fmt --width=70
            echo '----------------------------------------------------------------------'
            cli_printMessage "`gettext "HELP"`: centos-art help --read=$OPTIONVAL" 
            echo '----------------------------------------------------------------------'
            ;;

        'AsUpdatingLine' )
            echo "`gettext "Updating"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsRemovingLine' )
            echo "`gettext "Removing"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsCheckingLine' )
            echo "`gettext "Checking"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsCreatingLine' )
            echo "`gettext "Creating"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsSavedAsLine' )
            echo "`gettext "Saved as"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsLinkToLine' )
            echo "`gettext "Linked to"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsMovedToLine' )
            echo "`gettext "Moved to"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsTranslationLine' )
            echo "`gettext "Translation"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsConfigurationLine' )
            echo "`gettext "Configuration"`: $MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        'AsResponseLine' )
            echo "--> $MESSAGE"
            ;;

        'AsRequestLine' )
            echo -n $MESSAGE
            ;;

        'AsYesOrNoRequestLine' )
            echo -n "$MESSAGE [${Y}/${N}]: "
            read ANSWER
            if [[ ! $ANSWER =~ "^${Y}" ]];then
                exit
            fi
            ;;

        'AsToKnowMoreLine' )
            # This option receives the output of bash's caller builtin
            # as message value, in order to produce the documentation
            # entry automatically. As caller builtin outputs the
            # caller file path, documentation entry built from here is
            # a file documentation entry.
            MESSAGE=$(echo $MESSAGE | cut -d ' ' -f2-)
            MESSAGE="$(dirname $MESSAGE)' --filter='$(basename $MESSAGE)"
            echo "----------------------------------------------------------------------"
            echo "`gettext "To know more, run the following command"`:"
            echo "centos-art help --read='$MESSAGE'"
            echo "----------------------------------------------------------------------"
            exit # <-- ATTENTION: Do not remove this line. We use this
                 #                case as convenction to end script
                 #                execution.
            ;;

        'AsRegularLine' )
            echo "$MESSAGE" \
                | awk -f /home/centos/artwork/trunk/Scripts/Bash/Styles/output_forTwoColumns.awk
            ;;

        * )
            echo "$MESSAGE"
            ;;

    esac

}
