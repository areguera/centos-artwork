#!/bin/bash

function update_setPoMetadata {

    local COUNT=0
    local -a SRC
    local -a DST

    # Retrieve absolute path of portable object we'll work with.
    local PO_FILE="${1}"

    # Check existence of file before work with it.
    tcar_checkFiles -ef "${PO_FILE}"

    # Define pattern lines. The pattern lines are put inside portable
    # objects through xgettext and xml2po commands. In the case of
    # Last-Translators, be sure to remplace it only when it is empty
    # or refer the Documentation SIG only. This way translators' names
    # will survive metadata updates. We don't want they have to type
    # their name each time they edit a file.
    SRC[0]="\"Project-Id-Version: (.+)?"
    SRC[1]="\"Last-Translator: (.+)?"
    SRC[2]="\"Language-Team: (.+)?"
    SRC[3]="\"PO-Revision-Date: (.+)?"

    # Define replacement lines for pattern line.
    DST[0]="\"Project-Id-Version: ${TCAR_SCRIPT_NAME} ${TCAR_SCRIPT_VERSION}\\\n\""
    DST[1]="\"Last-Translator: Localization SIG <centos-l10n-${TCAR_SCRIPT_LANG_LL}@centos.org.cu>\\\n\""
    DST[2]="\"Language-Team: $(update_getLanguageName)\\\n\""
    DST[3]="\"PO-Revision-Date: $(date "+%F %H:%M%z")\\\n\""

    # Change pattern lines with their replacement lines.
    while [[ ${COUNT} -lt ${#SRC[*]} ]];do
        sed -i -r "/${SRC[${COUNT}]}/c${DST[${COUNT}]}" ${PO_FILE}
        COUNT=$((${COUNT} + 1))
    done

    # Replace package information using gettext domain information.
    sed -i -r "s/PACKAGE/${TCAR_SCRIPT_NAME}-${TCAR_SCRIPT_VERSION}/g" ${PO_FILE}

    # Remove absolute path to the working copy so it doesn't appear on
    # comments related to locations. Remember that people can download
    # their working copies in different locations and we don't want to
    # version those changes each time a translation message be
    # updated. To be consistent about this, show path information from
    # first level on. Don't show the variable part of the path.
    sed -i -r "s,${TCAR_BASEDIR}/,,g" ${PO_FILE}

    # Unset array variables to avoid undesired concatenations.
    unset SRC
    unset DST

}
