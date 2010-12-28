#!/bin/bash
#
# render_getIdentityDefs.sh -- This function provides shared variables
# re-definition for all rendering features inside centos-art.sh
# script.
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

function render_getIdentityDefs {

    # Do not render translation template directories (Tpl/).
    if [[ $FILE =~ '/Tpl/.+\.sed$' ]];then
        continue
    fi

    # Define the translation file absolute path. Only if we have a
    # .sed extension at file's end we can consider that file as a
    # translation file.  Otherwise there is not translation file.
    if [[ $FILE =~ '\.sed$' ]];then
        TRANSLATION=$FILE
    else
        TRANSLATION=`gettext "None"`
    fi

    # Check translation file existence. This may seem unnecessary
    # because we already built the file list using existent files.
    # But what happen if any of the files already loaded are removed
    # after being loaded? well, just skip it.
    if [[ "$TRANSLATION" == 'None' ]];then
        cli_printMessage "`gettext "None"`" "AsTranslationLine"
    else
        cli_checkFiles "$TRANSLATION" 'fh'
        cli_printMessage "`gettext "Translation"`: $TRANSLATION"
    fi
    
    # Define the design template absolute path. This definition is
    # done by interpreting the matching list and translation path
    # information.  This defintion needs to be coherent with those
    # defined in render_getFilesList function.
    if [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" == "" ]];then
    
        # Remove the template (`Tpl/') string from FILE for those
        # rendering images based on design templates. This avoids
        # the creation of an extra `Tpl' directory under Img. We
        # want to save primary PNG file structure directly under
        # Img/ not Img/Tpl/.
        FILE=$(echo $FILE | sed -r "s!^${SVG}/!!")
    
        # In this case just one primary image is rendered.
        # Template points to the value passed in the template
        # argument.
        TEMPLATE=${MATCHINGLIST}
    
    elif [[ "${MATCHINGLIST}" == "" ]] \
        && [[ "${TRANSLATIONPATH}" == "" ]];then
    
        # Remove the template (`Tpl/') string from FILE for those
        # rendering images based on design templates. This avoids
        # the creation of an extra `Tpl' directory under Img. We
        # want to save primary PNG file structure directly under
        # Img/ not Img/Tpl/.
        FILE=$(echo $FILE | sed -r "s!^${SVG}/!!")
    
        # In this case one primary image is rendered for each
        # design template. Template absolute path points to a
        # design template (see LOCATION's definition).
        TEMPLATE=$FILE
        
    elif [[ "${MATCHINGLIST}" == "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
    
        # In this case translation files are applied to design
        # templates with the same name (without extension). One
        # primary image is rendered for each translation file
        # matching.  Template and translation files use the same
        # path and name relative to their PARENTDIR. Translations
        # use .sed extension and templates .svg extension.
        TEMPLATE=$(echo $FILE | sed -r "s!.*/${PARENTDIR}/(.*)!\1!" \
            | sed 's!\.sed$!.svg!')
    
    elif [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
    
        # Create a template and translation matching list.  With this
        # configuration we can optimize the rendering process for
        # artworks like Anaconda progress slides and installation
        # media, where many translation files apply one unique design
        # template file.
        #
        # Previous to this feature, there was one (repeated) design
        # template for each design holding the same design in all
        # cases, basically a raw copy. This structure is very hard to
        # maintain so it was reduced and optimized as we described
        # above.
        #
        # The idea is to create a link and customizable relation
        # between translation files and design template files in
        # pre-rendering configuration scripts and then interpret it
        # here.
        #
        # This way we pretend to eliminate duplicated design templates
        # saying something like translation 1.sed, 2.sed, 3.sed,
        # 4.sed, and 5.sed apply to the single design template A.svg.
        # Or, 1.sed, 3.sed, 4.sed to A.svg and 2.sed and 5.sed to
        # B.svg.
        #
        # Possible configuration 1: In this first case,
        # translation files and design templates share a common
        # portion of the path.  Sometimes, we call this common
        # portion of path the ``bond path''. This configuration is
        # strictly used under the following situations: 
        #
        #  1. There are too many translation files to apply to a
        #  single design template. This is the case of Brands
        #  artworks (see: trunk/Identity/Brands) rendering, where
        #  it is very difficult to maintain the relation list of
        #  design templates and translation files. E.g.:
        #
        #  bond/path/template.svg: \
        #     bond/path/translation1.sed \
        #     bond/path/translation2.sed
        #
        #  2. Translation files are under a directory with the same
        #  name of that used in the design template. All translation
        #  files inside this directory will be applied to the single
        #  design template that has the same name of the directory
        #  containing the translation files. E.g.:
        #
        #  bond/path/green.svg: \
        #     bond/path/green/translation1.sed \
        #     bond/path/green/translation2.sed
        #
        BOND=$(echo $TRANSLATION | sed -r "s/^.*\/$PARENTDIR\/(.+)\/.*\.sed$/\1/")

        # If there is no template at this point, start reducing the
        # bond path and try to use the result as template.  This is
        # needed in those cases where you have a directory structure
        # with various levels of translations inside it and want to
        # apply the last available design template that match to all
        # translation files in the directory structure.
        if [[ ! -f "$SVG/${BOND}.svg" ]];then
            until [[ -f "$SVG/${BOND}.svg" ]] ;do
                [[ $BOND =~ '^(\.|/)$' ]] && break
                BOND=$(dirname $BOND)
            done
        fi

        # Possible configuration 2: If no template is found using the
        # previous bond paths reduction, then lets look using design
        # template and translation file base name bond only.  Use this
        # configuration as much as possible.  Note that it is much
        # more flexible than possible configuration 1.
        #
        # In this configuration, the pre-rendering configuration takes
        # the following form:
        #
        #  template.svg: \
        #     translation1.sed \
        #     translation2.sed
        #
        if [[ ! -f "$SVG/${BOND}.svg" ]];then
            BOND=$(basename $TRANSLATION)
        fi
  
        # Possible configuration 2.1: If not design template was found
        # with the .svg extension, lets try design template without
        # extension. This configuration is useful for rendering plain
        # text files that doesn't use an extension (e.g., see inside
        # `trunk/Identity/Release' directory structure).
        #
        #  template: \
        #     translation1.sed \
        #     translation2.sed
        #
        if [[ ! -f "$SVG/${BOND}.svg" ]] \
            && [[ ! -f $SVG/{$BOND} ]];then
            BOND=$(basename $TRANSLATION)
        fi
        
        # Define design template applying bond filtering.
        TEMPLATE=$(echo "${MATCHINGLIST}" \
            | egrep "$BOND" \
            | cut -d: -f1 \
            | sort )

        # Sometimes one BOND pattern can match more than one design
        # template (i.e. 2c-tm pattern match in: 2c-tm, 2c-tmd,
        # 2c-tmdr).  It makes no sence to apply one translation file
        # to many differnt design templates at the same time.  This
        # way we need to reduce the design templates found to just
        # one, the one matching the BOND translation path exactly,
        # without .sed extension.
        if [[ $(echo "$TEMPLATE" | wc -l ) -gt 1 ]];then
        
            # Remove `.sed' extension from BOND. This is required in
            # order to build the BOND design template correctly.
            BOND=$(echo $BOND | sed 's!\.sed$!!')
        
            # Reduce template designs found to match BOND design
            # template. Take into account design templates extensions.
            TEMPLATE=$(echo "$TEMPLATE" \
                | egrep "${BOND}(\.svg|\.html|\.htm)?$")
        
        fi
 
        # Sometimes we need to apply all translation files to a single
        # design template.  At this point, if there is no design
        # template available yet, look inside matching list and use
        # its value as design template for all translation files.
        if [[ "$TEMPLATE" == '' ]] \
            && [[ "$MATCHINGLIST" =~ '^[[:alnum:][:digit:][:punct:]]+(\.svg|\.html|\.htm)?$' ]];then
            TEMPLATE="$MATCHINGLIST"
        fi
        
        # If there is no template found at this point, we need to
        # prevent an empty template from being used. It is a missing
        # assignment definition in the pre-rendering script surely.
        if [[ "$TEMPLATE" == '' ]];then
            cli_printMessage "`eval_gettext "There is no design template defined for \\\`\\\$FILE'."`" 'AsErrorLine'
            cli_printMessage "$(caller)" "AsToKnowMoreLine"
        fi
    
    fi
    
    # Remove any release number from design template's path.  Release
    # directories are used under Translations structure only.
    # Removing release numbers from design template path makes
    # possible to match many release-specific translations to the same
    # design template. There is no need to duplicate the release
    # structure inside design template structure.
    TEMPLATE=$(echo $TEMPLATE | sed -r "s!^${RELEASE_FORMAT}/!!")
    
    # Remove any language from design template's path. Language
    # code directories are used under Translation structure only.
    # Removing language code directories from design template path
    # makes possible to match many language translations to the
    # same design templates. There is no need to duplicate
    # language code directories inside design template structure.
    if [[ $TEMPLATE =~ '^[[:alpha:]]{2}(_[[:alpha:]]{2}){,1}/' ]];then
    
        # It seems like the first directory referes to a language
        # code. At this point we check if that value is a valid
        # language code. 
        if [[ "$(cli_getLangCodes $(echo $TEMPLATE | cut -d/ -f1))" != '' ]];then
    
            # The value is a valid language code. Remove it from path
            # so design template path can be built correctly.
            TEMPLATE=$(echo $TEMPLATE | sed "s!$(echo $TEMPLATE | cut -d/ -f1)/!!")
    
         fi
    fi
    
    # Redefine design template using absolute path.
    if [[ -f $SVG/$(basename $TEMPLATE) ]];then
        # Generally, template files are stored one level inside
        # Tpl/ directory.
        TEMPLATE=$SVG/$(basename $TEMPLATE)
    else
        # Others, template designs may be stored some levels inside
        # the template structure. At this point, we look deeper inside
        # template's directory structure and redefine template path.
        # Avoid using duplicated names inside template directory
        # structure. If there are duplicate names, the first one in
        # the list is used and the rest is discarded.
        TEMPLATE=$(find $SVG -regextype posix-egrep -regex \
            ".*/${TEMPLATE}" | sort | head -n 1)
    fi
    
    # Check existence of TEMPLATE file. If design template doesn't
    # exist we cannot render it; in such case, stop working for it and
    # try the next one in the list.
    cli_checkFiles "$TEMPLATE"  'f'
    cli_printMessage "`gettext "Design"`: $TEMPLATE" 'AsRegularLine'
     
    # Get relative path to file. The path string (stored in FILE) has
    # two parts: 1. the variable path and 2. the common path.  The
    # variable path is before the common point in the path string. The
    # common path is after the common point in the path string. The
    # common point is the name of the parent directory (stored in
    # PARENTDIR).
    #
    # ... trunk/Translations/.../Firstboot/3/splash-small.sed
    # -------------------------^| the     |^------------^
    # variable path             | common  |    common path
    # -------------------------v| point   |    v------------v
    # ... trunk/Identity/Them.../Firstboot/Img/3/splash-small
    #
    # What we do here is remove the varibale path, the common point,
    # and the file extension parts in the string holding the path
    # retrived from translations structure. Then we use the common
    # path as relative path to the image file.
    #
    # The .sed file extension is removed from the common path.
    # Instead we assign the appropriate file extension when defining
    # file name.
    #
    # When rendering using renderImage function, the structure of
    # files under Img/ directory will be the same of that used after
    # the common point in its related Translations or Template
    # directory depending in which one was taken as reference when
    # LOCATION variable was defined. 
    FILE=$(echo $FILE \
        | sed -r "s!.*${PARENTDIR}/!!" \
        | sed -r 's!\.(sed|svg|html|htm)$!!')
    
    # Re-define absolute path to directory holding image file.
    DIRNAME=$IMG/$(dirname $FILE)
    
    # Check existence of output image directory.
    if [[ ! -d $DIRNAME ]];then
        mkdir -p $DIRNAME
    fi
    
    # Define absolute path to file.
    FILE=$IMG/$FILE

    # Define instance name.
    INSTANCE=$(cli_getTemporalFile $TEMPLATE)

    # Remove template instance if it is already present.
    if [[ -a $INSTANCE ]];then
        rm $INSTANCE
    fi

    # Create the design template instance. When building the instance,
    # take into account the matching list and translation path. It
    # should be coherent with previous definitions above and in
    # render_getFilesList.
    if [[ "${MATCHINGLIST}" == "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
   
        sed -f $TRANSLATION $TEMPLATE > $INSTANCE
   
    elif [[ "${MATCHINGLIST}" == "" ]] \
        && [[ "${TRANSLATIONPATH}" == "" ]];then
   
        cat $TEMPLATE > $INSTANCE
   
    elif [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" == "" ]];then
   
        cat $TEMPLATE > $INSTANCE
   
    elif [[ "${MATCHINGLIST}" != "" ]] \
        && [[ "${TRANSLATIONPATH}" != "" ]];then
   
        sed -f $TRANSLATION $TEMPLATE > $INSTANCE

    fi

    # Replace common translation markers inside instance.
    render_doTranslationMarkers

}
