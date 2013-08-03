#!/bin/bash

function update {
    
    local FILE=''
    local POT=$(dirname ${CONFIGURATION})/messages.pot
    local TEMPFILES=''

    # Define regular expression to match extensions of shell scripts
    # we use inside the repository.
    local EXTENSION='(svgz|svg)'

    # Process list of directories, one by one.
    for FILE in ${SOURCES[*]};do

        local TEMPFILE=$(tcar_getTemporalFile $(basename ${FILE}))

        if [[ $(file -b -i ${FILE}) =~ '^application/x-gzip$' ]];then
            /bin/zcat ${FILE} > ${TEMPFILE}
        else
            /bin/cat ${FILE} > ${TEMPFILE}
        fi

        TEMPFILES="${TEMPFILE} ${TEMPFILES}"

    done

    #
    if [[ ! -d $(dirname ${TRANSLATIONS[0]}) ]];then
        mkdir -p $(dirname ${TRANSLATIONS[0]})
    fi

    # Print action message.
    tcar_printMessage "${POT}" --as-creating-line

    # Create the portable object template.
    cat ${TEMPFILES} | xml2po -a -l ${TCAR_SCRIPT_LANG_LC} - \
        | msgcat --output=${POT} --width=70 --no-location -

    # Verify, initialize or merge portable objects from portable
    # object templates.
    locale_updateMessagePObjects "${POT}"

}
