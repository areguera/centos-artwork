#!/bin/bash
#
# prepare_forUsingPackages.sh -- This function queries your system's
# rpm database to verify centos-art.sh required packages existence.
# If there is any missing package, leave a message and quit script
# execution.
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
# $Id: prepare_forUsingPackages.sh 65 2010-09-18 03:18:50Z al $
# ----------------------------------------------------------------------

function prepare_forUsingPackages {

    # Output action message.
    cli_printMessage "`gettext "Packages"`" "AsHeadingLine"

    # Define variables as local to avoid conflicts outside.
    local PACKAGE=''
    local PACKAGES=''
    local PACKAGES_FROM_THIRDS=''
    local MISSING_PACKAGES=''
    local MISSING_PACKAGES_COUNTER=0
    local MISSING_PACKAGES_REPORT='' 
    local MISSING_PACKAGES_FROM_THIRDS=''
    local MISSING_PACKAGES_FROM_THIRDS_COUNTER=0

    # Define required packages needed by centos-art.sh script.
    PACKAGES="bash inkscape ImageMagick netpbm netpbm-progs
        syslinux gimp coreutils texinfo info tetex-latex tetex-fonts
        tetex-doc tetex-xdvi tetex-dvips gettext sudo yum texi2html"

    # Define, from required packages, packages being from third
    # parties (i.e., packages not included in rhel, nor centos [base]
    # repository.).
    PACKAGES_FROM_THIRDS="(inkscape|blender)"

    # Query RPM's database looking for required packages and build
    # list of missing packages.
    for PACKAGE in $PACKAGES;do
        rpm -q "$PACKAGE" >> /dev/null
        if [[ $? -gt 0 ]];then
            MISSING_PACKAGES="$PACKAGE $MISSING_PACKAGES"
            MISSING_PACKAGES_COUNTER=$(($MISSING_PACKAGES_COUNTER + 1))
            if [[ $PACKAGE =~ $PACKAGES_FROM_THIRDS ]];then
                MISSING_PACKAGES_FROM_THIRDS="$PACKAGE $MISSING_PACKAGES_FROM_THIRDS"
                MISSING_PACKAGES_FROM_THIRDS_COUNTER=$(($MISSING_PACKAGES_FROM_THIRDS_COUNTER + 1))
            fi
        fi
    done

    # Check required packages.
    if [[ $MISSING_PACKAGES_COUNTER -gt 0 ]];then

        cli_printMessage "`ngettext "The following package needs to be installed:"\
                                    "The following packages need to be installed:"\
                                    $MISSING_PACKAGES_COUNTER`"
        for PACKAGE in $MISSING_PACKAGES;do
            cli_printMessage $PACKAGE "AsResponseLine"
        done
        cli_printMessage "`gettext "Do you want to install the packages now?"`" "AsYesOrNoRequestLine"

        # Before installing packages, output a warning about
        # centos-art.sh required packages being from third parties (if
        # any).
        if [[ $MISSING_PACKAGES_FROM_THIRDS_COUNTER -gt 0 ]];then

            # Give format to missing packages from third parties.
            MISSING_PACKAGES_FROM_THIRDS=$(echo $MISSING_PACKAGES_FROM_THIRDS \
                | sed -r -e 's![[:space:]]+$!!' -e 's![[:space:]]+!, !g')

            cli_printMessage "`eval_ngettext \
            "The package \\\"\\\$MISSING_PACKAGES_FROM_THIRDS\\\" is not part of CentOS distribution. In order to install this package, you need to install third party repositories first.  For more information about installing third party repositories on CentOS distribution, see the url: http://wiki.centos.org/AdditionalResourses/Repositories."\
            "The packages \\\"\\\$MISSING_PACKAGES_FROM_THIRDS\\\" are not part of CentOS distribution. In order to install these packages, you need to install third party repositories first.  For more information about installing third party repositories on CentOS distribution, see the url: http://wiki.centos.org/AdditionalResourses/Repositories."  $MISSING_PACKAGES_FROM_THIRDS_COUNTER`" "AsWarningLine"
            
            cli_printMessage "`gettext "Do you want to continue?"`" "AsYesOrNoRequestLine"
 
        fi

        # Use sudo to install packages. By default user names
        # need to be set inside sudoers configuration file
        # (/etc/sudoers) in order to perform sudo commands.
        sudo yum install $MISSING_PACKAGES

        # Re-check packages. This is needed for those situations where
        # the user chooses not to install the required packages when
        # yum request for confirmation. If we don't re-check install
        # package the successful message is display after answering
        # negatively to yum's confirmation message. Additionally, it
        # helps to let the user know that third party packages are
        # still missing when third party repositories are not
        # installed inside CentOS distribution.
        for PACKAGE in $PACKAGES;do
            rpm -q "$PACKAGE" >> /dev/null
            if [[ $? -gt 0 ]];then
                prepare_forUsingPackages
            fi
        done

    else

        cli_printMessage "`gettext "The packages required by centos-art.sh script are already installed."`"

    fi

}
